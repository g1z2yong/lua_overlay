function fsize()
	local r=f:seek("end")
	return r
end

f = assert(io.open(arg[1], "rb"))

print(os.date())
print ('File size :'..fsize())