function d = read_mat(file_name)

mat_struct = load(file_name,'d');
d = mat_struct.d;

end
