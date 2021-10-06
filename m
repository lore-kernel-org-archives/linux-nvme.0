Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B38CC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 09:13:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F73604AC
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 09:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C7F73604AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qQZmloB1LC8Qm06auhXSGeeWeBsaI9CzfQyR9E5fpx4=; b=HwC6Y+YuDgfsDa
	CBrWzxeiSg4Rdsm/w2wWhT6S0qcOjo28ET/YllC4pf+b3yyE1jwnLQzS5apj+aMu9EIIFn205Dt+r
	4LgzHa+39n/hEZMfS4UY2shOr9riA96+YqhQAq86Om5xBmy81oSW9ys0ZK6XDMUhZYHAdfiZzVI/c
	H9LZBoqMCbZEySJHFcXfKoUDrukH/36cWWW8tIu9TTzcr7Q50cRoyKhqX/Qh3xiC9yylm1BtdsNcq
	fQEZsN0aq+1ZrH4nmpaEJ9gc+mzffZ8XVkZwQEBbL/GnVkEEJqglddRlsK/qzjAxJH1DAz8GHYHZp
	D4oN84DfXPPeoi4WwK0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY2zU-00DaqJ-JH; Wed, 06 Oct 2021 09:13:32 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY2zG-00Dapu-Ry
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 09:13:20 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5AFDA20350;
 Wed,  6 Oct 2021 09:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1633511594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oRJtGV6ylsYa1bQ9AutIK5zYZf+drRFIc2v1qoc9s/k=;
 b=swhmEM5e3W3y0I/faO5I8MznYxOeSB9ot4zaLEnoY9KJ/QQ+9NllYEuroxoJszmlSTiCre
 S/SAPpqk0Md4B5rSHL+uNddvOwAvxX7i9nfQpg9kUqJwOhutFou4mZ5PzAYwv/Wy8tLYW9
 aBjkSrdUGwPlwDQ2xLhSqHeKxrk4jBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1633511594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oRJtGV6ylsYa1bQ9AutIK5zYZf+drRFIc2v1qoc9s/k=;
 b=3oQSEC/96mx0Uo0Z4nrEfypNQx7GtoNWIzBg7T78em9EMH4fjZ/RHwUwOa5hjMSpVryVra
 oSwCREQph3wDRsAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2C15FA3B8B;
 Wed,  6 Oct 2021 09:13:14 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 1B43F518F34D; Wed,  6 Oct 2021 11:13:14 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv3] [RESEND] nvme: generate uevent once a multipath namespace
 is operational again
Date: Wed,  6 Oct 2021 11:13:13 +0200
Message-Id: <20211006091313.66055-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_021319_094935_4BEB46FB 
X-CRM114-Status: GOOD (  12.90  )
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
index e8ccdd398f78..fb96e900dd3a 100644
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
