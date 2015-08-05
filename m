From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 04 Aug 2015 21:45:54 -0400
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <1438716733-566-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Tue, 4 Aug 2015 13:32:13 -0600")
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1oaimik31.fsf@sermon.lab.mkp.net>

>>>>> "Keith" == Keith Busch <keith.busch at intel.com> writes:

Keith> The SG_GAPS queue flag caused checks for bio vector alignment
Keith> against PAGE_SIZE, but the device may have different
Keith> constraints. This patch adds a queue limits so a driver with such
Keith> constraints can set to allow requests that would have been
Keith> unnecessarily split. The new gaps check takes the request_queue
Keith> as a parameter to simplify the logic around invoking this
Keith> function.

Keith> This new limit makes the queue flag redundant, so removing it and
Keith> all usage. Device-mappers will inherit the correct settings
Keith> through blk_stack_limits().

This looks good to me except for the typo in the Subject: line.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
