From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 06 Dec 2016 15:23:21 -0800
Subject: [PATCH 2/3] nvmet: Make cntlid globally unique
In-Reply-To: <20161206082826.GC12194@lst.de>
References: <1480936146-6406-1-git-send-email-sagi@grimberg.me>
 <1480936146-6406-3-git-send-email-sagi@grimberg.me>
 <20161205153400.GA6529@lst.de>
 <1bbcabad-e586-c92b-ec06-c50f4dd1d09f@grimberg.me>
 <20161206082826.GC12194@lst.de>
Message-ID: <1481066601.2675.42.camel@linux.intel.com>

On Tue, 2016-12-06@09:28 +0100, Christoph Hellwig wrote:
> On Mon, Dec 05, 2016@07:06:44PM +0200, Sagi Grimberg wrote:
> > 
> > 
> > > 
> > > > 
> > > > +	pr_info("creating controller %d for subsystem %s for
> > > > NQN %s.\n",
> > > > +		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl-
> > > > >hostnqn);
> > > 
> > > That's going to be a crazy long line in the dmesg log..
> > 
> > Have a better idea how to provide this information?
> 
> Not sure.??Maybe multiple lines?


pr_info("Creating controller: %d\n ? in subsystem: %s\n ? for host:
%s\n",
? ? ? ? ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn);

????
