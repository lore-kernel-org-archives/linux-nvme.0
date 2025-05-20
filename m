Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FB3C3ABDD
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=; b=hLR7n2jJWArw1Y1GHA8DOpNR8f
	4QT9O4EDNbUeQX2DeTqPKC9+Zc1Wzb1adah+Q/KKGQGhXaeSWrLjzXlHnGHPpoUoqv2vbx6Uk6IFc
	n9gpHjeSw4+1Qob++7h0QlHfvid2JPAm75bEKQmLYHuTSgBI8yyPzb/uMCgqDntWhcKAgxilrl0B2
	qSmmyaGvmNVzFMPkjIsM5cKkzNOX4o42txpK/jm43srHg0Vl61D7wQ9SEk9qQ2XFP9A10oF3/sx9e
	6joxxI2+EzT6FksB7FKmR+Vdz/oX1IWXb2tp1+b3tUxuOeJvn/0VlWelwgQ0Sd20l1QEPE3efiHSm
	g9Jqkd4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPf8-0000000DUto-3xfH;
	Tue, 20 May 2025 16:17:54 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHPFp-0000000DPWn-3c8P
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 15:51:48 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250520155138epoutp03742a8b1b716eb2bc62469a938271cb4c~BRxfdWQrq2840128401epoutp03L
	for <linux-nvme@lists.infradead.org>; Tue, 20 May 2025 15:51:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250520155138epoutp03742a8b1b716eb2bc62469a938271cb4c~BRxfdWQrq2840128401epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1747756298;
	bh=MPy2dmqKlCsrw5okIZFwkiGzwVi0bWXg1j0NfWvMFRQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=HXQZ4jhvlTeMFISC/sc6BWYr1IWOfJaD1f5vgicEiutr74OV5W3yUBQt2pZtGqmY7
	 wG8XEjFx/yw/BbcGnUZPrWIppglHIGYoivaKuSvFKjQ2l8n4d9XqfHk+rtD9jsMlPA
	 eCSEIFkdrUSgxs319F+IkUKDvswU43D6+QbAQUkI=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250520155137epcas5p3c2e2b22befb1d02079e7800fcbeee1cf~BRxeo90__1618016180epcas5p3X;
	Tue, 20 May 2025 15:51:37 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.179]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4b1zZ04jdHz2SSKX; Tue, 20 May
	2025 15:51:36 +0000 (GMT)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250520155135epcas5p4a3c974fec78e0e8fe19c0ca306a174fa~BRxc_zzXq2769727697epcas5p4y;
	Tue, 20 May 2025 15:51:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250520155135epsmtrp1b308093bc1521297eb21dc0728c693fe~BRxc9x7Il0224702247epsmtrp1V;
	Tue, 20 May 2025 15:51:35 +0000 (GMT)
X-AuditID: b6c32a29-55afd7000000223e-41-682ca5078b0d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B5.E8.08766.705AC286; Wed, 21 May 2025 00:51:35 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250520155134epsmtip2383cd9c5b2a1f70fbd404c3835c39b92~BRxb-T4UM2879128791epsmtip2M;
	Tue, 20 May 2025 15:51:34 +0000 (GMT)
Message-ID: <e1edd43c-eec0-43ab-bea1-76e244b4bf8e@samsung.com>
Date: Tue, 20 May 2025 21:21:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: fix implicit bool to flags conversion
To: Pavel Begunkov <asml.silence@gmail.com>, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWy7bCSvC77Up0Mg6erpS3mrNrGaLH6bj+b
	xcrVR5ksJh26xmgxf9lTdot1r9+zOLB57Jx1l93j/L2NLB6Xz5Z6bFrVyeaxeUm9x+6bDWwB
	bFFcNimpOZllqUX6dglcGad2LGUqMKq4NrePqYFRt4uRk0NCwERi2+E1zF2MXBxCArsZJf7/
	fcQGkRCXaL72gx3CFpZY+e85O0TRa0aJ3fefMoIkeAXsJPbuvs8CYrMIqEqs3LOICSIuKHFy
	5hOwuKiAvMT9WzPABgkLuEjs7bsMtk1EYAKjxJWH+8C2MQs4SGzduwBqwwZGiZMHJrFAJMQl
	bj2ZDzSVg4NNQFPiwuRSkDCnQKzE+d8PoUrMJLq2djFC2PIS29/OYZ7AKDQLyR2zkEyahaRl
	FpKWBYwsqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLzczcxgmNGS3MH4/ZVH/QOMTJxMB5i
	lOBgVhLhXbVZI0OINyWxsiq1KD++qDQntfgQozQHi5I4r/iL3hQhgfTEktTs1NSC1CKYLBMH
	p1QDk4r/Xe6vPaGp90vTrvjYh86XE/p5cOYthqSL07oY3VlZj3H0n1/sEBnVt/7RX5US45CN
	tdu0um4f/3Xf5UN0hujl6S/63ycWdZxx4TNRkThe/OaSov/rNyy77I9z3NQ411m2OPRst/TG
	bWs3RVg+7bh48fmOpYu6Fnm83/OgdZn9iogHXKqJMWXHSl+Yb7uS7n1z+8SJLFaJtUeu+Juw
	mHsdKVxREHNx52NnzRmrWYQKdyi8TT98z2he2Lv7uVbzSw/5rj436e4qU8u51UXKU1xPOZg4
	Xo5WY1/z1SVs4U/D2/skja/pT2M0ulT+XP9L0p+u6O+s8TwtQq2Nh2w1Qo9N9HO8EpAwQXap
	rbvoRSWW4oxEQy3mouJEAHD8cKMIAwAA
X-CMS-MailID: 20250520155135epcas5p4a3c974fec78e0e8fe19c0ca306a174fa
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250520152811epcas5p3a0c63ffa250d376b3a9bec758fd12524
References: <CGME20250520152811epcas5p3a0c63ffa250d376b3a9bec758fd12524@epcas5p3.samsung.com>
	<d8ed3f9ae153dfc3e8a2a63ed5abbc5e1f0589fb.1747753887.git.asml.silence@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_085146_528903_FF67A3D5 
X-CRM114-Status: UNSURE (   9.31  )
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

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

