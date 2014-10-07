From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 07 Oct 2014 10:54:39 -0400
Subject: [PATCH 1/2] block: Implement support for write zeros
In-Reply-To: <20141007142127.GA5393@wil.cx> (Matthew Wilcox's message of "Tue, 
 7 Oct 2014 10:21:27 -0400")
References: <1404841359-24595-1-git-send-email-keith.busch@intel.com>
 <20141007142127.GA5393@wil.cx>
Message-ID: <yq14mvgexqo.fsf@sermon.lab.mkp.net>

>>>>> "Matthew" == Matthew Wilcox <willy at linux.intel.com> writes:

Matthew> Jens, did you want to ACK/NACK this one?  It seems resaonable
Matthew> to me.

But since that WRITE ZEROES fell in T10/T13 it would be an NVMe-specific
command (and it is already a subset of the existing WRITE SAME).

Since I'm redoing the zeroout/discard stuff for 3.19 anyway I'd rather
we wait and I can work with Keith on this.

-- 
Martin K. Petersen	Oracle Linux Engineering
