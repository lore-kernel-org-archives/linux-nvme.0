Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD2CC02197
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 19:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ofkRPdTjKg7ts9Ihi7aIUWTO3ybxkoz6ifoQjAbWOYI=; b=ZEzVCh32DxCvUtakyCSTatbm75
	a0hu7V8F26P5RRcwAmD4l1ob8pyrsYIQf/AH4rscmMdnF0eYPgGnXPwmBJbIz8IBHtIIKY78tv/Yk
	AqOOcSL8022SDqoWSTWoTZmeOn8wvgwWuqjEqYRHs0EyQQ+YKoL5Ww316oDjGE7c2FnMp56Wj+z1L
	eAn13Ditq+4agX7j/ExSM42DA/Tx7SBfNv9+uGu3OaLOjmJ/z3D3FHZC1nfTmhsQJPLsmc/Ds6fQ9
	pPa2vbENs5c0sD3n+bvMrPpqLNPcp8Eiq/IefeRYMPvkp4IodeIrpNh8F9pbUsS6q9qgUTEnpMIAu
	StnUeoTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1gI-0000000GMnc-0C4i;
	Mon, 03 Feb 2025 19:00:26 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1TA-0000000GJo0-0dwX
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 18:46:53 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IHnAU023598
	for <linux-nvme@lists.infradead.org>; Mon, 3 Feb 2025 10:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=ofkRPdTjKg7ts9Ihi7aIUWTO3ybxkoz6ifoQjAbWOYI=; b=SACofaZ8osAl
	ouCN04Tz5Vklhq7fleFAb9b5osRyNJMDn0HgLf2l8CjFqVBXRhu5gCPrhqat8HE5
	TMgYwXEvo1FD/TVIA29O3EHEvyPkLujPBT+uyJcLn4ax6LpKz0uY6iGsyOcA63yc
	JKgqkUqHe1kL+IZg7XOxIKd/5zzA+lasv562L6kKSClRCadA8Omyvxb/Lha9ACpl
	FEnk8x0MN31BQJQSbrnFP3VE/YWFqTO+eacVGUHQda3GiTVP3+U0ZjxHydv5yliZ
	DQNWzly0mD7FCi02fmseW/9SA52XSaIconyWPmqz4NmLJw3ayekON/szSQt/9NJ5
	hyHxQ+cc2A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k2muge55-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 10:46:51 -0800 (PST)
Received: from twshared7122.08.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:46:49 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id F0B45179C2621; Mon,  3 Feb 2025 10:41:33 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 01/11] fs: add a write stream field to the kiocb
Date: Mon, 3 Feb 2025 10:41:19 -0800
Message-ID: <20250203184129.1829324-2-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203184129.1829324-1-kbusch@meta.com>
References: <20250203184129.1829324-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: x2hp08NuuVTbsU_PqFPmML5GH2_zW3_h
X-Proofpoint-GUID: x2hp08NuuVTbsU_PqFPmML5GH2_zW3_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_104652_194547_44352382 
X-CRM114-Status: GOOD (  10.15  )
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

From: Christoph Hellwig <hch@lst.de>

Prepare for io_uring passthrough of write streams. The write stream
field in the kiocb structure fits into an existing 2-byte hole, so its
size is not changed.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index be3ad155ec9f7..e9ec7afa5d5f8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -408,6 +408,7 @@ struct kiocb {
 	void			*private;
 	int			ki_flags;
 	u16			ki_ioprio; /* See linux/ioprio.h */
+	u8			ki_write_stream;
 	union {
 		/*
 		 * Only used for async buffered reads, where it denotes the
--=20
2.43.5


