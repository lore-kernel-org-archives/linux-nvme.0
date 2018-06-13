From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Jun 2018 04:31:50 -0700
Subject: [PATCH v3 2/4] nvme_fc: change controllers first connect to use
 reconnect path
In-Reply-To: <20180612235028.17969-3-jsmart2021@gmail.com>
References: <20180612235028.17969-1-jsmart2021@gmail.com>
 <20180612235028.17969-3-jsmart2021@gmail.com>
Message-ID: <20180613113150.GB18531@infradead.org>

> Note: this patch is dependent on these changes that have been
> added to the nvme-cli utility:
> - nvme-cli: Wait for device file if not present after successful add_ctrl
> - nvme-cli: Add ioctl retry support for "connect-all"

Which means it breaks backwards compatibility.  We can't do that.

IFF we actually end up wanting async connect it needs to be an
explicit opt-it with a new option.

In the meantime I really like this code in general, so please resubmit
it with a flush_delayed_work to make it synchronus.
