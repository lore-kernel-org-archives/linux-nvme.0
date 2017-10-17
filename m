From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Oct 2017 23:50:55 -0700
Subject: [PATCH v2 0/3] Move tagset reinit to its only current consumer,
 nvme-core
In-Reply-To: <718a34b5-b28e-fc4f-5b42-f961dde53482@kernel.dk>
References: <1507715588-1041-1-git-send-email-sagi@grimberg.me>
 <20171016124817.GB26833@infradead.org>
 <718a34b5-b28e-fc4f-5b42-f961dde53482@kernel.dk>
Message-ID: <20171017065055.GA4164@infradead.org>

On Mon, Oct 16, 2017@08:47:38AM -0600, Jens Axboe wrote:
> On 10/16/2017 06:48 AM, Christoph Hellwig wrote:
> > Jens, are you fine with picking this up throught the nvme tree?
> > I think Sagi's later changes rely on it, so that would make life
> > a littler easier.
> 
> Yeah that's fine, you can add my reviewed-by to the patches
> as well.

Ok, applied to nvme-4.15 with your ACK.
