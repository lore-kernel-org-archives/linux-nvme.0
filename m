From: keith.busch@intel.com (Keith Busch)
Date: Tue, 5 Jan 2016 15:09:38 +0000
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
Message-ID: <20160105150938.GA20832@localhost.localdomain>

On Tue, Jan 05, 2016@12:54:53PM +0800, Ming Lei wrote:
> On Tue, Jan 5, 2016@2:24 AM, Keith Busch <keith.busch@intel.com> wrote:
> > This allows bio splits in the middle of a vector to form the largest
> 
> Wrt. the current block stack, one segment always hold one or more bvec,
> instead of part of bvec, so better to be careful about this handling.

Hi Ming,

Could you help me understand your concern here? If we split a vector
somewhere in the middle, it becomes two different bvecs. The first is
the last segment in the first bio, the second is the first segment in
the split bio, right?

It's not necessarily a new segment if it is physically contiguous with
the previous (if it exists at all), but duplicating the logic to coalesce
addresses doesn't seem to be worth that optimization.
 
> > possible bio at the h/w's desired alignment, and guarantees the bio being
> > split will have some data. Previously, if the first vector's length was
> > greater than the allowable amount, the bio would split at a zero length
> > and hit a kernel BUG.
> 
> That is introduced by d3805611130a, and zero length can't be splitted
> previously because queue_max_sectors() is at least one PAGE_SIZE.

Can a bvec's length exceed a PAGE_SIZE? They point to pages, so I
suppose not.

But it should be more efficient to split to the largest allowed by the
hardware. We can contrive a scenario where a bio would be split many
times more than necessary without this patch. Let's say queue_max_sectors
is a PAGE_SIZE, and we want to submit '2 * PAGE_SIZE' worth of data
addressed in 3 bvecs. Previously that would split three times; now it
will split only twice.
