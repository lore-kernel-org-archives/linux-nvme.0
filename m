From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Sat, 28 Nov 2015 09:44:20 +0800
Subject: [PATCH v2 1/3] lightnvm: missing nvm_lock acquire
In-Reply-To: <5658B1E9.2010700@bjorling.me>
References: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>
 <1448597384-27976-2-git-send-email-ww.tao0320@gmail.com>
 <565814E8.9020408@bjorling.me>
 <CACygaLAW23EbxN2Sw33K3Zzyq1P=mM4ouUq6SSxV=_2A0HJJjg@mail.gmail.com>
 <5658B1E9.2010700@bjorling.me>
Message-ID: <CACygaLDVxGCLaSowdzH8hAaWjso1bjsYuEaxUSD=DZNm4EsdSg@mail.gmail.com>

Hi Matiasl
Just to let you know this patch and previous version both cannot
address 'register device with supported manager may blocked while
holding the lock' issue.

2015-11-28 3:41 GMT+08:00 Matias Bj?rling <m at bjorling.me>:
> On 11/27/2015 01:04 PM, Wenwei Tao wrote:
>>
>> Hi Matias
>> Previous version patch miss acquire lock before find supported manager
>> in nvm_init().
>> And find supported manager code is duplicated in nvm_init() and
>> nvm_create_target(), we may move it into a function to make the code
>> more clean.
>> And find supported manager may blocked while holding the lock, this is
>> not good.
>>
>
> Ok, thanks. I'll pick this one up instead then.
>
