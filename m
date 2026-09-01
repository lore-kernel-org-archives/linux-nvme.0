Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E50C624D3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k7ME355fU8SnhX5VzIG2FLRGD8TjRkEL6kBP0doyPl0=; b=fDqXpntWjJjk4ntcf/Fc4IZgF8
	VUdQ6iDVvSTIhVQw73nNYj3jz0RxMYZ/M4vvJU/Mw1NbLgnoYD1E3tJe/Q2WGeTd7ot9E6If6EM3A
	bCnhCTwgOGhYgeFk5Oy4JKAkz1qzFDSG47F41N8ZsrpWvlg6GiXO2DlSiteTLoM3aO9jjPa0LQ7gQ
	UqiD8H59M3lMIRYLTTXzp5AG9KecAeAiE09DqIfH5b6EUisQsGmAV/bSndENmQ4jDHmpQLKsUbKwR
	M+oDtvABrb5tLgcz0Mkl4sUn1fKlC/WljUser1U8n7TxYqWnrtf/Dpau4V2VEMk1snzKTN9Gt5lKW
	+s6lCwNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1RgG-0000000ChxS-0Zfe;
	Tue, 01 Sep 2026 16:49:52 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1RgD-0000000ChwY-2yC6
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 16:49:51 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 681EKkqX2128391
	for <linux-nvme@lists.infradead.org>; Tue, 1 Sep 2026 09:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps82601-s2048-2026-q3; bh=k7ME355fU
	8SnhX5VzIG2FLRGD8TjRkEL6kBP0doyPl0=; b=UqRNZyrULPnQ8A6BCdYVnf5/0
	BS1yGTgHFYzhPOOdRyNIbD/lxspNWngaHoAo+q9z8fvSjcGpPaZzKgtvnz++3pKI
	iLXBEx9ilDval8srBl7l+oFutHb0oulLcV9inuXKHPAJ0gKXIhVlyxpdP0GsOlUL
	CPCE2zQEvYqnNJGgBNgscM84w5tTXvXqpo8JKuONFsGCGmmfsRnDRX4PbMr4Ygwe
	V018SBC75yaJI2avuOK5U/Q3zflRU4TkZfayX5eetCZNq0oK6XC4adCqfsVcB3rx
	sZkiz7uF195f4W3d3PWiMotxGc33LRgZnNjbvjyUvrDYLoy7qCSKZetw/wpEw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4ge0cx13tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 01 Sep 2026 09:49:47 -0700 (PDT)
Received: from twshared25022.01.snb2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 1 Sep 2026 16:49:46 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 3F45C29B518F4; Tue,  1 Sep 2026 09:49:36 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <axboe@kernel.dk>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] MAINTAINERS: update nvme entry
Date: Tue, 1 Sep 2026 09:49:35 -0700
Message-ID: <20260901164935.2464374-1-kbusch@meta.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0OCBTYWx0ZWRfX27Do4zXYXDYr
 Xsyl24VFuohqGJurI+9eZD+x0yq2VF1wBGbpKyhaoMokp9s6eI6ne+1UVX5GllOmEF20EBErk0k
 CyGozlr3sQG/CjRg0qJiDIWBeLLTzJ8=
X-Authority-Analysis: v=2.4 cv=VIftWdPX c=1 sm=1 tr=0 ts=6a97022b cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=855S8uPTkML1Oy45N9_h:22 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8
 a=Df3lwzbUzwLbonxX38EA:9 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-GUID: oG0R3VMGLh1L5vswZZJ4YccAfOguV6CK
X-Proofpoint-ORIG-GUID: oG0R3VMGLh1L5vswZZJ4YccAfOguV6CK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0OCBTYWx0ZWRfX0daVzmVZbII/
 WbxPjjdUADeK9HXNhQBi8IjqWho4Dl+g4wvd8DAHFmLY8U1uwxtoV8jRoUtYYVdttk82JCaehO4
 MH0ZSoVTJufDmhrzxh4IAV1YEOtOJBRp8+1ioKJAUIvlCDTG6TWMAnwGXX3vtJQ+89EqJnNZWLL
 esbi0PFUY/6/WkqyPbsYN6SZ2yncCIiQInqhBrkm+whOZXf/9Q/9TuEC4r9BCpqy2BfA+P2fucz
 dKRkYgKWxonkEbJmVGmxeqbrml97pJZxM2rBCpD9i8Q2Iq2s0nc6E15XxGNaB2cx/lKtpiSQZxz
 t58MFCrxmMUfV/zyQfhO5vDj7t3YKNiPpLGOSHVW3tVoIPSnnKcbd9kSdDtnXAV7BulUoqK5jkP
 YIv0QYtPHQ9GE55yj1R6bj/9lwBxPxl2FJKIdfSnbyYChlWprRWOPzOkRq6lR36lNH+FkOWAWm1
 IlZ6RH9tzexrrqE7IxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260901_094949_918664_E7E7653F 
X-CRM114-Status: GOOD (  12.50  )
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

From: Keith Busch <kbusch@kernel.org>

Update Jens' entry to match the mail address of his other entries.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 46d98b53729dc..91d6086196e2c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19366,7 +19366,7 @@ F:	include/linux/platform_data/x86/nvidia-wmi-ec-=
backlight.h
=20
 NVM EXPRESS DRIVER
 M:	Keith Busch <kbusch@kernel.org>
-M:	Jens Axboe <axboe@fb.com>
+M:	Jens Axboe <axboe@kernel.dk>
 M:	Christoph Hellwig <hch@lst.de>
 M:	Sagi Grimberg <sagi@grimberg.me>
 L:	linux-nvme@lists.infradead.org
--=20
2.53.0-Meta


