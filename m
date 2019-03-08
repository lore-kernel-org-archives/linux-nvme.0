From: andrew.smirnov@gmail.com (Andrey Smirnov)
Date: Fri, 8 Mar 2019 10:58:43 -0800
Subject: [PATCH] nvme-core: Share code between nvme_wait_ready() and
 nvme_shutdown_ctrl()
In-Reply-To: <20190308132355.GA18218@lst.de>
References: <20190207001312.13672-1-andrew.smirnov@gmail.com>
 <20190308132355.GA18218@lst.de>
Message-ID: <CAHQ1cqGxkz3F+taV5PUCkK7ayqU4QsmxOjr6-TUEgh7c38xg2Q@mail.gmail.com>

On Fri, Mar 8, 2019@5:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Feb 06, 2019@04:13:12PM -0800, Andrey Smirnov wrote:
> > Code polling NVME_CSTS_SHST_CMPLT in nvme_shutdown_ctrl() is very
> > similar to polling loop in nvme_wait_ready(). Move shared polling loop
> > code into __nvme_wait_ready() and re-implement both
> > nvme_shutdown_ctrl() and nvme_wait_ready() on top of it to avoid code
> > repetition.
>
> Is there any deeper reason why we would want this?  It only saves
> 6 lines of code, but makes the functions much harder to read.

No, there's no deeper reason.

Thanks,
Andrey Smirnov
