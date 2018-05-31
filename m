From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 11:51:31 +0300
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180530224402.GA7303@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
 <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>
 <20180530224402.GA7303@redhat.com>
Message-ID: <cab4ef4a-df7a-60c8-1f40-7a130aa3b15a@grimberg.me>


>> Moreover, I also wanted to point out that fabrics array vendors are
>> building products that rely on standard nvme multipathing (and probably
>> multipathing over dispersed namespaces as well), and keeping a knob that
>> will keep nvme users with dm-multipath will probably not help them
>> educate their customers as well... So there is another angle to this.
> 
> Noticed I didn't respond directly to this aspect.  As I explained in
> various replies to this thread: The users/admins would be the ones who
> would decide to use dm-multipath.  It wouldn't be something that'd be
> imposed by default.  If anything, the all-or-nothing
> nvme_core.multipath=N would pose a much more serious concern for these
> array vendors that do have designs to specifically leverage native NVMe
> multipath.  Because if users were to get into the habit of setting that
> on the kernel commandline they'd literally _never_ be able to leverage
> native NVMe multipathing.
> 
> We can also add multipath.conf docs (man page, etc) that caution admins
> to consult their array vendors about whether using dm-multipath is to be
> avoided, etc.
> 
> Again, this is opt-in, so on a upstream Linux kernel level the default
> of enabling native NVMe multipath stands (provided CONFIG_NVME_MULTIPATH
> is configured).  Not seeing why there is so much angst and concern about
> offering this flexibility via opt-in but I'm also glad we're having this
> discussion to have our eyes wide open.

I think that the concern is valid and should not be dismissed. And
at times flexibility is a real source of pain, both to users and
developers.

The choice is there, no one is forbidden to use multipath. I'm just
still not sure exactly why the subsystem granularity is an absolute
must other than a volume exposed as a nvmf namespace and scsi lun (how
would dm-multipath detect this is the same device btw?)
