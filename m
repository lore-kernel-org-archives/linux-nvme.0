From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 12 Feb 2016 00:35:08 -0800
Subject: [PATCHv2-4.5 00/10] NVMe fixes
In-Reply-To: <56BD0D4A.60003@fb.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <20160211222848.GA19595@localhost.localdomain>
 <56BD0D4A.60003@fb.com>
Message-ID: <20160212083508.GA18432@infradead.org>

On Thu, Feb 11, 2016@03:38:02PM -0700, Jens Axboe wrote:
> I already applied these for 4.5, just didn't send the ack before I had done
> some testing. JFYI.

Argg - some of these including the namespace removal changes absolutely
move into the wrong direction.  I've just been busy reviewing the easier
parts first before coming up with better ways for those.
