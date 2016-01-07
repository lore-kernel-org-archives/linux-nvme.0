From: kent.overstreet@gmail.com (Kent Overstreet)
Date: Thu, 7 Jan 2016 01:46:37 -0900
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <20160106162117.GE15113@localhost.localdomain>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
 <20160106055133.GA4868@localhost.localdomain>
 <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>
 <CACVXFVPifqQP_LdLv79Lv_EF-evfh9LFT2nfVvDKMuLJ-OCH5g@mail.gmail.com>
 <20160106151836.GB15113@localhost.localdomain>
 <CACVXFVM7BDvqWREUaZtbf+LwxLUWEgDrgrOyXPObE7H1PjHsAQ@mail.gmail.com>
 <20160106162117.GE15113@localhost.localdomain>
Message-ID: <20160107104637.GA22795@kmo-pixel>

On Wed, Jan 06, 2016@04:21:17PM +0000, Keith Busch wrote:
> On Wed, Jan 06, 2016@11:43:45PM +0800, Ming Lei wrote:
> > Please see the 1st line code of __blk_segment_map_sg(), in which only
> > one whole bvec is handled, and partial bvec can't be figured out there.
> > 
> > Think of it further, drivers often use bv.bv_len directly in the
> > iterator, for example:
> > 
> >         bio_for_each_segment(bvec, bio, iter)
> >                 memcpy(page_address(bvec.bv_page) +
> >                                             bvec.bv_offset,  addr +
> > offset, bvec.bv_len);
> > 
> > So your patch will break these drivers, won't it?
> 
> CC'ing Kent in hopes he will clarify what happens on a split.
> 
> The bio_advance() code comments say it's handled:
> 
> "
>  * This updates bi_sector, bi_size and bi_idx; if the number of bytes to
>  * complete doesn't align with a bvec boundary, then bv_len and bv_offset will
>  * be updated on the last bvec as well.
> "
> 
> I admit I'm having a hard time seeing where bv_len and bv_offset updated
> in this path. It was obviously handled after 054bdf646e then changed
> with 4550dd6c6b.
> 
> If I follow correctly, 4550dd6c6b will implicity update the bvec's offset
> and length during the split here since bio_iter_iovec resets the bvec's
> length and offset:
> ---
> #define __bio_for_each_segment(bvl, bio, iter, start)			\
> 	for (iter = (start);						\
> 	     (iter).bi_size &&						\
> 		((bvl = bio_iter_iovec((bio), (iter))), 1);		\
> 	     bio_advance_iter((bio), &(iter), (bvl).bv_len))
> --

Yes, splitting in the middle of a bvec is perfectly fine. The reason
bio_for_each_segment takes a struct bvec and not a struct bvec * is because it's
computing what bv_len should be (taking the min of bv_len and bi_size, roughly).

See include/linux/bio.h:

bio_for_each_segment()
  bio_iter_iovec()
    bvec_iter_bvec()
      bvec_iter_len()

which does the actual bv_len computation.
