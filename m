From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 19 Jun 2016 14:57:10 +0300
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <CAF1ivSZNJhOtORceAfk9Ym9SPpYOGQ4q0KOD8eEuy0ovU2Eefw@mail.gmail.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <005f01d1c8a1$5a229240$0e67b6c0$@opengridcomputing.com>
 <007801d1c8a2$d6056530$82102f90$@opengridcomputing.com>
 <CAF1ivSZNJhOtORceAfk9Ym9SPpYOGQ4q0KOD8eEuy0ovU2Eefw@mail.gmail.com>
Message-ID: <57668896.7090308@grimberg.me>



On 17/06/16 20:20, Ming Lin wrote:
> On Fri, Jun 17, 2016@7:16 AM, Steve Wise <swise@opengridcomputing.com> wrote:
>>>
>>>>
>>>> Steve, is this something that started happening recently? does the
>>>> 4.6-rc3 tag suffer from the same phenomenon?
>>>
>>> Where is this tag?
>>
>> Never mind.  I found it (needed 'git pull -t' for pull the tags from the gitlab
>> nvmef repo).
>
> I run this overnight,
>
> #!/bin/bash
>
> while [ 1 ] ; do
>      ifconfig eth5 down ; sleep 15; ifconfig eth5 up; sleep 15
> done
>
> Although the crash is not reproduced, but it triggers another OOM bug.

Which code-base is this? it looks like this code is just leaking queues.
Obviously something changed...
