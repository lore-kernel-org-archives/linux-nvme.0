Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D3E8C624D3
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Sep 2026 03:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ftGOifR/mSp8VWj3mAkVMyqRorEnxyKaHinJK42TVjo=; b=pFEcCUFaSrpYHVHzN6/nQ365q4
	jqyUEczVZ0IwMFZBnn0TA+WLvKfT2Y6oQLLDuvi/zoCE7Aw1VGXDqU56ic36Zsd5qHZBeMrzXL9Kn
	pVdb1dAzvpLIIiHghA361E+uqFhomL4w5zyU5eGK98IJAxFYeKfuLxoyEioZlcgFRP+SfJM2SNB56
	3pXh1zimdP68niieCvaS4rS5QvoxJkThsX4ugI6Z0/h6PLXXh6Fy+oAZWoJklNRPzS6mcg6sDwhre
	b+WWv7D6Hn4dQNVuUPeMbgInp9F25Jrm+wfOq3VmdEqhrhsBrNbkDexkS7gve0LHbZ4vTaXgJag2O
	7BND74pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2KZA-00000000vTx-39tf;
	Fri, 04 Sep 2026 03:26:12 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2KZ9-00000000vTZ-04S2
	for linux-nvme@lists.infradead.org;
	Fri, 04 Sep 2026 03:26:12 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2d9201076b3so6769325ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2026 20:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crusoe.ai; s=google; t=1788492368; x=1789097168; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ftGOifR/mSp8VWj3mAkVMyqRorEnxyKaHinJK42TVjo=;
        b=VkqJHnmMzesUTzpEoBCUPB3VAH1s5cCHCPlLZWZoUzx4DOFBfvSH1qaF+I7W+spySN
         FVHGp8uKpqPZbtIwjTpIQ4s3E2uWVLfhsBb1Ox+/HCKsbh8ptjdDvItuhpE91uGFkKel
         5PAsjDmh6P8MY9YqqrOQjyyNyImySYTYQt0VqYj7KhV6jdjZAp6aGYIMAgZeZMP/EpPf
         kz0Kayd6YkRrT0BNEjG9ZGUzeIGdVQvcgu+DilEm3VnnCufq8R74x66b3fiDVwdnYVfF
         mNHUJ/dC8Fr9IIj9orm0tlqWVc82eEgiZSS74RUXlCwJ3ftFeJpRcaYKxdl6p+BchhG0
         e7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788492368; x=1789097168;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ftGOifR/mSp8VWj3mAkVMyqRorEnxyKaHinJK42TVjo=;
        b=kT/0TfOOLy6IgQ8JfVAydwsrekaQAEUxEm2LyrShJ1oi3GrKHycCKteNqxhw7IeBFm
         W6TsXmndX7NmRclBM/7QtLXDgTsZWuc04Fhldy0/wp3a39nB9Qtf9klKRR+LVOqxmOgw
         fwU9+lHh+6Qp+njO8dLPKxfs1SWh+sfgfVRI2XZ96eXYnTcAkz86K+TXwVPVhbcXIco8
         Na5AaeFClqawYOQgiXlTwP9afyG59wzKA55a08LaLuH+jyKAoxf2esOuTqH6dH9Na94Q
         urQCskR7coJQiD2zcS9WZxbiXLYUV240aSp7bKX9fVep2RDrmxh2vV1rc3X3XEtuAjEY
         YIKA==
X-Gm-Message-State: AFuF++l1miTCd5Qd9Pt+drWHSXIo04gh4L+38JMTvCnTZaQcDwX61/+A
	T/4SZuuIUkpLpQq/gemrHjedlfCeCM6P4Qq3+doNl0lYbUUBUsELJ+lkFfijGl1RACM=
X-Gm-Gg: AYBFou0sRFYVQISNLCPNx9mVn0zbO15zegPpiOD9b14zvH1QvwRVF+7+fdTssCR/DnR
	+87LuTK6FBhzlMUovtIqR6ftVU62wlSeECTYXuMXwDTvxTv+ILslERYMjF6FXGrbUlPT7PPfdBw
	aOo0F8g96mwYrSaSIBOI7GEkjie013HugHLtkxakPxb7j9zxasTsvRZlmXIrWV3oyNOOajn59QT
	t3XcYkjGd6+a17un92gEwcqspn7UxZwCLcoyFby9IZ+J/WCjXaTEVxOSaPPtAnOl53e06Lpw7se
	cnEyfQ+ZHemx4JNnRE8BHJ8FtX82KT/uVQDCFQt1c+GoOxSH1kXr/6hVt1NZ4sDsoCbEO4tVYH6
	bF6pFJTJcvXPw31yv1ZsxMUnTK7mafVUV/bSbXbMrBc2qfTrsAhWCc6z0Tt2ug5r0KO305PLD8a
	HOZ9do3t/hXmiUzr6P/Fv2enxhGyr5aiqdhybeovhnZVYvHfmWRPSb2BKjVxxkDuxZR7zfX3aPo
	FxAB+CxietOUVagJGvsZTqvwLo+4tRTMfae2EIq3r3jl34s
X-Received: by 2002:a17:902:e948:b0:2d9:51b7:c0bc with SMTP id d9443c01a7336-2db125a3452mr51306755ad.12.1788492367938;
        Thu, 03 Sep 2026 20:26:07 -0700 (PDT)
Received: from MBP-Krishna-Iyer.civet-hops.ts.net ([2601:645:c68a:b830:ac00:830e:a5a6:34cd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm3145397eec.1.2026.09.03.20.26.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 20:26:07 -0700 (PDT)
From: Krishna Iyer <kiyer@crusoe.ai>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	sj@kernel.org,
	saravanand@crusoe.ai,
	Krishna Iyer <kiyer@crusoe.ai>
Subject: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail queued I/O
Date: Thu,  3 Sep 2026 20:26:05 -0700
Message-ID: <20260904032605.65758-1-kiyer@crusoe.ai>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260903_202611_096601_603C1BE0 
X-CRM114-Status: GOOD (  24.25  )
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

When all paths to a multipath namespace are down, I/O is held on the
head requeue list until a path returns. With ctrl_loss_tmo=-1 the
controllers reconnect forever, so during a long fabric outage the I/O
is held indefinitely and any process waiting on it sleeps in D state
until the fabric heals or the host is rebooted. We hit this on
virtualization hosts, where a SIGKILLed VM process cannot exit because
it is still draining I/O to an unreachable NVMe/TCP target.

There is currently no way to fail this I/O without tearing something
down. Deleting the controller (or letting ctrl_loss_tmo expire) works
but takes every namespace on the controller with it and requires a
manual reconnect afterwards. fast_io_fail_tmo only arms on the
RESETTING -> CONNECTING transition, so it cannot be set once the
outage has started. delayed_removal_secs only matters after all
controllers are gone, which never happens with ctrl_loss_tmo=-1.
dm-multipath has had "dmsetup message <dev> 0 fail_if_no_path" for
this for decades; nvme multipath has no equivalent.

Add a fail_io_now attribute on the ns-head disk. Writing a true value
sets NVME_NSHEAD_FAIL_IO_NOW, synchronizes SRCU so submitters see it,
and kicks the requeue work. nvme_available_path() treats the flag as
no path available, so the existing bio_io_error() branch fails the
parked and any newly arriving I/O, for that namespace only. Controller
state is not touched: reconnect attempts continue and other namespaces
on the controller keep queueing. The flag is cleared in
nvme_mpath_set_live() when a path comes back, like
NVME_CTRL_FAILFAST_EXPIRED.

Locking, SRCU usage and sysfs visibility follow the neighboring
delayed_removal_secs attribute; input parsing follows
io_passthru_err_log_enabled (kstrtobool, shows on/off). Validated on
real hardware with a 6.17 backport of this change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Krishna Iyer <kiyer@crusoe.ai>
---
Testing notes: the 6.17 backport was exercised on a virtualization
host with a two-path NVMe/TCP namespace connected with
ctrl_loss_tmo=-1. With both target portals firewalled off and a
SIGKILLed VM process stuck in D state on the parked I/O, the process
stayed unreapable for over six minutes; delayed_removal_secs=60,
armed before the outage, never triggered since the controllers were
CONNECTING throughout. Writing fail_io_now released the process in
about two seconds, the reconnect loop was undisturbed, and once the
firewall was removed the paths came back live and the attribute read
back off on its own. A namespace on a second subsystem kept the
default queueing behavior throughout. This posting is compile-tested
(including W=1) on nvme-next.

 drivers/nvme/host/multipath.c | 62 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/sysfs.c     |  4 ++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index fc6800a9f7f9..a026bdfb9d7f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -482,6 +482,15 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
 		return false;
 
+	/*
+	 * The user requested any I/O queued or arriving while no path is
+	 * usable to be failed immediately (e.g. to release I/O held for a
+	 * fabric that retries reconnection indefinitely). The flag is
+	 * cleared when a path becomes live again.
+	 */
+	if (test_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags))
+		return false;
+
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
@@ -780,6 +789,12 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	if (!head->disk)
 		return;
 
+	/*
+	 * A path is usable again, restore the default queue-if-no-path
+	 * behavior in case fail_io_now was set during a fabric outage.
+	 */
+	clear_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags);
+
 	/*
 	 * test_and_set_bit() is used because it is protecting against two nvme
 	 * paths simultaneously calling device_add_disk() on the same namespace
@@ -1168,6 +1183,53 @@ static ssize_t delayed_removal_secs_store(struct device *dev,
 
 DEVICE_ATTR_RW(delayed_removal_secs);
 
+static ssize_t fail_io_now_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+
+	return sysfs_emit(buf, test_bit(NVME_NSHEAD_FAIL_IO_NOW,
+			&head->flags) ? "on\n" : "off\n");
+}
+
+static ssize_t fail_io_now_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	bool enable;
+	int ret;
+
+	ret = kstrtobool(buf, &enable);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&head->subsys->lock);
+	if (enable)
+		set_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags);
+	else
+		clear_bit(NVME_NSHEAD_FAIL_IO_NOW, &head->flags);
+	mutex_unlock(&head->subsys->lock);
+
+	/*
+	 * Ensure that update to NVME_NSHEAD_FAIL_IO_NOW is seen
+	 * by its reader.
+	 */
+	synchronize_srcu(&head->srcu);
+
+	/*
+	 * Kick the requeue list so already-queued I/O re-evaluates path
+	 * availability and fails immediately.
+	 */
+	if (enable)
+		kblockd_schedule_work(&head->requeue_work);
+
+	return count;
+}
+
+DEVICE_ATTR_RW(fail_io_now);
+
 static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 		struct nvme_ana_group_desc *desc, void *data)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index eeabc72863d8..ca93a8934123 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -566,6 +566,7 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
+#define NVME_NSHEAD_FAIL_IO_NOW		2
 	struct nvme_ns __rcu	*current_path[];
 #endif
 };
@@ -1067,6 +1068,7 @@ extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
+extern struct device_attribute dev_attr_fail_io_now;
 extern struct device_attribute subsys_attr_iopolicy;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 93513c17ad5f..c154cc78c290 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -261,6 +261,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
+	&dev_attr_fail_io_now.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
 	NULL,
@@ -297,7 +298,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-	if (a == &dev_attr_delayed_removal_secs.attr) {
+	if (a == &dev_attr_delayed_removal_secs.attr ||
+	    a == &dev_attr_fail_io_now.attr) {
 		struct gendisk *disk = dev_to_disk(dev);
 
 		if (!nvme_disk_is_ns_head(disk))

base-commit: 011e0880d366be065d273c22ad1638934748d3e0
-- 
2.54.0


