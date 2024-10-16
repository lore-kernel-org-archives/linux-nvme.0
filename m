Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25181CF258F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 13:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ixWRd6Ku3AHLpgpPOdfQwfzu6Ddv6cbLE0o4Y5h4UVk=; b=U7u9ysnV+JT7Hor6BQEET+HiiV
	29WDWO+CEuIoYZFrRaivpb+uqP7ePBgbZTD6NTRsFrO8/5lN3PX50bwlHYZiJhYfUlxVYIQU5Visw
	qCv/V/AotZgoAyDvE94+gLZHTCH6iCWSNVj4/CgGxTbEmeq/9ps/nerVXw3g9oBtWzYZ1ISUHuD1G
	X4M8PgCQHAhHkSwnI4IRFonYT5EQFDKFSjLsEauvexUCNwcNpeCtDU43E+sYy/T3nc7tpYk2Z6G3r
	WPGDyK1BDOXLGjp4+cZ3o6qzwFJ60hIYusN315C4yvbzebGeJB2C4qFtifToAhfdpNFcQJIz+mbmp
	b44Q8Oxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t14LV-0000000Bxwm-24iA;
	Wed, 16 Oct 2024 13:45:49 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13Gk-0000000BlCU-0PF2
	for linux-nvme@bombadil.infradead.org;
	Wed, 16 Oct 2024 12:36:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=ixWRd6Ku3AHLpgpPOdfQwfzu6Ddv6cbLE0o4Y5h4UVk=; b=Ha025hAT8N76oxaHhfgf8fBDVp
	8S/NHLyRAgNu4T8gH73CqLuOJTyfhwTo0NJDH7pbLscj4Tb6oixxlxDDGzblQQGuebMbpT9aE49ma
	3/AT4ccbjO7hLOwR1fVz2XOYi+1TS7hT1R/T8deqGR9Wu5krMneCEp6JFAdX8Bwd7VN22kMAQbn0q
	JwVtDPI9cpndWdE50Vuc2b6oVhafgFZMORCWpsjHn1Ws++K32SsTXUuTdGqusMX4HNnTZV7Yx1FdX
	zaj5xoA5ShRv9zJPPzaq2jgMLfUe8I5oRHEeNJA66snMgma6f8GrG7j9mVnbFO1DM71GaigHHTWfX
	W61VN1dQ==;
Received: from mailout4.samsung.com ([203.254.224.34])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13Gg-00000006nXV-0Jlc
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 12:36:48 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241016123641epoutp04e054a9e86b1bcfeb3ee4e0c768301b5b~_7xnnronp1941219412epoutp04t
	for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 12:36:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241016123641epoutp04e054a9e86b1bcfeb3ee4e0c768301b5b~_7xnnronp1941219412epoutp04t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729082201;
	bh=ixWRd6Ku3AHLpgpPOdfQwfzu6Ddv6cbLE0o4Y5h4UVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sPhbQHLyV3BJ0gPwaVUU0uhLZccN3jWWum31eHCRN0sS+BWDx5dSgLhKeLbiIqayM
	 jBs5Q2rlrknKiAKP4jsFgsTXVqkKOGvRzlf9jN4nOeOl4gdy8vPUfA39KQg0KqSTdB
	 LG4fENZXtVTeKVldUhQwpvDnefYAGOX6wp1HvfS8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241016123641epcas5p28eda85d51e3c2d8369f8a94bf82dfc8d~_7xnN5CRN1006810068epcas5p2-;
	Wed, 16 Oct 2024 12:36:41 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4XT9Sl2YnBz4x9Pp; Wed, 16 Oct
	2024 12:36:39 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.90.09800.753BF076; Wed, 16 Oct 2024 21:36:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241016113743epcas5p3b4092c938d8795cea666ab4e6baf4aa9~_6_Ijwnih1066710667epcas5p3_;
	Wed, 16 Oct 2024 11:37:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241016113743epsmtrp22f1660c34422b1efbeeb7bfd71bfb89a~_6_Ii7uEO1555115551epsmtrp2f;
	Wed, 16 Oct 2024 11:37:43 +0000 (GMT)
X-AuditID: b6c32a4b-4a7fa70000002648-6e-670fb357c8db
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0E.68.08227.785AF076; Wed, 16 Oct 2024 20:37:43 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241016113741epsmtip197a1754cc8002dde58ee35e56722c539~_6_GfTUfB2875928759epsmtip1G;
	Wed, 16 Oct 2024 11:37:41 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: [PATCH v4 05/11] fs: introduce IOCB_HAS_METADATA for metadata
Date: Wed, 16 Oct 2024 16:59:06 +0530
Message-Id: <20241016112912.63542-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016112912.63542-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmpm74Zv50g63ThSw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7O4eWAnk8XK1UeZLN61nmOxmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jsjg/aw67A5/Hzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fm09UenzfJ
	BXBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2u
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOmPn4PXPBctaK64dOMDcwrmPpYuTkkBAwkZjydQ9TFyMXh5DAbkaJRY0gCRDnE6PEvJs/
	2SGcb4wS1269ZoRp+X98L1TLXkaJV90LmSGcz4wSs/c+ZQapYhNQlzjyvBWsQ0RgEqPE88uh
	IDazwClGibW/FEBsYQE3iYlLDjGB2CwCqhKPd91gA7F5BSwlPk4+xAqxTV5i5qXv7CA2p4CV
	xKlzB9khagQlTs58wgIxU16ieetssCMkBHZwSPzd2MsO0ewi0fRwCdQgYYlXx7dAxaUkPr/b
	ywZhp0v8uPyUCcIukGg+tg/qTXuJ1lP9QEM5gBZoSqzfpQ8RlpWYemodE8RePone30+gWnkl
	dsyDsZUk2lfOgbIlJPaea4CyPST2XvoLDdJeRompa1ayTWBUmIXkn1lI/pmFsHoBI/MqRsnU
	guLc9NRi0wLjvNRyeDQn5+duYgQnZy3vHYyPHnzQO8TIxMF4iFGCg1lJhHdSF2+6EG9KYmVV
	alF+fFFpTmrxIUZTYIBPZJYSTc4H5oe8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNT
	UwtSi2D6mDg4pRqYctff5entftxQLvDjW1fZ6+OP+ueczTqe67I5+P3VWSVruHhCV36uXTZD
	aNe1/6tMZ3W6mU9tSct+6sOzMbRxD7vOtD37ftg9ZJRt/3ZHuiWH8U7tq9ntk/xT7X/3Lc+U
	cW580PikKW/2lC8J2xIsExJzns61CfRexaX0fuoZofWf3PnS9btn8Ap0fV7QHX+LzZen+dSH
	bX3aR/XX/pdoncrsvoj/Wp3ePpvi+68Kv8SLLY70P6b36t/Zkr3LvJzO7DO+V3HLadXRCLHn
	svsrTGdU9GzRu+AUvK94kXobU8WSCbldirVPeJq/WxtHuEre/n/4qlzhK7uTTrcOP60rSeDQ
	2KYUc9hnZsKbnuqZSizFGYmGWsxFxYkA5bzw6VcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDLMWRmVeSWpSXmKPExsWy7bCSnG77Uv50g8kv+Sw+fv3NYtE04S+z
	xZxV2xgtVt/tZ7O4eWAnk8XK1UeZLN61nmOxmHToGqPF9jNLmS323tK2mL/sKbtF9/UdbBbL
	j/9jsjg/aw67A5/Hzll32T0uny312LSqk81j85J6j903G9g8Pj69xeLRt2UVo8fm09UenzfJ
	BXBGcdmkpOZklqUW6dslcGXMfPyeuWA5a8X1QyeYGxjXsXQxcnJICJhI/D++l6mLkYtDSGA3
	o8TDZb9YIRISEqdeLmOEsIUlVv57zg5R9JFRYsr7/0wgCTYBdYkjz1sZQRIiArMYJQ7Pmg82
	ilngAqPE1X3P2EGqhAXcJCYuOQTWwSKgKvF41w02EJtXwFLi4+RDUOvkJWZe+g5WzylgJXHq
	3EEwWwio5t/kD4wQ9YISJ2c+AbubGai+eets5gmMQGsRUrOQpBYwMq1ilEwtKM5Nzy02LDDK
	Sy3XK07MLS7NS9dLzs/dxAiOIC2tHYx7Vn3QO8TIxMF4iFGCg1lJhHdSF2+6EG9KYmVValF+
	fFFpTmrxIUZpDhYlcd5vr3tThATSE0tSs1NTC1KLYLJMHJxSDUxWtcc3Sf7+YX6GoXT7us4Z
	botu/nrXNi/iysbtf9wfnZb6cNOBby337Sd/b6rfDP4V9PFZZe/Td7u/us1vb33y0NCsNJ2j
	MMolb92OztdndgXuk1+/uS1l16IfV5az/rw3MX8vv3j0I96OuEjmG9O1xVkEm2zu+e6+VXnB
	dpvui9/9pQxGf68sTfslVKdxzqrl0Ln1lxPlayatWBDYvbJ50dbWSq0vRp/sv1zs4TJ7UPz7
	G0dnV5O+7L+DqQ0db8SnacY8dd1dcPC+6bWZP9dpvGeVf2vbEvH72u3w/SbRdypuCH5blHOA
	4esxwx3C/bOnr5xkP1voi2d6k3H/3p1P2+TvLDz7c4ubo+pV03WicUosxRmJhlrMRcWJAEi5
	2IoPAwAA
X-CMS-MailID: 20241016113743epcas5p3b4092c938d8795cea666ab4e6baf4aa9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016113743epcas5p3b4092c938d8795cea666ab4e6baf4aa9
References: <20241016112912.63542-1-anuj20.g@samsung.com>
	<CGME20241016113743epcas5p3b4092c938d8795cea666ab4e6baf4aa9@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_133647_189416_2BDF634B 
X-CRM114-Status: GOOD (  13.38  )
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

Introduce an IOCB_HAS_METADATA flag for the kiocb struct, for handling
requests containing meta payload.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3559446279c1..f451942db74b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -346,6 +346,7 @@ struct readahead_control;
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
 /* kiocb is a read or write operation submitted by fs/aio.c. */
 #define IOCB_AIO_RW		(1 << 23)
+#define IOCB_HAS_METADATA	(1 << 24)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
-- 
2.25.1


