From: yyt168@gmail.com (Tony Yang)
Date: Tue, 19 Sep 2017 09:57:08 +0800
Subject: compile nvme 4.13 appear error
In-Reply-To: <20170918172734.GD17096@localhost.localdomain>
References: <CADL4p-phBMqbqzR052xHBf_0=PPuGyvR82FoS=aaM_h7w_S7SA@mail.gmail.com>
 <20170918172734.GD17096@localhost.localdomain>
Message-ID: <CADL4p-pPFxsi1B0gTKutUEAdiWpHCk99NR0E4ed6Y5_eYe=p0Q@mail.gmail.com>

Hi, I from http://git.infradead.org/nvme.git to get 4.13 version

I want to compile with nvme new kernel, So I use 4.13 version to compile.

I would like to ask, how can I compile a new kernel for a successful
nvme? Thanks

2017-09-19 1:27 GMT+08:00 Keith Busch <keith.busch at intel.com>:
> On Mon, Sep 18, 2017@09:02:15PM +0800, Tony Yang wrote:
>> Dear All
>>
>>   I at redhat 6.5 ,kernel is 2.6.32-431.el6.x86_64?I comile nvme 4.13
>> appear this error:
>>
>> [root at cescel03 nvme-nvme-4.13]# make
>>   CHK     include/config/kernel.release
>>   CHK     include/generated/uapi/linux/version.h
>>   CHK     include/generated/utsrelease.h
>>   CHK     include/generated/bounds.h
>>   CHK     include/generated/timeconst.h
>>   CHK     include/generated/asm-offsets.h
>>   CALL    scripts/checksyscalls.sh
>>   CHK     scripts/mod/devicetable-offsets.h
>>   CHK     include/generated/compile.h
>>   AR      drivers/nvme/host/built-in.o
>>   CC [M]  drivers/nvme/host/core.o
>> drivers/nvme/host/core.c: In function ?nvme_alloc_mpath_ns?:
>> drivers/nvme/host/core.c:3111: error: ?NVME_FAILOVER_RETRIES?
>> undeclared (first use in this function)
>> drivers/nvme/host/core.c:3111: error: (Each undeclared identifier is
>> reported only once
>> drivers/nvme/host/core.c:3111: error: for each function it appears in.)
>> drivers/nvme/host/core.c: In function ?nvme_trigger_failover?:
>> drivers/nvme/host/core.c:3277: error: ?NVME_FAILOVER_RETRIES?
>> undeclared (first use in this function)
>> make[3]: *** [drivers/nvme/host/core.o] Error 1
>> make[2]: *** [drivers/nvme/host] Error 2
>> make[1]: *** [drivers/nvme] Error 2
>> make: *** [drivers] Error 2
>
> Not sure where you got this source. The 4.13 kernel doesn't contain an
> nvme driver with such errors, so it looks like whoever packaged up your
> source really botched it up from applying out-of-tree stuff.
