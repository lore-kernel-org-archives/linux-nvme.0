From: rrandall@micron.com (Robert Randall (rrandall))
Date: Fri, 10 Jun 2016 15:41:47 +0000
Subject: can't access repo - need assistance
In-Reply-To: <20160610145842.GL1696@localhost.localdomain>
References: <1465566005827.7981@micron.com>
 <CAEqzOjv6QRf8daxQLrqF3z_tZAE=UN=KY=B1ZDM3eOo-72pFRg@mail.gmail.com>
 <20160610145842.GL1696@localhost.localdomain>
Message-ID: <dce7543ba6a04b6eb8ba99ecc28cb041@bowex36e.micron.com>

Thanks everyone!  That pointed me in the right direction.  I have the source pulled using git:// and a bit of proxy magic.  We should be back to testing shortly.

Thanks!
Robert

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Friday, June 10, 2016 9:59 AM
To: Robert Randall
Cc: linux-nvme at lists.infradead.org
Subject: Re: can't access repo - need assistance

It sounds like you need to set GIT_PROXY_COMMAND to something to get through your firewall. Might need to confirm with your network admin what proxy to use.

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

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
