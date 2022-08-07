Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E07C25B08
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Aug 2022 18:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lOaVuemJcvzVqvhmC9wH8jBWzJSDY06o4HSKqGiM8oo=; b=Xc6rWGDGiXwPGZ1UX8jaSc3yZB
	e3CV4QNKI7vGYwHybrgh9cLVMMy2B/CKFKR2CLpN9x6wWKQ3EHzAR9hd2vx0nZDC6y9sH8U/TZcpj
	KjdabKT2GNSEBXm6sSeI+yXaB5dBXBJ/2gwmDS/UzCbus3oY9Q51I/wYGUWPWNpDV3nRl+/w4Kt7S
	nnrwt1d1DwO+f8zWLcKk5VP0jIe6JKZkCKb7l12YQO/N/nwDo6hk/akF+jbIERqUY6/4CG9Sjb2L/
	ur6S1p5ykGTd/ekTgKaGroZQybpqyxcONo6HW5VTTXLBQi6MCDQrESfXWirLsIb8Qu3+C1upAuzk6
	tBP9IMKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKlHp-001RFg-Vk; Sun, 07 Aug 2022 18:46:06 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKlHj-001R5u-08
	for linux-nvme@lists.infradead.org; Sun, 07 Aug 2022 18:46:00 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220807184548epoutp02981fa2363d9785f01abf675c0e76eec2~JJGOrWl031612316123epoutp02-
	for <linux-nvme@lists.infradead.org>; Sun,  7 Aug 2022 18:45:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220807184548epoutp02981fa2363d9785f01abf675c0e76eec2~JJGOrWl031612316123epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1659897948;
	bh=lOaVuemJcvzVqvhmC9wH8jBWzJSDY06o4HSKqGiM8oo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TlTffWhms4f0hMSZu5S5Bfkd6r080Cm9EK5GrnYCNJR0xj+q7Y6123uoRSw0fCJ8z
	 o4ACgrgS5Ar5+SQnIoPo61zNkmQz4Ny0/cc/gZd62vM4YW7T+zt1sO3jLq48b7IP/C
	 TXCbSkyxHIhFiGL4r6L173sHr6cPGyJKlFw5bZfs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220807184547epcas5p48b2150fea628f5cbe39ab0f8af669c1c~JJGOLdDhN2500925009epcas5p4_;
	Sun,  7 Aug 2022 18:45:47 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4M17ZK1drvz4x9Pr; Sun,  7 Aug
	2022 18:45:45 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	52.E2.42669.95800F26; Mon,  8 Aug 2022 03:45:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220807184544epcas5p19f676581e0fdf555fa1d0a83906f2fc7~JJGLU98HN2851528515epcas5p1k;
	Sun,  7 Aug 2022 18:45:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220807184544epsmtrp1511305150dd7048a48ee916a1029a9da~JJGLTgwnS0046100461epsmtrp1D;
	Sun,  7 Aug 2022 18:45:44 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff7000001a6ad-85-62f00859fd47
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.35.08905.85800F26; Mon,  8 Aug 2022 03:45:44 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220807184543epsmtip26d826f46aa4317493d357010c81cda5d~JJGKIR7wE1262212622epsmtip2a;
	Sun,  7 Aug 2022 18:45:43 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: axboe@kernel.dk, hch@lst.de
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, ming.lei@redhat.com, gost.dev@samsung.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v2 1/4] fs: add file_operations->uring_cmd_iopoll
Date: Mon,  8 Aug 2022 00:06:04 +0530
Message-Id: <20220807183607.352351-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220807183607.352351-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTUzeS40OSwbJ3bBar7/azWdw8sJPJ
	YuXqo0wW71rPsVgc/f+WzWLvLW2L+cueslscmtzM5MDhcflsqcfmJfUeu282sHm833eVzaNv
	yypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22VXHwC
	dN0yc4CuUVIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZY
	GRoYGJkCFSZkZ2w//Zi9YC9rxfVbJ9kaGI+xdDFyckgImEg0Nm9n7GLk4hAS2M0ocWz7GxYI
	5xOjxPuub+wQzjdGifkXTjDCtHT+nwvVspdRYuaHJjYI5zOQc+ElUIaDg01AU+LC5FKQBhEB
	eYkvt9eCjWUWWMsocXrvFyaQhLCAl0T3ie/MIDaLgKrE230TWUFsXgFLic+7+lghtslLzLz0
	nR1kJqeAlUTXFmWIEkGJkzOfgP3ADFTSvHU2M8h8CYGP7BIXbyyA6nWR2HzrIhuELSzx6vgW
	dghbSuJlfxuUnSxxaeY5Jgi7ROLxnoNQtr1E66l+ZpC9zEC/rN+lD7GLT6L39xMmkLCEAK9E
	R5sQRLWixL1JT6G2iks8nLEEyvaQOL5jJzR4ehklmmdMZJ/AKD8LyQuzkLwwC2HbAkbmVYyS
	qQXFuempxaYFRnmp5fCITc7P3cQITpRaXjsYHz74oHeIkYmD8RCjBAezkgjvkbXvk4R4UxIr
	q1KL8uOLSnNSiw8xmgKDeCKzlGhyPjBV55XEG5pYGpiYmZmZWBqbGSqJ83pd3ZQkJJCeWJKa
	nZpakFoE08fEwSnVwMTcJ7XC+3xM/snKvPbHV1NlU2S1pnE1HTJkml9S/JO/9bbp3NqKVYly
	/KoTWgT2MBlNTbA03Mm4Rvv9/ZazDEHP11yPDDNovp0vKfJ8507xV01snZbbPkdoaM5ZXZOv
	ldjvKuC+cvvW9B/Jj2Pui6iwXs3oq2JudPSPjfATXzV5MyfL3qT481Gx916c2W+5cPJrgcAo
	7Y1yZtcz+gvtrx+0LLPUKDk+h/twI5PcM96HbMwlZd9UOD0clHjFs3W/5x3ivvGfofekV5lI
	F+sjFeXN37hKw9N3K6resmk2KXsl/frViQ+Vz6UkvhdquN6xj46xdWy1+HSfY2q+861DqcU5
	a5+GJ07lXZSgyKHEUpyRaKjFXFScCACMslZzHQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvG4Ex4ckg0VzZC1W3+1ns7h5YCeT
	xcrVR5ks3rWeY7E4+v8tm8XeW9oW85c9Zbc4NLmZyYHD4/LZUo/NS+o9dt9sYPN4v+8qm0ff
	llWMHp83yQWwRXHZpKTmZJalFunbJXBlbD/9mL1gL2vF9Vsn2RoYj7F0MXJySAiYSHT+n8vY
	xcjFISSwm1Hi8vqVUAlxieZrP9ghbGGJlf+es0MUfWSUOL78BpDDwcEmoClxYXIpSI2IgKLE
	xo9NYIOYBTYzSnw6fYwZJCEs4CXRfeI7mM0ioCrxdt9EVhCbV8BS4vOuPlaIBfISMy99B5vJ
	KWAl0bVFGSQsBFRy9kILM0S5oMTJmU/AbmMGKm/eOpt5AqPALCSpWUhSCxiZVjFKphYU56bn
	FhsWGOallusVJ+YWl+al6yXn525iBIe4luYOxu2rPugdYmTiYDzEKMHBrCTCe2Tt+yQh3pTE
	yqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamLyKG8WX8uuGrA2p
	mBPybuPq81ecg+b/ym1euvXxEmsFX/8zhi6XHPTLXYN/nF7kvqzpzQlNznZf1Uk6t7OS52c1
	Pug8zCBfVnIyWe0BE/Py3+1fb/D6n85YePYk/0dNv6QfsuI/5XalqfXuD85J26xzKcwo0jFL
	bs3Tgg82zVvLl/8wrn91O+ni/k0BdzorDpTEcLCxKbOrFKZ2mcS2nZltHrTyfaXgLVVrl5Zf
	FT1ixf8+y3cfeDDzl9jGFfMEnD2T7y+f/5Ph5zSFJ5ov/kszzWNUi/gYP6EjdPJD+dD/LYU/
	C5M2rO1/MuF7XkroruVTUnI/bFBaGX5++6ZfMq9jd0msLhMP3p3XOD3QXImlOCPRUIu5qDgR
	AODKZNHgAgAA
X-CMS-MailID: 20220807184544epcas5p19f676581e0fdf555fa1d0a83906f2fc7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220807184544epcas5p19f676581e0fdf555fa1d0a83906f2fc7
References: <20220807183607.352351-1-joshi.k@samsung.com>
	<CGME20220807184544epcas5p19f676581e0fdf555fa1d0a83906f2fc7@epcas5p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_114559_384319_2E8E9547 
X-CRM114-Status: GOOD (  11.58  )
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

io_uring will trigger this to do completion polling on uring-cmd
operations.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9f131e559d05..449941f99f50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2134,6 +2134,7 @@ struct file_operations {
 				   loff_t len, unsigned int remap_flags);
 	int (*fadvise)(struct file *, loff_t, loff_t, int);
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
+	int (*uring_cmd_iopoll)(struct io_uring_cmd *ioucmd);
 } __randomize_layout;
 
 struct inode_operations {
-- 
2.25.1


