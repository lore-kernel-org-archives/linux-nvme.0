From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 31 Mar 2015 10:38:29 -0600
Subject: [PATCH] embedded iod mask cleanup
In-Reply-To: <1427419292-27518-1-git-send-email-chong.yuan@memblaze.com>
References: <1427419292-27518-1-git-send-email-chong.yuan@memblaze.com>
Message-ID: <551ACD85.7080606@kernel.dk>

On 03/26/2015 07:21 PM, Chong Yuan wrote:
> Remove unused mask in nvme_alloc_iod

Looks like a leftover from a rewrite of the embedded iod handling. 
Applied for 4.1.

-- 
Jens Axboe
