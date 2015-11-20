From: axboe@fb.com (Jens Axboe)
Date: Fri, 20 Nov 2015 14:47:30 -0700
Subject: [PATCH 02/47] block: fix blk_abort_request for blk-mq drivers
In-Reply-To: <x491tbkcpp2.fsf@segfault.boston.devel.redhat.com>
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-3-git-send-email-hch@lst.de>
 <x491tbkcpp2.fsf@segfault.boston.devel.redhat.com>
Message-ID: <564F94F2.1030603@fb.com>

On 11/20/2015 02:43 PM, Jeff Moyer wrote:
> Christoph Hellwig <hch at lst.de> writes:
>
>> We only added the request to the request list for the !blk-mq case,
>> so we should only delete it in that case as well.
>
> Sorry, I don't follow.  Do you mean the timeout_list?  It appears to me
> that blk_add_timer is called for both the old and mq paths.

It is called for both, but only !mq adds it to the list. We don't need 
that tracking on the mq side, as we can look it up in our tags.

-- 
Jens Axboe
