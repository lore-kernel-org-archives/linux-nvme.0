From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Feb 2018 12:15:19 -0700
Subject: [PATCH] nvme-pci: drain the entered requests after ctrl is
 shutdown
In-Reply-To: <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
References: <1518440222-652-1-git-send-email-jianchao.w.wang@oracle.com>
 <b466996e-b00a-e848-25a0-e6ba768a573f@grimberg.me>
Message-ID: <20180212191519.GD16255@localhost.localdomain>

On Mon, Feb 12, 2018@08:43:58PM +0200, Sagi Grimberg wrote:
> 
> > Currently, we will unquiesce the queues after the controller is
> > shutdown to avoid residual requests to be stuck. In fact, we can
> > do it more cleanly, just wait freeze and drain the queue in
> > nvme_dev_disable and finally leave the queues quiesced.
> 
> Does this fix a bug? What is the benefit of leaving the queues
> quiesced in shutdown?

This doesn't appear to fix anything. The things this patch does do are
either unnecessary (quiece), or already done elsewhere (wait freeze).
