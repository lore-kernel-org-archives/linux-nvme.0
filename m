Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B46C282DE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 11:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=udixDU6OHXbOac77c50GKCKCKKq/VjTJns48x1a09kI=; b=PUBAwi7lXdvHwhKIih++SQLgPd
	cf833uS1MTKG5+rsbOyfA4YMMohWWblWWlV6oLjumykKolNHZv8NfJdM/mQd/Bg0AXkg44B0RAHhp
	ZVK27es5i8E/bc05/jJJk5Hk6DtYt1tTRt0oJAuNYewyHS4IjJEQ/10d64WBoJhdXJ/MkftGulgR1
	gfTyMYB+9EtZBsVkGP+NdVk40cYUE6GSFX1TylZPZ8QpX8wq9pChPzpHF87mmmr7SpB9elzIgXSGQ
	9YL5oG9tKUKUuLpUL7+Xj2IageChxAuMyuzAiAHXAPRhXCHrz3jMVC4EzlH/KdOzVSirNoaqhiLmq
	MLeVfcTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trbgK-00000002U8c-1klc;
	Mon, 10 Mar 2025 11:52:28 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trbEr-00000002QNX-1cWb
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 11:24:09 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250310112358epoutp02605d59143420dc96549c8a9509c026b2~rbUhwzQl_1071710717epoutp02c
	for <linux-nvme@lists.infradead.org>; Mon, 10 Mar 2025 11:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250310112358epoutp02605d59143420dc96549c8a9509c026b2~rbUhwzQl_1071710717epoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741605838;
	bh=udixDU6OHXbOac77c50GKCKCKKq/VjTJns48x1a09kI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZmLUlUY0Gi3DJNuxXGH2KrETulhbsX4vL6aQGBdOLHF0WjDjcjjAv82XaGHfDmvfN
	 zyaZ9/hWHdgqQOg0zgr1pRAiPeipt0ujAijVuRtaZ35J1L7Z1Lf2yXefL0Dq2zzopD
	 4qRcQoeczN0TLySW4YV06bvScsaneyz7ndyj7G0I=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250310112357epcas5p2f0e887011e303aa3f6cb85e175bf3ce2~rbUg0S43D0265802658epcas5p2c;
	Mon, 10 Mar 2025 11:23:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZBDzx03Vyz4x9Pp; Mon, 10 Mar
	2025 11:23:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.FA.20052.8CBCEC76; Mon, 10 Mar 2025 20:23:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250310104708epcas5p47a8a441dde01467ee724444a77c0a9a9~ra0XKvbJo0263502635epcas5p4N;
	Mon, 10 Mar 2025 10:47:08 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250310104708epsmtrp10973902a0716bcac410c009b93984640~ra0XKImmM2966229662epsmtrp13;
	Mon, 10 Mar 2025 10:47:08 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-fe-67cecbc8f59c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	50.68.33707.C23CEC76; Mon, 10 Mar 2025 19:47:08 +0900 (KST)
Received: from green245 (unknown [107.99.41.245]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250310104707epsmtip1721ef9b47f1186670575ebf275d881e1~ra0WI-_i92405124051epsmtip15;
	Mon, 10 Mar 2025 10:47:07 +0000 (GMT)
Date: Mon, 10 Mar 2025 16:08:52 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
	Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: remove stale comment
Message-ID: <20250310103844.xbaqvnaui6rwc63f@green245>
MIME-Version: 1.0
In-Reply-To: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
User-Agent: NeoMutt/20171215
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmpu6J0+fSDVZsNbL4v+cYm8WKa29Y
	LFauPspkMenQNUaL+cuesluse/2exYHNY2LzO3aP8/c2snhsWtXJ5rF5Sb3H7psNbB5zG24x
	BbBFZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2h
	pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAwMgUq
	TMjOaHn2iKngH1PFmRdfGBsY7zN1MXJySAiYSHT+e8/axcjFISSwm1HixLS5UM4nRolHC1az
	wTn777yBa1k2Zw1UYiejxPutp9ghnGeMEo2duxhBqlgEVCUety9jA7HZBNQljjxvBYuLCKhI
	/H++DaybWWAJo8Tl1xvYQRLCAsYS517tAUpwcPAKmEl86SgDCfMKCEqcnPmEBcTmFIiQeDTp
	I5gtKiAjMWPpV2aQORICP9klPj34AnWei8ScmRuZIWxhiVfHt7BD2FISL/vboOx0iR+Xn0LV
	F0g0H9vHCGHbS7Se6gfrZRbIkLix4hdUvazE1FPrmCDifBK9v59A9fJK7JgHYytJtK+cA2VL
	SOw91wBle0is3LsFGqirGSX+PJ3LNIFRfhaS52Yh2QdhW0l0fmhinQUMC2YBaYnl/zggTE2J
	9bv0FzCyrmKUTC0ozk1PLTYtMMxLLYdHeXJ+7iZGcDrV8tzBePfBB71DjEwcjIcYJTiYlUR4
	b68+ly7Em5JYWZValB9fVJqTWnyI0RQYWROZpUST84EJPa8k3tDE0sDEzMzMxNLYzFBJnLd5
	Z0u6kEB6YklqdmpqQWoRTB8TB6dUA1NE/ClNbelXZ2ZPmfD2X+bWdZtDzqYUSNaIGU5y+frs
	vinTGoOod/u7hcNX3/y/tebMOU+vDoEEq33hCrv3i3y80HJv4iaey4pNj++3VUkvdAH6/vyt
	gvurLn6723B45ZOMCRb9hdV80da3y6MDbM/ZM3OaN183+H4ur+Ams4fmh037HJ5sWtd3gTsw
	cfa1Ja07tELs/XWkfzVouWbL3Dy6o8lq95crM7+mhNp9yWw/q1PKkMYZoWex99T9OQoFsaGy
	v6UmrRJOD2uav1Yj5eKe5OUXIpYfajkh0DXd5326VGaRtqEpy+dTP74Lej1KZBKMEzizzMJW
	h7FwTrtgYQHXrgPFV/WndaltuG61S4mlOCPRUIu5qDgRADI4w94wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSnK7O4XPpBi2zBSz+7znGZrHi2hsW
	i5WrjzJZTDp0jdFi/rKn7BbrXr9ncWDzmNj8jt3j/L2NLB6bVnWyeWxeUu+x+2YDm8fchltM
	AWxRXDYpqTmZZalF+nYJXBk3H8xnLzCoeNu+iLWBUbuLkZNDQsBEYtmcNWxdjFwcQgLbGSUO
	X3rICpGQkDj1chkjhC0ssfLfc3YQW0jgCaNE5yxmEJtFQFXicfsyNhCbTUBd4sjzVrB6EQEV
	if/Pt4ENZRZYwijx6/B/sCJhAWOJc6/2ANkcHLwCZhJfOspATCGBcIm2RVogFbwCghInZz5h
	AbGZgSrmbX7IDFLCLCAtsfwfB0iYUyBC4tGkj2AlogIyEjOWfmWewCg4C0n3LCTdsxC6FzAy
	r2IUTS0ozk3PTS4w1CtOzC0uzUvXS87P3cQIDnmtoB2My9b/1TvEyMTBeIhRgoNZSYT39upz
	6UK8KYmVValF+fFFpTmpxYcYpTlYlMR5lXM6U4QE0hNLUrNTUwtSi2CyTBycUg1MOtwaD1wk
	m6I+2EaI7NYwmO3291DW0gVX6wXU3fbFTOdJmhcTaFW59eTvA10HRDefXigQxJDr6H8yOnC9
	ZKJM4r9lPbd9828eTO79optunDxFaZKR31Zezs57R6+1/pmc3HrM1cYxImXepFv9F5sF39Td
	nvsjt3cSR9+jH3YKnAVaOcG/Zu4LTH3oLH0wm4On2J/xod4fj+1O3uEH3vP81YhglPDcfGtJ
	hcesLzdfpDzn89+7smb1Op1DvJ2nZ/2qN4kSO3X+665LR37zTddff+Km5Je0KX4Sjst3F5/+
	otT99bzv1Ykr7Ax2r1mvdIjj08F/gdeO8vdumvj1h+qV7Z7N866Zn9B6JfM99S3vASWW4oxE
	Qy3mouJEABb/hLnoAgAA
X-CMS-MailID: 20250310104708epcas5p47a8a441dde01467ee724444a77c0a9a9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HfQHDWAqs1zy.OV.rsL8t3s7xOtFM7wsnj7.cJqEK_cJO4Ic=_b9100_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250310104708epcas5p47a8a441dde01467ee724444a77c0a9a9
References: <624210159350e1c8137b5e55cb29ae509ac21d47.1741251211.git.baruch@tkos.co.il>
	<CGME20250310104708epcas5p47a8a441dde01467ee724444a77c0a9a9@epcas5p4.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_042406_854628_7AF07546 
X-CRM114-Status: GOOD (  10.33  )
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

------HfQHDWAqs1zy.OV.rsL8t3s7xOtFM7wsnj7.cJqEK_cJO4Ic=_b9100_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>

------HfQHDWAqs1zy.OV.rsL8t3s7xOtFM7wsnj7.cJqEK_cJO4Ic=_b9100_
Content-Type: text/plain; charset="utf-8"


------HfQHDWAqs1zy.OV.rsL8t3s7xOtFM7wsnj7.cJqEK_cJO4Ic=_b9100_--

