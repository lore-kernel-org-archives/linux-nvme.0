From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:32:30 -0400
Subject: [PATCH v2 4/4] nvme-pci: open-code polling logic in nvme_poll
In-Reply-To: <1497796090-14808-5-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
 <1497796090-14808-5-git-send-email-sagi@grimberg.me>
Message-ID: <20170619163229.GE21765@localhost.localdomain>

On Sun, Jun 18, 2017@05:28:10PM +0300, Sagi Grimberg wrote:
> Given that the code is simple enough it seems better
> then passing a tag by reference for each call site, also
> we can now get rid of __nvme_process_cq.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks good, and the previous patch makes more sense along with this.

Reviewed-by: Keith Busch <keith.busch at intelcom>
