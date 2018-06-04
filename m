From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 4 Jun 2018 16:46:54 -0600
Subject: [PATCHv3 7/9] nvme-pci: Attempt reset retry for IO failures
In-Reply-To: <d81b6cb4-ba05-df56-3b21-e79e9a1a6fc9@grimberg.me>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-8-keith.busch@intel.com>
 <d81b6cb4-ba05-df56-3b21-e79e9a1a6fc9@grimberg.me>
Message-ID: <20180604224654.GA8782@localhost.localdomain>

On Thu, May 31, 2018@02:40:26AM +0300, Sagi Grimberg wrote:
> > If the reset failed due to a non-fatal error, this patch will attempt
> > to reset the controller again, with a maximum of 4 attempts.
> 
> curious, where did 4 came from?

It was a pretty arbitrary choice based on what passed a modified blktests
block/011. I don't really like having test code deciding how a driver
should behave, so I'm okay with either changing the retry counts,
or just dropping this patch to have the driver unbind on init errors
instead of retrying.
