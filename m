From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Fri, 04 Sep 2015 10:49:33 +0200
Subject: [PATCH v7 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <55E955DF.5020303@cn.fujitsu.com>
References: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
 <1438957791-24632-2-git-send-email-mb@lightnvm.io>
 <55E67218.9010701@cn.fujitsu.com> <55E6D41A.5060100@bjorling.me>
 <55E94301.3010501@cn.fujitsu.com> <55E950BA.50203@bjorling.me>
 <55E955DF.5020303@cn.fujitsu.com>
Message-ID: <55E95B1D.1010700@bjorling.me>

On 09/04/2015 10:27 AM, Dongsheng Yang wrote:
> On 09/04/2015 04:05 PM, Matias Bj?rling wrote:
>>>
>>> So here is a suggestion, register_bm again
>>> if we found nvm_dev->bm == NULL in create_target(). And if it is still
>>> NULL after that. return an error "nvm: no compatible bm was found"
>>> and stop target creating. Otherwise, there would be a NULL Pointer
>>> reference problem.
>>>
>>> That's a real problem I met in my testing and I did this change
>>> in my local using. I hope that's useful to you.
>>>
>> Hi Yang,
>> ac
>> Similar to this?
>
> Okey, I attached two changes in my local using. I hope that
> useful to you.
>

Thanks! Applied and pushed to master.
