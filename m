From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 10 Feb 2016 17:53:10 -0500
Subject: [PATCH for-4.5 04/13] NVMe: Set queue limits max_dev_sectors
In-Reply-To: <20160210194907.GA23402@localhost.localdomain> (Keith Busch's
 message of "Wed, 10 Feb 2016 19:49:07 +0000")
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-5-git-send-email-keith.busch@intel.com>
 <20160210182051.GA28235@infradead.org>
 <20160210182416.GC32064@localhost.localdomain>
 <20160210184031.GB7512@infradead.org>
 <20160210194907.GA23402@localhost.localdomain>
Message-ID: <yq1bn7o9nzd.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> Heh, that's pretty funny. I mentioned something along those lines
Keith> after I broke the the block layer in rc1, but thought it was done
Keith> that way on purpose. :)

Keith> So instead of this nvme specific patch, we should do this?

Yes. Thinko on my part, sorry about that.

Acked-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
