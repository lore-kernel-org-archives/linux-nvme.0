From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 9 Mar 2016 15:35:45 -0800
Subject: [PATCH 0/4] Remove un-needed 'major' registration when
 alloc_disk(0) is used.
In-Reply-To: <20160309215702.20904.61407.stgit@noble>
References: <20160309215702.20904.61407.stgit@noble>
Message-ID: <CAPcyv4gcOdBmzhMoyEErwh9Q7sXmWprdYy=W-iSSj+JwT=n6YA@mail.gmail.com>

On Wed, Mar 9, 2016@1:59 PM, NeilBrown <neilb@suse.com> wrote:
> When alloc_disk(0) is used, the ->major number is ignored and
> irrelevant.  Yet several drivers register a major number anyway.
>
> This series of patches removes the pointless registrations.  The pmem
> driver also does this, but a patch has already been sent for that
> driver.
>
> Note that I am not in a position to test these beyond simple compile
> testing.
>
> Thanks,
> NeilBrown
>
>
> ---
>
> NeilBrown (4):
>       nvdimm/blk: don't allocate unused major device number
>       nvdimm/btt: don't allocate unused major device number

The libnvdimm unit tests were fine with these, applied.

Btw, because you mentioned it, our unit test infrastructure does not
require real hardware.  See the ndctl readme [1], and if you have
copious amounts of free time the lwn write up on how we're mocking
resources [2].

[1]: https://github.com/pmem/ndctl/blob/master/README.md
[2]: https://lwn.net/Articles/654071/
