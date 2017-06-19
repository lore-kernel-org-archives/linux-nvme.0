From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:01:03 -0400
Subject: [PATCH v2 2/2] nvme: use a single NVME_AQ_DEPTH and relax it to 32
In-Reply-To: <1497791759-5754-2-git-send-email-sagi@grimberg.me>
References: <1497791759-5754-1-git-send-email-sagi@grimberg.me>
 <1497791759-5754-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170619160103.GA21765@localhost.localdomain>

On Sun, Jun 18, 2017@04:15:59PM +0300, Sagi Grimberg wrote:
> No need to differentiate fabrics from pci/loop, also lower
> it to 32 as we don't really need 256 inflight admin commands.

Might want to check with Jens on reducing the count. d31af0a325ca4f increased the
limit from 64 to 256 for a particular use case.
