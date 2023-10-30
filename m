Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12943C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Oct 2023 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Content-Type:MIME-Version:Message-ID:Subject:CC:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vEqq26SzxQ6PkARHOhjcaxlR5mTDPMvCCTqwuUfuO4=; b=Ci7sLeVSW4VrHu/oBlqbybn+wB
	pKnNhSppSqAbX368SUVDPIXIDhjJmE1tB4FE1jjvmJLJw8ebHkTANthtYdfahUPf4gXeT8/zmiIPG
	gAN4SNBPpBfpcHCzjBa29iynp/ONfhP7rs2k1qn2NaotxpQsmpQr9A16LlkorGYZL2EaGrjE9pyog
	DiChKIu2+kaQe1buea5bEGBXRDGTrusZkpJcAiCPc9d26Ge+LRA96mAQWiGPpY5U+LxF5t4a24cxH
	JrJ3lKHwKUyM9n9M44+QB84H5ozk6uDKNjXN20ki8etOrGWICS7HGs6HxbzhSfmaMIjIfGtpy/bAL
	5xjKwFTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTRt-003V6V-0U;
	Mon, 30 Oct 2023 14:41:01 +0000
Received: from mailout2.w1.samsung.com ([210.118.77.12])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxTRp-003V5W-2Z
	for linux-nvme@lists.infradead.org;
	Mon, 30 Oct 2023 14:41:00 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20231030144051euoutp0291c3bb85fc99b04cfef3e8a40b21f205~S6ZidElNp1297012970euoutp02c
	for <linux-nvme@lists.infradead.org>; Mon, 30 Oct 2023 14:40:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20231030144051euoutp0291c3bb85fc99b04cfef3e8a40b21f205~S6ZidElNp1297012970euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698676851;
	bh=7vEqq26SzxQ6PkARHOhjcaxlR5mTDPMvCCTqwuUfuO4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rYpN92E/MHgPHXl7lEMr8OAU7VOYfaQk9mF+jkbJY5teuAbtfTBCX4VZDR/e59Yvd
	 C3x+gH1FXC5IXI6bP9BwQrMKtJlAWuod5GOZOx/Gus6F1q1Ruz40SkmegVSDWO54nn
	 zbd+sHHEKLJ8R8xgPxs1GEa/8arFBz65a203SHpI=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20231030144050eucas1p2f37991834be6210119c18e1e48b42dc7~S6ZiOyTA-1690516905eucas1p2-;
	Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 15.2C.42423.270CF356; Mon, 30
	Oct 2023 14:40:50 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20231030144050eucas1p12ede963088687846d9b02a27d7da525e~S6Zhts8fs3038730387eucas1p1G;
	Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231030144050eusmtrp133a2b43dc3a97345dfae8ef264d47ec2~S6ZhtFjPS0879508795eusmtrp14;
	Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-64-653fc0723ef8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.66.25043.270CF356; Mon, 30
	Oct 2023 14:40:50 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231030144050eusmtip230b5bbc97899291e5b39aee6005c14c3~S6Zhg2dtJ2861528615eusmtip2W;
	Mon, 30 Oct 2023 14:40:50 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 30 Oct 2023 14:40:49 +0000
Date: Mon, 30 Oct 2023 15:40:47 +0100
From: Pankaj Raghav <p.raghav@samsung.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
	<io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>,
	<joshi.k@samsung.com>, <martin.petersen@oracle.com>, Keith Busch
	<kbusch@kernel.org>, <p.raghav@samsung.com>
Subject: Re: [PATCHv2 1/4] block: bio-integrity: directly map user buffers
Message-ID: <20231030144047.yrwejvdyyi4vo62m@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231027181929.2589937-2-kbusch@meta.com>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xSYRjexzkeDhR1RDe/LtqgWamFsazYcpWrFbWuv9y6KeiXNhGLI2V2
	w62LlkVhaqIu7SKEKw3R7OJsrLQUKcoyLzXdorKyIV1MK0o4tvr3fM/lfd9n+0iMX+I3mdyh
	TEcqpUwhJLh4XdOwfY7q7hI0t+2nWFL5UktIrlTeZ0k+HbHjEp31OZDYnpXjkoauCMn5Cidb
	Ymj2sJaS0qdtaqnZlENIay4dkt7u1BBSuyNDOujswqWfzSEb2Ju40YlIsWM3UkUujucmV5g0
	7J0GXkbh9V5CA35zjgMOCako+MVZih8HXJJPGQE0uzQE8/gCoOfWSRbz+AxgzXA/+BtxVX8d
	ixgA7Mg7gXkFn6vEpGQEC4C1BYO4V8CpUPi2oWd0FEkSVDjMymF76UBKAB91Musw77revKs+
	IYBaDbuzhvy8mEcthEcMtSwG+8OHRa99MzFqNiy77Sa8MzFqCjR4SC/NGbV/b60nmEOFUFNj
	wxl8ALZYunxtIOUiofFONZsRlkNLW/cYDoDvmy1jeCpszcsdC++Dzhc/MCZ8GEDtzSrfYkgt
	gqdsCsYTA385C1gMPQG+GPBnzpwAdXWFGEPzYPZRPuOeAStffcRPg+n6/4rp/yum/1esDGAm
	EITUdGoSosVKtEdEy1JptTJJlJCWagajH6jV0+yuB6XvB0VWwCKBFUASEwbysJhoxOclyvZm
	IlVanEqtQLQVTCFxYRAvNHEa4lNJsnSUgtBOpPqrskjOZA3rwjK6Z3MRpZm0LOa5PEzX7r9/
	VaTujm4g8iC3KfZc3zAdtrTYkrtNP49TaHMV9gq+hTzBR+Zr7e6Png1vgs5YkkPOmM8H10Td
	3Vg10dSRe+5GrdHRpFWvMJTLyz+0JIlcYE3E+ASj49ehgKyV7q2N+FCRRh68v+6geyTTUFq2
	a5Jiy559qJa/PreVHhqPBKtSdNMKHNS10ITHynsN2YtKsi/G+MVLmwRf160trSoYJ3h31tqX
	ISC2jxwDwSpxv6hdHjhvZnqOusfRuMA+PbazLGrhkC2+d1yHcT03TjfxVr58RkWOebaec3bW
	g+hgWwQ68SbTdLlRvFmbll/cHibE6WSZOBxT0bI/orIfaK8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJIsWRmVeSWpSXmKPExsVy+t/xe7pFB+xTDW7c5LdYfbefzWLl6qNM
	Fu9az7FYTDp0jdHizNWFLBZ7b2lbzF/2lN1i+fF/TA4cHpfPlnpsWtXJ5rF5Sb3H7psNbB7n
	LlZ4fHx6i8Xj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU
	1JzMstQifbsEvYxlqxrYC5bzVkzf+ICtgfE/ZxcjJ4eEgInEhw1fWboYuTiEBJYySlxa9IQJ
	IiEjsfHLVVYIW1jiz7UuNoiij4wSJ5++ZoZwtjBKHN60AKyDRUBV4vneO0A2BwebgJZEYyc7
	SFhEQFHiPND9IPXMAl8YJR5MXguWEBbwkrjd+B1sA6+AuUTr8q1gvUICyRKLJhZAhAUlTs58
	wgJiMwvoSCzY/YkNpIRZQFpi+T8OkDAnUOeP0zvYIO5UkmjYfIYFwq6V+Pz3GeMERuFZSCbN
	QjJpFsKkBYzMqxhFUkuLc9Nzi430ihNzi0vz0vWS83M3MQLjcNuxn1t2MK589VHvECMTB+Mh
	RgkOZiURXmZHm1Qh3pTEyqrUovz4otKc1OJDjKbAgJjILCWanA9MBHkl8YZmBqaGJmaWBqaW
	ZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUw+Lmv19voq1zPOmG+s9mrdKYVakUvr5yy5
	IKD//MvUr64FORzX0q0mPz1bGdKwQMenxLZPyKhi/dWJO4prYxJN10xx5yya2i67hWu1trbq
	XY4Xn0WEROdO3xbJGOwf9Hh/xe6GwCcLcp8e5Zqtc2zabifDQs+NQiWuK/ta+lacOl/sd+xa
	9s/dPNPy073emfZnvFS0kNjInVOjauVev99/mvlxiRcHNnO+azt0xv9NdUGjkHuSll/g9W+V
	PQf9dnZxWoRG72K0mOC7PKUs46hjXEGC1Cf3Bp1/62fcmRPBdaYiPf1j9uXOa4vqdD2kvdO1
	F2dyiC7uZfbfo/zq4Nxj+pNDbq3h3fG92MT4mxJLcUaioRZzUXEiADSWan1MAwAA
X-CMS-MailID: 20231030144050eucas1p12ede963088687846d9b02a27d7da525e
X-Msg-Generator: CA
X-RootMTR: 20231030144050eucas1p12ede963088687846d9b02a27d7da525e
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231030144050eucas1p12ede963088687846d9b02a27d7da525e
References: <20231027181929.2589937-1-kbusch@meta.com>
	<20231027181929.2589937-2-kbusch@meta.com>
	<CGME20231030144050eucas1p12ede963088687846d9b02a27d7da525e@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231030_074058_371652_D95BF242 
X-CRM114-Status: GOOD (  17.93  )
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

> +static int bio_integrity_copy_user(struct bio *bio, struct bio_vec *bvec,
> +				   int nr_vecs, unsigned int len,
> +				   unsigned int direction, u32 seed)
> +{
> +	struct bio_integrity_payload *bip;
> +	struct bio_vec *copy_vec = NULL;
> +	struct iov_iter iter;
> +	void *buf;
> +	int ret;
> +
> +	/* if bvec is on the stack, we need to allocate a copy for the completion */
> +	if (nr_vecs <= UIO_FASTIOV) {
> +		copy_vec = kcalloc(sizeof(*bvec), nr_vecs, GFP_KERNEL);
> +		if (!copy_vec)
> +			return -ENOMEM;
> +		memcpy(copy_vec, bvec, nr_vecs * sizeof(*bvec));
> +	}
> +
> +	buf = kmalloc(len, GFP_KERNEL);
> +	if (!buf)
> +		goto free_copy;

ret is not set to -ENOMEM here.

> +
> +	if (direction == ITER_SOURCE) {
> +		iov_iter_bvec(&iter, direction, bvec, nr_vecs, len);
> +		if (!copy_from_iter_full(buf, len, &iter)) {
> +			ret = -EFAULT;
> +			goto free_buf;
> +		}
> +	} else {
> +		memset(buf, 0, len);
> +	}
> +
> +	/*
> +	 * We just need one vec for this bip, but we need to preserve the
> +	 * number of vecs in the user bvec for the completion handling, so use
> +	 * nr_vecs.
> +	 */
> +	bip = bio_integrity_alloc(bio, GFP_KERNEL, nr_vecs);
> +	if (IS_ERR(bip)) {
> +		ret = PTR_ERR(bip);
> +		goto free_buf;
> +	}
> +
> +	ret = bio_integrity_add_page(bio, virt_to_page(buf), len,
> +				     offset_in_page(buf));
> +	if (ret != len) {
> +		ret = -ENOMEM;
> +		goto free_bip;
> +	}
> +
> +	bip->bip_flags |= BIP_INTEGRITY_USER;
> +	bip->copy_vec = copy_vec ?: bvec;
> +	return 0;
> +free_bip:
> +	bio_integrity_free(bio);
> +free_buf:
> +	kfree(buf);
> +free_copy:
> +	kfree(copy_vec);
> +	return ret;
> +}
> +

