From: hch@lst.de (Christoph Hellwig)
Date: Fri, 8 Mar 2019 14:23:55 +0100
Subject: [PATCH] nvme-core: Share code between nvme_wait_ready() and
 nvme_shutdown_ctrl()
In-Reply-To: <20190207001312.13672-1-andrew.smirnov@gmail.com>
References: <20190207001312.13672-1-andrew.smirnov@gmail.com>
Message-ID: <20190308132355.GA18218@lst.de>

On Wed, Feb 06, 2019@04:13:12PM -0800, Andrey Smirnov wrote:
> Code polling NVME_CSTS_SHST_CMPLT in nvme_shutdown_ctrl() is very
> similar to polling loop in nvme_wait_ready(). Move shared polling loop
> code into __nvme_wait_ready() and re-implement both
> nvme_shutdown_ctrl() and nvme_wait_ready() on top of it to avoid code
> repetition.

Is there any deeper reason why we would want this?  It only saves
6 lines of code, but makes the functions much harder to read.
