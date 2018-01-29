From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 29 Jan 2018 21:55:41 +0200
Subject: [PATCH] nvme-pci: use NOWAIT flag for nvme_set_host_mem
In-Reply-To: <20180129160145.GA25515@localhost.localdomain>
References: <1517195255-21832-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180129160145.GA25515@localhost.localdomain>
Message-ID: <1b7d3700-945f-9272-b6aa-d2ebeaf0cb1e@grimberg.me>

Hey Keith,

> Thanks for the fix. It looks like we still have a problem, though.
> Commands submitted with the "shutdown_lock" held need to be able to make
> forward progress without relying on a completion, but this one could
> block indefinitely.

Can you explain to me why is the shutdown_lock needed to synchronize
nvme_dev_disable? More concretely, how is nvme_dev_disable different
from other places where we rely on the ctrl state to serialize stuff?

The only reason I see would be to protect against completion-after-abort
scenario but I think the block layer should protect against it (checks
if the request timeout timer fired).
