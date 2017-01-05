From: Vyacheslav.Dubeyko@wdc.com (Slava Dubeyko)
Date: Thu, 5 Jan 2017 22:58:57 +0000
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical
 Interface, and Vector I/Os
In-Reply-To: <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
References: <05204e9d-ed4d-f97a-88f0-41b5e008af43@bjorling.me>
 <1483398761.2440.4.camel@dubeyko.com>
 <e42ff0c8-6568-d211-331f-7bfa6af94e2e@bjorling.me>
 <1483464921.2440.19.camel@dubeyko.com>
 <9319ce16-8355-3560-95b6-45e3f07220de@bjorling.me>
 <SN2PR04MB219184580108939442EBDA7E88610@SN2PR04MB2191.namprd04.prod.outlook.com>
 <a5acdf89-99c0-774d-cb08-76cb5d846f29@wdc.com>
Message-ID: <SN2PR04MB2191BE43398C84C4D262960488600@SN2PR04MB2191.namprd04.prod.outlook.com>


-----Original Message-----
From: Damien Le Moal 
Sent: Tuesday, January 3, 2017 11:25 PM
To: Slava Dubeyko <Vyacheslav.Dubeyko at wdc.com>; Matias Bj?rling <m at bjorling.me>; Viacheslav Dubeyko <slava at dubeyko.com>; lsf-pc at lists.linux-foundation.org
Cc: Linux FS Devel <linux-fsdevel at vger.kernel.org>; linux-block at vger.kernel.org; linux-nvme at lists.infradead.org
Subject: Re: [LSF/MM TOPIC][LSF/MM ATTEND] OCSSDs - SMR, Hierarchical Interface, and Vector I/Os

<skipped>

> But you are missing the parallel with SMR. For SMR, or more correctly zoned
> block devices since the ZBC or ZAC standards can equally apply to HDDs and SSDs,
> 3 models exists: drive-managed, host-aware and host-managed.
> Case (1) above corresponds *exactly* to the drive managed model, with
> the difference that the abstraction of the device characteristics (SMR
> here) is in the drive FW and not in a host-level FTL implementation
> as it would be for open channel SSDs. Case (2) above corresponds to the host-managed
> model, that is, the device user has to deal with the device characteristics
> itself and use it correctly. The host-aware model lies in between these 2 extremes:
> it offers the possibility of complete abstraction by default, but also allows a user
> to optimize its operation for the device by allowing access to the device characteristics.
> So this would correspond to a possible third way of implementing an FTL for open channel SSDs.

I see your point. And  I think that, historically, we need to distinguish 4 cases for the
case of NAND flash:
(1) drive-managed: regular file systems (ext4, xfs and so on);
(2) host-aware: flash-friendly file systems (NILFS2, F2FS and so on);
(3) host-managed: <file systems under implementation>;
(4) old-fashioned flash-oriented file systems for raw NAND (jffs, yaffs, ubifs and so on).

But, frankly speaking, even regular file systems are slightly flash-aware today because of
blkdev_issue_discard (TRIM) or REQ_META flag. So, the next really important question is:
what can/should be exposed for the host-managed and host-aware cases? What's principal
difference between these models? And, finally, the difference is not so clear.

Let's start from error corrections. Only flash-oriented file systems take care about
error corrections. But I assume that drive-managed, host-aware and host-managed cases
expect hardware-based error correction. So, we can treat our logical page/block as ideal
byte stream that always contains valid data. So, we have no difference and no contradiction
here.

Next point is read disturbance. If BER of physical page/block achieves some threshold then
we need to move data from one page/block into another one. What subsystem will be
responsible for this activity? The drive-managed case expects that device's GC will manage
read disturbance issue. But what's about host-aware or host-managed case? If the host side
hasn't information about BER then the host's software is unable to manage this issue. Finally,
it sounds that we will have GC subsystem as on file system side as on device side. As a result,
it means possible unpredictable performance degradation and decreasing device lifetime.
Let's imagine that host-aware case could be unaware about read disturbance management.
But how host-managed case can manage this issue?

Bad block management... So, drive-managed and host-aware cases should be completely unaware
about  bad blocks. But what's about host-managed case? If a device will hide bad blocks from
the host then it means mapping table presence, access to logical pages/blocks and so on. If the host
hasn't access to the bad block management then it's not host-managed model. And it sounds as
completely unmanageable situation for the host-managed model. Because if the host has access
to bad block management (but how?) then we have really simple model. Otherwise, the host
has access to logical pages/blocks only and device should have internal GC. As a result,
it means possible unpredictable performance degradation and decreasing device lifetime because
of competition of GC on device side and GC on the host side.

Wear leveling... Device will be responsible to manage wear-leveling for the case of device-managed
and host-aware models. It looks like that the host side should be responsible to manage wear-leveling
for the host-managed case. But it means that the host should manage bad blocks and to have direct
access to physical pages/blocks. Otherwise, physical erase blocks will be hidden by device's indirection
layer and wear-leveling management will be unavailable on the host side. As a result, device will have
internal GC and the traditional issues (possible unpredictable performance degradation and decreasing
device lifetime). But even if SSD provides access to all internals then how will file system be able
to implement wear-leveling or bad block management in the case of regular I/O operations? Because
block device creates LBA abstraction for us. Does it mean that software FTL on the block layer level
is able to manage SSD internals directly? And, again, file system cannot manage SSD internals directly
for the case of software FTL. And where should software FTL keep mapping table, for example?

So, F2FS and NILFS2 looks like a host-aware case because it is LFS file systems that is oriented on
regular SSDs. So, it could be desirable to have some knowledge (page size, erase block size and so on)
about SSD internals. But, mostly, such knowledge should be shared with mkfs tool during file
system volume creation. The rest looks like as not very promising and not very different with
device-managed model. Because even if F2FS and NILFS2 has GC subsystem and mostly looks like
as LFS case (F2FS has in-place updated area; NILFS2 has in-place updated superblocks in the begin/end
of the volume), anyway, both these file systems completely rely on device indirection layer and
GC subsystem. We are still in the same hell of GCs competition. So, what's the point of host-aware
model?

So, I am not completely convinced that, finally, we will have really distinctive features for the
case of device-managed, host-aware and host-managed model. Also I have many question about
host-managed model if we will use block device abstraction. How can direct management of
SSD internals be organized for the case of host-managed model is hidden under block device
abstraction?

Another interesting question... Let's imagine that we create file system volume for one device
geometry. It means that geometry details will be stored in the file system metadata during volume
creation for the case host-aware or host-managed case. Then we backups this volume and restore
the volume on device with completely different geometry. So, what will we have for such case?
Performance degradation? Or will we kill the device?

> The open-channel SSD interface is very 
> similar to the one exposed by SMR hard-drives. They both have a set of 
> chunks (zones) exposed, and zones are managed using open/close logic. 
> The main difference on open-channel SSDs is that it additionally exposes 
> multiple sets of zones through a hierarchical interface, which covers a 
> numbers levels (X channels, Y LUNs per channel, Z zones per LUN).

I would like to have access channels/LUNs/zones on file system level.
If, for example, LUN will be associated with partition then it means
that it will need to aggregate several partitions inside of one volume.
First of all, not every file system is ready for the aggregation several
partitions inside of the one volume. Secondly, what's about aggregation
several physical devices inside of one volume? It looks like as slightly
tricky to distinguish partitions of the same device and different devices
on file system level. Isn't it?

> I agree with Damien, but I'd also add that in the future there may very
> well be some new Zone types added to the ZBC model. 
> So we shouldn't assume that the ZBC model is a fixed one.  And who knows?
> Perhaps T10 standards body will come up with a simpler model for
> interfacing with SCSI/SATA-attached SSD's that might leverage the ZBC model --- or not.

Different zone types is good. But maybe LUN will be the better place
for distinguishing the different zone types. Because if zone can have the type
then it's possible to imagine any combinations of zones. But mostly
zone of some type will be inside of some contiguous area (inside of NAND
die, for example). So, LUN looks like as NAND die representation.

>> SMR zone and NAND flash erase block look comparable but, finally, it 
>> significantly different stuff. Usually, SMR zone has 265 MB in size 
>> but NAND flash erase block can vary from 512 KB to 8 MB (it will be 
>> slightly larger in the future but not more than 32 MB, I suppose). It 
>> is possible to group several erase blocks into aggregated entity but 
>> it could be not very good policy from file system point of view.
>
> Why not? For f2fs, the 2MB segments are grouped together into sections
> with a size matching the device zone size. That works well and can actually
> even reduce the garbage collection overhead in some cases.
> Nothing in the kernel zoned block device support limits the zone size
> to a particular minimum or maximum. The only direct implication of the zone
> size on the block I/O stack is that BIOs and requests cannot cross zone
> boundaries. In an extreme setup, a zone size of 4KB would work too
> and result in read/write commands of 4KB at most to the device.

The situation with grouping of segments into sections for the case of F2FS
is not so simple. First of all, you need to fill such aggregation with data.
F2FS distinguish several types of segments and it means that current
segment/section will be larger. If you mix different types of segments into
one section (but I believe that F2FS doesn't provide opportunity to do this)
then GC overhead could be larger, I suppose. Otherwise, the using one section
for one segment type means that the current section with greater size than
segment (2MB) will be resulted in changing the speed of filling sections with
different type of data. As a result, it will change dramatically the distribution
of different type of sections on file system volume. Does it reduce GC overhead?
I am not sure. And if file system's segment should be equal to zone size
(for example, NILFS2 case) then it could mean that you need to prepare the
whole segment before real flush. And if you will need to process O_DIRECT
or synchronous mount case then, most probably, you will need to flush the
segment with huge hole. I suppose that it could significantly decrease file system's
free space, increase GC activity and decrease device lifetime.

>> Another point that QLC device could have more tricky features of erase 
>> blocks management. Also we should apply erase operation on NAND flash 
>> erase block but it is not mandatory for the case of SMR zone.
>
> Incorrect: host-managed devices require a zone "reset" (equivalent to
> discard/trim) to be reused after being written once. So again, the
> "tricky features" you mention will depend on the device "model",
> whatever this ends up to be for an open channel SSD.

OK. But I assume that SMR zone "reset" is significantly cheaper than
NAND flash block erase operation. And you can fill your SMR zone with
data then "reset" it and to fill again with data without significant penalty.
Also, TRIM and zone "reset" are different, I suppose. Because, TRIM looks
like as a hint for SSD controller. If SSD controller receives TRIM for some
erase block then it doesn't mean  that erase operation will be done
immediately. Usually, it should be done in the background because real
erase operation is expensive operation. 

Thanks,
Vyacheslav Dubeyko.
