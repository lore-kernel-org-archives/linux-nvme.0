From: axboe@fb.com (Jens Axboe)
Date: Thu, 14 Apr 2016 14:03:35 -0600
Subject: I/O 0 QID 0 timeout, disable controller - kernel 4.4 / 4.5 NVMe
 controller dropouts
In-Reply-To: <20160414152326.GA12458@infradead.org>
References: <1DC99E13-F6CB-4B7F-AFD7-187825DEE523@fastmail.com>
 <20160414132113.GA21794@localhost.localdomain> <570FA450.7080105@fb.com>
 <20160414152326.GA12458@infradead.org>
Message-ID: <570FF797.2000109@fb.com>

On 04/14/2016 09:23 AM, Christoph Hellwig wrote:
> The code in the 4.7 tree still falls back to legacy irqs, it just tries
> MSI-X first, then MSI, then legacy.  Which seems a common patters in
> MSI-X using drivers, as I've just started a tree wide audit for the
> usage of the MSI/MSI-X APIs.

Yeah, that seems sane. OK, let's queue it up for 4.6, it's sucks to have 
known broken behavior like the current out there.

-- 
Jens Axboe
