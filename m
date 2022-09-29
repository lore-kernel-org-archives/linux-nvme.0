Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 361C3C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 11:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hy9C3AtYglbaIyt78JEa6EgJSaplP/rYBelXAP22NDU=; b=GahUkKMxILVRhFrI/ucIP2llrs
	n4IryqGGNUQjc5kDNLGWji1SM2LgsvhkR8JsqRWLDCANK2A5GW+MfguE6ujWLpaaloEbHwYbahJmX
	EEM59YDZWP7vkLUHUHSGMVwAoSu1uMqcZvD5cG1buy/vR3iP5R4w08a0Xh6vwK6D0sPBS3i3KH2RE
	csmysE55h+n+rqCur18kAgQ6g/JhHBfVJUKicaDdYmkIJKzIAJoYMbjh/o770SxCXpaeFlmBGk14W
	qJMJippRFvUpnkdLgmUIIW7ckfrRqXzpXHG/vzWqXjDw3ayhK+Qa2qY5170WOmYWUWPoo00GgCQoB
	wGIwqKyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ods3K-002kF7-6s; Thu, 29 Sep 2022 11:50:06 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ods3H-002kE6-Ui
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 11:50:05 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220929114957epoutp01aa7af78281771117c6195b72956c12db~ZUnRtnxYW1031810318epoutp013
	for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 11:49:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220929114957epoutp01aa7af78281771117c6195b72956c12db~ZUnRtnxYW1031810318epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664452197;
	bh=hy9C3AtYglbaIyt78JEa6EgJSaplP/rYBelXAP22NDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YEupjZB4NjcZZvd0WlJQkYdaRxnmu0zSDEqsGjKM8HcC/uIKkK9TdVlRLJqQC6gom
	 aAovG8gM1IYCHB4MmO+IumqiivbmY/nGOd4IxYZgc5UETlVnpJX/2gUCpHygwIlBj1
	 QhFlxuVUZFDZvv3RZxWNg+csWu7ojxdvz2brnIQU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20220929114956epcas5p2b34e1d2c272dbbb7ea93c4102a45d8d4~ZUnRUz8ND3251432514epcas5p28;
	Thu, 29 Sep 2022 11:49:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MdWr227rgz4x9Q9; Thu, 29 Sep
	2022 11:49:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	32.C1.39477.E5685336; Thu, 29 Sep 2022 20:49:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20220929114015epcas5p130aa7895d04b4dad998d63aaaf4feb88~ZUezpnN6o2945329453epcas5p1f;
	Thu, 29 Sep 2022 11:40:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220929114015epsmtrp1e082624c493ef17240ffeb0c4340272b~ZUezox7F22938629386epsmtrp11;
	Thu, 29 Sep 2022 11:40:15 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-48-6335865e4692
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	9B.4A.18644.F1485336; Thu, 29 Sep 2022 20:40:15 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220929114013epsmtip10f63f2841a4afbcf082c72598523a747~ZUeyQiRhX1338713387epsmtip1t;
	Thu, 29 Sep 2022 11:40:13 +0000 (GMT)
Date: Thu, 29 Sep 2022 17:00:25 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next v10 4/7] nvme: refactor nvme_alloc_request
Message-ID: <20220929113025.GB27633@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220928171932.GB17153@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmhm58m2myQVMvs8Xqu/1sFjcP7GSy
	WLn6KJPFu9ZzLBZH/79ls5h06Bqjxd5b2hbzlz1ld+DwuHy21GPTqk42j81L6j1232xg8+jb
	sorR4/MmuQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58A
	XbfMHKBrlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVW
	hgYGRqZAhQnZGV2/nrAUfOWo+H/tJksDYy97FyMnh4SAicTUEzNYuxi5OIQEdjNKNO/bxgLh
	fGKUmPp/J1iVkMBnRonzXaowHXd+HWWDiO9ilJi3TQai4RmjxP1HKxi7GDk4WARUJZ5v8Aep
	YRNQlzjyvJURxBYRUJJ4+uosI0g9s8AeRon11zezgiSEBdwlVi1vZQfp5RXQlbiyRw4kzCsg
	KHFy5hMWEJtTQEfi4u7ZYOWiAsoSB7YdZwKZIyHQyyHx9uIEFojjXCSeHznGDGELS7w6vgXq
	TSmJl/1tUHa6xI/LT5kg7AKJ5mP7GCFse4nWU/1gvcwCGRJPTrVBzZSVmHpqHRNEnE+i9/cT
	qF5eiR3zYGwlifaVc6BsCYm95xqgbA+JJ5tmMUMC6CajxOtdh1knMMrPQvLcLCT7IGwdiQW7
	P7HNAoYFs4C0xPJ/HBCmpsT6XfoLGFlXMUqmFhTnpqcWmxYY5aWWw+M7OT93EyM4rWp57WB8
	+OCD3iFGJg7GQ4wSHMxKIrziBabJQrwpiZVVqUX58UWlOanFhxhNgXE1kVlKNDkfmNjzSuIN
	TSwNTMzMzEwsjc0MlcR5F8/QShYSSE8sSc1OTS1ILYLpY+LglGpgWnRycY+e0L+/BY8CX4jz
	Sn/Ybdb/8ai7oUrnlyX28y2tGw1uvM5btSwg8tb0lQtO8D0P5u3c4G+u5TL1ubBV24/VNlM0
	Nj6cK5KjO+nqvIytNSqH7yQ7aNzVyiu5Xf7ywIwuz3g5j4rDz427+rwvWu6TWlBZruzQWfHV
	Nal3349t+71DshkNlk9x+NC0PevQ/7V8h2euNFM+GaN+nq+PPciy/9IRf8feGkNueY/GydHt
	E06eO323jGVO5M6zV4+2hpbbZQflilbMk877/DDhStSTPVv6fl/wdTG+kX8/+5uppK79w40T
	1k7wflTCYCPvM3tnYdClM2Z6tX+LsytMCt/PuHg7ckr56W3/F6y4rcRSnJFoqMVcVJwIAOZT
	eYs0BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWy7bCSnK58i2mywdFHXBar7/azWdw8sJPJ
	YuXqo0wW71rPsVgc/f+WzWLSoWuMFntvaVvMX/aU3YHD4/LZUo9NqzrZPDYvqffYfbOBzaNv
	yypGj8+b5ALYorhsUlJzMstSi/TtErgyPs9qZSnYylbx5+Vh1gbGZyxdjJwcEgImEnd+HWXr
	YuTiEBLYwSjR37GSGSIhIXHq5TJGCFtYYuW/5+wQRU8YJT4vXgLUzcHBIqAq8XyDP0gNm4C6
	xJHnrWD1IgJKEk9fnWUEqWcW2MMosf76ZlaQhLCAu8Sq5a3sIL28AroSV/bIQcy8zSjR3j0f
	rIZXQFDi5MwnYNcxC2hJ3Pj3kgmknllAWmL5Pw6QMKeAjsTF3bPBykUFlCUObDvONIFRcBaS
	7llIumchdC9gZF7FKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcEVpaOxj3rPqgd4iR
	iYPxEKMEB7OSCK94gWmyEG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KL
	YLJMHJxSDUwzTsy5ysGguspJzX3rNKfa55+Ky17fvOC1QMWYPaFA1Wdm3urZm591LZp3922V
	0TKLzSsOx35cw75LVWwFd1/OSYWCC/+lg42uBm5/qfn7U0bpktezotvf8oQ9vh4/SfneqUxF
	jy6znyFfArLP5Qvb5LdF7M5y/7xa3+LBDe6HIV3rVpec3JhUVrmZudj960T5tj1CBUprixe+
	iSsU75BaGuicqfG7obPw28QLN1tb31d+k/p74mCC7ooVO+4/irh4ap+zwCL960HaXVOd3hip
	7XxWUzf/1Zd59v7O8c9PH8v+++7UtufcOxbtYX+npvB05t4jlpn77wZHGJvn/t23/533fFmF
	VKOzDja2WltylViKMxINtZiLihMBkzeR9vcCAAA=
X-CMS-MailID: 20220929114015epcas5p130aa7895d04b4dad998d63aaaf4feb88
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_2329a_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869
References: <20220927173610.7794-1-joshi.k@samsung.com>
	<CGME20220927174633epcas5p4d492bdebde981e2c019e30c47cf00869@epcas5p4.samsung.com>
	<20220927173610.7794-5-joshi.k@samsung.com> <20220928171932.GB17153@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_045004_351140_CDF32BB4 
X-CRM114-Status: GOOD (  22.03  )
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

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_2329a_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Sep 28, 2022 at 07:19:32PM +0200, Christoph Hellwig wrote:
> > +	if (!vec)
> > +		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
> > +			GFP_KERNEL);
> > +	else {
> > +		struct iovec fast_iov[UIO_FASTIOV];
> > +		struct iovec *iov = fast_iov;
> > +		struct iov_iter iter;
> > +
> > +		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
> > +				UIO_FASTIOV, &iov, &iter);
> > +		if (ret < 0)
> >  			goto out;
> > +
> > +		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
> > +		kfree(iov);
> > +	}
> 
> As mentioned before this is something that should got into blk-map.c
> as a separate helper, and scsi_ioctl.c and sg.c should be switched to
> use it as well.
> 

sure, this will be done in the next iteration
> Otherwise this looks good.

--
Anuj Gupta

> 

------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_2329a_
Content-Type: text/plain; charset="utf-8"


------zXa1yWTdJy36.cdAFXt1mnTNG7drKMUjG1kd-arILwPMI.kl=_2329a_--

