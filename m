From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Fri, 27 Nov 2015 20:41:29 +0100
Subject: [PATCH v2 1/3] lightnvm: missing nvm_lock acquire
In-Reply-To: <CACygaLAW23EbxN2Sw33K3Zzyq1P=mM4ouUq6SSxV=_2A0HJJjg@mail.gmail.com>
References: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>	<1448597384-27976-2-git-send-email-ww.tao0320@gmail.com>	<565814E8.9020408@bjorling.me>
 <CACygaLAW23EbxN2Sw33K3Zzyq1P=mM4ouUq6SSxV=_2A0HJJjg@mail.gmail.com>
Message-ID: <5658B1E9.2010700@bjorling.me>

On 11/27/2015 01:04 PM, Wenwei Tao wrote:
> Hi Matias
> Previous version patch miss acquire lock before find supported manager
> in nvm_init().
> And find supported manager code is duplicated in nvm_init() and
> nvm_create_target(), we may move it into a function to make the code
> more clean.
> And find supported manager may blocked while holding the lock, this is
> not good.
>

Ok, thanks. I'll pick this one up instead then.
