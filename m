From: axboe@fb.com (Jens Axboe)
Date: Tue, 17 Jan 2017 23:06:09 -0800
Subject: [PATCH 0/3] nvme: APST support
In-Reply-To: <cover.1484703713.git.luto@kernel.org>
References: <cover.1484703713.git.luto@kernel.org>
Message-ID: <ea94f6b8-61d3-b4c1-719b-dccf7cc474ad@fb.com>

On 01/17/2017 05:54 PM, Andy Lutomirski wrote:
> As far as I can tell, APST works fine on every NVMe device I'm aware
> of with the single exception of a particular Samsung device.  This
> series enables APST by default but quirks it off on the offending
> Samsung device.  Some Samsung engineers are taking a look, and,
> depending on what they find, we may be able to change the quirk to
> work around the bug rather than disabling APST outright.

Funky, so we did have hardware problems after all...

I think you need to flip this series, where you first add the
blacklist and the samsung blacklist entry, before adding the
feature. In the current order, you have a bisection point
that's potentially broken.

Apart from that, looks OK to me.

-- 
Jens Axboe
