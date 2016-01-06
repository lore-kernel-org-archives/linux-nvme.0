From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 6 Jan 2016 14:53:22 +0800
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
 <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>
 <20160106055133.GA4868@localhost.localdomain>
 <CACVXFVNWTSD9Few9KLT6r+yvgynfMduAoLEbP0t3Yo=ye5UDHA@mail.gmail.com>
Message-ID: <CACVXFVPifqQP_LdLv79Lv_EF-evfh9LFT2nfVvDKMuLJ-OCH5g@mail.gmail.com>

On Wed, Jan 6, 2016@2:29 PM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Wed, Jan 6, 2016@1:51 PM, Keith Busch <keith.busch@intel.com> wrote:
>> On Wed, Jan 06, 2016@10:17:51AM +0800, Ming Lei wrote:
>>> Firstly we didn't split one single bio vector before bio splitting.
>>>
>>> Secondly, current bio split still doesn't support to split one single
>>> bvec into two, and it just makes the two bios shared the original
>>> bvec table, please see bio_split(), which calls bio_clone_fast()
>>> to do that, and the bvec table has been immutable at that time.
>>
>> You are saying we can't split a bio in the middle of a vector?
>
> I mean the current block stack may not be ready for that.
>
>> bvec_iter_advance() says we can split anywhere.
>
> bvec_iter_advance() can split anywhere, but the splitted bios may
> cross one same bvec, which may cause trouble, for example,
> BIOVEC_PHYS_MERGEABLE() may not work well and
> blk_phys_contig_segment() too.

blk_rq_map_sg() isn't ready for splitting in the middle of bvec too.

Thanks,
