From: axboe@fb.com (Jens Axboe)
Date: Thu, 11 Feb 2016 15:38:02 -0700
Subject: [PATCHv2-4.5 00/10] NVMe fixes
In-Reply-To: <20160211222848.GA19595@localhost.localdomain>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <20160211222848.GA19595@localhost.localdomain>
Message-ID: <56BD0D4A.60003@fb.com>

On 02/11/2016 03:28 PM, Keith Busch wrote:
> Just want to point out a couple issues. Both are easy fixes and will
> send in a few minutes.
>
> First, admin queues don't have namespaces, so the new namespace state
> check isn't always correct. I haven't been able to synthesize a test that
> gets an admin command down this path in the disabled queue condition,
> but it's clearly not correct.
>
> The second issue potentially existed all along, but it's a littlie easier
> to hit now: we need to lock out shutdown from manipulating registers
> while they're being setup. This was hit by forcing controller reset from
> the shelll in a loop, then "rmmod nvme" at the same time.

I already applied these for 4.5, just didn't send the ack before I had 
done some testing. JFYI.

-- 
Jens Axboe
