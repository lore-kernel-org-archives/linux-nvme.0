From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 23 Sep 2016 09:43:24 -0700
Subject: [PATCH RFC] nvme-cli: propose 'c' vs 'r' for connect flag
In-Reply-To: <20160923150026.GB19352@keith>
References: <1474583840-23739-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20160923033301.GB12637@infradead.org> <20160923150026.GB19352@keith>
Message-ID: <1474649004.15303.44.camel@linux.intel.com>

On Fri, 2016-09-23@11:00 -0400, Keith Busch wrote:
> On Thu, Sep 22, 2016@08:33:01PM -0700, Christoph Hellwig wrote:
> > 
> > On Thu, Sep 22, 2016@03:37:20PM -0700, Jay Freyensee wrote:
> > > 
> > > I am not sure if it matters too much except in possibly
> > > human usage understanding, but '-r' is used in the 'discover'
> > > command for --raw.??Change the --reconnect-delay flag
> > > single letter to something not being used in any fabrics
> > > command.
> > 
> > Sounds ok to me.??But I have to say dealing with these short
> > options
> > start to be a little annoying.??For a lot of these commands I'd
> > prefer
> > to simply support long options only if we could (I'll need to look
> > at argconfig.c in a bit more detail how easily that could be done).
> 
> Aw, I like having short opts. Yeah, some were arbitrarily picked to
> avoid
> clashes (though I clearly missed some clashes), and difficult to
> remember,
> but every sub-command shows consistent helpful usage info with a "
> --help".

OK, I'll respin this, add the review tags, and remove the RFC and send
it back out.
