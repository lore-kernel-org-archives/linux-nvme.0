From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 9 Jan 2016 19:10:38 +0800
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <20160107104637.GA22795@kmo-pixel>
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
 <20160107104637.GA22795@kmo-pixel>
Message-ID: <CACVXFVN8SJNOp7-VhaLdySpn8s41cxyT0vzUNxLZDmAFH9Q=Dg@mail.gmail.com>

On Thu, Jan 7, 2016 at 6:46 PM, Kent Overstreet
<kent.overstreet@gmail.com> wrote:
> On Wed, Jan 06, 2016@04:21:17PM +0000, Keith Busch wrote:
...
> Yes, splitting in the middle of a bvec is perfectly fine. The reason
> bio_for_each_segment takes a struct bvec and not a struct bvec * is because it's
> computing what bv_len should be (taking the min of bv_len and bi_size, roughly).
>
> See include/linux/bio.h:
>
> bio_for_each_segment()
>   bio_iter_iovec()
>     bvec_iter_bvec()
>       bvec_iter_len()
>
> which does the actual bv_len computation.

Looks my understanding was wrong, and Keith's patch is correct, sorry
for the noise.

-- 
Ming Lei
