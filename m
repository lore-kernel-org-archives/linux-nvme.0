From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 29 Jan 2018 16:06:13 +0800
Subject: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
In-Reply-To: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <40b52195-95c8-4c33-39cc-dc80043161a2@oracle.com>



On 01/29/2018 11:07 AM, Jianchao Wang wrote:
> nvme_set_host_mem will invoke nvme_alloc_request without NOWAIT
> flag, it is unsafe for nvme_dev_disable. The adminq driver tags
> may have been used up when the previous outstanding adminq requests
> cannot be completed due to some hardware error. We have to depend
> on the timeout path to complete the previous outstanding adminq
> requests and free the tags.
> However, nvme_timeout will invoke nvme_dev_disable and try to
> get the shutdown_lock which is held by another context who is
> sleeping to wait for the tags to be freed by timeout path. A
> deadlock comes up.
> 
> To fix it, let nvme_set_host_mem use NOWAIT flag.

In fact, this is the only case about nvme_set_host_mem in
nvme_dev_disable.
Consider the following case:

A adminq request expired.

timeout_work context
nvme_timeout
  -> nvme_dev_disable
    -> nvme_set_host_mem
    if this adminq request expires again, the timeout_work
    cannot handle this case, because it is waiting for the
    result of nvme_set_host_mem.

Thanks
Jianchao
