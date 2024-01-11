clc;
clear all;
close all;

path = input('Enter Filename with single quotes: ');
path =[path '.txt'];
disp('Menu: ');
disp('1.Scrambler');
disp('2.Unscrambler');
choice = input('\nEnter option: ');


if choice ==1
    fid=fopen(path,'r');
    formatSpec='%c';
    file=fscanf(fid,formatSpec);
    lines=strsplit(file,'\n');
    lines_out=[];
    for k=1:length(lines)
        line=strtrim(string(lines(k)));
        chr = convertStringsToChars(line);
        stream = dec2bin(double(chr),7);
        len_stream=size(stream);
        stream_out=[];
        for j=1:len_stream(1)
            s=stream(j,:);
            data=[];
            for i=1:7
                data=[data str2double(s(i))];
            end

            %scramble Operation--------------
            generator =[1 0 1 0 0 1];
            data_out=scram(data,generator);
            %--------------------------------

            s_out=[];
            for i=1:7
                s_out=[s_out num2str(data_out(i))];
            end
            stream_out=[stream_out; s_out];
        end
        characters = char(bin2dec(char(stream_out)))';
        lines_out=[lines_out string(characters)];
    end
    fid = fopen('scrambled_text.txt', 'w');
    fprintf(fid, '%s\n', lines_out);
    fclose(fid);
    disp('Scrambled Text File generated successfully..');

elseif choice==2
    fid=fopen(path,'r');
    formatSpec='%c';
    file=fscanf(fid,formatSpec);
    lines=strsplit(file,'\n');
    lines_out=[];
    for k=1:length(lines)
        line=strtrim(string(lines(k)));
        chr = convertStringsToChars(line);
        stream = dec2bin(double(chr),7);
        len_stream=size(stream);
        stream_out=[];
        for j=1:len_stream(1)
            s=stream(j,:);
            data=[];
            for i=1:7
                data=[data str2double(s(i))];
            end

            %Unscramble Operation--------------
            generator =[1 0 1 0 0 1];
            data_out=Unscram(data,generator);
            %--------------------------------

            s_out=[];
            for i=1:7
                s_out=[s_out num2str(data_out(i))];
            end
            stream_out=[stream_out; s_out];
        end
        characters = char(bin2dec(char(stream_out)))';
        lines_out=[lines_out string(characters)];
    end
    fid = fopen('Unscrambled_text.txt', 'w');
    fprintf(fid, '%s\n', lines_out);
    fclose(fid);
    disp('UnScrambled Text File generated successfully..');
else
    disp('Enter valid Option..');    
end
    