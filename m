From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 20 Jun 2018 14:54:26 -0600
Subject: [PATCH] nvme: use __GFP_NOWARN for iod allocation
In-Reply-To: <20180620204310.GA24840@localhost.localdomain>
References: <4cb394ca-7032-ea67-5bb1-ef331e42ace2@kernel.dk>
 <b054a000-c7ad-9926-b45f-2771a98b7d23@kernel.dk>
 <b51cce4d-d0c9-fb4e-d5ac-2e48e23e18f7@kernel.dk>
 <20180620204310.GA24840@localhost.localdomain>
Message-ID: <34e64832-c345-3a70-401f-1915b5bb4af1@kernel.dk>

On 6/20/18 2:43 PM, Keith Busch wrote:
> On Wed, Jun 20, 2018@02:09:03PM -0600, Jens Axboe wrote:
>> On 6/20/18 1:16 PM, Jens Axboe wrote:
>>> On 6/20/18 1:10 PM, Jens Axboe wrote:
>>>> This begs the question is we should limit the size in general. The
>>>> command overhead is low enough that I think we should default to
>>>> something sane that doesn't require _any_ > 0 order allocations.
>>>>
>>>> Our default 1280kb will require 10248 bytes of iod, which is an
>>>> order 2 allocation.... That's not helping tail latencies in
>>>> data centers, where memory is always full and fragmented.
>>>
>>> In terms of sizing, defaulting to 256kb might not be a bad idea.
>>> That'd be 2056 bytes for a normal config. Alternatively we could
>>> go 1280/4 == 320k, which would be 2568 bytes.
>>>
>>> In any case, I think it's something that's worth doing.
>>
>> Talking more to myself - higher order allocations needed to make
>> progress isn't a viable approach. There may _never_ be any available,
>> which means we are stuck since this isn't backed by a mempool.
>>
>> How about something like the below. Default to a size that will
>> never require > PAGE_SIZE allocation, and back that with a single
>> entry mempool. Even if we don't wait on it, if we keep retrying
>> we'll always be able to allocate memory and make forward progress.
>> And allocating a single page is a hell of a lot more likely than
>> a 2nd order allocation.
> 
> If we go this route, there is a great deal of cleanup that can follow
> on. For example, we'll never need to chain PRPs, so nvme_iod setup/free
> can become a lot simpler, and the struct iod npages and hidden "iod_list"
> member can go away.

Missed this one before sending the other one out - yeah, I agree.
And since we already have the inline sg for smaller commands, I
think it makes a lot of sense to move in this direction.

I should also mention that this came out of a real life hang
on a production box. I suppose we haven't seen a lot of these
since a lot of nvme controllers have a hw limit of 128k, but
the ones that don't can pretty easily hit the hang of needing
2^2 pages and failing miserably forever.

-- 
Jens Axboe
