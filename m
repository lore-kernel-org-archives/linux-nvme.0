From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 16 Nov 2016 21:48:02 -0500
Subject: [PATCH 2/5] block: add support for REQ_OP_WRITE_ZEROES
In-Reply-To: <20161116175906.GA10050@localhost.localdomain> (Keith Busch's
 message of "Wed, 16 Nov 2016 12:59:07 -0500")
References: <1479279039-25818-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1479279039-25818-3-git-send-email-chaitanya.kulkarni@hgst.com>
 <20161116175906.GA10050@localhost.localdomain>
Message-ID: <yq1h976akkd.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> Your maximum bi_size exceeds the 2-bytes an NVMe Write Zeroes
Keith> command provides for the block count. Instead of having a simple
Keith> queue flag for write zeroes support, have it take a max sectors
Keith> value instead.

Yes, please. Make it a queue limit and make sure it is properly stacked.

The rest looks sensible to me. I'll wire up the SCSI pieces.

-- 
Martin K. Petersen	Oracle Linux Engineering
