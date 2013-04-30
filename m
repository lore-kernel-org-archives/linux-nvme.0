From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Apr 2013 15:20:33 -0000
Subject: [PATCH] NVMe: Meta-data support in NVME_IOCTL_SUBMIT_IO
In-Reply-To: <1366759439-16265-1-git-send-email-keith.busch@intel.com>
References: <1366759439-16265-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LRH.2.03.1304090141480.25729@localhost.localdom>

On Tue, 23 Apr 2013, Keith Busch wrote:

> This adds support for namespaces with separate meta-data formats in the
> submit io ioctl. The meta-data buffer has to be a contiguous, so such
> a buffer is allocated and the mapped user pages are copied to/from this
> buffer for write/read commands.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

> +	ns->ms = id->lbaf[lbaf].ms;

Reviewing my own patch! This should be:

+	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
