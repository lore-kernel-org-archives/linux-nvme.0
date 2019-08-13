From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Aug 2019 19:08:50 +0200
Subject: [PATCHv3] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <955adc31-6d46-3187-54ac-8d342c117bf8@suse.de>
References: <20190812075147.79598-1-hare@suse.de>
 <20190813170144.GA10269@lst.de>
 <955adc31-6d46-3187-54ac-8d342c117bf8@suse.de>
Message-ID: <20190813170850.GA10538@lst.de>

On Tue, Aug 13, 2019@07:03:35PM +0200, Hannes Reinecke wrote:
> That was my worry, too.
> But I wasn't sure if that was the direction we should be going.
> Personally, I'd be more than happy to add a flag for non-retryable errors.
>
> Let's see how it would look like ...

Can you start by explaining what the actual problem is, e.g. what
you are doing, what the expected and what the actual behavior is.
That also belongs into the commit log.
