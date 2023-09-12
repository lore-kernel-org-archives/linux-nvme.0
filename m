Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C57CA0EC3
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=GaYCwQqNDH9JX6B/vwpvteUWi16Iqx6JkVARbYdwWW0=; b=hfZtl/oRYua+hg
	gszDmyexllUByTnTKmMHOaeZbDoTl+PFBKXpyz2UrA8/zii8LElmZ7Ov1zYQyGhaL2SS4byPEHggw
	DND+5tVZoIiQ1cBb1W6fSyRnLxOyd9eYJmluDq9xqh81LVpPyr7o/ZqqPhg9743T/a9POPdsQ3371
	g0dAa9r4buuOYiD/8RFer85HHruYP3/KXBXE0VHig9ayykFS3bs2IJrESMNrNM544LZsr0p0/QHRG
	V69I/bp/jFR9YHI29KaZn+LJtK/P4xPzjuMbTYU0mOfMv56N4Hmft28j4jeUZApFKCQms+jHPeKLY
	hI4HuckVkqbaBMqPfJyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1Kz-003BPi-1f;
	Tue, 12 Sep 2023 11:13:45 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1Ku-003BON-2r
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:13:43 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230912111333epoutp03aee0c77cd652a14de94930c1f586ea5d~EIm2Se1BM3182931829epoutp03C
	for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 11:13:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230912111333epoutp03aee0c77cd652a14de94930c1f586ea5d~EIm2Se1BM3182931829epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1694517213;
	bh=GaYCwQqNDH9JX6B/vwpvteUWi16Iqx6JkVARbYdwWW0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=VhFXvq/W6VNE0RULVmIHNkCjH81p6dIhEmtp3eHMCLPwPMcEhQ712SxTEMXrVJu2W
	 6NF33bPwILEsZjy6HZ6pRoOFdKD2NKLNWj09gdNx4OZG7N46aCNKkLVZ5js8yQ13nh
	 ynVeQF/ihgLf5EPzSL36M88YdUWxM8p4uKh9ceso=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230912111333epcas5p3d5ea62b5296dd1d5337914b9cdfbff9a~EIm169sBa1018110181epcas5p3A;
	Tue, 12 Sep 2023 11:13:33 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4RlLYS1J0Yz4x9Pr; Tue, 12 Sep
	2023 11:13:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E1.18.09949.CD740056; Tue, 12 Sep 2023 20:13:32 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230912092353epcas5p130b50fa2030574071c41461447fddd52~EHHFhGthI1065910659epcas5p1e;
	Tue, 12 Sep 2023 09:23:53 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230912092353epsmtrp29b6568c1bdec3b61fa6b41650be298f9~EHHFgXlCO1661016610epsmtrp28;
	Tue, 12 Sep 2023 09:23:53 +0000 (GMT)
X-AuditID: b6c32a49-98bff700000026dd-5d-650047dc7e9f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9D.65.08742.82E20056; Tue, 12 Sep 2023 18:23:53 +0900 (KST)
Received: from localhost.sa.corp.samsungelectronics.net (unknown
	[107.99.41.223]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230912092351epsmtip233955eeb43722b7a2d2d3934258f5b75~EHHEIZjZZ2725227252epsmtip2k;
	Tue, 12 Sep 2023 09:23:51 +0000 (GMT)
From: soni.ankit@samsung.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, sathya.m@samsung.com,
	d.palani@samsung.com, prakash.bv@samsung.com, anshul@samsung.com, Ankit Soni
	<soni.ankit@samsung.com>
Subject: [PATCH 1/1] nvme: host: changing data type for variable from bool
 to int.
Date: Tue, 12 Sep 2023 09:25:11 +0530
Message-Id: <1694490911-32299-1-git-send-email-soni.ankit@samsung.com>
X-Mailer: git-send-email 1.8.3.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBKsWRmVeSWpSXmKPExsWy7bCmpu4dd4ZUg92nWS1+T5/CavF/zzE2
	i7dfH7BZrFx9lMli0qFrjBbzlz1lt7g3o4vdYt3r9ywWWy8vYLc4uvQ9swOXx8Tmd+we5+9t
	ZPHYtKqTzWPzknqP3Tcb2Dz6tqxiDGCLyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1
	tLQwV1LIS8xNtVVy8QnQdcvMATpNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNg
	UqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdseXzf7aCVWwV25bOZWlgXMbaxcjJISFgIrFlxgOm
	LkYuDiGB3YwSU/ZvZYZwPjFKrD+0hR3C+cYocfPESrYuRg6wlnMb8yDiexklWp9vZoFw2pgk
	nq7pZwaZyyYgI/FkzhEwW0TAUeLViudsIEXMAosZJTo/TmEDSQgLhEis7L/HDmKzCKhKXDv1
	AewoXgE3iR0r9jJBHKggMeXhe7CbJATOsUuc2v+QHSLhItF6cTMjhC0s8er4Fqi4lMTnd3vZ
	IOxsiZknvkDZBRKbp5xmhrDtJS7u+csE8g6zgKbE+l36EGFZiamn1oHtZRbgk+j9/QTqBl6J
	HfNgbBWJNevfMMGs+v3wDJTtITF50zewVUICsRJHls1in8AoOwthwwJGxlWMkqkFxbnpqcWm
	BYZ5qeXwmErOz93ECE5yWp47GO8++KB3iJGJg/EQowQHs5IIb8mhvylCvCmJlVWpRfnxRaU5
	qcWHGE2BYTaRWUo0OR+YZvNK4g1NLA1MzMzMTCyNzQyVxHlft85NERJITyxJzU5NLUgtgulj
	4uCUamCyudBeukPu65fQf9VLZ21xvf/h8DruLuHlj1yt175QkBOZcL5RMFssIe7ewcTTfGfF
	J8T1ZouetF/1c0ePc5fqUrlcF+5DJXy98/3qD2+O/5v/9qdy0vP0ncK6C+d+yRY5c+nykXhm
	5dMX4/JDDQ40zv0UtkqsPSJh7cv2u5dZ+wvdpvJ8Y16yP3TSuto6HuODpz6f5Eua5/Fuzr/I
	kIfit/Y/mer8I8ltpVji3pS6s+YyyqtC+o5/epq+QXju1lcuss9yzPc+uLZ9phL/YrvV1+w5
	fN+ayBTsuVx1+8j9fTsDZ3lFbHU+bLfpv5Vd2J16Sx010WOP9BPS04+k6G+3mKomtXdtXmVa
	I6vf6uf5SizFGYmGWsxFxYkAA2b7dfsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprMLMWRmVeSWpSXmKPExsWy7bCSvK6mHkOqwbkORovf06ewWvzfc4zN
	4u3XB2wWK1cfZbKYdOgao8X8ZU/ZLe7N6GK3WPf6PYvF1ssL2C2OLn3P7MDlMbH5HbvH+Xsb
	WTw2repk89i8pN5j980GNo++LasYA9iiuGxSUnMyy1KL9O0SuDK2fP7PVrCKrWLb0rksDYzL
	WLsYOTgkBEwkzm3M62Lk4hAS2M0o8evtZqYuRk6guJTEgtU7WCFsYYmV/56zQxS1MEl0nDrL
	CJJgE5CReDLnCDOILSLgLnH0ZQMTSBGzwEpGiXV7V7GBJIQFgiTOvD8NZrMIqEpcO/UBbCqv
	gJvEjhV7obYpSEx5+J55AiPPAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5uZsYweGm
	pbmDcfuqD3qHGJk4GA8xSnAwK4nwlhz6myLEm5JYWZValB9fVJqTWnyIUZqDRUmcV/xFb4qQ
	QHpiSWp2ampBahFMlomDU6qBya344nyuw3tfab7w/C5y9bymWuikWaVLnj/8sFWW45nuS2cr
	5r6Pv9dzeD4WnG3Rp6c+oXBf2ZQfRzX3tWv8//VZZ1Pk4ZQTaZsNOXgXZf3mzmtksjp158Hz
	ZYWSYWsudJQ/1tkT5MIpas16tcNCdwrvktuPZl9if5Ip0jbnfEbfRD/LgyvuWDbMZQjc8uKS
	VuWbTXLZHc9NHIO3Vjb9277ZeIXD+vCEFQXtgSmLhEt+V7Ge5bDQf2h/Rkbqzot35w77nili
	so1rDlPZt6O+4FpPzHqDKdbGs2sDS2Mn1xW36b2Jl43z+RE+NX1l6UYphYX/M3cVxJ3id5gh
	uCDB5eAhq082P+c8YL3ftCEiVYmlOCPRUIu5qDgRAPQaR7imAgAA
X-CMS-MailID: 20230912092353epcas5p130b50fa2030574071c41461447fddd52
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230912092353epcas5p130b50fa2030574071c41461447fddd52
References: <CGME20230912092353epcas5p130b50fa2030574071c41461447fddd52@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_041341_638386_E4CC1BCF 
X-CRM114-Status: GOOD (  17.33  )
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

From: Ankit Soni <soni.ankit@samsung.com>

Changing data type of  local variable to make it aligned with
return type of "nvme_poll_cq" function.

Signed-off-by: Ankit Soni <soni.ankit@samsung.com>
Signed-off-by: Sathyavathi M <sathya.m@samsung.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12..b328a65 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1116,7 +1116,7 @@ static void nvme_poll_irqdisable(struct nvme_queue *nvmeq)
 static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
-	bool found;
+	int found;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
-- 
1.8.3.1


