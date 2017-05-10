From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 09:57:29 -0700
Subject: [PATCH V2] nvmf: keep track of nvmet connect error status
In-Reply-To: <1493725066-10096-1-git-send-email-guanjunxiong@huawei.com>
References: <1493725066-10096-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <20170510165729.GA15161@infradead.org>

On Tue, May 02, 2017@07:37:46PM +0800, Guan Junxiong wrote:
> To let the host know what happends to the connection establishment,
> adjust the behavior of nvmf_log_connect_error to make more connect
> specifig error codes human-readble.

Hi Guan,

I was just going to apply your patches, but they all miss the
Signed-off-by: line.  Can you add it and resend, and I'll queue the
patch up?

Please also pick up the Reviewed-by: tag from Sagi while you're at it.
