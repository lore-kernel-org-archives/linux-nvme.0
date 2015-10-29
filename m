From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 29 Oct 2015 16:34:55 +0900
Subject: [PATCH v13 2/5] gennvm: Generic NVM manager
In-Reply-To: <56315D0F.5010602@cn.fujitsu.com>
References: <1445992233-676-1-git-send-email-m@bjorling.me>
 <1445992233-676-3-git-send-email-m@bjorling.me>
 <56315D0F.5010602@cn.fujitsu.com>
Message-ID: <5631CC1F.5050107@kernel.dk>

On 10/29/2015 08:41 AM, Dongsheng Yang wrote:
> On 10/28/2015 08:30 AM, Matias Bj?rling wrote:
>> The implementation for Open-Channel SSDs is divided into media
> [...]
>> +        lun->reserved_blocks = 2; /* for GC only */
>> +        lun->vlun.id = i;
>> +        lun->vlun.lun_id = i % dev->luns_per_chnl;
>> +        lun->vlun.chnl_id = i / dev->luns_per_chnl;
>
> Please use do_div(). % would be not supported in some platforms, as
> the kbuild pointed in V12.

Neither of those are 64-bit variables, which is where you end up with 
the problem on 32-bit archs.

-- 
Jens Axboe
