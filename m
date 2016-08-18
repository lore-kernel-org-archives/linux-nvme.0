From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 18 Aug 2016 13:30:54 -0700
Subject: two small nvmf fixes for 4.8
In-Reply-To: <1471544196-30525-1-git-send-email-hch@lst.de>
References: <1471544196-30525-1-git-send-email-hch@lst.de>
Message-ID: <1471552254.31578.17.camel@linux.intel.com>

On Thu, 2016-08-18@11:16 -0700, Christoph Hellwig wrote:
> One is a potential use after free that will actually be easy to
> trigger
> with the new default hostnqn support in nvme-cli, and the other fixes
> up the dependencies in the Kconfig file so that we don't always drag
> in
> the traditional NVMe PCIe driver.
> 

Series looks good to me,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
