From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 22 Oct 2015 16:27:03 +0000
Subject: [PATCH 4/9] nvme: do not restart the request timeout if we're
 resetting the controller
In-Reply-To: <1445515421-4940-5-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-5-git-send-email-hch@lst.de>
Message-ID: <20151022162702.GD21840@localhost.localdomain>

On Thu, Oct 22, 2015@02:03:36PM +0200, Christoph Hellwig wrote:
> Otherwise we're never going to complete a command when it is restarted just
> after we completed all other outstanding commands in nvme_clear_queue.

Returning BLK_EH_HANDLED to block mq's timeout handler has the block layer
complete the request. However, the reset work is going to force cancel
the request anyway, so the same command will be completed twice. That
can't be right ... right?

> @@ -1063,7 +1063,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  				 req->tag, nvmeq->qid);
>  		}
>  		spin_unlock_irq(&dev_list_lock);
> -		return BLK_EH_RESET_TIMER;
> +
> +		req->errors = -EIO;
> +		return BLK_EH_HANDLED;
>  	}
