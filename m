Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B864C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Jan 2022 14:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=dajj7+8u6+RVGk4vbyS6ox9A3BTCdDdBZGfhulcQdTw=; b=Hj6hRk+xmJAzXA4SeroLl0pggk
	HE2g7jn3ipywRXNmnNmyPSQ0IxApaRuyrfgNfL3haZi5JCQ2HSMkbs8EUwOwgZp3rfq6LWO9A2DyS
	0r+r3If5yiGB7VyxQNvTH9J+FOzPaUvDk+gq0mZwTFGCbmuL2nMAJLQmP7hCTDPr1Oo01jEP7eTSL
	fWls+lHdzmdWlXZpOOBA/HjiwpE/xLyNtw+NpY2liR246n/X8FYpOtuo/LGlxOI3PMer+XmT/Efmt
	uqiKlYGZxWxRLKj9rCh4/Tco/Eptw5HXLwCoaCuXrC8/rGYoYVqtt9iu+y57FPtrZViMwxcBvahI5
	EV/252ZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nAv10-00FO2O-F5; Fri, 21 Jan 2022 14:35:46 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nAv0x-00FO0B-5G
 for linux-nvme@lists.infradead.org; Fri, 21 Jan 2022 14:35:45 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20220121143539euoutp02883ed3738a047e5e176508775a8cd7c5~MT9TOQHqe1196911969euoutp027
 for <linux-nvme@lists.infradead.org>; Fri, 21 Jan 2022 14:35:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20220121143539euoutp02883ed3738a047e5e176508775a8cd7c5~MT9TOQHqe1196911969euoutp027
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1642775739;
 bh=dajj7+8u6+RVGk4vbyS6ox9A3BTCdDdBZGfhulcQdTw=;
 h=From:To:Cc:Subject:Date:References:From;
 b=UY8wSwtDEjpOsZ0NGdQYZgI5mWSLHB1ATn/5/22gcdlWIOzen/w54KTG+H1bE0TaH
 CFtKPLkWlJAYlR9ZyVhAC43fOSQJOvgMTBEHisQcsdh/ys3gy1bnK+ctQIdyEa+6ao
 8ZcwXL0Yh/i/38EtcQWAB5axKu4KxoKLD2P60hv4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20220121143539eucas1p12555cee792bf90fc9dc72aee9e7526f5~MT9TBu5ze0086900869eucas1p18;
 Fri, 21 Jan 2022 14:35:39 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 77.7E.10260.BB4CAE16; Fri, 21
 Jan 2022 14:35:39 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20220121143539eucas1p20202376f83b0b499143c18b1434ff000~MT9SxKMhj3076330763eucas1p2Q;
 Fri, 21 Jan 2022 14:35:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20220121143538eusmtrp2f697433c953d8cb20827a988d54efbb6~MT9SquMUb0857908579eusmtrp2Y;
 Fri, 21 Jan 2022 14:35:38 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-ac-61eac4bbd39e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id C1.8B.09522.AB4CAE16; Fri, 21
 Jan 2022 14:35:38 +0000 (GMT)
Received: from localhost (unknown [106.210.248.1]) by eusmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20220121143537eusmtip1f3d6858425a5cc4725870fe38818560c~MT9Re7sli1820218202eusmtip11;
 Fri, 21 Jan 2022 14:35:37 +0000 (GMT)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Pankaj Raghav <pankydev8@gmail.com>, linux-nvme@lists.infradead.org,
 Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] nvme: Use pci_iomap instead of ioremap
Date: Fri, 21 Jan 2022 20:05:33 +0530
Message-Id: <20220121143533.164928-1-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd3dR14lGuyax2mxcvVRJotJh64x
 Wsxf9pTd4vPSFnaLNTefsjiweuycdZfdY9OqTjaPzUvqPXbfbGDz6NuyijGANYrLJiU1J7Ms
 tUjfLoEro//TCpaCXawVd/deYmlgPMzSxcjJISFgIvH6xH62LkYuDiGBFYwSO67NZYZwvjBK
 XF38kwXC+cwosenwblaYlgMv+qFaljNK/P16kBXCec4oMXPGZCCHg4NNQEuisZMdpEFEwFni
 b+95JhCbWSBfovHlOrDdwgLmEu8WbASrYRFQlXg5axNYDa+AlcTpPZeglslLzLz0nR0iLihx
 cuYTFog58hLNW2eDnSohMJFD4njzSiaQvRICLhJrGmUgeoUlXh3fwg5hy0j83zmfCaK+nVFi
 +bpnLBDOBEaJjpsfmCGq7CX+fdrEBjKIWUBTYv0ufYiZyhJHbkHDy1Hi1Z517BBhPokbbwUh
 zuGTmLRtOjNEmFeio00IolpJYufPJ1AXSEhcbpoDNcVD4mPTEZYJjIqzkDw2C8ljsxBOWMDI
 vIpRPLW0ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMwqZz+d/zrDsYVrz7qHWJk4mA8xCjBwawk
 wluQ/ypRiDclsbIqtSg/vqg0J7X4EKM0B4uSOG9y5oZEIYH0xJLU7NTUgtQimCwTB6dUA5OD
 3MI+/Wy3f8+uhbouMbjBYp6R9T2TyzL38crHy2ZnbM5iT3vUtNjhy45rf2Zcyrn9+tXdEPd2
 gZz6OS43r1Y+znVPvynq+Ehige164cW2DqZ/eT5ssugTzPd97B3wx/3Lqy1NVwocNXY3Nvuq
 sq907FSc8//LFUNjzykNgYaNPGs05r3inSj4oaZPzU7rVvDS15ur/ofOd9nK2ZK0llFnu6T7
 RdFnL1KFnhdxKZQVqj7nvLptsv1fRy/r8nUSR/1l+Mt12a7fKZstwOeSwrqteG3k7IDfgR/P
 WM5heHjYq1Y3WfrI6ZxYpSC9rZnzmPpCX2rVNoZ/67273uXXaZFD1gvLOj+c3Lx2xuVQLyWW
 4oxEQy3mouJEAC0ql+WZAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xu7q7jrxKNJj1QNti5eqjTBaTDl1j
 tJi/7Cm7xeelLewWa24+ZXFg9dg56y67x6ZVnWwem5fUe+y+2cDm0bdlFWMAa5SeTVF+aUmq
 QkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRv+nFSwFu1gr7u69
 xNLAeJili5GTQ0LAROLAi362LkYuDiGBpYwSjxauZ4NISEjcXtjECGELS/y51gVV9JRRYtqD
 2UDdHBxsAloSjZ3sIDUiAq4Sm/+uAKtnFiiU+HRmKSuILSxgLvFuwUawGhYBVYmXszYxgdi8
 AlYSp/dcYoWYLy8x89J3doi4oMTJmU9YIObISzRvnc08gZFvFpLULCSpBYxMqxhFUkuLc9Nz
 iw31ihNzi0vz0vWS83M3MQLDeduxn5t3MM579VHvECMTB+MhRgkOZiUR3oL8V4lCvCmJlVWp
 RfnxRaU5qcWHGE2B7pvILCWanA+MqLySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTU
 gtQimD4mDk6pBqYKzSCxqwsKjiiYpl9O7eu815vqHC6Y4NrmorG7cs9J/4bdrL8WLZ+Qz7Kl
 cK3N/gevbKUVV1YL//oVyMv7on+W28vW3Cttc/9UvTDl2fz1zKU53+3vnzPm3P7/yMlDjxde
 +Tg3IbnskZXC/Sq76XJW2/vmXvpjo15xUTWkI34bW8msoAuZK+f27eifInz32uUfuw0bDW0u
 l5qLdvxaHzefO7Jgm62F7D6tCO6MhSsfSP2ftPvrHBm5vU5TrwalnIh/eXqGxK5jHBcWC/xv
 dVwXe9JO8fdlHuHpwZZcE4V1rzvdK3Lhue1tsmuhjIT0p0MSmT3PW/nP/o1afKH29ovlW4qN
 tflf/zOLZ7orfu+AEktxRqKhFnNRcSIALwXbNfACAAA=
X-CMS-MailID: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-RootMTR: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220121143539eucas1p20202376f83b0b499143c18b1434ff000
References: <CGME20220121143539eucas1p20202376f83b0b499143c18b1434ff000@eucas1p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220121_063543_561223_36961E33 
X-CRM114-Status: GOOD (  12.98  )
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

Use the better checked pci_iomap instead of ioremap.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d8585df2c2fd..6c8aad9ff7db 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1800,7 +1800,7 @@ static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 		return -ENOMEM;
 	if (dev->bar)
 		iounmap(dev->bar);
-	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
+	dev->bar = pci_iomap(pdev, 0, size);
 	if (!dev->bar) {
 		dev->bar_mapped_size = 0;
 		return -ENOMEM;
-- 
2.25.1


