From: logang@deltatee.com (Logan Gunthorpe)
Date: Sat, 15 Apr 2017 11:47:00 -0600
Subject: [PATCH 09/22] dm-crypt: Make use of the new sg_map helper in 4
 call sites
In-Reply-To: <22703638-27a9-7dc5-5180-536f61661592@gmail.com>
References: <1492121135-4437-1-git-send-email-logang@deltatee.com>
 <1492121135-4437-10-git-send-email-logang@deltatee.com>
 <20170414083921.GC25471@lst.de>
 <302ae5ab-d515-5427-2e54-d58a9cdb8241@deltatee.com>
 <22703638-27a9-7dc5-5180-536f61661592@gmail.com>
Message-ID: <19b18d76-57fa-0a4f-252d-5d735105a159@deltatee.com>

Thanks for the information Milan.

On 15/04/17 06:10 AM, Milan Broz wrote:
> I think your patch is ok (if it is just plain conversion), if it is
> really needed, we can switch to ahash later in follow-up patch.

Sounds good to me.

> p.s.
> there is a lot of lists on cc, but for this patch is missing dm-devel, dmcrypt changes
> need to go through Mike's tree (I added dm-devel to cc:)

Oh, sorry, I thought I had included all the lists. My hope however would
be to get the first patch merged and then re-send the remaining patches
to their respective maintainers. So that would have happened later. It's
hard to manage patches otherwise with such large distribution lists.

Logan
