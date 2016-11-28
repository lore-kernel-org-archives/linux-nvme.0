From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 28 Nov 2016 07:54:57 -0800
Subject: [PATCH 1/3] nvmetcli: Adding manpage/html generation
In-Reply-To: <20161125074346.GA753@lst.de>
References: <1479924073-6952-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1479924073-6952-2-git-send-email-james_p_freyensee@linux.intel.com>
 <20161125074346.GA753@lst.de>
Message-ID: <1480348497.2827.11.camel@linux.intel.com>

On Fri, 2016-11-25@08:43 +0100, Christoph Hellwig wrote:
> Hi Jay,
> 
> thanks a lot for writing this man page!??I have a few comments below,
> but otherwise this looks really great.

No problem, thanks for the compliment :-).

> 
> > 
> > +NAME
> > +----
> > +nvmetcli - Configure NVMe Target for NVMe-over-Fabrics solution.
> 
> I'd just say "Configure the NVMe-over-Fabrics Target".

Will do.

> 
> > 
> > +[verse]
> > +nvmetcli
> > +nvmetcli [cmd] [file]
> 
> Should we just list the three actual command here?

You mean just list out all the "nvmetcli [cmd] [file]" commands
(nvmetcli restore [file], nvmetcli clear [file])?

> 
> > 
> > +DESCRIPTION
> > +-----------
> > +*nvmetcli* is a python-based program used for viewing, editing,
> > saving,
> 
> I'd drop python here - that's an implementation detail not
> interesting
> to the actual user reading the man page.

No problem.

> 
> 
> > 
> > It enables an administrator to assign local
> > +storage resources backed by either local NVMe devices, OS files,
> > or
> > +system volumes and export them to remote systems via network
> > fabrics
> > +based on the NVMe-over-Fabrics specification from http://www.nvmex
> > press.org.
> 
> I'd something like "It allows to export a local block device
> (including,
> but not limited to a NVMe devices).."??We can't really export files
> directly but need to turn them into a block device first using the
> loop
> device, and NVMe devices aren't really treated special, although they
> are of course worse mentioning.

OK, I'll give it a stab to tweak and add that comment.

> 
> > 
> > +nvmetcli manages only one NVMe Target as there is only one Linux
> > kernel
> > +NVMe Target per system.
> 
> Can we just remove this sentence???

Sure.


> > +|==================
> > +| cd????????????????????| Same as Linux, allows to move around the
> > tree.?
> > +| ls????????????????????| Similar as Linux, lists contents of
> > current tree node.
> 
> Can we drop the "Same as" and "Similar as"???It's really traditional
> Unix shells that we are similar too, but that wording seems a bit
> clumsy.

Sure, no problem.

> 
> > 
> > +ADDITIONAL INFORMATION
> > +----------------------
> > +nvmetcli has the ability to start and stop the NVMe Target
> > configuration
> > +on boot and shutdown through the *systemctl* Linux utility via a
> > .service file.
> 
> It might be good to mention the actual service, e.g.
> 
> nvmetcli ships with a nvmet systemd service file, which automatically
> restores the saved config from /etc/nvme/nvmet.json on system
> startup,

Yah, I've played with the nvmet systemd service file, I can mention
that.

> and clears the configuration on shutdown.??You can uses systemctl
> (and we
> probably want a man page reference to systemctl here, no idea how to
> do
> that in asciidoc) to enable and disable this functionality.

I can explicitly state the commands:

systemctl enable nvmet
systemctl disable nvmet

into this section...not sure how I'd add a man page reference to
systemctl, I'm not an asciidoc power user.

> 
> > 
> > +
> > +AUTHORS
> > +-------
> > +This was written by mailto:james.p.freyensee at intel.com[Jay
> > Freyensee]
> > +for mailto:hch at infradead.org[Christoph Hellwig].
> 
> If at all I'd word this as
> 
> This man page was written by mailto:james.p.freyensee at intel.com[Jay
> Freyensee].
> nvmetcli was originall written by mailto:hch at infradead.org[Christoph
> Hellwig].
> 

I can just do this. ?I don't mind mentioning I authored the man page,
but I don't want to take credit that is yours.

> > +
> > +REPORTING BUGS & DEVELOPMENT
> > +-----------------------------
> > +Please send patches to linux-nvme at lists.infradead.org for review
> > and acceptance.
> 
> Might be worth to also mention bug reports here.

OK, I can tweak it.

> 
> > 
> > +doc: ${NAME}
> > +	${MAKE} -C ${DOCDIR}
> > +
> > +cleandoc:
> > +	@rm -f ${DOCDIR}/${PKGNAME}.1
> > +	@rm -f ${DOCDIR}/${PKGNAME}.html
> > +	@rm -f ${DOCDIR}/${PKGNAME}.xml
> 
> Should this be ${MAKE} -C ${DOCDIR} clean?
> 

Maybe :-P. ?I'll look into it.

> Also I suspect this should be a .8 page, not .1 given that we install
> into sbin.

Can change, no problem.
