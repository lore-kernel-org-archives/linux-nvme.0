From: axboe@fb.com (Jens Axboe)
Date: Wed, 19 Oct 2016 11:01:31 -0600
Subject: nvme header updates
In-Reply-To: <20161019165318.GA28931@infradead.org>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
 <20161019165318.GA28931@infradead.org>
Message-ID: <2caba216-e0fe-341b-83df-cddb67d26b76@fb.com>

On 10/19/2016 10:53 AM, Christoph Hellwig wrote:
> On Fri, Sep 30, 2016@01:51:05PM +0200, Christoph Hellwig wrote:
>> This series resyncs nvme.h to that it can be reused by nvme-cli, and
>> while at that brings over another enums so far only used in nvme-cli.
>
> Jens, is this something still doable for 4.9?  It would help us to keep
> nvme.h in sync with nvme-cli.

Seems minor enough that we can, I'll apply it for 4.9.

-- 
Jens Axboe
