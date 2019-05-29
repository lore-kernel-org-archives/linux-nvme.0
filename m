From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 29 May 2019 23:39:29 +0900
Subject: [PATCH 0/2] nvme: enable to inject errors into admin commands
In-Reply-To: <8cb23080-b7ab-f773-2d25-e39b36501e3d@oracle.com>
References: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
 <8cb23080-b7ab-f773-2d25-e39b36501e3d@oracle.com>
Message-ID: <CAC5umyiqy82saDbTAtR8w99ahe-sH=r1hvt2jMtjnFE9AufqNw@mail.gmail.com>

2019?5?29?(?) 2:47 Thomas Tai <thomas.tai at oracle.com>:
>
> On 5/28/19 1:03 PM, Akinobu Mita wrote:
> > Currenlty fault injection support for nvme only enables to inject errors
> > into the commands submitted to I/O queues.
> >
> > This enables to inject errors into the commands submitted to the admin
> > queue.
> >
> > It is useful to test error handling in the controller initialization.
> >
> >       # echo 100 > /sys/kernel/debug/nvme0/fault_inject/probability
> >       # echo 1 > /sys/kernel/debug/nvme0/fault_inject/times
> >       # echo 10 > /sys/kernel/debug/nvme0/fault_inject/space
> >       # nvme reset /dev/nvme0
> >       # dmesg
>
> Hi Akinobu,
> That sounds like a good idea. would you kindly update the document in
> Documentation/fault-injection/nvme-fault-injection.txt with your example?

Sure. I'll add the following exmple.

Example 3: Inject an error into the 10th admin command
------------------------------------------------------

echo 100 > /sys/kernel/debug/nvme0/fault_inject/probability
echo 10 > /sys/kernel/debug/nvme0/fault_inject/space
echo 1 > /sys/kernel/debug/nvme0/fault_inject/times
nvme reset /dev/nvme0

Expected Result:

After NVMe controller reset, the reinitialization may or may not succeed.
It depends on which admin command is actually forced to fail.

Message from dmesg:
...
