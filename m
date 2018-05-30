From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:20:03 +0300
Subject: [PATCH 0/3] Provide more fine grained control over multipathing
In-Reply-To: <20180525135813.GB9591@redhat.com>
References: <20180525125322.15398-1-jthumshirn@suse.de>
 <20180525130535.GA24239@lst.de> <20180525135813.GB9591@redhat.com>
Message-ID: <db1aa53f-1152-c003-ccc1-3e439ca6916d@grimberg.me>

Hi Folks,

I'm sorry to chime in super late on this, but a lot has been
going on for me lately which got me off the grid.

So I'll try to provide my input hopefully without starting any more
flames..

>>> This patch series aims to provide a more fine grained control over
>>> nvme's native multipathing, by allowing it to be switched on and off
>>> on a per-subsystem basis instead of a big global switch.
>>
>> No.  The only reason we even allowed to turn multipathing off is
>> because you complained about installer issues.  The path forward
>> clearly is native multipathing and there will be no additional support
>> for the use cases of not using it.
> 
> We all basically knew this would be your position.  But at this year's
> LSF we pretty quickly reached consensus that we do in fact need this.
> Except for yourself, Sagi and afaik Martin George: all on the cc were in
> attendance and agreed.

Correction, I wasn't able to attend LSF this year (unfortunately).

> And since then we've exchanged mails to refine and test Johannes'
> implementation.
> 
> You've isolated yourself on this issue.  Please just accept that we all
> have a pretty solid command of what is needed to properly provide
> commercial support for NVMe multipath.
> 
> The ability to switch between "native" and "other" multipath absolutely
> does _not_ imply anything about the winning disposition of native vs
> other.  It is purely about providing commercial flexibility to use
> whatever solution makes sense for a given environment.  The default _is_
> native NVMe multipath.  It is on userspace solutions for "other"
> multipath (e.g. multipathd) to allow user's to whitelist an NVMe
> subsystem to be switched to "other".
> 
> Hopefully this clarifies things, thanks.

Mike, I understand what you're saying, but I also agree with hch on
the simple fact that this is a burden on linux nvme (although less 
passionate about it than hch).

Beyond that, this is going to get much worse when we support "dispersed
namespaces" which is a submitted TPAR in the NVMe TWG. "dispersed
namespaces" makes NVMe namespaces share-able over different subsystems
so changing the personality on a per-subsystem basis is just asking for
trouble.

Moreover, I also wanted to point out that fabrics array vendors are
building products that rely on standard nvme multipathing (and probably
multipathing over dispersed namespaces as well), and keeping a knob that
will keep nvme users with dm-multipath will probably not help them
educate their customers as well... So there is another angle to this.

Don't get me wrong, I do support your cause, and I think nvme should try
to help, I just think that subsystem granularity is not the correct
approach going forward.

As I said, I've been off the grid, can you remind me why global knob is
not sufficient?

This might sound stupid to you, but can't users that desperately must
keep using dm-multipath (for its mature toolset or what-not) just stack 
it on multipath nvme device? (I might be completely off on this so
feel free to correct my ignorance).
