Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E3CCA1013
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Sep 2025 00:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b4+zwgrQAQ3N3b1iw4KkX8A72y4CQUMcsEcWsajlOug=; b=fUgresuQWmsGp+MIb+QZj3te1H
	YqViou+VOQ2DGMApAVnr5AccacqTQXjyJbdc1ejCoPqvNuHQ0EYUcQEkFA0Ifcx3rpWRfqfvcfflI
	EIhykzaEUFPmb/8nk9hFRXUK3OHer6oWJ6RA9Gt1TkTGRxIwurA8sOTUQs0QN27k3mQiNawVX+qqW
	IyBGDDq3lc7Z0L5fcQlxf4vv/eSU8NDYyBE/kp+I0utiDPzWi2iwZKYNqwJI8OdRTQBhafOyiVp8Y
	bp+zeW6B74DPte/SmTwEMMFEBVBYMvAUf9SU14KJK1JAUjITZ3EG/olxP/uouy7xPboa+Yj17FGAu
	UiGIrlJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uugZW-00000005Yb5-29IV;
	Sat, 06 Sep 2025 00:14:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uufod-00000005G6r-1Jvo
	for linux-nvme@lists.infradead.org;
	Fri, 05 Sep 2025 23:26:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1757114759; x=1788650759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xnm/rL7S5sreIfGIwvGukiv5lCZMGf/j8qxjqCE7hL4=;
  b=GV0x+b+Hl3za7CY+1u0zZjs3YyjkUsBHEsIJQuH/FZMHPmzIxH+5HjyF
   CQBUT8hRWdVpTDrJcZjrckSVSsqczn2AEIUm+VoVQ4umzhkuWESaOVLI+
   zr2A9DQrZJg/UhiqS2wcXHlmwgA25UgaZ/EV9VpUsGD64biA3d60wu28M
   Pzgw3jwC1u+QdC36UbCjGrU9BkFBWhJ0AKcyJUs+mg/OEvjdvXp8HlP+k
   vlseAWXSr7lq5U+MaGRiEMpVMGOOSIfNHfd9CosKdwTvTkFEKH+CpSUmJ
   k9P/LwT+oCaOnwIr2cmV2QB+iu7UOfzaqwW72KxyJD2UEPSYJHcjzO64t
   g==;
X-CSE-ConnectionGUID: FLSr69PoTVODL8MjrwtN0A==
X-CSE-MsgGUID: tz59aoFWQYeUWubEvGEcxA==
X-IronPort-AV: E=Sophos;i="6.18,242,1751212800"; 
   d="scan'208";a="109647372"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2025 07:25:56 +0800
IronPort-SDR: 68bb7184_kgs+03OYoTuFuxOQ73Ldl65jSp7pkq6zxeUQLUvVoCbdZRN
 30oUusyG9TU8LbM/TcaNRlv+qlP9dGUrKgH90Zw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:56 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Sep 2025 16:25:56 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cJXXM60Hnz1SHvk
	for <linux-nvme@lists.infradead.org>; Fri,  5 Sep 2025 16:25:55 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:subject:to
	:from; s=dkim; t=1757114755; x=1759706756; bh=xnm/rL7S5sreIfGIwv
	Gukiv5lCZMGf/j8qxjqCE7hL4=; b=m6JS2rkUQoFOD8mAJbzXHE+nQONbp8IwQ6
	wmqV1AyI0gzxneDvTVvMnguOejfzvdIA0WmBflRB4YzvXWJG6xD7e1I/xhiuUDec
	BO+F7m+AKWy3cCdMPTUvLwi/4UKqukUu2RfebIgQAGYqxLgee4Ad4HJlbe3rf9Sm
	KQet0NZvyt2/vsVEb+Iltsm+x/cjrnYukINv9we+9UVVDxlRGmlJPIpzFK14rjua
	KPd1cS4vJyAGJttq2GtNaWOVA51dAELCrKTL0N1C2Cs6G/965RWrEivy8RKUfrNy
	Gyp9uwMKUM8WH+rp3OuUqIHo2q85Fcr9Q8otgjPuVRDfB4okTlPA==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id fcgjlACMqVId for <linux-nvme@lists.infradead.org>;
 Fri,  5 Sep 2025 16:25:55 -0700 (PDT)
Received: from ros-3.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cJXXL6mM2z1SHkR;
	Fri,  5 Sep 2025 16:25:54 -0700 (PDT)
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: [PATCH v2 1/2] nvme-core: add method to check for an I/O controller
Date: Fri,  5 Sep 2025 16:25:49 -0700
Message-ID: <20250905232550.1950307-2-kamaljit.singh@opensource.wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250905_162559_416524_08E74999 
X-CRM114-Status: GOOD (  13.21  )
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

Add nvme_is_io_ctrl() to check if the controller is of type I/O
controller. Uses negative logic by excluding an administrative
controller and a discovery controller.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
---
 drivers/nvme/host/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d67545bd7abb..fab672e50510 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3167,6 +3167,11 @@ static inline bool nvme_admin_ctrl(struct nvme_ctr=
l *ctrl)
 	return ctrl->cntrltype =3D=3D NVME_CTRL_ADMIN;
 }
=20
+static inline bool nvme_is_io_ctrl(struct nvme_ctrl *ctrl)
+{
+	return !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl);
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
--=20
2.43.0


