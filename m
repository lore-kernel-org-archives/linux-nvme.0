Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F47BCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQkCJOekpzr4oSS5FFCc+ZvzJJELquPaD/Yon1iSBSw=; b=2lWCyElVIXJy5DgFu6CrKE1lsJ
	N+xyhkZ3EOdxnOrYcPpby6Q2CSe9FsSRGCUpzor6AHv0hRrTPtBjSoJASjCzQXnNuhzQbXZfTkBf7
	VGD5HeXwZm+V7NOMo+NZkS87wXlMIJOZ5DIbH5xmUenqkdlIdcXP6pGeCZShq9tY12SsvN6A/gQMt
	lCtxLqkn4AM/JXdvSO8uN0Bj8kYV18821kJffioSKhOX4lL1Ceu2ZXggPUGBq4aZkdSqioLZD2W+n
	hmw4/Gd+xbvsfzOZW6QuriqEHcYdWnwvg3PKvGV+0u257mWfqnEjcGefiM14SWMSwA1w6YOSoih1I
	2lkCICfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMM1f-0000000ClG5-35ll;
	Mon, 11 May 2026 08:30:07 +0000
Received: from out28-41.mail.aliyun.com ([115.124.28.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMM1c-0000000ClFO-2y4B
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:30:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778488201; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=CQkCJOekpzr4oSS5FFCc+ZvzJJELquPaD/Yon1iSBSw=;
	b=g5VCqQf72WgI38hrMpaIjoG0nGjZyBmrWD7IjJVCsduHpFP33oluq3xmIrrpOBCaZk9d6tkSvZ+wC9sXVsYAswHwGj/GPKEKBlMW9ZB+Nuv/JxhfNdA9SPBwhAP8Lx60UHcaz6BBP+iCYXOy4FDhPoyb4mujfZqyzgw0RLqjlyRBmZM1O8kL9tIWS+msubu59aaXSwNNmHLf+aR4iMzTk6Ke7jMdq2rzbvjrn3iJBYuKh24zqtWHxECwbOJE/V30DF0yEL0Q12IWf8XP95INDW06zOLVLBbA0QZnSjnOXLOkcXFk187IxiywhOWPetGX/AXk8/0YIsf/s/bRl/NbiA==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9243625|0.09915012;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.032702-0.00222044-0.965078;FP=1216133566099408019|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=me@alancui.cc;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.hUT8Hs._1778488198;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hUT8Hs._1778488198 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 11 May 2026 16:29:59 +0800
From: AlanCui4080 <me@alancui.cc>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH RFC V2 RESEND] nvme: make providing NGUID as UUID usage less scary
Date: Mon, 11 May 2026 16:29:58 +0800
Message-ID: <p3A0AxbHQ4aKNhfIeaPQng@alancui.cc>
In-Reply-To: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_013004_985113_4A1D4F8B 
X-CRM114-Status: GOOD (  12.53  )
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

Since we decide to show the prp passthrough usage warning at device
initial discovery stage and degrade it to a informational message,
here is a warning that I think are essentially the same.

grep -C3 -rn "dev_warn_once" ./drivers/nvme/*
```
./drivers/nvme/host/sysfs.c-147-         * we have no UUID set
./drivers/nvme/host/sysfs.c-148-         */
./drivers/nvme/host/sysfs.c-149-        if (uuid_is_null(&ids->uuid)) {
./drivers/nvme/host/sysfs.c:150:                dev_warn_once(dev,
./drivers/nvme/host/sysfs.c-151-                        "No UUID available providing old NGUID\n");
./drivers/nvme/host/sysfs.c-152-                return sysfs_emit(buf, "%pU\n", ids->nguid);
./drivers/nvme/host/sysfs.c-153-        }
```

This warning will only complain for the first partition of the first device also.
And for NVMe devices, according to the NVM-Express-1_4 specification p.175 Figure 251:
"Bit 9 (UUID List): ...", UUID is not mandatory. So let's degrade it into a
informational message on initial discovery for every device.

Signed-off-by: Alan Cui <me@alancui.cc>
---
v2: move the hint to nvme_init_ns_head instead of nvme_validate_ns
v2: clean the commit message lines

In my understanding, the nvme_init_ns_head will be called each time
a namespace created, and it does some checking on ids so we also place
the hint there, and here is the result of dmesg applied current patch.

resend v2: add Ccs to all maintainers
resend v2: see https://lists.infradead.org/pipermail/linux-nvme/2026-May/062831.html

After discussion, I begin to think we should treat this as a warning,
since the way kernel generate UUID by NGUID is not a valid RFC4122 UUID,
and NVMe specification requires "The Universally Unique Identifier is defined in RFC4122"

However the "No UUID available providing old NGUID" is should be reported
per device anyway.

[    4.502052] nvme nvme1: pci function 0000:05:00.0
[    4.502060] nvme nvme0: pci function 0000:01:00.0
[    4.508544] nvme nvme1: missing or invalid SUBNQN field.
[    4.508664] nvme nvme1: D3 entry latency set to 8 seconds
[    4.512422] nvme nvme0: missing or invalid SUBNQN field.
[    4.517581] nvme nvme0: allocated 32 MiB host memory buffer (1 segment).
[    4.523519] nvme nvme0: 8/0/0 default/read/poll queues
[    4.524761] nvme nvme1: 16/0/0 default/read/poll queues
[    4.525438] nvme nvme0: No UUID available, uuid_show providing old NGUID
[    4.526683] nvme nvme1: No UUID available, uuid_show providing old NGUID
[    4.527243]  nvme0n1: p1 p2 p3 p4 p5 p6
[    4.528351]  nvme1n1: p1

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766e9cc4ffca..70856856a99c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4007,6 +4007,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ctrl->quirks |= NVME_QUIRK_BOGUS_NID;
 	}
 
+	if (uuid_is_null(&info->ids.uuid)) {
+		dev_info(ctrl->device, "No UUID available, uuid_show providing old NGUID\n");
+	}
+
 	mutex_lock(&ctrl->subsys->lock);
 	head = nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 16c6fea4b2db..ea8bce9887f9 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -147,8 +147,6 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 	 * we have no UUID set
 	 */
 	if (uuid_is_null(&ids->uuid)) {
-		dev_warn_once(dev,
-			"No UUID available providing old NGUID\n");
 		return sysfs_emit(buf, "%pU\n", ids->nguid);
 	}
 	return sysfs_emit(buf, "%pU\n", &ids->uuid);
--
2.54.0




