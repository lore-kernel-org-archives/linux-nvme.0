From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Feb 2018 11:31:04 -0700
Subject: [PATCH 4/6] nvme-pci: break up nvme_timeout and nvme_dev_disable
In-Reply-To: <1517554849-7802-5-git-send-email-jianchao.w.wang@oracle.com>
References: <1517554849-7802-1-git-send-email-jianchao.w.wang@oracle.com>
 <1517554849-7802-5-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180202183103.GI24417@localhost.localdomain>

On Fri, Feb 02, 2018@03:00:47PM +0800, Jianchao Wang wrote:
> Currently, the complicated relationship between nvme_dev_disable
> and nvme_timeout has become a devil that will introduce many
> circular pattern which may trigger deadlock or IO hang. Let's
> enumerate the tangles between them:
>  - nvme_timeout has to invoke nvme_dev_disable to stop the
>    controller doing DMA access before free the request.
>  - nvme_dev_disable has to depend on nvme_timeout to complete
>    adminq requests to set HMB or delete sq/cq when the controller
>    has no response.
>  - nvme_dev_disable will race with nvme_timeout when cancels the
>    outstanding requests.

Your patch is releasing a command back to the OS with the
PCI controller bus master still enabled. This could lead to data or
memory corruption.

In any case, it's not as complicated as you're making it out to
be. It'd be easier to just enforce the exisiting rule that commands
issued in the disabling path not depend on completions or timeout
handling. All of commands issued in this path already do this except
for HMB disabling. Let'sjust fix that command, right?
