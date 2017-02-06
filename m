From: hch@lst.de (Christoph Hellwig)
Date: Mon, 6 Feb 2017 09:58:05 +0100
Subject: [PATCH v3 2/2] nvme: Enable autonomous power state transitions
In-Reply-To: <CALCETrW8dixddw-y4pitqOqUJbJn9BieYkb4fg90iYrsTh5Gcw@mail.gmail.com>
References: <cover.1486158145.git.luto@kernel.org>
 <348b90a06980a671ff82a6555cabbb292f46c837.1486158145.git.luto@kernel.org>
 <CALCETrW8dixddw-y4pitqOqUJbJn9BieYkb4fg90iYrsTh5Gcw@mail.gmail.com>
Message-ID: <20170206085805.GB22409@lst.de>

On Sat, Feb 04, 2017@07:46:45PM -0800, Andy Lutomirski wrote:
> The only decent argument I have for not just putting
> nvme_configure_apst() into nvme_init_identify() is the code in pci.c's
> nvme_setup_io_queues() that tears down the admin queue interrupt and
> the whole BAR mapping after nvme_init_identify().  This shouldn't be a
> problem, but it makes me a tiny bit nervous to have APST on when we do
> this -- is it plausible that something bad would happen if the NVMe
> device took a nap while we this happens?
> 
> Christoph, Keith, and/or Jens, any insight here?  Maybe I should stop
> worrying about this and just move everything into
> nvme_init_identify().

I would much prefer to move the code to nvme_init_identify.  The
NVMe spec has no prohibition on taking down interrupts after setting
up features.  In fact there are all kinds of drivers that run NVMe
devices without any interrupts at all.
