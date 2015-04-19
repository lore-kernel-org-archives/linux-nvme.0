From: m@bjorling.me (Matias Bjorling)
Date: Sun, 19 Apr 2015 20:12:58 +0200
Subject: [PATCH 1/5 v2] blk-mq: Add prep/unprep support
In-Reply-To: <20150418201610.GB20311@infradead.org>
References: <1429101284-19490-1-git-send-email-m@bjorling.me>
 <1429101284-19490-2-git-send-email-m@bjorling.me>
 <20150417063439.GB389@infradead.org> <5530C132.30107@bjorling.me>
 <20150417174630.GA10249@infradead.org> <5531FD7F.8070809@bjorling.me>
 <20150418201610.GB20311@infradead.org>
Message-ID: <5533F02A.6020208@bjorling.me>

> On Sat, Apr 18, 2015@08:45:19AM +0200, Matias Bjorling wrote:
<snip>
>> The reason it shouldn't be under the a single block device, is that a target
>> should be able to provide a global address space.
>> That allows the address
>> space to grow/shrink dynamically with the disks. Allowing a continuously
>> growing address space, where disks can be added/removed as requirements grow
>> or flash ages. Not on a sector level, but on a flash block level.
>
> I don't understand what you mean with a single block device here, but I
> suspect we're talking past each other somehow.

Sorry. I meant that several block devices should form a single address 
space (exposed as a single block device), consisting of all the flash 
blocks. Applications could then get/put from that.

Thanks for your feedback. I'll push the pieces around and make the 
integration self-contained outside of the block layer.
