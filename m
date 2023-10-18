Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42F8CDB47E
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Oct 2023 14:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=SdqUnA7w3NpIzu45nzdgSwhtvQWblzAEAHaI6zNSMec=; b=AoN/tJrO4k05dZBu22StwKCqUH
	gpqBw8NzYFOkqgh6fjC+M8yA7jkxRN4SRtqKQstH3hutXUoSTzyZObc/bWfx0UKpLjjxRHtPWr/AG
	ZGGvMHIDflgXzcrPvbaz7qAEjom4i+I2oAVEdL3oZCHl0hf21rGZE2FcnsXKRNyq0MOmdcKXpLmUa
	382T+xZDFg8v+9zPbmrNI9kEBUDTkKEyreGMzBNS6vJ8YZGvOUxbu3aJcFrXdPmpR9m584AVPVnEd
	53HMZiKKXHP0i+FB4mBMh+wJHn4EjWYqAC1Qg2Dr7OQ9DELDp3KjdiA/Ghnb2KQExnC0R3cO/vorb
	4ybx0FAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qt79L-00Eq7U-21;
	Wed, 18 Oct 2023 14:03:51 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qt79I-00Eq73-0h
	for linux-nvme@lists.infradead.org;
	Wed, 18 Oct 2023 14:03:50 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231018140335epoutp04188ab053bd43b89d60b84d58e860f69c~POJlS1bfe3217232172epoutp04J
	for <linux-nvme@lists.infradead.org>; Wed, 18 Oct 2023 14:03:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231018140335epoutp04188ab053bd43b89d60b84d58e860f69c~POJlS1bfe3217232172epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697637815;
	bh=SdqUnA7w3NpIzu45nzdgSwhtvQWblzAEAHaI6zNSMec=;
	h=From:To:Cc:Subject:Date:References:From;
	b=pxVatu+hqFDWqVQH5JiwG+JJC7r3bTtX6aY5EGxnnjaK59Nzlu2nd/16Ojc2flMya
	 yxs7AYfAfLBABfXC/wi391qDfOG2PbRAIkA68FH5/YBrhhQUPbVTyfI00DVek9cP9W
	 aPlitH3ur8/xDho7j+uXEABGpXMfX+1D3uPmjung=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231018140335epcas5p24761d9c8d84855fefdcf3b18ba64c9cb~POJlGDqKP1091610916epcas5p2A;
	Wed, 18 Oct 2023 14:03:35 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4S9Xd22R9Mz4x9Pp; Wed, 18 Oct
	2023 14:03:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.4C.09634.6B5EF256; Wed, 18 Oct 2023 23:03:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6~POJjuMI8P1405414054epcas5p1o;
	Wed, 18 Oct 2023 14:03:34 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231018140334epsmtrp1c63cbfa01e9bad33ae786343556c7ce4~POJjtjK9M2413324133epsmtrp1S;
	Wed, 18 Oct 2023 14:03:34 +0000 (GMT)
X-AuditID: b6c32a49-eebff700000025a2-87-652fe5b6e727
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.25.18939.5B5EF256; Wed, 18 Oct 2023 23:03:33 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231018140332epsmtip105674b10de8ab1cf5854c8e30be67521~POJif69lD1744417444epsmtip1C;
	Wed, 18 Oct 2023 14:03:32 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, joshiiitr@gmail.com, Anuj Gupta
	<anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] nvme: fix error-handling for io_uring nvme-passthrough
Date: Wed, 18 Oct 2023 19:27:18 +0530
Message-Id: <20231018135718.28820-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdlhTQ3fbU/1Ug/MHBCyaJvxltlh9t5/N
	YuXqo0wWR/+/ZbM4//Ywk8WkQ9cYLeYve8puse71exYHDo+ds+6ye5y/t5HF4/LZUo9NqzrZ
	PDYvqffYfbOBzaNvyyrGAPaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8
	xNxUWyUXnwBdt8wcoKOUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnF
	pXnpenmpJVaGBgZGpkCFCdkZjy99YSmYzlFx6doq9gbGD2xdjJwcEgImEltXzWfuYuTiEBLY
	zShxasEZsISQwCdGiVs3dSASQPbt1dOYYTpmnH4F1bGTUWLt1O2sEM5noKp7PUDtHBxsApoS
	FyaXgjSICLhINPx7wwhSwyzQyChx/fRvFpAaYQF3ie5OEZAaFgFViQs//rOA2LwCFhKrGh4x
	QiyTl5h56Ts7RFxQ4uTMJ2A1zEDx5q2zwY6QELjHLvHwUi8rRIOLxNLVv1kgbGGJV8e3sEPY
	UhIv+9ug7GSJSzPPMUHYJRKP9xyEsu0lWk/1M4Pcxgx0//pd+hC7+CR6fz9hAglLCPBKdLQJ
	QVQrStyb9BRqq7jEwxlLoGwPifXr3zGClAsJxEpMXcY+gVFuFpIHZiF5YBbCrgWMzKsYJVML
	inPTU4tNCwzzUsvhMZmcn7uJEZwYtTx3MN598EHvECMTB+MhRgkOZiUR3vRgnVQh3pTEyqrU
	ovz4otKc1OJDjKbAUJ3ILCWanA9MzXkl8YYmlgYmZmZmJpbGZoZK4ryvW+emCAmkJ5akZqem
	FqQWwfQxcXBKNTBpmnGFJ2zbNTc89iJX4RbpFRcUHwu8OKq1Y43GHtZzwgq6jRItEg7Bfqel
	b7+8yHbhs4Rsgqhf71tZP7WWmh1O2zbNVN0c/U+69NWPl4eyFu39lxQYwrg7im1nzdJeh/bj
	XmLHd867rxLL/klL2Y7N0UeNqT/tt4PeUuaZOZ8lbKMn2Tyy3Hyk1fv0tJJA4zI9D57edHsX
	6f6ilIsT89ZwHX9mcptJW/lRmcak7kvrQ/aYbXixZZ5PiPmaprT0BTP/rD8ay5fy4UytrWlD
	j2PiNAVH0V2G27gZhA5mKnwpuyO/cmtfooxvsu2vPVrtRd/7zExnZ6lsdCyu0bvZY7/n4KWf
	mW2p+Z7launVSizFGYmGWsxFxYkATHNXHhUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsWy7bCSnO7Wp/qpBu9fm1k0TfjLbLH6bj+b
	xcrVR5ksjv5/y2Zx/u1hJotJh64xWsxf9pTdYt3r9ywOHB47Z91l9zh/byOLx+WzpR6bVnWy
	eWxeUu+x+2YDm0ffllWMAexRXDYpqTmZZalF+nYJXBmPL31hKZjOUXHp2ir2BsYPbF2MnBwS
	AiYSM06/Yu5i5OIQEtjOKNHQ8REqIS7RfO0HO4QtLLHy33N2iKKPjBJPZy1j6mLk4GAT0JS4
	MLkUpEZEwEti3uwFLCA1zAKtjBIf5s9iAakRFnCX6O4UAalhEVCVuPDjPwuIzStgIbGq4REj
	xHx5iZmXvrNDxAUlTs58AlbDDBRv3jqbeQIj3ywkqVlIUgsYmVYxiqYWFOem5yYXGOoVJ+YW
	l+al6yXn525iBAeuVtAOxmXr/+odYmTiYDzEKMHBrCTCmx6skyrEm5JYWZValB9fVJqTWnyI
	UZqDRUmcVzmnM0VIID2xJDU7NbUgtQgmy8TBKdXAlFjIlxH4YiqXd5lMd2HAG7e5xzfJv2T0
	a37iUGwa+Hir4J9F99bNi52SqGlg8jk7ccnFgOS2oztuCLS29mx6N3l+zZnFB+9O2WvA3Nfr
	nvOxkGWpp+Yn7q/T5H4ceTCLNUPIzVhzVbK6mo5t9P91X977xaWpHFXKyrTYqv95Qmf+cm5B
	ny+vTW4w1WXZBGraSUxhNUkUFTnLskHkAH9+gSj3Z3MO9gcekyfnuHada7S78cbl3sxJNRIx
	u/5NqY71Pbj1xLM/E1qtP9jeVLLxNT3c/b4k86ydsMvBr6Kfl295/XVeppZH6cb5HaZFB/8v
	OfM26Uk0a4sv84GpHm0pD/dJZD0yjanXN3h72kFeiaU4I9FQi7moOBEAlasS0ssCAAA=
X-CMS-MailID: 20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6
References: <CGME20231018140334epcas5p128c55c56fb9203a19479cbf86175a1d6@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_070348_855730_C2CB6BA7 
X-CRM114-Status: GOOD (  17.17  )
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

From: Anuj Gupta <anuj20.g@samsung.com>

Driver may return an error before submitting the command to the device.
Ensure that such error is propagated up.

Fixes: 456cba386e94 ("nvme: wire-up uring-cmd support for io-passthru on char-device.")

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d8ff796fd5f2..53987df6ea7c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -508,8 +508,11 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	req->bio = pdu->bio;
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		pdu->nvme_status = -EINTR;
-	else
+	else {
 		pdu->nvme_status = nvme_req(req)->status;
+		if (!pdu->nvme_status)
+			pdu->nvme_status = blk_status_to_errno(err);
+	}
 	pdu->u.result = le64_to_cpu(nvme_req(req)->result.u64);
 
 	/*
-- 
2.25.1


