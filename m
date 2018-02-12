From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Feb 2018 20:43:58 +0200
Subject: [PATCH] nvme-pci: drain the entered requests after ctrl is
 shutdown
In-Reply-To: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>


> Currently, we will unquiesce the queues after the controller is
> shutdown to avoid residual requests to be stuck. In fact, we can
> do it more cleanly, just wait freeze and drain the queue in
> nvme_dev_disable and finally leave the queues quiesced.

Does this fix a bug? What is the benefit of leaving the queues
quiesced in shutdown?
