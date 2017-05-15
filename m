From: jsmart2021@gmail.com (James Smart)
Date: Mon, 15 May 2017 15:43:11 -0700
Subject: [PATCH 06/10] nvmet_fc: Reduce work_q count
In-Reply-To: <5ca80708-59d9-d7d1-6102-67ff2d1c1b8f@broadcom.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-7-jsmart2021@gmail.com>
 <5e0fefab-9a20-a409-8ff2-6eefe3ab1649@suse.de>
 <5ca80708-59d9-d7d1-6102-67ff2d1c1b8f@broadcom.com>
Message-ID: <f9b9d254-59fd-c133-ab6e-55c2ff8a77ed@gmail.com>

>>>
>> Per-cpu ptr?
>> Check drivers/scsi/fcoe/fcoe.c:fcoe_init() for reference.
>
> As you can see above - I'm using per_cpu(), which is actually "#define
> per_cpu(var, cpu)       (*per_cpu_ptr(&(var), cpu))". So I'm already
> using it.

Actually your right, they aren't quite the same. Should have looked a 
little closer at the macros. I'll repost.

-- james
