From: Vyacheslav.Dubeyko@wdc.com (Slava Dubeyko)
Date: Wed, 4 Jan 2017 02:59:39 +0000
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
In-Reply-To: <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
Message-ID: <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>


-----Original Message-----
From: Matias Bj?rling [mailto:m@bjorling.me] 
Sent: Tuesday, January 3, 2017 11:11 AM
To: Viacheslav Dubeyko <slava at dubeyko.com>; lsf-pc at lists.linux-foundation.org
Cc: Linux FS Devel <linux-fsdevel at vger.kernel.org>; linux-block at vger.kernel.org; linux-nvme at lists.infradead.org; Slava Dubeyko <Vyacheslav.Dubeyko at wdc.com>
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical Interface, and Vector I/Os

<skipped>

> All of the open-channel SSD work is done in the open.
> Patches, new targets, and so forth are being developed for everyone to see. 
> Similarly, the NVMe host interface is developed in the open as well.
> The interface allows one to implements supporting firmware. The "front-end"
> of the FTL on the SSD, is removed, and the "back-end" engine is exposed. 
> It is not much work and given HGST already have an SSD firmware implementation.
> I bet you guys can whip up an internal implementation in a matter of weeks.
> If you choose to do so, I will bend over backwards to help you sort out any quirks that might be.

I see your point. But I am the research guy and I have software project. So, it's completely unreasonable for me
to spend the time on SSD firmware. I simply need in ready-made hardware for testing/benchmarking
my software and to check the assumptions that it was made. That's all. If I haven't the hardware right now
then I need to wait the better times. 

> Another option is to use the qemu extension. We are improving it continuously
> to make sure it follows the implementation of a real hardware OCSSDs.
> Today we do 90% of our FTL work using qemu, and most of the time
> it just works when we run the FTL code on real hardware.

I really dislike to use the qemu for file system benchmarking.

> Similarly to vendors that provide new CPUs, NVDIMMs, and graphic drivers.
> Some code and refactoring go in years in advance. What I am proposing here is to discuss how OCSSDs
> fits into the storage stack, and what we can do to improve it. Optimally, most of the lightnvm subsystem
> can be removed by exposing vectored I/Os. Which then enables implementation of a target to be
> a traditional device mapper module. That would be great!

OK. From one point of view, I like the idea of SMR compatibility. But, from another point of view,
I am slightly skeptical about such approach. I believe you see the bright side of your suggestion.
So, let me take a look on your approach from the dark side.

What's the goal of SMR compatibility? Any unification or interface abstraction has the goal to hide
the peculiarities of underlying hardware. But we have block device abstraction that hides all
hardware's peculiarities perfectly. Also FTL (or any other Translation Layer) is able to represent
the device as sequence of physical sectors without real knowledge on software side about
sophisticated management activity on the device side. And, finally, guys will be completely happy
to use the regular file systems (ext4, xfs) without necessity to modify software stack. But I believe that
the goal of Open-channel SSD approach is completely opposite. Namely, provide the opportunity
for software side (file system, for example) to manage the Open-channel SSD device with smarter
policy.

So, my key worry that the trying to hide under the same interface the two different technologies
(SMR and NAND flash) will be resulted in the loss of opportunity to manage the device in
more smarter way. Because any unification has the goal to create a simple interface. But SMR
and NAND flash are significantly different technologies. And if somebody creates technology-oriented
file system, for example, then it needs to have access to really special features of the technology.
Otherwise, interface will be overloaded by features of both technologies and it will looks like as
a mess.

SMR zone and NAND flash erase block look comparable but, finally, it significantly different stuff.
Usually, SMR zone has 265 MB in size but NAND flash erase block can vary from 512 KB to 8 MB
(it will be slightly larger in the future but not more than 32 MB, I suppose).
It is possible to group several erase blocks into aggregated entity but it could be not very good
policy from file system point of view. Another point that QLC device could have more tricky features
of erase blocks management. Also we should apply erase operation on NAND flash erase block
but it is not mandatory for the case of SMR zone. Because SMR zone could be simply re-written
in sequential order if all zone's data is invalid, for example. Also conventional zone could be really tricky
point. Because it is one zone only for the whole device that could be updated in-place.
Raw NAND flash, usually, hasn't likewise conventional zone.

Finally, if I really like to develop SMR- or NAND flash oriented file system then I would like to play
with peculiarities of concrete technologies. And any unified interface will destroy the opportunity
to create the really efficient solution. Finally, if my software solution is unable to provide some
fancy and efficient features then guys will prefer to use the regular stack (ext4, xfs + block layer).

Thanks,
Vyacheslav Dubeyko.
