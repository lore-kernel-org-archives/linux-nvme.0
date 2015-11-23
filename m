From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 23 Nov 2015 07:46:40 -0800
Subject: [PATCH] nvmet: Improve device_path output
In-Reply-To: <1448287153-28318-1-git-send-email-ianb@mellanox.com>
References: <1448287153-28318-1-git-send-email-ianb@mellanox.com>
Message-ID: <20151123154640.GB20924@infradead.org>

On Mon, Nov 23, 2015@03:59:13PM +0200, Ian Bakshan wrote:
> Add '\n' when printing device path.
> 
> Signed-off-by: Ian Bakshan <ianb at mellanox.com>
> Reviewed-by: Sagi Grimberg <sagig at mellanox.com>


Thanks, this looks sensibe.  Note that it can't currently handle
a newline at the input side either, they might be even more useful to
fix.
