From: jaegeuk@kernel.org (Jaegeuk Kim)
Date: Thu, 5 Jan 2017 17:09:30 -0800
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
Message-ID: <20170106010930.GC2064@jaegeuk.local>

Hello,

On 01/04, Damien Le Moal wrote:

...
> 
> > Finally, if I really like to develop SMR- or NAND flash oriented file
> > system then I would like to play with peculiarities of concrete
> > technologies. And any unified interface will destroy the opportunity 
> > to create the really efficient solution. Finally, if my software
> > solution is unable to provide some fancy and efficient features then
> > guys will prefer to use the regular stack (ext4, xfs + block layer).
> 
> Not necessarily. Again think in terms of device "model" and associated
> feature set. An FS implementation may decide to support all possible
> models, with likely a resulting incredible complexity. More likely,
> similarly with what is happening with SMR, only models that make sense
> will be supported by FS implementation that can be easily modified.
> Example again here of f2fs: changes to support SMR were rather simple,
> whereas the initial effort to support SMR with ext4 was pretty much
> abandoned as it was too complex to integrate in the existing code while
> keeping the existing on-disk format.

>From the f2fs viewpoint, now we support single host-managed SMR drive having
a portion of conventional zones. In addition, f2fs supports multiple devices
[1], which enables us to use pure host-managed SMR which has no conventional
zone, working with another small conventional partition.

I think current lightNVM with OCSSD aims towards a drive-managed device for
generic filesystems. Depending on FTL, however, OCSSD can report conventional
or sequential zones. 1) If FTL handles random 4K writes pretty well, it would
be better to report converntional zones. Otherwise, 2) if FTL has almost nothing
to map bettwen LBA to PBA, it is able to report sequential zones likewise pure
host-managed SMR.

Interestingly, for 1) host-aware model, there is no need to change f2fs at all.
In order to explore 2) pure host-managed model, I introduced aligned write IO
[2] to make FTL more simple by eliminating partial page write. IMHO, it'd be
funny to evaluate several zoned models of SMR and OCSSD accordingly.

[1] https://lkml.org/lkml/2016/11/9/727
[2] https://lkml.org/lkml/2016/12/30/242

Thanks,
