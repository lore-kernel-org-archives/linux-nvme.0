From: aeasi@marvell.com (Arun Easi)
Date: Tue, 28 May 2019 17:29:11 -0700
Subject: [EXT] Re: [PATCH] nvme-fc: Add message when creating new
 controller
In-Reply-To: <06bf2ef9-253e-3292-5cd5-11cae0c40afa@gmail.com>
References: <20190528182404.3463-1-jsmart2021@gmail.com>
 <alpine.LRH.2.21.9999.1905281624470.9636@mvluser05.qlc.com>
 <06bf2ef9-253e-3292-5cd5-11cae0c40afa@gmail.com>
Message-ID: <alpine.LRH.2.21.9999.1905281722090.9636@mvluser05.qlc.com>

On Tue, 28 May 2019, 5:13pm, James Smart wrote:

> ----------------------------------------------------------------------
> On 5/28/2019 4:37 PM, Arun Easi wrote:
> > On Tue, 28 May 2019, 11:24am, James Smart wrote:
> > 
> > > When looking at console messages to troubleshoot, there are one
> > > maybe two messages before creation of the controller is complete.
> > > However, a lot of io takes place to reach that point. It's unclear
> > > when things have started.
> > > 
> > > Add a message when the controller is first attempting to be
> > > connecting to. Thus we know what controller and its NQN is being
> > > put into place for any subsequent success or failure messages.
> > > 
> > > Signed-off-by: James Smart <jsmart2021 at gmail.com>
> > > ---
> > >   drivers/nvme/host/fc.c | 4 ++++
> > >   1 file changed, 4 insertions(+)
> > > 
> 
> > > +	dev_info(ctrl->ctrl.device,
> > > +		"NVME-FC{%d}: creating new ctrl: NQN \"%s\"\n",
> > > +		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
> > > +
> > 
> > Adding rport+lport information would be helpful. It would be good to have
> > for all messages, but at least one message establishing the relationship
> > would make it easier when looking at logs.
> > 
> > Just wondering if there is any reason why no FC rport/lport info
> > was logged with any of the messages in fc.c?
> 
> I actually asked myself the same question after sending the patch: whether
> having host_traddr and traddr fields in that message made sense. I opted to
> stay as is only because it is much shorter (those WWN's are long).

I agree, *traaddr-s are too long. Having just lport pWWN and rport pWWN, 
though still longer, would be good IMHO. Longer term, it would be great to 
have a nvmefc_info/warn/err that takes in a "ctrl" or other abstraction 
that can provide these additional information. That way messages remain 
consistent and easily changeable to usefulness/taste.

> 
> The other question I had is whether I should print this only on initial
> creation or whenever a new association is started so it picks up the cases of
> when a reconnect start.

+1 for reconnect. That way we can know every start of re-connects.

-- arun

> Only disadvantage is - more long messages in the log.
> 
> I can easily be convinced to do something different if you prefer.
> 
> -- james
> 
> 
