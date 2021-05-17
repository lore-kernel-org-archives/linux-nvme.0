Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458EAC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 08:36:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6A3610C9
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 08:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6A3610C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hm2ljP2FyA1yXlPViHN42JBUGgFHQGLPleNCu/j/e7Q=; b=iygiYMvORycaZ4nRqOPhNcnWiC
	hm8XuX3QPcm1L8V6w5mX/mSFUhatkkRKxeuf7w9zWAfRRPr0FIuq+Chq5jke9esR2L0i2r96brzgb
	HseohuDKedPq0J9qn3RNSVefgOtvXceSU7ec3CyEe6D/e7O0Fk3PMqS2hGNj0DI6URS8Oaj+g9UPY
	U5OUhUwSTYYRLgKAMuFAnYkg2fr2XYaxxdcRWPIW/UqZwBlM2iMGsKWNuXjTR20101gCzuSsNvJab
	nwYnIkl9BC1CE6fuamzAq+i2FLcX6IOUkXv+oPP+fyjwr5+ZCHKGALP5fQxvWT/5/wpxvSxWLsEkC
	cFc2jlUw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1liYja-00EGy1-Ai; Mon, 17 May 2021 08:36:18 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liYfp-00EFyI-PX
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 08:32:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=Ah2gnZo2TJMV9qPlOjfLUU9gNNZuCCtZslSJXdFoCTQ=; b=4rD0I6ea7/ZhFRSVezEhwtSovC
 NbHWy3XO/WHhGCfw9dbDq4Qz1EUpAr5w03MVawErtQdFLXOXbpB8d1zhSifajveJdg/o0mEXqWL9J
 tOG5QJ+udY/tKgBLqLbct5k+vV57Md147oK9bHxbOAj0d8mq9DCkflhlvizo5yo25+Nlgk45oHwzY
 anVpI3ae4L68rYo2n3ALzIs9x982/xF4zGiquf6sK3b2lENQzEH3BHqsUGtOmFei/VF7ZWIb5wdh4
 R+1/RHl87ARMQ7Ce5XhI0dfc+01ZIF5OYJFgIwLL3Azf7V7QLm1n+krs4l7eDHzGulAY6WAw/m9zu
 sWaB3J8g==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1liYfk-00DbGL-1i
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 08:32:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B1491AFC8;
 Mon, 17 May 2021 08:32:18 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3] nvme: generate uevent once a multipath namespace is
 operational again
Date: Mon, 17 May 2021 10:32:15 +0200
Message-Id: <20210517083215.105604-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_013220_253357_D542AE98 
X-CRM114-Status: GOOD (  12.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When fast_io_fail_tmo is set I/O will be aborted while recovery is
still ongoing. This causes MD to set the namespace to failed, and
no futher I/O will be submitted to that namespace.

However, once the recovery succeeds and the namespace becomes
operational again the NVMe subsystem doesn't send a notification,
so MD cannot automatically reinstate operation and requires
manual interaction.

This patch will send a KOBJ_CHANGE uevent per multipathed namespace
once the underlying controller transitions to LIVE, allowing an automatic
MD reassembly with these udev rules:

/etc/udev/rules.d/65-md-auto-re-add.rules:
SUBSYSTEM!="block", GOTO="md_end"

ACTION!="change", GOTO="md_end"
ENV{ID_FS_TYPE}!="linux_raid_member", GOTO="md_end"
PROGRAM="/sbin/md_raid_auto_readd.sh $devnode"
LABEL="md_end"

/sbin/md_raid_auto_readd.sh:

MDADM=/sbin/mdadm
DEVNAME=$1

export $(${MDADM} --examine --export ${DEVNAME})

if [ -z "${MD_UUID}" ]; then
    exit 1
fi

UUID_LINK=$(readlink /dev/disk/by-id/md-uuid-${MD_UUID})
MD_DEVNAME=${UUID_LINK##*/}
export $(${MDADM} --detail --export /dev/${MD_DEVNAME})
if [ -z "${MD_METADATA}" ] ; then
    exit 1
fi
if [ $(cat /sys/block/${MD_DEVNAME}/md/degraded) != 1 ]; then
    echo "${MD_DEVNAME}: array not degraded, nothing to do"
    exit 0
fi
MD_STATE=$(cat /sys/block/${MD_DEVNAME}/md/array_state)
if [ ${MD_STATE} != "clean" ] ; then
    echo "${MD_DEVNAME}: array state ${MD_STATE}, cannot re-add"
    exit 1
fi
MD_VARNAME="MD_DEVICE_dev_${DEVNAME##*/}_ROLE"
if [ ${!MD_VARNAME} = "spare" ] ; then
    ${MDADM} --manage /dev/${MD_DEVNAME} --re-add ${DEVNAME}
fi

Changes to v2:
- Add udev rules example to description
Changes to v1:
- use disk_uevent() as suggested by hch

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0551796517e6..ecc99bd5f8ad 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -100,8 +100,11 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->disk)
-			kblockd_schedule_work(&ns->head->requeue_work);
+		if (!ns->head->disk)
+			continue;
+		kblockd_schedule_work(&ns->head->requeue_work);
+		if (ctrl->state == NVME_CTRL_LIVE)
+			disk_uevent(ns->head->disk, KOBJ_CHANGE);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
