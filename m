From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 9 May 2018 08:16:12 -0600
Subject: [PATCH v3] nvme: add quirk to force medium priority for SQ
 creation
In-Reply-To: <20180509140544.GA679@localhost.localdomain>
References: <672a97be-7fbf-b21e-9f75-2c18e64ccf8f@kernel.dk>
 <20180509044014.GA10650@infradead.org>
 <20180509140544.GA679@localhost.localdomain>
Message-ID: <72d53f64-853f-e326-65e2-c6ee1a55910d@kernel.dk>

On 5/9/18 8:05 AM, Keith Busch wrote:
> On Tue, May 08, 2018@09:40:14PM -0700, Christoph Hellwig wrote:
>> On Tue, May 08, 2018@10:25:15AM -0600, Jens Axboe wrote:
>>> Some P3100 drives have a bug where they think WRRU (weighted round
>>> robin) is always enabled, even though the host doesn't set it. Since
>>> they think it's enabled, they also look at the submission queue
>>> creation priority. We used to set that to MEDIUM by default,
>>> but that was removed in commit 81c1cd98351b. This causes various
>>> issues on that drive. Add a quick to still set MEDIUM priority
>>> for that controller.
>>
>> And this really isn't something that could be fixed with a trivial
>> firmware uptodate?  I'd really hate to pile on hacks like this if we
>> can somehow avoid it.
> 
> Agreed, we don't like resorting to this option; we have only 32 entries
> in the quirk table before we're out of bits. In this case, though, all
> device side options for this issue were explored before considering a
> driver-side work-around.

Indeed, this has to be a software work-around, unfortunately.

-- 
Jens Axboe
