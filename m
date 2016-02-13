From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 13 Feb 2016 02:01:01 -0800
Subject: [PATCH] nvme: lightnvm: return ppa completion status
In-Reply-To: <1455190589-20016-2-git-send-email-m@bjorling.me>
References: <1455190589-20016-1-git-send-email-m@bjorling.me>
 <1455190589-20016-2-git-send-email-m@bjorling.me>
Message-ID: <20160213100101.GA28353@infradead.org>

On Thu, Feb 11, 2016@12:36:29PM +0100, Matias Bj??rling wrote:
> PPAs sent to device is separately acknowledge in a 64bit status
> variable. The status is stored in DW0 and DW1 of the completion queue
> entry. Store this status inside the nvm_rq for further processing.
> 
> This can later be used to implement retry techniques for failed writes
> and reads.
> 
> Signed-off-by: Matias Bj??rling <m at bjorling.me>

Looks reasonable:

Reviewed-by: Christoph Hellwig <hch at lst.de>
