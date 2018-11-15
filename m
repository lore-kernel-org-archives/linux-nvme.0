From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 15 Nov 2018 11:43:43 -0500
Subject: [PATCH] qla2xxx: Add SysFS hook for FC-NVMe autoconnect
In-Reply-To: <824ea768-5397-30c0-6fb4-85420ae41476@suse.de>
References: <20181112214017.11218-1-himanshu.madhani@cavium.com>
 <1542060403.8992.3.camel@acm.org>
 <4AF60723-8D50-47B5-B347-07D022E8ADC9@cavium.com>
 <1542118997.192870.0.camel@acm.org>
 <7FC9DAE5-8E21-43D8-9624-3B7764B2B392@cavium.com>
 <1542131346.192870.9.camel@acm.org>
 <74e3efc2e8442bd7c1546b2bcf0e4c8f46365c67.camel@redhat.com>
 <824ea768-5397-30c0-6fb4-85420ae41476@suse.de>
Message-ID: <101ef45ac029fb456a57194aee609d90c5abe6a8.camel@redhat.com>

On Thu, 2018-11-15@13:52 +0100, Hannes Reinecke wrote:
> On 11/14/18 6:13 PM, Ewan D. Milne wrote:
> > On Tue, 2018-11-13@09:49 -0800, Bart Van Assche wrote:
> > > On Tue, 2018-11-13@17:38 +0000, Madhani, Himanshu wrote:
> > > > On Nov 13, 2018,@6:23 AM, Bart Van Assche <bvanassche@acm.org> wrote:
> > > > > On Tue, 2018-11-13@01:02 +0000, Madhani, Himanshu wrote:
> > > > > > I see other drivers also use similar information populated for NVMe
> > > > > > Connection at boot time.
> > > > > 
> > > > > Hi Himanshu,
> > > > > 
> > > > > Which other drivers are you referring to?
> > > > > 
> > > > > Thanks,
> > > > > 
> > > > > Bart.
> > > > 
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri
> > > > vers/scsi/lpfc/lpfc_attr.c
> > > 
> > > Hello James,
> > > 
> > > Please either move the information exported by lpfc_nvme_info_show() into
> > > debugfs or split the information exported by that function into multiple
> > > sysfs attributes. Otherwise you will get flamed by Greg KH as soon as he
> > > encounters that code because of not following the rules explained in
> > > Documentation/filesystems/sysfs.txt.
> > > 
> > > Bart.
> > 
> > Better yet, is there some way we could get at least the connection
> > information needed for discovery moved into the NVMe/FC transport
> > layer so that we don't need to have separate implementations that
> > have to be parsed?
> > 
> 
> Sigh.
> 
> It's already been solved, there's no need for this attribute.
> 
> nvme-fc already sends a uevent whenever a new nvme rport is attached,
> (check nvme_fc_register_remoteport()->nvme_fc_signal_discovery_scan().
> 
> James Smart added a sysfs entry for retriggering these uevents, and I've 
> posted a set of scripts (... at least I think I did :-) utilizing those.
> 
> Please do _NOT_ do this; better rely on common mechanisms here.
> 
> And please, next time please cc linux-nvme so that we can track it better.
> 
> Cheers,
> 
> Hannes

So, the uevent can take care of the discovery mechanism, however there
are other reasons why one would want to be able to know e.g. what the
WWPNs of the Initiator & Target ports of the NVMe connections are.
For example, we would typically want to capture this information when
troubleshooting a system remotely.  There are also SAN test environments
that have a need for this information, which is one of the reasons
for the original patch posting.  I don't think it matters too much how
we do it, but the information is needed somehow.

I suppose a udev rule could put the information into a file, but that
seems awkard, and the infomation neeeded is in kernel objects, so why
not make it visible?

The uevent is of course necessary as it signifies an event, but the
desired info here is the *state*.

-Ewan
