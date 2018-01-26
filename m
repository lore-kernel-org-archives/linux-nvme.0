From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Jan 2018 08:54:25 +0100
Subject: [PATCH v2 0/1] nvme: Add fault injection feature
In-Reply-To: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
References: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
Message-ID: <20180126075425.GC2356@lst.de>

On Wed, Jan 24, 2018@03:23:09PM -0500, Thomas Tai wrote:
> Linux's fault injection framework provides a systematic way to support
> error injection via debugfs in the /sys/kernel/debug directory. This
> patch uses the framework to add error injection to NVMe driver. 

Care to expand on the use cases a bit more?  Especially on what this
buys us vs block layer error injection?
