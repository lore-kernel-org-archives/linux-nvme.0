From: hch@infradead.org (Christoph Hellwig)
Date: Sat, 12 May 2018 06:34:53 -0700
Subject: [PATCH v2 2/7] nvme: revise nvme_set_queue_count to return error
 on some nvme status codes
In-Reply-To: <20180512005028.29661-3-jsmart2021@gmail.com>
References: <20180512005028.29661-1-jsmart2021@gmail.com>
 <20180512005028.29661-3-jsmart2021@gmail.com>
Message-ID: <20180512133453.GB14317@infradead.org>

On Fri, May 11, 2018@05:50:23PM -0700, James Smart wrote:
> The status codes that transports may generate are NVME_SC_ABORT_REQ and
> NVME_SC_INTERNAL. In those cases, return a positive error value with the
> value being the status code.

No, your transport should not come up with fake nvme errors, sorry.

And we need this code to ignore errors to bring up various
PCIe controller in degraded conditions.
