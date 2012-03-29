function getw(mypos,mylen)
	local result=0
	f:seek("set",mypos)
	local b=f:read(mylen)
	for i=mylen,1,-1 do
		result=string.byte(b,i)+result*256
		--print(result)
	end
	return result
end

function fsize()
	local r=f:seek("end")
	return r
end



 f = assert(io.open(arg[1], "rb"))



print ('File size :'..fsize())
peoffset=getw(0x3c,2)
pestr=getw(peoffset,2)
sections=getw(peoffset+6,2)
print ("sections: "..sections)
sectionr=peoffset+0xF8
ts=0
for i=1,5 do
	--print ("="..sectionr)
	s_1=getw(sectionr+8,4)
	s_2=getw(sectionr+12,4)
	s_3=getw(sectionr+16,4)
	s_4=getw(sectionr+20,4)
	---print ("p"..s_1)
	--print (s_2)
	--print (s_3)
	--print ("Pp"..s_4)
	if ts<s_3+s_4 then
		ts=s_3+s_4
	end
	--print (ts)
	sectionr=sectionr+0x28
end
overlay=fsize()-ts
print("Overlay Pos:"..ts)
print("Overlay Size:"..overlay)
f:seek("set",0)
rr=f:read(ts)
f:seek("set",ts)
oo=f:read(overlay)

if overlay>0 then
	fo=io.open(arg[1]..'.overlay','wb')
	fr=io.open(arg[1]..'.main','wb')
	fo:write(oo)
	fr:write(rr)
	fo:close()
	fr:close()
end
f:close()
