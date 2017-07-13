From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 13 Jul 2017 09:56:53 +0300
Subject: [PATCH] nvme/pci: Remove nvme_setup_prps BUG_ON
In-Reply-To: <1499889547-11018-1-git-send-email-keith.busch@intel.com>
References: <1499889547-11018-1-git-send-email-keith.busch@intel.com>
Message-ID: <34a00ee8-4e9c-ec53-95ca-df11d30514c4@grimberg.me>

> This patch replaces the invalid nvme SGL kernel panic with a warning,
> and returns an appropriate error. The warning will occur only on the
> first occurance, and sgl details will be printed to help debug how the
> request was allowed to form.

That's definitely needed! Looks great,

Reviewed-by: Sagi Grimberg <sagi at grimberg.m>
