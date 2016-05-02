From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 2 May 2016 09:10:10 -0600
Subject: proper controller state machine and more common code V2
In-Reply-To: <1461671520-4758-1-git-send-email-hch@lst.de>
References: <1461671520-4758-1-git-send-email-hch@lst.de>
Message-ID: <57276DD2.90009@kernel.dk>

On 04/26/2016 05:51 AM, Christoph Hellwig wrote:
> This series introduces a controller state machine based on code that Sagi
> did for the Fabrics driver, and moves the namespace scanning and AER code
> to nvme-core now that we have that state machine.
>
> Changes since V1:
>   - renamed the finished_scan method to post_scan

Applied for 4.7.

-- 
Jens Axboe
