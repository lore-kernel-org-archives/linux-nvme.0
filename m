From: axboe@fb.com (Jens Axboe)
Date: Fri, 12 Feb 2016 08:09:05 -0700
Subject: [PATCHv2-4.5 00/10] NVMe fixes
In-Reply-To: <20160212083508.GA18432@infradead.org>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
 <20160211222848.GA19595@localhost.localdomain> <56BD0D4A.60003@fb.com>
 <20160212083508.GA18432@infradead.org>
Message-ID: <56BDF591.5030804@fb.com>

On 02/12/2016 01:35 AM, Christoph Hellwig wrote:
> On Thu, Feb 11, 2016@03:38:02PM -0700, Jens Axboe wrote:
>> I already applied these for 4.5, just didn't send the ack before I had done
>> some testing. JFYI.
>
> Argg - some of these including the namespace removal changes absolutely
> move into the wrong direction.  I've just been busy reviewing the easier
> parts first before coming up with better ways for those.

Let's just kill the series, it's not in the 4.6 branch yet either. I'll 
rebase for-linus.

-- 
Jens Axboe
