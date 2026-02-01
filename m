Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEB8E7C6FD
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Feb 2026 03:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=icBR9kiwaK5ieSI1ONSopOpVymHytvb8yTztT1ByJJ0=; b=SWAn1zYLtgmoXawtN9a0gXfwWC
	3CUY2eoOY1SAYyu9geg2bhxzATQns5JrC4PiGAdpZNhQiX0M8Yl9X5qJNASamM2Vw3t6/Rbiy7ICI
	TvRGEizq1Oh1giFPHVJWgFuT7GI9PFhEzCpScss2xn5rSGiGZTLL2ciAQrTMnDlh+g1BoB6UnMh0p
	vahaH2SCZdH4Zsr8/BE1vzCSQJ5W2r1zdYwenIppd4Js1T1zU3tYVRHkH0oEIr5SWSUu1f8kb+kY5
	2yLI6Abx8SOKXzBpcdEL5QgdnCxpvpVY9ksN4k8vnZehqqwAsMvLy54IW5t8YvUd7GD1l+62HaE3r
	P8HubohQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmNpe-00000003DKR-0LKr;
	Sun, 01 Feb 2026 03:09:02 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmNpW-00000003DJg-3aRB
	for linux-nvme@lists.infradead.org;
	Sun, 01 Feb 2026 03:08:56 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VMMevB2775188
	for <linux-nvme@lists.infradead.org>; Sat, 31 Jan 2026 19:08:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=icBR9kiwaK5ieSI1ON
	SopOpVymHytvb8yTztT1ByJJ0=; b=Spi3+a31SAgtLpVX9WygTW72JyX1YAwDl4
	LZHSNMtVFPB80LANVzT3UBIoZZyPUaMg2OeUeNlg8357bUxKL0uVmuoDS8WgWJz0
	ABD5YFuoeTJkWHAk23O5qTJ9Z1guPVAQSTSQbZkLZ+91ZmuEJ7fgY8RaNq7/C0h6
	miqv9FdPW8t1NcU72CnvMrIFkmsPitW414l54Mz0MC8TGR8HOS/tfP9ecj2scYCB
	myRvkpcFwVeqDAfPkDExmC8fvS2SPdpL/pzZ6aNrFCScnlhEJugMA5VpuiJe6o5W
	0sin940QnpZD2Qy7D7V3/zxqtrw22kw1OhYcOeSy1uau/bcoiV8Q==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c1dx2nxw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Sat, 31 Jan 2026 19:08:53 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sun, 1 Feb 2026 03:08:52 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 1D7EF77B21B; Sat, 31 Jan 2026 19:08:40 -0800 (PST)
From: Daniel Hodges <hodgesd@meta.com>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Daniel
 Hodges <hodgesd@meta.com>
Subject: [PATCH] nvme-fabrics: use kfree_sensitive() for DHCHAP secrets
Date: Sat, 31 Jan 2026 19:08:40 -0800
Message-ID: <20260201030840.3173507-1-hodgesd@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 129MmUCY2E9dxvXgGRJ_nvDsufkF8wxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDAyNSBTYWx0ZWRfX25ICAgiCzJmT
 LCP06Qo/mGnvZwvP6/U1rADnA1NmoWQm6gJGyLdH2ofpucxLltGI+bt1HnLzGo5nvZKkaGS2tIz
 e7xtF1ngArjPJP5b1rjcllO3Mf0SdemQgXOSx+o80k7J2A1csWFQ0mm+kli9aAeLpkqwu2kg6i6
 sifj5cX0HxesgXtJ6u/1j9jxwimJ5ZPcthFvKgKz8U/m2Ux4nlfDW/Q/DbrOCmjkMZ0erFFtX9/
 nWa7bWbqVcNx8zSZG2o0D4kKlY2J163Labn8MvQtJ9nB9I8EaSxxhPTlwXmy3eZRGtTI2H++vqW
 lkYPFCBWLqLgIAJlZcrhqXwgXHWqBRzzdhT9aaejtfcqTuUph4YHeyzSU85hkenRxBx1rMouHqq
 yzbTc2G4nmYUVzoMTIuY4JGqGW1DAyP3U9wBl0XK92/iC6995sGNYLVDdY52GOwNtVnbxg7AOxP
 TtY6YH9gaEqvYYBRlYQ==
X-Proofpoint-ORIG-GUID: 129MmUCY2E9dxvXgGRJ_nvDsufkF8wxR
X-Authority-Analysis: v=2.4 cv=Tb2bdBQh c=1 sm=1 tr=0 ts=697ec3c5 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=-W7SLkP_sVXSNSbjlKUA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-01_01,2026-01-30_04,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260131_190854_896761_8F6C0EBF 
X-CRM114-Status: GOOD (  10.43  )
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

The DHCHAP secrets (dhchap_secret and dhchap_ctrl_secret) contain
authentication key material for NVMe-oF. Use kfree_sensitive() instead
of kfree() in nvmf_free_options() to ensure secrets are zeroed before
the memory is freed, preventing recovery from freed pages.

Signed-off-by: Daniel Hodges <hodgesd@meta.com>
---
 drivers/nvme/host/fabrics.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 55a8afd2efd5..d37cb140d832 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1283,22 +1283,22 @@ void nvmf_free_options(struct nvmf_ctrl_options *=
opts)
 {
 	nvmf_host_put(opts->host);
 	key_put(opts->keyring);
 	key_put(opts->tls_key);
 	kfree(opts->transport);
 	kfree(opts->traddr);
 	kfree(opts->trsvcid);
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
-	kfree(opts->dhchap_secret);
-	kfree(opts->dhchap_ctrl_secret);
+	kfree_sensitive(opts->dhchap_secret);
+	kfree_sensitive(opts->dhchap_ctrl_secret);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
=20
 #define NVMF_REQUIRED_OPTS	(NVMF_OPT_TRANSPORT | NVMF_OPT_NQN)
 #define NVMF_ALLOWED_OPTS	(NVMF_OPT_QUEUE_SIZE | NVMF_OPT_NR_IO_QUEUES |=
 \
 				 NVMF_OPT_KATO | NVMF_OPT_HOSTNQN | \
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
--=20
2.47.3


