Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E46B3CD3442
	for <linux-nvme@archiver.kernel.org>; Thu,  7 May 2026 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MapS9nyYtwgzKpi2my6D51Q4DjgyPby4G0IFSZWdF84=; b=hYwXJUhWifyqV7zvv2hFxC8ftZ
	WAp/azcHWGwhU98eKACln1q+0ad5CG4yv930y8BSUtPGKqUuFT8pyAmQ05XIZOOShNYBojIVKwl6T
	gQIDhsT7w0XqWY1hTEbrJ11pUihLCe24CAeksNF9jGcFrDGgIh/pAi+c1Vtpsjdfbio1fAJmXYKm8
	WktzQKr/32CEkjptF7dmRjGoQ8WJBRa3m93DEYUG8R9b4np6+MSuX3ZQMfObKh2JJs28oUF/ReQPY
	kmQLlSmG6yPvWxl41Stp/fUM1h6m+s8Qn0WzXDxV4T1puJ8whhonVujm8ZkCBzfIpP3wHvc6E3odd
	L/YQ8Pag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1lR-00000004M6e-1BlF;
	Thu, 07 May 2026 16:39:53 +0000
Received: from out28-81.mail.aliyun.com ([115.124.28.81])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wL1lN-00000004M4m-1qFV
	for linux-nvme@lists.infradead.org;
	Thu, 07 May 2026 16:39:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778171981; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=MapS9nyYtwgzKpi2my6D51Q4DjgyPby4G0IFSZWdF84=;
	b=PGRei6PIlWKEhOdkW2C4dXEzuih/jEcDzebfQ5KeFrK33Pkzd12jClNTiRl5YuCj+1bUydxwBEwe9/dXfZFBe64COeUbgrYPVeRVXRdSFskofc+wiUMIghyB19XMdcHLI6QOunzQg6qg2H7+7u62vwUwgSWczPHm+lChd2HMgn5Et/K98Y9FvXld+Wmb/EP/Gs55/EZqoBto57ssfhTyazTvdpjd9H20WpcgRc1FcbeGbg2uA1+7wyIoJeCAX3i8678GB5ggAm5dCcBE/96/x3roGdc56f9BnFgfGcOxpujBZbiLv7jwMXP5Yz7Om8TRHU8/NM0/p16Yt6aRgR4YYQ==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5305654|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0151987-0.00177872-0.983023;FP=3775383492054609555|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037071049;MF=me@alancui.cc;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.hRqRX87_1778171979;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hRqRX87_1778171979 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 00:39:39 +0800
From: AlanCui4080 <me@alancui.cc>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] nvme: make providing NGUID as UUID usage less scary
Date: Fri, 08 May 2026 00:36:50 +0800
Message-ID: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260507_093949_661999_AE1544D8 
X-CRM114-Status: UNSURE (   9.68  )
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

Hi, 

> From: Keith Busch <kbusch@kernel.org>
> 
> The warning is a bit alarming, and it only prints for the very first
> non-sgl capable device that receives a passthrough command. Just log an
> informational message on initial discovery for every device.

Since we decide to show this warning at device initial discovery stage,
here are some similar warnings that I think are essentially the same.

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
"Bit 9 (UUID List): ...", UUID is not mandatory i guess. So let's degrade it into a
informational message on initial discovery for every device.

Signed-off-by: Alan Cui <me@alancui.cc>
---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3fdcd73b9546..c432d8bc7b62 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4296,6 +4296,10 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
                goto out;
        }
 
+       if (uuid_is_null(&info->ids.uuid)) {
+               dev_info(ns->ctrl->device, "No UUID available, uuid_show providing old NGUID\n");
+       }
+
        ret = nvme_update_ns_info(ns, info);
 out:
        /*
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..839a36c22ebf 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -147,8 +147,6 @@ static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
         * we have no UUID set
         */
        if (uuid_is_null(&ids->uuid)) {
-               dev_warn_once(dev,
-                       "No UUID available providing old NGUID\n");
                return sysfs_emit(buf, "%pU\n", ids->nguid);
        }
        return sysfs_emit(buf, "%pU\n", &ids->uuid);

--
2.54.0



