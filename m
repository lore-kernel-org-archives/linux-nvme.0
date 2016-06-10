From: keith.busch@intel.com (Keith Busch)
Date: Fri, 10 Jun 2016 10:58:43 -0400
Subject: can't access repo - need assistance
In-Reply-To: <CAEqzOjv6QRf8daxQLrqF3z_tZAE=UN=KY=B1ZDM3eOo-72pFRg@mail.gmail.com>
References: <1465566005827.7981@micron.com>
 <CAEqzOjv6QRf8daxQLrqF3z_tZAE=UN=KY=B1ZDM3eOo-72pFRg@mail.gmail.com>
Message-ID: <20160610145842.GL1696@localhost.localdomain>

It sounds like you need to set GIT_PROXY_COMMAND to something to get
through your firewall. Might need to confirm with your network admin
what proxy to use.

On Fri, Jun 10, 2016@09:08:28AM -0500, Robert Randall wrote:
> What is the most stable branch to use at the moment for a stable RoCE target?
> 
> Thanks,
> Robert
> 
> On Fri, Jun 10, 2016 at 8:38 AM, Robert Randall (rrandall)
> <rrandall@micron.com> wrote:
> >
> > Sorry for being a newbie and not keeping up with the repo changes.
> >
> > Do I need an account at git.infradead.org to pull the source tree?
> >
> > I can't pull using git: (blocked by firewall) and I can't pull using https:.
> >
> > I can pull using ssh: but that appears to require an account.
> >
> > At the moment we're blocked by a bug in the for-next branch of the old repository and need to move to the correct bits in order to continue our development.  Please help!
> >
> > Best regards,
> > Robert
