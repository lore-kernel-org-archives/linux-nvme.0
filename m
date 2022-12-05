Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60893C4321E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 14:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DrwhaP5wvMBer1T0AxaNHrcw6+swXdG/opZ7fT0H0Ik=; b=OPJVg29K8GnqdF1uVX82t2EoiT
	8ua1/P5kF9LaDk8QFm9uWfMHKGUM3hjidj6aRXNaX0t0LqL4DYTmBP+RHhGZLsQnHxRPbHLfqJaHU
	/EcN2rT9+55ZxThmN9D5q6BkbcyWNvdWIo3qSD7XfwzOHbjPu7Ufn9rn0oBBzzjYL5TN9xxMOCkks
	OXBvDRdr0TrpC1KBnuAnOrcnIiJEsgjZBlgq3sNbR26z5ARxtgs3rHRAD3tm1RnjI7j/7zNXcnkhE
	bymVCN/TPh+8v74QfGYnPPZqKcqvVc9svNO/9adzG4uMTUAXkikxHd3fZzSkKWhfUSPtfc55ueg31
	ty3p1IPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2CVb-0045kt-Dd; Mon, 05 Dec 2022 14:31:51 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2CVX-0045js-KD
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 14:31:50 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221205143143euoutp012b8f808b359ed9c3dafb5e3c1533a221~t7Cp5Ci-p1459414594euoutp01e
	for <linux-nvme@lists.infradead.org>; Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221205143143euoutp012b8f808b359ed9c3dafb5e3c1533a221~t7Cp5Ci-p1459414594euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670250704;
	bh=DrwhaP5wvMBer1T0AxaNHrcw6+swXdG/opZ7fT0H0Ik=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=k26sIlIESjBdSFxpNBXmCn4GGxPpx9hvo/3kDlGcUIFzdI+wVd8RvTrx1XO2rlorB
	 yyuDeHTOlwQ+1eNwzYWqdY4O1C+rvRCF+CqMV3K12lzgHmY8+hMNiq8qEIw5UM80Ab
	 oX5k6EgKd1q17VHki7ikRTldDH4jPMIBM7nOMN48=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221205143143eucas1p231ef5054e299d6b2df21b10a3fd78ad4~t7CprVGWa3244732447eucas1p2f;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 75.C3.09561.FC00E836; Mon,  5
	Dec 2022 14:31:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce~t7CpVqc7R1308813088eucas1p2z;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221205143143eusmtrp2d2d71e1c447bd559a3c56dfd859bd106~t7CpU-30L1241112411eusmtrp2_;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
X-AuditID: cbfec7f2-0c9ff70000002559-9c-638e00cf7b75
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id B7.99.09026.FC00E836; Mon,  5
	Dec 2022 14:31:43 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221205143143eusmtip1f0a51f630b081be41d06e94c62337819~t7CpMCWlo0131001310eusmtip1E;
	Mon,  5 Dec 2022 14:31:43 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 5 Dec 2022 14:31:40 +0000
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <chaitanyak@nvidia.com>, <sagi@grimberg.me>,
	<kbusch@kernel.org>
CC: <p.raghav@samsung.com>, <javier.gonz@samsung.com>,
	<joshi.k@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH v5 1/1] nvme : Add ctrl id to allowed passthru commands
Date: Mon, 5 Dec 2022 15:27:46 +0100
Message-ID: <20221205142746.1026912-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221205142746.1026912-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzned3zDH3JBq/btSzeH3zMarFy9VEm
	i0mHrjFazF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRnHZpKTmZJal
	FunbJXBlvJy8ga1gK1vF/q9n2BsYF7J2MXJySAiYSHzs3cvSxcjFISSwglHi/vIHTBDOF0aJ
	RS1/WCGcz4wS3VM/ssC07N92mx0isZxRYu/GL8wgCbCqg7sFIRKbGCVWdlxmB0mwCehInH9z
	B6xIRCBE4sftvWDdzAKzGCVOXuoGGyss4C6xftcKsAYWARWJG9O/gTXwCthKfDi/hhFitbxE
	2/XpYDangJ1E01uYGkGJkzOfgM1hBqpp3jqbGcKWkDj44gUzRK+ixJY536G+rpU4teUW2KMS
	Ajc4JP7d/s8EkXCR2LB1DxuELSzx6vgWdghbRuL/zvlQNdkSO6fsghpaIDHr5FSgeg4g21qi
	70wORNhRov35P6gwn8SNt4IQ5/BJTNo2nRkizCvR0SY0gVFlFpIHZiF5YBaSBxYwMq9iFE8t
	Lc5NTy02zEst1ytOzC0uzUvXS87P3cQITC2n/x3/tINx7quPeocYmTgYDzFKcDArifC+2Nib
	LMSbklhZlVqUH19UmpNafIhRmoNFSZx3xZSOZCGB9MSS1OzU1ILUIpgsEwenVAOTv8HFbTFv
	O8yaEuLPdtmECLWciI7ZwXl9oetr4StVvR9S9QQjFI4wcM/Pv8axL+xGwSt/0XmuQg2V637V
	MG35lliXovx+vULq0y6fZezT47lNSzTzynQr5gtsvXIq8PWSmw+451qohP+1eu/OfmjZnzuv
	PYp8pqjLrSs4cZ57/43WIvVl60rXKbQ8WSr5jG1pfl7ltPOCbAXxh/cZ24vOtv2dz1Y9zbDf
	dGex9+aQwtYdRktrl8dPEDxvY75uH9+qI7OfpjwuNObds/uL9grlLrX/4dxT19T9+JF5u9n1
	W0PCjvVvF4i3v3zh26e3Y0+U/q5rd64+3l35+e2f+66fN/5Ik3vuNOfro5tb3p3fo8RSnJFo
	qMVcVJwIAPn+yl+cAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7rnGfqSDWasEbF4f/Axq8XK1UeZ
	LCYdusZoMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGqVnU5RfWpKq
	kJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8XLyBraCrWwV+7+e
	YW9gXMjaxcjJISFgIrF/2232LkYuDiGBpYwSa098YYZIyEh8uvKRHcIWlvhzrYsNougjo0TP
	qU2sEM4mRomDd/ezgVSxCehInH9zB6xbRCBE4sftvWBjmQVmMEqsWguxT1jAXWL9rhVgY1kE
	VCRuTP8G1sArYCvx4fwaRoh18hJt16eD2ZwCdhJNbyFqhIBqjq3uZYeoF5Q4OfMJC4jNDFTf
	vHU2M4QtIXHwxQuoFxQltsz5DvVnrcTnv88YJzCKzELSPgtJ+ywk7QsYmVcxiqSWFuem5xYb
	6RUn5haX5qXrJefnbmIERt+2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrwvNvYmC/GmJFZWpRbl
	xxeV5qQWH2I0BfpzIrOUaHI+MP7zSuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtS
	i2D6mDg4pRqY8hP+GKuJ7xCq3ChzNIXtTX5N274IwWfijnMOJZbfrcvgaTylx1h75N0qE3Oj
	S9bigiKvOZd6r72z7fKLh5PCLTQmPqzxmWLWMVu4c8bi7amz7Hba2jHOSD69agtfysE3mn/b
	b5uXfpVxWLaDq3hzwFeLtIuLpvtvWbv98Tur47k5MmX2J4OtT6WGbm+obd7e33T7wp7kggsT
	JObdWvw85uWaH3/6ji1k2fpmaeQk3Xur4ph2Jt1uufr7wlWhdt+90bML2EtYF0bxLfQ7vuXZ
	Ju/IDa9L3tWrli/vOCr87Pu8f/8m3uizY7T9ms/Qen9OwidttoTyIwpueTMcfCL87t+xKpKT
	K5rS6zsx4evEK0osxRmJhlrMRcWJAMDek+VHAwAA
X-CMS-MailID: 20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce
X-Msg-Generator: CA
X-RootMTR: 20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce
References: <20221205142746.1026912-1-j.granados@samsung.com>
	<CGME20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_063148_274466_F2DF3F71 
X-CRM114-Status: GOOD (  11.64  )
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

Add NVME_ID_CNS_CS_CTRL and NVME_ID_CNS_CTRL to the nvme admin commands
that are allowed in unprivileged passthru. This will allow access to
attributes that are needed to effectively write to the char device in
passthru.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/nvme/host/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9550a69029b3..9ddda571f046 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -34,6 +34,8 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 			case NVME_ID_CNS_NS:
 			case NVME_ID_CNS_CS_NS:
 			case NVME_ID_CNS_NS_CS_INDEP:
+			case NVME_ID_CNS_CS_CTRL:
+			case NVME_ID_CNS_CTRL:
 				return true;
 			}
 		}
-- 
2.30.2


