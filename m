Return-Path: <SRS0=HgeD=FF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4E2C64E7A
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3D2420857
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Dec 2020 04:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ATn6X/8r";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Fs0sFfFI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D2420857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6zzAvP6ATRxJLbFyq99w8no9v7FSfBoRMH1fMxnWsc8=; b=ATn6X/8rSCkB+4TL3OKVUZbtR
	KepMvVeRIWN87NYnrJrUwFcGLEdKTfIBD3lh7SfixaWPj7XPEQfUHCUbEXgptLPEHgmmU3qUT5min
	k9LsnA+wzGeHJLKcTOwMfiGm+cadZKd0ClY7mANyCwcwSB4nRbJ4XS16AR9NoY8Oqk0PBSaVPZhd3
	/8Uw0tdfPaJGrmfFEboYmh1PbyPDXStNem8TaaYvDWuegO1rPETjj6t9+i9ufGvP++mI/fCu/y5ed
	oWgZBR4SF/TCHV4B1BHRcYifu000WVOenUxBovLjOATOpVDr5Rhl2zk/pUsP9bCOgEz7tquv4iztw
	jluP0jPqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjx4D-0008Pn-Pf; Tue, 01 Dec 2020 04:15:05 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjx4B-0008Of-3B
 for linux-nvme@lists.infradead.org; Tue, 01 Dec 2020 04:15:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606796102; x=1638332102;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+iv8i8xvGTKjTFiSy9i/jgbNCBRhvNbZSotD5vVTWDc=;
 b=Fs0sFfFIwiqlM4xJmHFjaeUpYAgivKGBU5pjk3NarJtNB2KvwdcWVV0B
 5ATdMJti/oLaKglHoyRQFWd0RfCLngfodvyZ6aK7kFNV+yAYS6+EchpCP
 rN8d4bOD6jWobhBVAUHLANBH9LPtYwCjDFiyvEAhu8b2VvJRi1cSIDzLN
 ne8KdOCY+/xdK90b5oGY89GZWiLN0VUfB5GfY9cianO2N90qAIUfHaEhf
 T/+YdWVaNFSHQkLZ0euhBX+vfGTtTlaD802vF+FWsyfql20PXE81ZZZpa
 HJ5nYOfqy69PAxJumBb2gcUuE/vpPm410Cn2l3JvCJnVjN1Um3d9TkP6t w==;
IronPort-SDR: kCDwSrSCzEehy9i0aCf6VqN86PFlISccXJSeFY3Lo83hMDTmFDowzXX0WSrS7/ts2gE+1RZvwX
 5gW6LaDLhG6YQa4E++bxfjlvfKiJzKQCV3m/44Q77VV/6ifoPe1JBzD0OiqalwcwFmtqcylHY4
 YaSDN/rzW5cRQAsRreF3HIO0eBU0ZfxaHqwaHL5L4B8AKWiPjPIokSUvGdgJRWBU40PMQ/6x4z
 x2ozvfgit1HkDHeUMQR05R0XnY6BvLQh1s/njRN9eMRMtBVoxM30M/bI9lnR+9HPijgUtPY5CR
 RX4=
X-IronPort-AV: E=Sophos;i="5.78,383,1599494400"; d="scan'208";a="153948685"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Dec 2020 12:15:02 +0800
IronPort-SDR: tTNF4lAds+FJnj+jNtHMdVENfvd/jmeqYvWsNYudzQE1HhavPCD/6ix2znaoVWkr4zLBCf6Vx+
 khi+qFrPxLSnj1G4tMSNBCrkQB3bJwbUw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Nov 2020 20:00:38 -0800
IronPort-SDR: h5fnJ21debZvfkYEpcq0/DTqM3DTdw5CsfIEjan+M57FL6ex5KKZqiMpE9cwEY+RPNchNVn0+t
 z3PNOaostPmw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Nov 2020 20:15:02 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V3 5/9] nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev
Date: Mon, 30 Nov 2020 20:14:12 -0800
Message-Id: <20201201041416.16293-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_231503_306995_6AB6FE7D 
X-CRM114-Status: GOOD (  13.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Update the nvmet_execute_identify() such that it can now handle
NVME_ID_CNS_CS_CTRL when identify.cis is set to ZNS. This allows
host to identify the support for ZNS.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index d4fc1bb1a318..e7d2b96cda6b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -650,6 +650,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		return nvmet_execute_identify_ns(req);
 	case NVME_ID_CNS_CTRL:
 		return nvmet_execute_identify_ctrl(req);
+	case NVME_ID_CNS_CS_CTRL:
+		if (req->cmd->identify.csi == NVME_CSI_ZNS)
+			return nvmet_execute_identify_cns_cs_ctrl(req);
+		break;
 	case NVME_ID_CNS_NS_ACTIVE_LIST:
 		return nvmet_execute_identify_nslist(req);
 	case NVME_ID_CNS_NS_DESC_LIST:
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
