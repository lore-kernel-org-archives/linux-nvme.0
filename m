Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5CCD1AD5D
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Oct 2024 13:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKoRNiCpE9xYsK9GrO7c2Huj45QYroY0N/mJ/Q8UOgA=; b=ew6arwp7p3PLsdAQkM+jQf/V1e
	WGwe+f1KbKbhB/FYTQjd97SVIBdEtQLsKHrB1lq+1VV218y1XHviA86lo0P4//8uFS7BTaTGaG+XV
	HDyRTpprFrLWvzJjAfcooPfxV1xbbtSpyFOaHAYdw5m/O4v4FpsBdPmR5U18OXbefoU+/EtvB+5DN
	OlDa51DrJOOyvOyb2GiMIndpCDWqGB33N/zFq4eqRA9nxPl6l0GB1Dhz0f7/SXkO7+NjubGpRp/qS
	ZdaS52rEhUJmYBUN0xau4iO7m7FyZPStec7QiBC3b0ZNwBBVzP4IqsvMaxcnK3l9Sw2x0QwJI5yF6
	2EyzW34A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t14LU-0000000BxwL-3Nnq;
	Wed, 16 Oct 2024 13:45:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13Gb-0000000BlAX-2LAR
	for linux-nvme@bombadil.infradead.org;
	Wed, 16 Oct 2024 12:36:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=UKoRNiCpE9xYsK9GrO7c2Huj45QYroY0N/mJ/Q8UOgA=; b=gDQlDxDWOkanHki/km3oyJJjFL
	nYjzmxsK8ANlty0vaHyqSDYYgdmmi90dpG0hjF4dVpBzm4aT4FuzvMBbbsTofOaARUfL+wisrEmbf
	DAcCeosUDStf7Ebvsf1AZ+Urbf0TH8P63ItL1evN/LZ0RxqmHadqIBP/3jS2mFuFkjucVNQTFjq8w
	+03YNhhH2thokZuYPHVTm2970o0xvJE9JQLVetVfBd4Io+DrYqmnN3WtZGecJGUonZcmBEP0/wxvd
	DNAEbqJS9hw5u6HuJgN0AA+/22SWDITutONI2Nz8Co1LC7aJlB26hi8AozQ2Cn6up/7m18OteXyTh
	PnZCGtmA==;
Received: from mailout3.samsung.com ([203.254.224.33])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t13GY-00000006nWc-0kUQ
	for linux-nvme@lists.infradead.org;
	Wed, 16 Oct 2024 12:36:40 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241016123633epoutp038d9e6b76409051be5fc47eb77661eef5~_7xgAbjIm1120811208epoutp032
	for <linux-nvme@lists.infradead.org>; Wed, 16 Oct 2024 12:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241016123633epoutp038d9e6b76409051be5fc47eb77661eef5~_7xgAbjIm1120811208epoutp032
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729082193;
	bh=UKoRNiCpE9xYsK9GrO7c2Huj45QYroY0N/mJ/Q8UOgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g5VMOxn7sS5c4XXHGRpj/NR68Ico3k7JQF1ZuhVekvENVxYA37kZ+RArLMsSE7tCr
	 UR2bFn6Ix7SPHtW9Fi0Crqsf2NNjPTXFaSemHOegex0daLD2JHhtPqkCHJYagy+r+U
	 GMZRt/La0DSmHRGmK2GJfjFWhlheAlkT/WTpFDtE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20241016123632epcas5p3e1a8e0f298d5b0f8dfc499cf647650b0~_7xfUVskf2029820298epcas5p3a;
	Wed, 16 Oct 2024 12:36:32 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4XT9SZ6CBYz4x9Pv; Wed, 16 Oct
	2024 12:36:30 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	09.08.09420.E43BF076; Wed, 16 Oct 2024 21:36:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289~_6_GdhFFt1063910639epcas5p3I;
	Wed, 16 Oct 2024 11:37:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241016113741epsmtrp1a08274ed734fadd9a7decb4cd101e4cf~_6_GcrwNh0254402544epsmtrp1p;
	Wed, 16 Oct 2024 11:37:41 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-c2-670fb34e35ba
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3E.9A.07371.485AF076; Wed, 16 Oct 2024 20:37:41 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20241016113738epsmtip15ae17822cc4bf05c896c76e759451560~_6_EWKVy-2875928759epsmtip1F;
	Wed, 16 Oct 2024 11:37:38 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	krisman@suse.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com, Kanchan Joshi
	<joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH v4 04/11] block: define meta io descriptor
Date: Wed, 16 Oct 2024 16:59:05 +0530
Message-Id: <20241016112912.63542-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241016112912.63542-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBJsWRmVeSWpSXmKPExsWy7bCmpq7fZv50g52bDC0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7O4eWAnk8XK1UeZLN61nmOxOPr/LZvFpEPXGC22n1nKbLH3lrbF/GVP2S26
	r+9gs1h+/B+TxflZc9gd+D12zrrL7nH5bKnHplWdbB6bl9R77L7ZwObx8ektFo++LasYPTaf
	rvb4vEkugDMq2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DX
	LTMH6HwlhbLEnFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWh
	gYGRKVBhQnbGm11zmQpOs1d8fLGMqYFxJVsXIyeHhICJxIL2A6xdjFwcQgK7GSU6l11ng3A+
	MUq0Tf4KlfnGKNG79hiQwwHWcr4zHCK+l1HicE8LM4TzmVHi8o9tYHPZBNQljjxvZQSxRQQm
	MUo8vxwKUsQs8J5RYtmzWWAJYQErifYjTUwgNouAqsTs5jNgcV4BS4n9E3exQxwoLzHz0ncw
	mxOo/tS5g+wQNYISJ2c+YQGxmYFqmrfOZoao38MhsfVSAoTtItF4aTEThC0s8er4FqiZUhIv
	+9ug7HSJH5efQtUUSDQf28cIYdtLtJ7qZwb5mFlAU2L9Ln2IsKzE1FPrmCDW8kn0/n4C1cor
	sWMejK0k0b5yDpQtIbH3XAOU7SHRdKAFGry9jBK7L/QxTmBUmIXknVlI3pmFsHoBI/MqRsnU
	guLc9NRi0wLDvNRyeCwn5+duYgQnaS3PHYx3H3zQO8TIxMF4iFGCg1lJhHdSF2+6EG9KYmVV
	alF+fFFpTmrxIUZTYHhPZJYSTc4H5om8knhDE0sDEzMzMxNLYzNDJXHe161zU4QE0hNLUrNT
	UwtSi2D6mDg4pYCekWPrYtlveuDQzpkXe1axBP/+emPjh0L3HlO91hf/y6+Zfns4p/8s+/v/
	7JX68SKbjM379jvG6TpcfXNmytb9B2KZo73mbrxw5nKpUOLNjC8TH3VHvGTwnZ3E+HAXg8rd
	GYX9OzZbF3hp/dy7i1V4QfN3a4ujflvXuFzhtni+xVlh+d6T825X8OdfOptSUdwptuH8x5B/
	M5jjxQU3S6dH3FRK+arVeHlCixufRHLz7T3/Ci3iG213M/vG2DSYBlgoeCYZX9Q2bbtWvGZL
	TMO9otU8r+4rrptaYbXTeOqzunk7lv2y+2Xp3S26/NWMp1+zFe3lbG7M6VgyQVStrctovoN7
	1KJDZ/fGKCwS3TpXiaU4I9FQi7moOBEAXW363FsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsWy7bCSnG7rUv50g8OXGC0+fv3NYtE04S+z
	xZxV2xgtVt/tZ7O4eWAnk8XK1UeZLN61nmOxOPr/LZvFpEPXGC22n1nKbLH3lrbF/GVP2S26
	r+9gs1h+/B+TxflZc9gd+D12zrrL7nH5bKnHplWdbB6bl9R77L7ZwObx8ektFo++LasYPTaf
	rvb4vEkugDOKyyYlNSezLLVI3y6BK+PNrrlMBafZKz6+WMbUwLiSrYuRg0NCwETifGd4FyMX
	h5DAbkaJHZvnsHQxcgLFJSROvVzGCGELS6z895wdougjo8S8u3eZQRJsAuoSR563MoIkRARm
	MUocnjWfCSTBLPCdUeJftzOILSxgJdF+pAksziKgKjG7+QzYVF4BS4n9E3exQ2yQl5h56TuY
	zQlUf+rcQTBbCKjm3+QPUPWCEidnPmGBmC8v0bx1NvMERqCtCKlZSFILGJlWMUqmFhTnpucm
	GxYY5qWW6xUn5haX5qXrJefnbmIEx5GWxg7Ge/P/6R1iZOJgPMQowcGsJMI7qYs3XYg3JbGy
	KrUoP76oNCe1+BCjNAeLkjiv4YzZKUIC6YklqdmpqQWpRTBZJg5OqQamp0K3V5t9KZSbotM3
	Xc/KRT30KMPMlrTKxq4jC9Tri07wpy5880/wmbh5zYbQ8t0nk44J3a3zEu/wnLeV+1bRdd41
	ASsm/go+/91NVvr40ZSku6ptG6I0FjTs7W7uf3wjqdpypreieVL7+uJFhW32Ri+F1V/6v3Ly
	iQ+O7zg/Oe/atEvn3s1IjsrzL/1zzoPlbMBrl9M9f2J/tz55tuWS8iJGkefLHlf4W/IvOLVq
	cnRUgLLyMfO9D2Zfe7uX5cHKB6tytZ1sryhduZyp9LuZvU7k/V4X9f/nMs8aCsb4Bntvn/51
	5b0FTP8ldoQ/XeFcl7RHT/Oi8Sf1X3EZRqpFCaa/eGwexndVnv79hfWCEktxRqKhFnNRcSIA
	6fhL3hIDAAA=
X-CMS-MailID: 20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289
References: <20241016112912.63542-1-anuj20.g@samsung.com>
	<CGME20241016113741epcas5p3b90adb3b43b6b443ffd00df29d63d289@epcas5p3.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_133638_960696_3E3ADA33 
X-CRM114-Status: GOOD (  13.70  )
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

From: Kanchan Joshi <joshi.k@samsung.com>

Introduces a new 'uio_meta' structure that upper layer can
use to pass the meta/integrity information.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 include/linux/bio-integrity.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/bio-integrity.h b/include/linux/bio-integrity.h
index 90aab50a3e14..529ec7a8df20 100644
--- a/include/linux/bio-integrity.h
+++ b/include/linux/bio-integrity.h
@@ -30,6 +30,16 @@ struct bio_integrity_payload {
 	struct bio_vec		bip_inline_vecs[];/* embedded bvec array */
 };
 
+/* flags for integrity meta */
+typedef __u16 __bitwise meta_flags_t;
+
+struct uio_meta {
+	meta_flags_t	flags;
+	u16		app_tag;
+	u32		seed;
+	struct iov_iter iter;
+};
+
 #define BIP_CLONE_FLAGS (BIP_MAPPED_INTEGRITY | BIP_CTRL_NOCHECK | \
 			 BIP_DISK_NOCHECK | BIP_IP_CHECKSUM)
 
-- 
2.25.1


