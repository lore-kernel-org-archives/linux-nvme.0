Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE8DAD65C7F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 11:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sPCiH7C8otAPeKBQxafGfpBc//4CVwTtOappMXTNYFs=; b=Ykyp3itglUKVUqgU8/tA8cvine
	Jt7j6h+rIuSzJbSnyUJFK9qSOPk92S/Ug6J7CGSOtf3IW3L96EQ8etp7WQR1/SRQ9PNinHLF9cCUo
	uK3RbKSMbKFOtolTyLckceYeEKzy6a0s045gVl8+SPH6i4UmE1EGHhiY/0rTu/m+tSTwaNqwO9wFi
	PwfIOTFhe/uR0JHp2itT+COmlnV0GaQ80XLsjhYMiGslrdJ8KQ8t853An9uVgmRuZP3lINRQ96c3d
	JnAK2rgHwdXs+uIKB5x8MIhquIxwmGcLprcJtLeMZM/a6lPe3cb6w3gXpPzRTcR56wFbO4H0lLwz9
	ck/4af1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYTi-00000009oCt-2KUo;
	Thu, 14 Nov 2024 11:57:38 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXtA-00000009hox-3MGR
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 11:19:54 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241114111948epoutp035414d24d51470009468ec4eec8c1a6c1~H0bxry2az0120601206epoutp03P
	for <linux-nvme@lists.infradead.org>; Thu, 14 Nov 2024 11:19:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241114111948epoutp035414d24d51470009468ec4eec8c1a6c1~H0bxry2az0120601206epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1731583188;
	bh=sPCiH7C8otAPeKBQxafGfpBc//4CVwTtOappMXTNYFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pbLfKJQYyMYOFeoMk6ZKo0grczyU+DHzmLcQj0dillrDENWbbc/Clfu/ZNDR48ETi
	 QrHDMzfnZyyYATpy5JMTg+lsAnQPXjmR/VBD0HlkEaGQkgZbOwLlM3pl4MufgeZfWy
	 O1GDJxdw7rtRdTglTSVjhzqal4U3Xrsol7xcuWj8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20241114111948epcas5p2425468228fccc7ba27fd405cfe538a0c~H0bxSRZWr0097800978epcas5p2U;
	Thu, 14 Nov 2024 11:19:48 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4XpyNf5Dy7z4x9QG; Thu, 14 Nov
	2024 11:19:46 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AB.DA.09420.A4CD5376; Thu, 14 Nov 2024 20:17:30 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20241114105400epcas5p270b8062a0c4f26833a5b497f057d65a7~H0FPJmqK_1555815558epcas5p2d;
	Thu, 14 Nov 2024 10:54:00 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241114105400epsmtrp2eedbb581c1c9a80d1800cf73f9b7ce21~H0FPIWilp1919519195epsmtrp2J;
	Thu, 14 Nov 2024 10:54:00 +0000 (GMT)
X-AuditID: b6c32a49-0d5ff700000024cc-ec-6735dc4a6900
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9A.5A.07371.7C6D5376; Thu, 14 Nov 2024 19:53:59 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241114105357epsmtip2bec5fd7f0d47e4a70ee8b15f3b18d6fa~H0FMtVSO_1421814218epsmtip2I;
	Thu, 14 Nov 2024 10:53:57 +0000 (GMT)
From: Anuj Gupta <anuj20.g@samsung.com>
To: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, anuj1072538@gmail.com,
	brauner@kernel.org, jack@suse.cz, viro@zeniv.linux.org.uk
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, vishak.g@samsung.com,
	linux-fsdevel@vger.kernel.org, Anuj Gupta <anuj20.g@samsung.com>, Kanchan
	Joshi <joshi.k@samsung.com>
Subject: [PATCH v9 04/11] fs, iov_iter: define meta io descriptor
Date: Thu, 14 Nov 2024 16:15:10 +0530
Message-Id: <20241114104517.51726-5-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241114104517.51726-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVRTZRzHfe693F3gzHPDl57oxXlNUHRzw23dEaiEB2/p6XBO51jZH7TD
	boPY29lLllhRNBEUxmYvOF6UGhlbCiFwkAHHeAnFQoQOhrVK40U0IOE07QDaxh3lf5/f7/n+
	Xp/nIdAoHx5NZOnMrFGn1FB4BNbUuTFO2P+LTC2utUXTd/6ew+gPSxZQutzdBGiPz4bTtztn
	AD18/hxC13i6EXrK2ofRZZ/lIXT3g0mcdnQMAbrt2ia6te0iRp/4cpRHH7najNOneu4j9OWF
	njD6srOctyOKOef08ZjBHyxMvbsAZ8663me8w7k4c2f0GsYUN7gB8/3JLh4zW/8UUz8yiaRF
	7MtOzGSVKtYoYHUZelWWTp1E7X4pPSVdJhdLhBIF/Qwl0Cm1bBK1c0+aMDVLE5iJEryl1FgC
	rjSlyURt2ZZo1FvMrCBTbzInUaxBpTFIDSKTUmuy6NQiHWtOkIjF8bKA8PXsTNenQsOP/Le/
	GKrCc0FZZCEIJyAphbajR7EgR5FeAA9d3VQIIgI8A+DNlhaEM/wAVnRVY0sRw91WwB20AXj+
	Vk8YZ8wCOHZlOiyowslY2DXOqVaSrQAWVV3CggZKliAw317OC6pWkMmwo2kWCTJGroejLj8a
	ZD6pgPazrShXbw08PnB3UR9OJsCvchtDmkfgxeMjiz2hAU1eY1lI/xMB+w7HcLwTDp/yh/pe
	AW/1NPA4joazU204x2p4b3AU4dgA875rBxxvh9ZeWyAnEci/Eda2bOHcT8JPes8gXNnlsGhu
	JBTKh82VS0zB/JryEEPY1pcbYgbOzzWHtlUEoGO8AJQAgfOhcZwPjeP8v/RJgLrBY6zBpFWz
	JplBomP3/3fLGXptPVh853HPNwPf73+JOgBCgA4ACZRaye9N2aqO4quU7xxgjfp0o0XDmjqA
	LLBvOxq9KkMf+Cg6c7pEqhBL5XK5VLFVLqEe5d+2VqiiSLXSzGazrIE1LsUhRHh0LvJa5NQ+
	h2Fz7W6xovrjF/sdpcUnGhPjj/i3qYgG3KFYdfjZzzckFUiJ6eLVu9bFbD9onHocJetwi8J2
	Y43F86cveXqd7b3nDqULYgbeKPdqX/beTXjlI6d1zvpAf/PYZonMHVt32jiRUrF3be/Auw33
	6w/ohC94Yq1XcGtce58mIcm/vrLBHF756hi5us51PcM3c/Dpe5P9fs8Hsn8Su1zSXzMKfdVD
	X8cnai+UMv2d9uk39SNd47tkyy6Jf9vbHinN1s/Jq8+I3OixnCeIVpGTtCXn50yUfrN8x+BE
	aup1x7eYYtnP4I+aQWrPgnegsHjt6Qs35kdykvdX2UXEBv7YPIWZMpWSONRoUv4LTBD/TXAE
	AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIIsWRmVeSWpSXmKPExsWy7bCSvO7xa6bpBtcfm1l8/PqbxaJpwl9m
	izmrtjFarL7bz2bx+vAnRoubB3YyWaxcfZTJ4l3rORaL2dObmSyO/n/LZjHp0DVGi723tC32
	7D3JYjF/2VN2i+7rO9gslh//x2Rx/u9xVovzs+awOwh57Jx1l93j8tlSj02rOtk8Ni+p99h9
	s4HN4+PTWywefVtWMXqcWXCE3ePzJjmPTU/eMgVwRXHZpKTmZJalFunbJXBlLJmmW3CFt2Lx
	tYVsDYyzubsYOTkkBEwkbh5tZQSxhQR2M0r8fc4EEZeQOPVyGSOELSyx8t9zdoiaj4wSG2eD
	2WwC6hJHnkP0igicYJSYP9Gti5GLg1lgBpNEz68VbCAJYQFHiUPbPoMNZRFQlXi65BsziM0r
	YCkxcfMeZogF8hIzL30HG8opYCWxomErUJwDaJmlxPf1IhDlghInZz5hAbGZgcqbt85mnsAo
	MAtJahaS1AJGplWMkqkFxbnpucmGBYZ5qeV6xYm5xaV56XrJ+bmbGMGxpqWxg/He/H96hxiZ
	OBgPMUpwMCuJ8J5yNk4X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzms4Y3aKkEB6YklqdmpqQWoR
	TJaJg1OqgYlNVpdh4cIjtpO11N6c4A1Z+34Zh/z8S8GLdp6eyFR1dY+bZuRa/vppiovvKC+z
	a9q5n8MsyChFwvfGYbHZ01pPVOxzX3sk9f37U94zJs9rWVXE9CtsWu4zs9K3Vo/v2rpeV9+e
	fYTj8CeNnrce05b2y0au2vZm6f8XOrY2FX84+T5rs5i0f7r9qqltt3OqqFYed+r9+1GvPVl1
	sjV4b3ySt90o+M1Fp/bdtGMT+DyucXJsWLq3pmJGROjjwDWn418aXdshvPXhQs+QZb8PHHnA
	rlpzbW9gjUHUIrvTal9rJ4YJtsTZzXtmumDni3/qIg8rdK6xTBf9wulen7FLR9P9wKn2sHsa
	Wb8/hDjPn1OjxFKckWioxVxUnAgARuYorSQDAAA=
X-CMS-MailID: 20241114105400epcas5p270b8062a0c4f26833a5b497f057d65a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241114105400epcas5p270b8062a0c4f26833a5b497f057d65a7
References: <20241114104517.51726-1-anuj20.g@samsung.com>
	<CGME20241114105400epcas5p270b8062a0c4f26833a5b497f057d65a7@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_031953_218625_44CF2B98 
X-CRM114-Status: GOOD (  16.38  )
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

Add flags to describe checks for integrity meta buffer. Also, introduce
a  new 'uio_meta' structure that upper layer can use to pass the
meta/integrity information.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/uio.h     | 9 +++++++++
 include/uapi/linux/fs.h | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 853f9de5aa05..8ada84e85447 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -82,6 +82,15 @@ struct iov_iter {
 	};
 };
 
+typedef __u16 uio_meta_flags_t;
+
+struct uio_meta {
+	uio_meta_flags_t	flags;
+	u16			app_tag;
+	u64			seed;
+	struct iov_iter		iter;
+};
+
 static inline const struct iovec *iter_iov(const struct iov_iter *iter)
 {
 	if (iter->iter_type == ITER_UBUF)
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 753971770733..9070ef19f0a3 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -40,6 +40,15 @@
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
+/* flags for integrity meta */
+#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
+#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
+#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */
+
+#define IO_INTEGRITY_VALID_FLAGS (IO_INTEGRITY_CHK_GUARD | \
+				  IO_INTEGRITY_CHK_REFTAG | \
+				  IO_INTEGRITY_CHK_APPTAG)
+
 #define SEEK_SET	0	/* seek relative to beginning of file */
 #define SEEK_CUR	1	/* seek relative to current file position */
 #define SEEK_END	2	/* seek relative to end of file */
-- 
2.25.1


