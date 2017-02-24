From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 24 Feb 2017 15:12:32 -0700
Subject: NVMe IO error due to abort..
In-Reply-To: <CA+55aFw8=Xh=GS0KJzYKcV612EtWOvCMkfZe7H3vGT8W7AYmwQ@mail.gmail.com>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
 <CA+55aFxpdWPL3=X1gop4jeCk7JQpT4KMvaUq2aAeSfNNW6N=kg@mail.gmail.com>
 <CA+55aFwA+=ojRqcydxa-6ZGqHo+YJqEQqaa9w6HpKtYPmsN+jw@mail.gmail.com>
 <CA+55aFzb8uLKbYaAdGHkJzRfSSqzr3irh0EOQ5NTO4Noeb8htw@mail.gmail.com>
 <18390BD4-644C-40DD-A6FF-E8327962D5F2@kernel.dk>
 <7cc18f03-935e-c053-8752-1c42b711f441@kernel.dk>
 <CA+55aFw8=Xh=GS0KJzYKcV612EtWOvCMkfZe7H3vGT8W7AYmwQ@mail.gmail.com>
Message-ID: <38e75ee9-e20a-3a64-c570-c780cb593958@kernel.dk>

On 02/24/2017 02:55 PM, Linus Torvalds wrote:
> On Fri, Feb 24, 2017@1:35 PM, Jens Axboe <axboe@kernel.dk> wrote:
>>
>> And below is the branch info. I was going to send this in pretty soon
>> anyway, but lets see what happens.
>>
>>   git://git.kernel.dk/linux-block.git for-linus
> 
> Can you give me an overview of this all for the merge message. Might
> as well merge this properly regardless.

Yes sure, this pull request contains:

- NVMe updates and fixes that missed the first pull request. This
  includes bug fixes, and support for autonomous power management.

- Fix from Christoph for missing clear of the request payload,
  causing a problem with (at least) the storvsc driver.

- Further fixes for the queue/bdi life time issues from Jan.

- The Kconfig mq scheduler update from me.

- Fixing a use-after-free in dm-rq, spotted by Bart, introduced
  in this merge window.

- Three fixes for nbd from Josef.

- Bug fix from Omar, fixing a bug in sas transport code that
  oopses when bsg ioctls were used. From Omar.

- Improvements to the queue restart and tag wait from from
  Omar.

- Set of fixes for the sed/opal code from Scott.

- Three trivial patches to cciss from Tobin

> I'm currently just building things in a loop on the old Fedora kernel,
> just to verify stability (I had already pruned away my own 4.10 kernel
> due to the earlier "git bisect" I did on that machine due to the
> touchpad issue earlier in the merge window, so I'm using the distro
> kernel just to verify that it really isn't any new hw issue).
> 
> I'm pretty sure the hw is fine, but I'll do that a bit more, before I
> go back to current head of git for testing.
> 
> But that means I might as well just have this all already merged
> (which I do on my main desktop that has so far not shown any signs of
> this issue).

It's a puzzling issue. Let me know how it goes with the above merge, and
I can add some debug code to try and narrow this down.

-- 
Jens Axboe
