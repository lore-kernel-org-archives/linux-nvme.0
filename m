From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 27 Oct 2018 01:26:23 -0700
Subject: Duplicate subnqn of NVMe SSD Controllers
In-Reply-To: <5m6gor-7xj0dn5dtb12x1b8f3-xfsypw-s3pjnd-oq8eyy-82l7b1-qdnqdci1wm87jp0w3aj5wymq-xt9rda-x787pwq8q8mz-118hyj7ztvz0flkog2-9es5q86pqysjjks19b-ps9rfn-a0r0vp7260ev.1540625692098@email.android.com>
References: <5m6gor-7xj0dn5dtb12x1b8f3-xfsypw-s3pjnd-oq8eyy-82l7b1-qdnqdci1wm87jp0w3aj5wymq-xt9rda-x787pwq8q8mz-118hyj7ztvz0flkog2-9es5q86pqysjjks19b-ps9rfn-a0r0vp7260ev.1540625692098@email.android.com>
Message-ID: <20181027082623.GA25033@infradead.org>

On Sat, Oct 27, 2018@03:34:52PM +0800, zhitaoli1201@163.com wrote:
> Hello, everyone,
> 
> 
> I am Zhitao Li, interested in Linux kernel and?SSDs.
> 
> I am writing nvme device drivers based on my Open-channel SSDs. However, when two SSDs are connected to motherboard and Linux(4.17) boots, following warning information will be printed in the booting process:
> 
> 
> "nvme nvme1: ignoring ctrl due to duplicate subnqn (nqn.2014.08.org.nvmexpress:1ded1dedAA....)"

This means your devices have a duplicate serial (and model, but that is
expected) number, which means they are buggy in a way that can have
data integrity consequences.  Please talk to the vendor so that the
firmware will provide a proper unique serial number.
