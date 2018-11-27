From: james@dingwall.me.uk (James Dingwall)
Date: Tue, 27 Nov 2018 10:25:54 +0000
Subject: Two M.2 NVMe drives with same NQN, one gets removed
In-Reply-To: <20181127075426.GA4173@infradead.org>
References: <20181126133839.GA4348@dingwall.me.uk>
 <20181126153110.GM26707@localhost.localdomain>
 <20181127075426.GA4173@infradead.org>
Message-ID: <20181127102554.GA16387@dingwall.me.uk>

Hi,
On Mon, Nov 26, 2018@11:54:27PM -0800, Christoph Hellwig wrote:
> On Mon, Nov 26, 2018@08:31:11AM -0700, Keith Busch wrote:
> > According to the resolution discussion here:
> > 
> >   https://downloadcenter.intel.com/download/28320/Known-Issue-Intel-SSD-760p-Pro-7600p-Series-SubNQN-Conflict-on-Linux
> > 
> >   "
> >   If you purchased your Intel? SSD from an OEM, your firmware version may
> >   have a different naming. Contact your local OEM representative for
> >   latest firmware revisions.
> >   "
> > 
> > Sounds like Lenovo will need to merge the Intel update into their
> > specific firmware if they haven't already done so.
> 
> OEMs are notoriously bad in picking up firmware fixes.  If the problems
> with this drive persist we should probably add a quick that ignores the
> drive provided NQN and build up one from based on the legacy
> model/serial number algorithm instead.

Would something like this be the way to go if an appropriate entry is
created in the nvme_id_table in pci.c?  The example subnqn shown in
http://lists.infradead.org/pipermail/linux-nvme/2018-November/021154.html
looks like the fallback entry so I suppose the firmware fix has been to
just blank the relevant field.  (Should 2014.08.org be 2014-08.org
in core.c when generating the fake name?)

Thanks,
James

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 559d567693b8..d4ace74237d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2076,10 +2076,12 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	size_t nqnlen;
 	int off;
 
-	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
-	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
-		return;
+	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
+			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+			return;
+		}
 	}
 
 	if (ctrl->vs >= NVME_VS(1, 2, 1))
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb388af..a07155c05328 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Ignore device provided subnqn.
+	 */
+	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
 };
 
 /*
