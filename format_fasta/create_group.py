"""
Pre-process for MATLAB:
all proteins from one group are in ONE fasta file. With this file, create a folder having same name under PATH.
In this folder, create a fasta file for each chain.
"""
import os
from os import listdir
from os.path import isfile, join

PATH = 'E:\Research\protein classification\myCode\SCOP\\'
RAWDATA_PATH = 'E:\Research\protein classification\\format_fasta\\raw data\\'


def create_folder(file):
    """
    Create a folder under PATH. The name of the folder is same as the file
    :param file: (str): the name of a fasta file which contains all proteins from same group.
    :return: (str): the full path of the new folder
    """
    folder_name = file[:file.find('.')]
    folder_path = PATH + folder_name
    if not os.path.exists(folder_path):
        os.makedirs(folder_path)
    else:
        for the_file in os.listdir(folder_path):
            file_path = os.path.join(folder_path, the_file)
            try:
                if os.path.isfile(file_path):
                    os.unlink(file_path)
                # elif os.path.isdir(file_path): shutil.rmtree(file_path)
            except Exception as e:
                print(e)
    return folder_path


def create_RCSB_fastas(file):
    """
    Read a fasta file from www.rcsb.org. Create a fasta file for each chain in the original file under RAWDATA_PATH
    :param file: (str): the name of a fasta file which contains all proteins from same group.
    :return: null
    """
    folder_path = create_folder(file)
    filepath = RAWDATA_PATH + file
    with open(filepath, 'r') as raw_file:
        raw_data = raw_file.read()
        chains = raw_data.split('>')
        cache = []
        for chain in chains[1:]:
            head = chain[:4]  # for SCOP
            chain_number = chain[5]
            prefix_pos = 27  # for SCOP
            prefix = chain[:prefix_pos]
            sequence = chain[prefix_pos:]
            sequence = sequence.replace('\n', '')
            assert prefix[6:] == '|PDBID|CHAIN|SEQUENCE', 'Unknown prefix'
            if chain_number < 'A' or chain_number > 'Z':  # invalid chain
                continue
            elif sequence in cache:  # same chain
                continue
            if not cache:  # new protein
                cache = [head, sequence]
            elif head != cache[0]:  # new protein
                protein_sequence = ''
                for cached_sequence in cache[1:]:
                    protein_sequence += cached_sequence
                if len(protein_sequence) > 300:
                    new_fasta = open('{0}\{1}.txt'.format(folder_path, head), 'w')
                    new_fasta.write('>' + chain[:prefix_pos] + '\n')
                    new_fasta.write(protein_sequence)
                    new_fasta.close
                cache = [head, sequence]
            cache.append(sequence)
        new_fasta = open('{0}\{1}.txt'.format(folder_path, head), 'w')
        new_fasta.write('>' + chain[:prefix_pos] + '\n')
        for cached_sequence in cache[1:]:
            new_fasta.write(cached_sequence)
        new_fasta.close


def create_UniProb_fastas(file):
    """
    Read a fasta file from www.uniprot.org. Create a fasta file for each chain in the original file under RAWDATA_PATH
    :param file: (str): the name of a fasta file which contains all proteins from same group.
    :return: null
    """
    folder_path = create_folder(file)
    filepath = RAWDATA_PATH + file
    with open(filepath, 'r') as raw_file:
        raw_data = raw_file.read()
        chains = raw_data.split('>')
        for chain in chains[1:]:
            head = chain[3:9]  # for Aminoacyl-tRNA
            prefix_pos = chain.find('SV=') + 4  # for Aminoacyl-tRNA
            sequence = chain[prefix_pos:]
            sequence = sequence.replace('\n', '')
            new_fasta = open('{0}\{1}.txt'.format(folder_path, head), 'w')
            new_fasta.write('>' + chain[:prefix_pos] + '\n')
            new_fasta.write(sequence)
            new_fasta.close


def main():
    """
    Under RAWDATA_PATH, each fasta file has all proteins in one group. Run pre-process work for each group
    :return: null
    """
    onlyfiles = [f for f in listdir(RAWDATA_PATH) if isfile(join(RAWDATA_PATH, f))]
    for file in onlyfiles:
        create_RCSB_fastas(file)


if __name__ == '__main__':
    main()
