From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 18 Sep 2017 08:00:39 -0600
Subject: compile nvme not find bi_disk
In-Reply-To: <CADL4p-rjo2DisDwRP5YFDDMZS-GrP3fKijGSmp26Uqa+BACB6A@mail.gmail.com>
References: <CADL4p-rjo2DisDwRP5YFDDMZS-GrP3fKijGSmp26Uqa+BACB6A@mail.gmail.com>
Message-ID: <659ced79-5aba-668c-ae16-4b04bcf31d7c@kernel.dk>

On 09/18/2017 07:47 AM, Tony Yang wrote:
> Dear All
> 
>   I'm compiling nvme, but encountered the following error, how can I
> solve it? Thanks
> 
>  CHK     include/generated/compile.h
>   CC [M]  drivers/nvme/host/core.o
> drivers/nvme/host/core.c: In function ?__nvme_submit_user_cmd?:
> drivers/nvme/host/core.c:631: error: ?struct bio? has no member named ?bi_disk?
> make[3]: *** [drivers/nvme/host/core.o] Error 1
> make[2]: *** [drivers/nvme/host] Error 2
> make[1]: *** [drivers/nvme] Error 2
> make: *** [drivers] Error 2
> [root at cescel03 nvme-nvme-4.13]# bi_disk

You're not running a mainline version of the kernel, looks like you're
trying to compile a newer version of the nvme driver on an older kernel
version.  That's not going to work.

-- 
Jens Axboe
