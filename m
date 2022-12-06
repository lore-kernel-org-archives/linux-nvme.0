Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB0FC352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 07:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q9/VZUZOe2Xl+04vfQljLT1kmH9gsmzuIJEJuNWCDu4=; b=S3CA4CsflG2WIAuNPDb6es5H8N
	k4fubcp136HI954fCPHD4Aa0pubInNavEEpLySFrNswUqcEmxbreLZA43BRwVV8JV4V4qEA1sM1Np
	blPNXbKS0tJ1Nqb3V86YLZRJKh0rIOEZ5UZs2D0plBP/yqUfnR89i+OFkL7yUxKSbCQ7mZOHGFuTK
	+CnyvTaCRFpLjVANxsDFaIpJ9mmLON3pQKciFZyDyZyPrwcWU5Ccp30zeO5upejeqJkqWPgwpU4r4
	dGuC+BSSf2Md5SgxfxNsRa9S4biFFw+OZFp2Eq1n3TOOxQzS7XKjfDqdZRWWmkHVdJbVI6Em5Nx22
	fiNHL4Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Sbi-003sjg-4a; Tue, 06 Dec 2022 07:43:14 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Sbd-003sVP-Rh
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 07:43:12 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221206074307euoutp02a3fc5a52b53572c81967301c1b061144~uJHLrvy0t3170831708euoutp02Q
	for <linux-nvme@lists.infradead.org>; Tue,  6 Dec 2022 07:43:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221206074307euoutp02a3fc5a52b53572c81967301c1b061144~uJHLrvy0t3170831708euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1670312587;
	bh=q9/VZUZOe2Xl+04vfQljLT1kmH9gsmzuIJEJuNWCDu4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=lFjKy762S/ZM+GSlsJT9bypeI0ShG1dvqetvZ4WcQdHy3lWz/s9fDrdkaRTkaJZ43
	 3KFk7YJyDuzC5qd4US2Yt3KjWSjKyDvYXDk++owlWcA4dY7vqZAfR4n36P2SMrx18V
	 pg6/7/zK9KBQwRl6itLexYSvDZESFNtFE++UH6+Q=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20221206074307eucas1p1234bcfa7a6b0e252952d437d91df8330~uJHLfOaCQ3045530455eucas1p1Z;
	Tue,  6 Dec 2022 07:43:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CB.B9.09549.B82FE836; Tue,  6
	Dec 2022 07:43:07 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221206074307eucas1p2efc258061ac4ee50f2a818bb854af157~uJHK_G09-2478524785eucas1p2s;
	Tue,  6 Dec 2022 07:43:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221206074307eusmtrp124e9e542fbfe357240ed6d23a20f7c95~uJHK9fpMr1421114211eusmtrp1u;
	Tue,  6 Dec 2022 07:43:07 +0000 (GMT)
X-AuditID: cbfec7f5-f47ff7000000254d-bc-638ef28b097d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 97.D2.08916.A82FE836; Tue,  6
	Dec 2022 07:43:06 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221206074306eusmtip247134cbe2b5d993ee70e90443cd2dca5~uJHKvikgO1186411864eusmtip2h;
	Tue,  6 Dec 2022 07:43:06 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 6 Dec 2022 07:43:01 +0000
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <chaitanyak@nvidia.com>,
	<sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>, <javier.gonz@samsung.com>,
	<joshi.k@samsung.com>, <p.raghav@samsung.com>, Joel Granados
	<j.granados@samsung.com>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v6 1/1] nvme : Add ctrl id to allowed passthru commands
Date: Tue, 6 Dec 2022 08:39:14 +0100
Message-ID: <20221206073914.1243191-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221206073914.1243191-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned3uT33JBtfey1q8P/iY1WLl6qNM
	FpMOXWO0eHp1FpPF/GVP2S3WvX7P4sDmcf7eRhaPTas62Tw2L6n32H2zgc2jt/kdWwBrFJdN
	SmpOZllqkb5dAlfGu7dvWAses1csnbSKqYFxO1sXIyeHhICJxJuuB2C2kMAKRom7vdxdjFxA
	9hdGiclXL7BAOJ8ZJX7NPgbkcIB1vJ8YABFfzihx4+h3RriiS5d2MkM4mxgl7jStZAeZyyag
	I3H+zR1mEFtEIERi6ZXpTCBFzAL7GSXOfdvNCpIQFnCXWLLyNyvIChYBFYltq3VAwrwCthIT
	fu5lgrhVXqLt+nRGEJtTwE7ixtpuJogaQYmTM5+wgNjMQDXNW2czQ9gSEgdfvGCG6FWU2DLn
	OyuEXSuxt/kAO8gNEgJvOCR2tJxjhEi4SBw4vxfKFpZ4dXwLO4QtI3F6cg8LhJ0tsXPKLqih
	BRKzTk5lgwSLtUTfmRyIsKPEwec72CHCfBI33gpCnMMnMWnbdGaIMK9ER5vQBEaVWUgemIXk
	gVlIHljAyLyKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMMGc/nf86w7GFa8+6h1iZOJg
	PMQowcGsJML7YmNvshBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeFVM6koUE0hNLUrNTUwtSi2Cy
	TBycUg1MLhPTDPI+qcT+X7fz+e6unAtrruV9vXk6h3lS8OtlYp5q+o96HyxxEVmc7pJx8c7O
	reYTt0xvMVicZaF7uyPt0urLCbYRfFLXpcy0r3tfOf5ZsuX7gdI3Medar35dPu3FPD9uC4VM
	3fJNf90cr7/bmKnldN7rGld62cLCvj1h/ftu37APX6QeU5uSLJbofOYh695NVjPNmy5+XPkl
	PfFfypb/p+ODMk08mbfPSHWKXmApzn/M4NR7raV/7n20659z9f5xrZhNS56/OMek2xnEUcPg
	VG0/6fee6JurtScrH7vy5o8H889309/P/GO97MMZG44Js5u8rOcoqvSUz2TYosytve1ymtGJ
	rW7TXjFHmiqxFGckGmoxFxUnAgD9jgpmnwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsVy+t/xe7pdn/qSDX4dMLN4f/Axq8XK1UeZ
	LCYdusZo8fTqLCaL+cuesluse/2exYHN4/y9jSwem1Z1snlsXlLvsftmA5tHb/M7tgDWKD2b
	ovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2Md2/fsBY8
	Zq9YOmkVUwPjdrYuRg4OCQETifcTA7oYuTiEBJYySnRsnszSxcgJFJeR+HTlIzuELSzx51oX
	G0TRR0aJr/3rGEESQgKbGCWmffYEsdkEdCTOv7nDDGKLCIRILL0ynQmkgVlgP6PEuW+7WUES
	wgLuEktW/mYF2cwioCKxbbUOSJhXwFZiws+9TBDL5CXark8Hm88pYCdxY203E8QuW4ktU14w
	Q9QLSpyc+QTsUGag+uats5khbAmJgy8gaiQEFCW2zPnOCmHXSnS+Os02gVFkFpL2WUjaZyFp
	X8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwArcd+7l5B+O8Vx/1DjEycTAeYpTgYFYS
	4X2xsTdZiDclsbIqtSg/vqg0J7X4EKMp0JsTmaVEk/OBKSCvJN7QzMDU0MTM0sDU0sxYSZzX
	s6AjUUggPbEkNTs1tSC1CKaPiYNTqoGpK/XB5bzg2m99sef+OOs7Z7+QuPaz8eICv1UMLzOO
	1yYEbbn3Rut4MueS525+Ind3Ox4VaeL9tOPr7im/8pfyn9hrbbP2WNd85ZcMJjU78iLjFlS9
	92heZ7/hTW7Ym5DVkvEPdJmr4u8nSuslXBOd5tFfvP78lhCXMIfzW/bptd7pl7vzs12smf/R
	7lK2SWc2mn16tKDMo+jatHN/l27U+8v+qmhV0ruyWY4eQQ3Guyx0807U1079uX7vFln1RbOn
	VQXPvr9y3vP/u413t/aIJ+yewegb/v3AKo4ln/N/e5ixWr06Wf3+1tZ3WztcDoYw9J/NsTTJ
	+pJjkG3yz//Kuc2mutkfy7f+uDPlWf/n1UosxRmJhlrMRcWJAP9kZjtJAwAA
X-CMS-MailID: 20221206074307eucas1p2efc258061ac4ee50f2a818bb854af157
X-Msg-Generator: CA
X-RootMTR: 20221206074307eucas1p2efc258061ac4ee50f2a818bb854af157
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221206074307eucas1p2efc258061ac4ee50f2a818bb854af157
References: <20221206073914.1243191-1-j.granados@samsung.com>
	<CGME20221206074307eucas1p2efc258061ac4ee50f2a818bb854af157@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_234310_181717_7D705702 
X-CRM114-Status: GOOD (  11.67  )
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
that are allowed in unprivileged passthru. This will make attributes like
maximum data transfer size (mdts) and write zeroes size limit (wzsl)
available so they can be used to effectively write to the char device in
passthru.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


