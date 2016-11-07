From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 07 Nov 2016 12:34:46 -0800
Subject: [PATCH RFC nvme-cli 0/2] auto generate hostnqn file on
 installation
In-Reply-To: <5a2ee2fb-8104-39cc-1af3-f0fca1caa48e@grimberg.me>
References: <1478459581-22654-1-git-send-email-sagi@grimberg.me>
 <20161106192451.GA18342@lst.de>
 <5a2ee2fb-8104-39cc-1af3-f0fca1caa48e@grimberg.me>
Message-ID: <1478550886.5463.14.camel@linux.intel.com>

On Sun, 2016-11-06@23:36 +0200, Sagi Grimberg wrote:
> > 
> > > 
> > > Not sure if it's the best way to do this as my packeging
> > > understanding is
> > > very limited, hence the RFC. the debian part is tested (don't
> > > have
> > > access to rpm distros at the moment).
> > 
> > My idea was to add a command to generate an automatic hostnqn to
> > the nvme tool instead, what would you think about that?
> 
> I'm fine with that too.

How about an extra tweak to that tool proposal? ?Have the tool have the
option to do both NQN supported formats:

A. the first format that uses a date code in which I think that is what
patch 2 in this series was trying to do

and

B. The second format the NVMe Host driver is already does in fabrics.c?

> 
> > 
> > The install scripts could then call that.
> 
> Sounds fine.
