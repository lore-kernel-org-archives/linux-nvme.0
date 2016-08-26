From: keith.busch@intel.com (Keith Busch)
Date: Fri, 26 Aug 2016 11:17:01 -0400
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
 pointer
In-Reply-To: <20160826143557.GA21788@lst.de>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
 <20160825073810.GA18622@lst.de>
 <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>
 <c199d91a-0f6d-6ef7-f8f8-9b8b28430564@fb.com>
 <CALCETrV+ndPPGhoO5zwQWC5knvrRF8NKtk2hx0CgCqg60=vGmQ@mail.gmail.com>
 <20160826143557.GA21788@lst.de>
Message-ID: <20160826151701.GA19986@localhost.localdomain>

On Fri, Aug 26, 2016@04:35:57PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 26, 2016@07:31:33AM -0700, Andy Lutomirski wrote:
> >  - Consider *deleting* the SCSI translation layer's power saving code.
> > It looks almost entirely bogus to me.  It has an off-by-one in its
> > NPSS handling, it hardcodes power state indices which is total BS, it
> > ignores the distinction between operational and non-operational states
> > (which I think matters for non-APST usage).  It also seems likely to
> > be that it's never been used, since it's one of the formerly
> > crashy-looking set_features users.
> 
> Please go ahead and send a patch to delete it.  Adding the whole SCSI
> layer was a mistake to start with, and it's always been horribly buggy.
> Until I started running the libiscsi testsuite even fairly normal I/O
> commands were a sure way to crash it, and crazy things like PM are
> almost guaranteed to a) not actually be used by real application and
> b) horrible buggy (as you've already noticed)

Ack. If no distros or tools rely on the the SCSI crutch anymore, then
by all means, let's delete it. It's been disabled default for a while
now, and I think/hope everyone we care about has since migrated to
nvme awareness.
