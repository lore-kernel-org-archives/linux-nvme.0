From: james.smart@broadcom.com (James Smart)
Date: Tue, 24 Oct 2017 10:55:18 -0700
Subject: [PATCH v2] nvmet: Fix fatal_err_work deadlock
In-Reply-To: <b2ec3e9e-2a06-e925-060d-f37e7c7a47cd@grimberg.me>
References: <20171020161253.29296-1-jsmart2021@gmail.com>
 <20171023082805.GA25383@infradead.org>
 <a1123d71-51f8-1d72-3e5d-67f23634543a@grimberg.me>
 <20171023145013.GA3017@infradead.org>
 <b2ec3e9e-2a06-e925-060d-f37e7c7a47cd@grimberg.me>
Message-ID: <4ce921ac-501c-c935-05aa-1acce23133c5@broadcom.com>

On 10/24/2017 12:31 AM, Sagi Grimberg wrote:
>
>>> If fatal_err_work calls ->delete_ctrl() and that in turn gets to put 
>>> the
>>> last reference on the ctrl it will end up in ->free_ctrl() under
>>> fatal_err_work context which will then try to flush fatal_err_work.
>>
>> Yes, and the way I understand flush_work that is perfectly fine for
>> flush_work, just not for cancel_work_sync.
>
> Really?
>
> My understanding is that flush_work() is inserting a barrier work
> into the worker running the work right after the running work and waits
> for it to complete.
>
> How will the barrier complete without the current work completing?
>
> James, can you give it a shot?
Sagi is correct.

The patch version that solves this problem is v2:
http://lists.infradead.org/pipermail/linux-nvme/2017-October/013505.html

-- james
