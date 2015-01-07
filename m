From: axboe@fb.com (Jens Axboe)
Date: Wed, 7 Jan 2015 09:16:17 -0700
Subject: [PATCHv2 05/10] blk-mq: Allow requests to never expire
In-Reply-To: <1420599484-21582-6-git-send-email-keith.busch@intel.com>
References: <1420599484-21582-1-git-send-email-keith.busch@intel.com>
 <1420599484-21582-6-git-send-email-keith.busch@intel.com>
Message-ID: <54AD5BD1.1030503@fb.com>

On 01/06/2015 07:57 PM, Keith Busch wrote:
> Some requests may be started but have no gaurantee they'll ever
> complete. This defines a special timeout value that a driver can use so
> the request will never be timed out.

What if the timeout just happens to be UINT_MAX for the regular case? I 
think it'd be a lot safer to add a specific no-timeout flag to the 
request instead.

-- 
Jens Axboe
