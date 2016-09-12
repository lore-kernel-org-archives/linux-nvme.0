From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Sep 2016 17:58:09 +0300
Subject: [PATCH v5 0/6] nvme-rdma device removal fixes
In-Reply-To: <00ee01d20d04$df3e2d70$9dba8850$@opengridcomputing.com>
References: <cover.1472833420.git.swise@opengridcomputing.com>
 <89eb2382-9a2f-48d1-c9fd-0c018e07cd9f@grimberg.me>
 <00ee01d20d04$df3e2d70$9dba8850$@opengridcomputing.com>
Message-ID: <f492116d-72ad-0217-9e8f-56e890324c45@grimberg.me>


>>> Doug/Sagi, the first 2 iw_cxgb4 patches are included here because they're
>>> needed for the testing.  While I've also submitted them to linux-rdma,
>>> perhaps Sagi can merge them in nvmf-4.8-rc?  If that is acceptable
>>> with everyone.
>>
>> Fine with me,
>>
>> Queued for the next round of rc fixes.
>>
>> Thanks Steve!
>
> Hey Sagi, Will these make 4.8-rc7?

I planned to send them out tomorrow.

I'll also apply a patch that clears the flags
when creating the queue.

Cheers,
