From: gmazyland@gmail.com (Milan Broz)
Date: Sat, 15 Apr 2017 14:10:17 +0200
Subject: [PATCH 09/22] dm-crypt: Make use of the new sg_map helper in 4
 call sites
In-Reply-To: <302ae5ab-d515-5427-2e54-d58a9cdb8241@deltatee.com>
References: <1492121135-4437-1-git-send-email-logang@deltatee.com>
 <1492121135-4437-10-git-send-email-logang@deltatee.com>
 <20170414083921.GC25471@lst.de>
 <302ae5ab-d515-5427-2e54-d58a9cdb8241@deltatee.com>
Message-ID: <22703638-27a9-7dc5-5180-536f61661592@gmail.com>

On 04/14/2017 06:03 PM, Logan Gunthorpe wrote:
> 
> 
> On 14/04/17 02:39 AM, Christoph Hellwig wrote:
>> On Thu, Apr 13, 2017@04:05:22PM -0600, Logan Gunthorpe wrote:
>>> Very straightforward conversion to the new function in all four spots.
>>
>> I think the right fix here is to switch dm-crypt to the ahash API
>> that takes a scatterlist.
> 
> Hmm, well I'm not sure I understand the code enough to make that
> conversion. But I was looking at it. One tricky bit seems to be that
> crypt_iv_lmk_one adds a seed, skips the first 16 bytes in the page and
> then hashes another 16 bytes from other data. What would you do
> construct a new sgl for it and pass it to the ahash api?
> 
> The other thing is crypt_iv_lmk_post also seems to modify the page after
> the hash with a  crypto_xor so you'd still need at least one kmap in there.

yes, it is in fact modification of CBC mode implemented this hacky way.
These IVs are only for compatibility with loopaes and very old trueCrypt formats.

I think your patch is ok (if it is just plain conversion), if it is
really needed, we can switch to ahash later in follow-up patch.

All common code in dmcrypt uses async API already.

p.s.
there is a lot of lists on cc, but for this patch is missing dm-devel, dmcrypt changes
need to go through Mike's tree (I added dm-devel to cc:)

Milan
