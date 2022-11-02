Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A966C43219
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 17:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:MIME-Version:Content-Type:Message-ID:Date:Subject:
	CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=IPGa8iEHGxlJlHr5lizXk3EZyR7QlUBjkJcb67tBOgo=; b=IxnwJ8eSQ0v4/jE+G1tyr2nDQr
	/+0BOb0WUGT5f46OUks0y7NFOrTyW53qNFw1QjGwoMntLSJPVSmfk5/5oWSvVhbylSTgHSl0e8McT
	tXpyetbs4Gx4rd//ooB1tlQw1mQ2bkmn7Skcrqhggm6dv92g5S06b3HUs2SwEUBeqvjk2z2DzJP3n
	eUcU01kWFcnqmpCM9QMwc0QNT8lQx8TepHbMALvj1rxlmzxuDJOD6G5mRVsLU4tf+Wsa4HTkEzANW
	e3Qc4prLwj0ffR3pnEJi1uuwZiBrL/Q7gNx56i0PeRPNMtfHWCcRZTpAQd44PtIUBh9PpUb8kF+5L
	k2xI+/fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqHQE-00CVT2-MS; Wed, 02 Nov 2022 17:21:02 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqHQ4-00CVL2-Gb
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 17:20:55 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20221102172042euoutp024792cde4ef2d9f2be87aba4a5335a279~j1Dw8txYb0905109051euoutp02h
	for <linux-nvme@lists.infradead.org>; Wed,  2 Nov 2022 17:20:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20221102172042euoutp024792cde4ef2d9f2be87aba4a5335a279~j1Dw8txYb0905109051euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667409642;
	bh=IPGa8iEHGxlJlHr5lizXk3EZyR7QlUBjkJcb67tBOgo=;
	h=From:To:CC:Subject:Date:References:From;
	b=ONyK5dy+kqHUO1Q9tHJDUKWNeQ5oUPejqOkn8YhbYKtXnnGV0SE6PzxRWtVQkfEmr
	 tUegblap19R/ysc6Cv2C9VaL+KHMdS0OqErrgHDoNhQ4wCVImJKCqTZc0tf5sTW3xP
	 FslAfQT1/h4CCJADPU6DnHQObzU/47Ofevqi4xj4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221102172042eucas1p2efd04e76023ce6af56c0d95e576ab36d~j1Dw2BHr31900419004eucas1p2r;
	Wed,  2 Nov 2022 17:20:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 2D.29.19378.AE6A2636; Wed,  2
	Nov 2022 17:20:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221102172041eucas1p2d34f85a83d3dd5a8d110c26a88e187a8~j1DwlSWAz1937119371eucas1p2V;
	Wed,  2 Nov 2022 17:20:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221102172041eusmtrp1c93f97057c9989aaaf1c782d1cc8b987~j1Dwkm9bv2164121641eusmtrp1N;
	Wed,  2 Nov 2022 17:20:41 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-a7-6362a6ea5b92
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 13.FD.07473.9E6A2636; Wed,  2
	Nov 2022 17:20:41 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20221102172041eusmtip22c2fbc5bce921148d2c0dfb6e6009235~j1DwZrTXW1790017900eusmtip2E;
	Wed,  2 Nov 2022 17:20:41 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Wed, 2 Nov 2022 17:20:40 +0000
From: Joel Granados <j.granados@samsung.com>
To: <kbusch@kernel.org>, <sagi@grimberg.me>, <hch@lst.de>
CC: <gost.dev@samsung.com>, <linux-nvme@lists.infradead.org>, Joel Granados
	<j.granados@samsung.com>
Subject: [PATCH 0/1] nvme: return err on nvme_init_non_mdts_limits fail
Date: Wed, 2 Nov 2022 18:17:07 +0100
Message-ID: <20221102171708.3303614-1-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djP87qvliUlG6yawGqxcvVRJotJh64x
	Wsxf9pTdYt3r9ywOLB7n721k8di0qpPNY/OSeo/dNxvYAliiuGxSUnMyy1KL9O0SuDL2v1vO
	XnCApeLF0k3sDYx3mbsYOTkkBEwkVq1bxtbFyMUhJLCCUWLhulnMEM4XRolpE36yg1QJCXxm
	lHj5SBKm40v7fUaIouWMEm37r0C1AxV1/XwM1bGJUeLCz1wQm01AR+L8mztg+0QELCUmvPnP
	AmIzC6RJvO89DlYvLOAu8e1NLxuIzSKgIjF77XqwGl4BW4lj/yazQmyWl2i7Ph1oMwdQr6bE
	+l36ECWCEidnPoEaKS/RvHU21GuKElvmfIdqrZU4teUWE8idEgJbOCTefp/MApFwkbgw4Qoj
	hC0s8er4FnYIW0bi9OQeqJpsiZ1TdkENLZCYdXIqG8gNEgLWEn1nciDCjhLnz+1jgQjzSdx4
	KwhxDp/EpG3TmSHCvBIdbUIQ1WoSO5q2Mk5gVJ6F8MssJL/MQvLLAkbmVYziqaXFuempxcZ5
	qeV6xYm5xaV56XrJ+bmbGIHp4/S/4193MK549VHvECMTB+MhRgkOZiUR3vqz0clCvCmJlVWp
	RfnxRaU5qcWHGKU5WJTEedlmaCULCaQnlqRmp6YWpBbBZJk4OKUamHIPb73ed+qB4ZXGr13P
	HesP+wurfLx+LKnmwKqoU4tOux/9rLLsv9bC63zOvyr9NeNCns+L4Ll33nPGnE2yti/nXN4e
	tsC2KHaWpZh/k9yku2fTdxTe3mf67kbG8tvaJ32L7b5Vp7Fkec5Snrg5jm+eQpwer+jXY/OU
	bi8JW6ev8fzV7u6kRvsHyq8P3t2u+Wez8cub28xlxaa2PL52LY230+vJM97cCQK/DWZZX08/
	WrhH8fC1Tw81rfgPXkwKPX1r1axF14/eevDZsM+Yc/3Pmlfyp1/e3Nf878dF+8BbH6etc+Ar
	P5bt+yJPt8tZX/fGukKR3ybVebP3HDx6quFru8STh8F3HWV/rjlaMfH9CyWW4oxEQy3mouJE
	AG0DtZGOAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnkeLIzCtJLcpLzFFi42I5/e/4Pd2Xy5KSDfZ81rVYufook8WkQ9cY
	LeYve8puse71exYHFo/z9zayeGxa1cnmsXlJvcfumw1sASxRejZF+aUlqQoZ+cUltkrRhhZG
	eoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehn73y1nLzjAUvFi6Sb2Bsa7zF2MnBwS
	AiYSX9rvM3YxcnEICSxllDj2ZB1UQkbi05WP7BC2sMSfa11sEEUfGSUurtvADuFsYpT4MuUY
	G0gVm4COxPk3d8C6RQQsJSa8+c8CYjMLpEm87z0ONklYwF3i25tesHoWARWJ2WvXg9XwCthK
	HPs3mRVim7xE2/XpQCdxAPVqSqzfpQ9RIihxcuYTqJHyEs1bZ0MdqiixZc53qNZaic9/nzFO
	YBSahdA9C0n3LCTdCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgTGzLZjPzfvYJz36qPe
	IUYmDsZDjBIczEoivPVno5OFeFMSK6tSi/Lji0pzUosPMZoCfTORWUo0OR8YtXkl8YZmBqaG
	JmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUxbPz6Vej1h+/HD/689sCxPEfp5
	oG4Ba5mDzhe9f2/5z+fuMg0VbPj09S3/3MPaTDkBm56kPnkcl9xfXrfx7ha7IoHmzHeBVrac
	nyw+GXV9KW5u9Hv66K7nAbMNE6euEF+moW8acfhutXDEzO3rm95dZTlzM+bPvoUf3ukk3HgY
	+7xROOzBilnfEhbN+C002bhqYeeb/2o/VjmpaK97/KiEfV1T0ayMbQ0+P3ceF3neviVVTjF6
	9Zmwx3Jfv4U69rKdN9iSsq30x1HNyxVbV18/mll96f3Zj8k/HLblvUtRnT539QNB+5cKE/l+
	bdb4tDTOwe1CmPxPwz5Fj8ty+odd92hfTT3NtrpeyXLCG6UZU5VYijMSDbWYi4oTAedG+UUi
	AwAA
X-CMS-MailID: 20221102172041eucas1p2d34f85a83d3dd5a8d110c26a88e187a8
X-Msg-Generator: CA
X-RootMTR: 20221102172041eucas1p2d34f85a83d3dd5a8d110c26a88e187a8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221102172041eucas1p2d34f85a83d3dd5a8d110c26a88e187a8
References: <CGME20221102172041eucas1p2d34f85a83d3dd5a8d110c26a88e187a8@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_102053_169388_AF606996 
X-CRM114-Status: UNSURE (   9.42  )
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

This patch was part of an RFC that I previously posted
https://lore.kernel.org/all/20221027155724.1161670-1-j.granados@samsung.com/
but it generated some discussion so I decided to send it out by itself.

In nvme_init_non_mdts_limits function we are returning 0 on kzalloc
failure; it should be returns -ENOMEM.  Introduced in: 5befc7c26e5a ("nvme:
implement non-mdts command limits")

Joel Granados (1):
  nvme: return err on nvme_init_non_mdts_limits fail

 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.30.2


