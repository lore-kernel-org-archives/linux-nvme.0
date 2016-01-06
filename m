From: tom.leiming@gmail.com (Ming Lei)
Date: Wed, 6 Jan 2016 10:17:51 +0800
Subject: [PATCH for-4.4] block: split bios to max possible length
In-Reply-To: <20160105150938.GA20832@localhost.localdomain>
References: <1451931895-17474-1-git-send-email-keith.busch@intel.com>
 <CACVXFVPOYra24SNmGBthcheYv_kY=5Fv-6s=-bSwwZijudXapw@mail.gmail.com>
 <20160105150938.GA20832@localhost.localdomain>
Message-ID: <CACVXFVNQQNd8_3ti4AAhZB4KN0uJEN8sdmB+xsmpykJaCLfebA@mail.gmail.com>

Hi Keith,

On Tue, Jan 5, 2016@11:09 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, Jan 05, 2016@12:54:53PM +0800, Ming Lei wrote:
>> On Tue, Jan 5, 2016@2:24 AM, Keith Busch <keith.busch@intel.com> wrote:
>> > This allows bio splits in the middle of a vector to form the largest
>>
>> Wrt. the current block stack, one segment always hold one or more bvec,
>> instead of part of bvec, so better to be careful about this handling.
>
> Hi Ming,
>
> Could you help me understand your concern here? If we split a vector
> somewhere in the middle, it becomes two different bvecs. The first is
> the last segment in the first bio, the second is the first segment in
> the split bio, right?

Firstly we didn't split one single bio vector before bio splitting.

Secondly, current bio split still doesn't support to split one single
bvec into two, and it just makes the two bios shared the original
bvec table, please see bio_split(), which calls bio_clone_fast()
to do that, and the bvec table has been immutable at that time.

>
> It's not necessarily a new segment if it is physically contiguous with
> the previous (if it exists at all), but duplicating the logic to coalesce
> addresses doesn't seem to be worth that optimization.

I understand your motivation in the two patches, actually before bio splitting,
we don't do sg merge for nvme because of the flag of NO_SG_MERGE,
which is ignored after bio splitting is introduced. So could you check if
the nvme performance can be good by putting NO_SG_MERGE back
in blk_bio_segment_split()? And the change should be simple, like the
attached patch.

>
>> > possible bio at the h/w's desired alignment, and guarantees the bio being
>> > split will have some data. Previously, if the first vector's length was
>> > greater than the allowable amount, the bio would split at a zero length
>> > and hit a kernel BUG.
>>
>> That is introduced by d3805611130a, and zero length can't be splitted
>> previously because queue_max_sectors() is at least one PAGE_SIZE.
>
> Can a bvec's length exceed a PAGE_SIZE? They point to pages, so I
> suppose not.

No, it doesn't, but blk_max_size_offset() may be less than PAGE_SIZE,
then zero splitting is triggered.

>
> But it should be more efficient to split to the largest allowed by the
> hardware. We can contrive a scenario where a bio would be split many

Previously Jens took the opposite approach to make each bvec
as one segment, and he mentioned performance is increased.

> times more than necessary without this patch. Let's say queue_max_sectors
> is a PAGE_SIZE, and we want to submit '2 * PAGE_SIZE' worth of data
> addressed in 3 bvecs. Previously that would split three times; now it
> will split only twice.

IMO, splitting is quite cheap, or we still can increase the limit of
queue_max_sectors() to the hardware allowed value.


-- 
Ming Lei
-------------- next part --------------
A non-text attachment was scrubbed...
Name: blk-no-sg-merge.patch
Type: text/x-patch
Size: 642 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20160106/a03321cd/attachment.bin>
