Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F39CCD343F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nMHV48hSgrd27QN5a5+9XgzPBNWLKoTKfhA2RZKLPEo=; b=YkyoMfTvPPCCaAAj4f/PBkkzOP
	w2hgvprSyd83VKIwu90Q6LzzVTC4F32j9IqQjyhQLY+Iua/CwZdZGH7mQLxmIt5LmdHX++c3t9cUd
	hnxHuy8BDqmSsdHo/OcPTKjwqKntY2l4q/Hzl0pDZ4ep8r2XAjI4pRZ2iRn1WzYtMT8W0xRBtSQ/n
	x/rVKJP02vXMFMfyAmWYW0Wu/b58T37SYx+6pHMx08VyAIJ2t660TD0hpEbSwcCVyc9Ta2cfmRdgn
	jb7+WnDpr3LqE1dYXCWT1Z13LMaYELnhSlSk2z/bAvO18tCi86DeMfVLn0l1vaD7qKYBy2BqduxoZ
	WKv+W9Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL8Dk-000000059mU-1RA6;
	Thu, 07 May 2026 23:33:32 +0000
Received: from out28-57.mail.aliyun.com ([115.124.28.57])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL8Df-000000059lS-2y6d
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 23:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778196804; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=nMHV48hSgrd27QN5a5+9XgzPBNWLKoTKfhA2RZKLPEo=;
	b=fJQXFuE3syXMhjUrKsFcV1Xf9FmAKaXyrvAWezYW5k1iI+4S3ABQ50VADlZcSsl5PK9N2nloDrX3+v6kr6NiqvI8UhyOqpod3FemVyqMeMueR44/hfBy0Kyh51TMvJtwzwwTujr62yIX/f61WroJquaAIS37cDUlEoA1bxcawCjXLPKXTtf2Shu6k37Q7tVg7GM+28CoQlu+Uf8eInFHQZdrZHsuAWjy4moech+gk4Fta7IRh3SvAD8pCYvsCnNZ3XiQw2Ub45WJ7A/pD7wFQ5S6DQSbs5SgH65NmRTz7lLoHff6kkrUFehy6uIBxRYqoCdrHXEUsN6bpoQHpIdsKw==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9243625|0.09915012;CH=green;DM=|AD|false|;DS=CONTINUE|ham_alarm|0.0193226-0.000620814-0.980057;FP=3776430246451530899|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032062159;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hS.oeHD_1778196802;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hS.oeHD_1778196802 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 07:33:23 +0800
From: AlanCui4080 <me@alancui.cc>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: [PATCH V2] nvme: make providing NGUID as UUID usage less scary
Date: Fri, 08 May 2026 07:33:22 +0800
Message-ID: <fXjcjd9PSFq_4YruRqDOCw@alancui.cc>
In-Reply-To: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_163327_960639_04F0854F 
X-CRM114-Status: UNSURE (   8.71  )
X-CRM114-Notice: Please train this message.
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




