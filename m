From: hch@lst.de (Christoph Hellwig)
Date: Wed, 9 May 2018 09:52:53 +0200
Subject: [PATCH 1/5] nvmet: EUI64 support
In-Reply-To: <20180509094529.2fb1cffe@pentland.suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-2-hare@suse.de> <20180509070858.GA20363@lst.de>
 <20180509094529.2fb1cffe@pentland.suse.de>
Message-ID: <20180509075253.GA21148@lst.de>

On Wed, May 09, 2018@09:45:29AM +0200, Hannes Reinecke wrote:
> On Wed, 9 May 2018 09:08:58 +0200
> "Christoph Hellwig" <hch@lst.de> wrote:
> 
> > On Fri, May 04, 2018@01:28:41PM +0200, Hannes Reinecke wrote:
> > > Allow the setting of an IEEE Extended Unique Identifier (EUI64) for
> > > each namespace. As the OUI is per subsystem ensure that the OUI
> > > part of the EUI64 value (ie the top 3 bytes) are matching for each
> > > namespace.  
> > 
> > I don't think we should support the EUI64 value.  It doesn't have
> > a lot of uniqueness, and it requires and IEEE OID to be properly
> > implemented.  Please use the UUID identifier always, unless you
> > actually doe havean IEEE OID and really want to use it, in which case
> > you should use the NGUID.
> > 
> 
> It's not so much about usability, it's about choice.
> Some users might want to set an EUI64; companies (like ours) have
> a valid OUI, so generating an EUI64 is pretty simple.
> 
> And the patch itself is pretty simple, so where's the harm?

Please always use the NGUID then.  Using a 64-bit unique
identifier is a bad idea.  And even when using NGUIDs you have to
be extremely careful to make sure they are never reused.
