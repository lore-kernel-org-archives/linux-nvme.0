From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 09:16:06 -0600
Subject: [PATCH 04/13] nvme: don't send keep-alives to the discovery controller
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <20180412151615.5176-5-keith.busch@intel.com>

From: Johannes Thumshirn <jthumshirn@suse.de>

NVMe over Fabrics 1.0 Section 5.2 "Discovery Controller Properties and
Command Support" Figure 31 "Discovery Controller ? Admin Commands"
explicitly listst all commands but "Get Log Page" and "Identify" as
reserved, but NetApp report the Linux host is sending Keep Alive
commands to the discovery controller, which is a violation of the
Spec.

We're already checking for discovery controllers when configuring the
keep alive timeout but when creating a discovery controller we're not
hard wiring the keep alive timeout to 0 and thus remain on
NVME_DEFAULT_KATO for the discovery controller.

This can be easily remproduced when issuing a direct connect to the
discovery susbsystem using:
'nvme connect [...] --nqn=nqn.2014-08.org.nvmexpress.discovery'

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Fixes: 07bfcd09a288 ("nvme-fabrics: add a generic NVMe over Fabrics library")
Reported-by: Martin George <marting at netapp.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/fabrics.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8f0f34d06d46..3583f9492a45 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -608,8 +608,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->discovery_nqn =
 				!(strcmp(opts->subsysnqn,
 					 NVME_DISC_SUBSYS_NAME));
-			if (opts->discovery_nqn)
+			if (opts->discovery_nqn) {
+				opts->kato = 0;
 				opts->nr_io_queues = 0;
+			}
 			break;
 		case NVMF_OPT_TRADDR:
 			p = match_strdup(args);
-- 
2.14.3
