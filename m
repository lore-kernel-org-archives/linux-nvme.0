Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5BEC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EAB65295
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 19:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EAB65295
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:MIME-Version:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=TI7TyIG8VGgQVt06gQO7ZHot/jXwcgd9FTUvqp7iztA=; b=b78tb6PdKpO1vnFwikKOGjuZI
	IFo0CT90gx48BYHadFOU+qUHZcE7VUSzsPkK1F0QXQ9W6eTJt4XHLTs+GQDKlNapnUeGnETWZKwxS
	8gdoNYN+ftV3Z1NlBBTVdlAq5D7k0H2C4kDUYlWJtNKS4vJIonKuWI84934U5clZ5HIBTPNcNRgw/
	E0Q8MpLc6m39I5rwAaJ0gR1kiiGhjGwF5ur3kCl9HT8UcczBTL+ju0hGxI4HH3DC5pjKLrLQhKtbi
	l8z80hPlf6C1F4cPQBGfj1R9ODipDSKPpyKnhOEzrN3LSQ1rPphgmRq3nzx+zXIR1hNb/EEbB23v+
	Cr3kpKtgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJLPE-0022SC-QT; Mon, 08 Mar 2021 19:19:04 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJLP2-0022Mn-3u
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 19:18:55 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20210308191844epoutp01ea2788b107c039aaff58270585be7044~qdCZs_i_h2259322593epoutp01W
 for <linux-nvme@lists.infradead.org>; Mon,  8 Mar 2021 19:18:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20210308191844epoutp01ea2788b107c039aaff58270585be7044~qdCZs_i_h2259322593epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1615231124;
 bh=caDx+0rZmPdGARfxduVhyMCN3a76uRzqyh0OnFTlNAA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=gsL3wD5DaUy9qXWb1rFIXQNhWUfAm/X8swxPsTOgH73W+Ab7D8AgS3pi26vs8wWZQ
 VbNDe32clVXRDUkzKAjpt0Ufhb//QVxXdvUBnQ4yH9iG9wzXzsACnUemzzaA+1R+KD
 cuPTNBzyjMqQ8nKUSYM50ewqqlNHx/VAj/56xCPw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTP id
 20210308191844epcas5p2b563599bbc79300fba00fa0498fcb6da~qdCZKR1hw2858228582epcas5p21;
 Mon,  8 Mar 2021 19:18:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
 epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
 CE.8B.33964.49876406; Tue,  9 Mar 2021 04:18:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
 20210308191842epcas5p2a21883eef4b6f98492987f80704d09bd~qdCX3O0xI0715507155epcas5p2X;
 Mon,  8 Mar 2021 19:18:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20210308191842epsmtrp2e09300412cd01972d56474176d10e22a~qdCX2hCyg1790917909epsmtrp22;
 Mon,  8 Mar 2021 19:18:42 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-ef-60467894b50e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 88.A1.13470.29876406; Tue,  9 Mar 2021 04:18:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
 epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20210308191841epsmtip2dbf532814b1cdf9bd530c4b5a53ae5c0~qdCWgHsPr2995629956epsmtip2O;
 Mon,  8 Mar 2021 19:18:41 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com, Kanchan
 Joshi <joshi.k@samsung.com>
Subject: [PATCH 0/2] cleanup and small improvement
Date: Tue,  9 Mar 2021 00:48:02 +0530
Message-Id: <20210308191804.8582-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCmlu6UCrcEg56FbBb/9xxjs1i5+iiT
 xdH/b9ksJh26xmgxf9lTdosrUxYxW6x7/Z7Fgd1jYvM7do/z9zayeGxa1cnmsXlJvcfumw1s
 Hn1bVjEGsEVx2aSk5mSWpRbp2yVwZfx5EF/wlqni1psJ7A2MS5i6GDk5JARMJK6/v83axcjF
 ISSwm1Gi/e8iKOcTo8SJ9sWsIFVCAt8YJf5ec4XpODt5BRtE0V5GiQ2v70EVfWaU6G9i6WLk
 4GAT0JS4MLkUJCwioCTxdz1EmFkgQ+LRGV2QsLCAkcTshYvAjmARUJXYsPM+I4jNK2Au8fj2
 SXaIVfISMy99Z4eIC0qcnPmEBcRmBoo3b53NDHKChMA1doknR+cxQzS4SCzf+ADqM2GJV8e3
 QA2Skvj8bi8bhF0s8evOUajmDkaJ6w0zWSAS9hIX9/xlgjhUU2L9Ln2IZXwSvb+fgIUlBHgl
 OtqEIKoVJe5NesoKYYtLPJyxBMr2kFi19DE0RGIljj3ayTKBUW4WkhdmIXlhFsKyBYzMqxgl
 UwuKc9NTi00LjPNSy/WKE3OLS/PS9ZLzczcxglOIlvcOxkcPPugdYmTiYDzEKMHBrCTC29vj
 nCDEm5JYWZValB9fVJqTWnyIUZqDRUmcd4fBg3ghgfTEktTs1NSC1CKYLBMHp1QDU7Wq4ucN
 YSe1/JMfzkmRnjh1r/OJUxeTzz6YbsGWFvMg54JBYUjXnCW/H+2Ue/c4UGjjscQoy4ssGl5r
 hf7E/l4pEr+s/X2thK3a81VNz2/O2nElrN7b7Xntz9qShYYPGnp3s9fVWf08f5tDWYHZP/Xn
 wrerGEpVv1eqhn09O19pxdKY/c3Rqd5a+y0i3577E3bV6sTxTx/1di5bqb8qzCbM8PM0uZu1
 bK+Nt7oGT+NZxbL+tu6TVewdZ2R9lZ+1Tf3fJLv56P0fX3uPKj38eLR5XozTv0kvM1ludbS/
 2vTHdu/tvws2/HlaWfd5rv+GfJsMiT9mN7Vni4hergvTtlVLeXcvZ3vxWpulRa8cBc2VWIoz
 Eg21mIuKEwEkKJQ4kAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvO6kCrcEg8XnVS3+7znGZrFy9VEm
 i6P/37JZTDp0jdFi/rKn7BZXpixitlj3+j2LA7vHxOZ37B7n721k8di0qpPNY/OSeo/dNxvY
 PPq2rGIMYIvisklJzcksSy3St0vgyvjzIL7gLVPFrTcT2BsYlzB1MXJySAiYSJydvIKti5GL
 Q0hgN6PEvZfb2CAS4hLN136wQ9jCEiv/PWeHKPrIKPFm4WaWLkYODjYBTYkLk0tBakQElCT+
 rm9iAbGZBfIktjd3gM0RFjCSmL1wEdgyFgFViQ077zOC2LwC5hKPb5+Emi8vMfPSd3aIuKDE
 yZlPoObISzRvnc08gZFvFpLULCSpBYxMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcx
 goNVS3MH4/ZVH/QOMTJxMB5ilOBgVhLh7e1xThDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6Hr
 ZLyQQHpiSWp2ampBahFMlomDU6qBSThknm1w+x8Trv8Mh+5/Fa80zv+buKg64mGX7AvTO4zb
 7t0r0GXbdHz6KcXORZ+e1kxe8dHs4Jtlvkf1vvWap/qv/X5uS+Fes3leV4o2N7fmOC30Kg7v
 fuD3fPXSJfLbn779P+t/24u2le+vce/rcugqCzkQwqj/vmiy40PuB3Oj9mWpbtdiWaTt9fWN
 9qOfFxxe24gqMhV7yFgpKD2tuFm7MTFk0q/dBVd7GOa9fXF1D0dM1mVlKenySq9z3GcYStMX
 qKl2n5zCeTnfaGbXo0nJKgmnbSfcZz8l6Xjw3K/nbfNzl0T7LNhgukLwnoJw8ms+m60lsqYF
 7uuXanmd2rPqwibh6RW3vi1OPXfh1j4lluKMREMt5qLiRACw0dUjxQIAAA==
X-CMS-MailID: 20210308191842epcas5p2a21883eef4b6f98492987f80704d09bd
X-Msg-Generator: CA
CMS-TYPE: 105P
X-CMS-RootMailID: 20210308191842epcas5p2a21883eef4b6f98492987f80704d09bd
References: <CGME20210308191842epcas5p2a21883eef4b6f98492987f80704d09bd@epcas5p2.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_191853_071036_8BDB7099 
X-CRM114-Status: GOOD (  13.72  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

First patch does away with hard-coded value.
Second patch is a micro-optimization for io passthrough commands.

Kanchan Joshi (2):
  nvme: use NVME_CTRL_CMIC_ANA macro
  nvme-core: reduce checks for zero command effects

 drivers/nvme/host/core.c | 3 ++-
 drivers/nvme/host/nvme.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
