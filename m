From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 15:18:36 +0000
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <CACVXFVPifqQP_LdLv79Lv_EF-evfh9LFT2nfVvDKMuLJ-OCH5g@mail.gmail.com>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
 <20160106055133.GA4868@localhost.localdomain>
 <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>
 <CACVXFVPifqQP_LdLv79Lv_EF-evfh9LFT2nfVvDKMuLJ-OCH5g@mail.gmail.com>
Message-ID: <20160106151836.GB15113@localhost.localdomain>

On Wed, Jan 06, 2016@02:53:22PM +0800, Ming Lei wrote:
> On Wed, Jan 6, 2016@2:29 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> >
> > bvec_iter_advance() can split anywhere, but the splitted bios may
> > cross one same bvec, which may cause trouble, 

Cross? One starts where the other starts. Could you please explain what's
wrong?

> > for example,
> > BIOVEC_PHYS_MERGEABLE() may not work well and
> > blk_phys_contig_segment() too.

Could you please explain why it may not work well? I have no idea what
concern you have with BIOVEC_PHYS_MERGEABLE in this case.

The only place blk_phys_contig_segment is called from is
ll_merge_requests, and the first req of the split bio wouldn't even go
through here because it's marked REQ_NOMERGE.

> blk_rq_map_sg() isn't ready for splitting in the middle of bvec too.

Could you please explain? It just uses the bio iterator, which I'm pretty
sure is not broken.
