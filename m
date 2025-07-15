Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 766A6C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=My7zKWNVhiHUXiSOckpsQoPEQZVJXST7ozwScrUxbWo=; b=242f0toQxwLSYbF9+8v9xpqHDg
	5vkL0GVBVPJD/0O296tf1ebNfHfnbe7g50ShyiBmak6xkivyzYolpq80qYT9HvkR3QNQCe7sQyaXA
	QaVFhG2EjVxs4ZBNzq7ZOcMsFntfvl917AncQmPhVLeTXZBHbTc5QnabGiZYmfDwzHrijXxXAgP14
	rweeGJfX6jj1Dzz+HesBLb7zqRMYzWj7be7hto5yytVPOMRLUgpry2ctT+OlRE0fDivRoFTXNEU2O
	9KwMTfkW5J/61TAhxwuYU1ZD81raGDx9mqV6J+Wf9dWcy5AGb2X/XwUd7xOuKgoVp5VaqzVnt+OGq
	aaY+aRjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublLn-000000065Qi-2vjr;
	Tue, 15 Jul 2025 19:30:03 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublLT-000000065L8-2RAO
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 19:29:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 90D2C61465;
	Tue, 15 Jul 2025 19:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E025AC4CEE3;
	Tue, 15 Jul 2025 19:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752607782;
	bh=pyiKjDBLmUWSMxig3No0s8MlQGDpYRf9ZfLZXB+Tl0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BGzIZu4etbnBq2AjBVMgjYTnz2QXEU2DzVfqFFIdVjWB4sA0WHD8eihAR3IXmwpw4
	 /RLP5DflhHrYHW58xZl+LgrVwjUkPDszJdvZDlhwNTJO3QUcplweEG3vppPEujWeT6
	 +KPteouis5eszJHB0Y9Jh9XUPWojABFslejvHFRUzVzP62WY5hzfO3Zgamw+Qk17VA
	 6GVhSIaobbFN3TEUKI33D93yHYFXG2mF/VwKzDxxHnqfwrccGnJ50fs4nIy+1Y0sIF
	 OfancFK0ppb6giHdE24TGSSVwHT5/Dyk1YhsNv3J6zBw7F5eE+zu00CTmY4kljNYjd
	 NTNF7okRn8riw==
Date: Tue, 15 Jul 2025 13:29:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
Message-ID: <aHasJPv2Jb4bQ3ik@kbusch-mbp>
References: <20250509151627.20434-1-bgurney@redhat.com>
 <aB4gO7mAYDO3Bm3A@kbusch-mbp>
 <cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
 <aCId7XmLnrLWZPdk@kbusch-mbp>
 <aFrBVeEcapNtOvPx@kbusch-mbp>
 <1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 15, 2025 at 03:01:59PM -0400, John Meneghini wrote:
> On 6/24/25 11:16 AM, Keith Busch wrote:
> > On Mon, May 12, 2025 at 10:12:29AM -0600, Keith Busch wrote:
> > > On Mon, May 12, 2025 at 11:18:58AM -0400, John Meneghini wrote:
> > > > On 5/9/25 11:33 AM, Keith Busch wrote:
> > > > 
> > > > > If those are not unique, they need to be blanked out to make sure we don't
> > > > > expose these on the namespace's sysfs attributes.
> > > > 
> > > > OK, we can add another patch that blanks out the lower precedent/invalid IDs.
> > > > 
> > > > Will that work?
> > > 
> > > I think you'd have to blank out the non-unique ones, otherwise the
> > > driver would export them.
> > > 
> > > And while I think that might work, this proposal didn't go over so well
> > > last time it came up:
> > > 
> > > https://lore.kernel.org/linux-nvme/20250414111916.GB13225@lst.de/
> > 
> > I've recently encountered some devices with this behavior, from machines
> > hosted by various cloud providers. I had to pull in something
> > out-of-tree like the patch here just to get things going. I think we
> > should have the kernel discard lower priority fields.
> 
> OK good I will ask Bryan to resubmit this as a version 2 patch.
> We can add another patch that blanks out the lower precedent/invalid IDs in sysfs so that only the unique IDs are reported.

Note, it's not me who needs convincing.

FWIW, this is what I'm running with. There's just some extra care here
to ensure we refresh sysfs attributes as needed, as well as prevent
repeatedly spamming the kernel messages with the same error.

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 12e7ae1f99e20..13482b2fbf46a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1467,7 +1467,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID ||
+		    ctrl->subsys->quirks & NVME_SUBSYS_BAD_EUI64)
 			return NVME_NIDT_EUI64_LEN;
 		memcpy(ids->eui64, data + sizeof(*cur), NVME_NIDT_EUI64_LEN);
 		return NVME_NIDT_EUI64_LEN;
@@ -1477,7 +1478,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 				 warn_str, cur->nidl);
 			return -1;
 		}
-		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID)
+		if (ctrl->quirks & NVME_QUIRK_BOGUS_NID ||
+		    ctrl->subsys->quirks & NVME_SUBSYS_BAD_NGUID)
 			return NVME_NIDT_NGUID_LEN;
 		memcpy(ids->nguid, data + sizeof(*cur), NVME_NIDT_NGUID_LEN);
 		return NVME_NIDT_NGUID_LEN;
@@ -1611,10 +1613,12 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 			 "Ignoring bogus Namespace Identifiers\n");
 	} else {
 		if (ctrl->vs >= NVME_VS(1, 1, 0) &&
-		    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
+		    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)) &&
+		    !(ctrl->subsys->quirks & NVME_SUBSYS_BAD_EUI64))
 			memcpy(ids->eui64, id->eui64, sizeof(ids->eui64));
 		if (ctrl->vs >= NVME_VS(1, 2, 0) &&
-		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
+		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)) &&
+		    !(ctrl->subsys->quirks & NVME_SUBSYS_BAD_NGUID))
 			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
 
@@ -3554,7 +3558,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
-		struct nvme_ns_ids *ids)
+		struct nvme_ns_ids *ids, bool global)
 {
 	bool has_uuid = !uuid_is_null(&ids->uuid);
 	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
@@ -3564,14 +3568,39 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
+		bool changed = false;
+
 		if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
 			return -EINVAL;
 		if (has_nguid &&
-		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
-			return -EINVAL;
+		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0) {
+			if (!has_uuid || global)
+				return -EINVAL;
+
+			dev_warn(&subsys->dev, "duplicate nguid:%16phN\n",
+				ids->nguid);
+			memset(ids->nguid, 0, sizeof(ids->nguid));
+			memset(h->ids.nguid, 0, sizeof(h->ids.nguid));
+			subsys->quirks |= NVME_SUBSYS_BAD_NGUID;
+			has_nguid = false;
+			changed = true;
+		}
 		if (has_eui64 &&
-		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
-			return -EINVAL;
+		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0) {
+			if ((!has_uuid && !has_nguid) || global)
+				return -EINVAL;
+
+			dev_warn(&subsys->dev, "duplicate eui64:%8phN\n",
+				ids->eui64);
+			memset(ids->eui64, 0, sizeof(ids->eui64));
+			memset(h->ids.eui64, 0, sizeof(h->ids.eui64));
+			subsys->quirks |= NVME_SUBSYS_BAD_EUI64;
+			has_eui64 = false;
+			changed = true;
+		}
+
+		if (changed)
+			nvme_update_ns_attrs(h);
 	}
 
 	return 0;
@@ -3719,7 +3748,7 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
 		if (s == this)
 			continue;
 		mutex_lock(&s->lock);
-		ret = nvme_subsys_check_duplicate_ids(s, ids);
+		ret = nvme_subsys_check_duplicate_ids(s, ids, true);
 		mutex_unlock(&s->lock);
 		if (ret)
 			break;
@@ -3776,7 +3805,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
-		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
+		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids, false);
 		if (ret) {
 			dev_err(ctrl->device,
 				"duplicate IDs in subsystem for nsid %d\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c4bb8dfe1a458..b81fe820280c2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -447,6 +447,10 @@ struct nvme_subsystem {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
 #endif
+
+#define NVME_SUBSYS_BAD_NGUID	(1 << 0)
+#define NVME_SUBSYS_BAD_EUI64	(1 << 1)
+	unsigned long		quirks;
 };
 
 /*
@@ -1181,6 +1185,7 @@ struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 bool nvme_get_ns(struct nvme_ns *ns);
 void nvme_put_ns(struct nvme_ns *ns);
+void nvme_update_ns_attrs(struct nvme_ns_head *head);
 
 static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea39..ef232e0da5f72 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -299,6 +299,18 @@ static const struct attribute_group nvme_ns_attr_group = {
 	.is_visible	= nvme_ns_attrs_are_visible,
 };
 
+void nvme_update_ns_attrs(struct nvme_ns_head *head)
+{
+	struct gendisk *disk;
+
+	if (nvme_ns_head_multipath(head))
+		disk = head->disk;
+	else
+		disk = list_first_entry(&head->list, struct nvme_ns,
+					siblings)->disk;
+	sysfs_update_group(&disk_to_dev(disk)->kobj, &nvme_ns_attr_group);
+}
+
 const struct attribute_group *nvme_ns_attr_groups[] = {
 	&nvme_ns_attr_group,
 	NULL,
--

