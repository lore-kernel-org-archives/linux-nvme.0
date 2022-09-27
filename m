Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4787C54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 16:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WN98Z+toqYTCJyZopsufyzYBGzY35LhUkYamHWj83rk=; b=PllNHk0VPpURAENPtI8z4pLyrw
	Zsm3Z2F5huLMQZlaN+lm5LqC3JXcxaixlCPThBM245texYiq5VB37fD77bJi2iL2+mjbo8HmhaGKa
	7BWMdLkSSDTLLL8oHdtvPJ6LlepEwOp62o2vFqYsum7MN7Fqv7ZYjt8OFDsjzUa7MRvJXWQJAhCd4
	c6wLd6ikhrlanMaBFty+hWdBbA1HUtAfgmrAnHBjB1u3leCMFLgYXLIl8lDVeN2WhPjgt7jIjfi25
	KvbCPjUjL/7WwBb+E5pFBhH63PPL1T+CVJ0GOwyrKPhCY4BtDr9mLdY+nHVKstZjzgzNbTAWsmN6l
	E4QapTFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odDtq-00Bstt-Cl; Tue, 27 Sep 2022 16:57:38 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odDtn-00Bsk8-0y
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 16:57:37 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220927165719epoutp022f97cbd92fed40c89ddeeb6008fd71cd~YxhEmUXyz1897818978epoutp02Q
	for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 16:57:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220927165719epoutp022f97cbd92fed40c89ddeeb6008fd71cd~YxhEmUXyz1897818978epoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664297839;
	bh=WN98Z+toqYTCJyZopsufyzYBGzY35LhUkYamHWj83rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LS4fyQpoZcoMzB8+kfQy1zqv2S+cKQZa1UylmoBQmXIbBvme4QD8atDGVMyAKdVuE
	 zqOCRoFN3RD+MNAfFdHcgkRtSis6VQ9E5gjsWPdyRviZb0uevI9tVsbYz7j3Ilgjcl
	 7olWVHgqEfCXPLBO7Ar+xDj84jUpfF8CqJjzRPHg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220927165718epcas5p424fb7ceac7e422fa513a0c4ae11e4a24~YxhEEMzz02047920479epcas5p4F;
	Tue, 27 Sep 2022 16:57:18 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4McQlc0t5qz4x9Pr; Tue, 27 Sep
	2022 16:57:16 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	90.A6.56352.B6B23336; Wed, 28 Sep 2022 01:57:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220927165715epcas5p28fdc79fc8bbac37658494595608eb19a~YxhBYQBPV1847418474epcas5p2I;
	Tue, 27 Sep 2022 16:57:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220927165715epsmtrp2081da919304018c590a5acd3cac8e661~YxhBXgNai0403504035epsmtrp2N;
	Tue, 27 Sep 2022 16:57:15 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-6d-63332b6ba39c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	94.65.18644.B6B23336; Wed, 28 Sep 2022 01:57:15 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220927165714epsmtip25960e2685bb794df81781f490d4ed20b~Yxg-_bGB11745417454epsmtip2d;
	Tue, 27 Sep 2022 16:57:14 +0000 (GMT)
Date: Tue, 27 Sep 2022 22:17:26 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v7 4/5] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220927164726.GA23874@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220926145040.GA20424@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIJsWRmVeSWpSXmKPExsWy7bCmpm6OtnGywdwNzBZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi0mHrjFa7L2lbTF/2VN2B06PnbPusntcPlvqsWlVJ5vH
	5iX1HrtvNrB59G1ZxejxeZNcAHtUtk1GamJKapFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5
	kkJeYm6qrZKLT4CuW2YO0F1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul1IKUnAKTAr3i
	xNzi0rx0vbzUEitDAwMjU6DChOyMB0vWsRZM5Kvo2X2BrYHxJncXIyeHhICJxLwpDUxdjFwc
	QgK7GSVO/PrGCuF8YpRY+24XG4TzmVHizoV1zDAtL749Y4dI7AJKLLkA5TxjlHj68y4LSBWL
	gKrErV/rgdo5ONgENCUuTC4FCYsIKEk8fXWWEaSeWeAKo8STrnVMIAlhgViJjUd+g23gFdCV
	OHp+EyOELShxcuYTsJmcAjoSPy81sIHYogLKEge2HQc7XEJgLofEtEebGSHOc5E48fc5C4Qt
	LPHq+BZ2CFtK4vO7vWwQdrLEpZnnmCDsEonHew5C2fYSraf6wY5gFsiQOPJ2CiuEzSfR+/sJ
	E8gzEgK8Eh1tQhDlihL3Jj1lhbDFJR7OWAJle0ismXOFERIo95kkNr9qZJ7AKDcLyT+zkKyA
	sK0kOj80AdkcQLa0xPJ/HBCmpsT6XfoLGFlXMUqmFhTnpqcWmxYY56WWw2M5OT93EyM4rWp5
	72B89OCD3iFGJg7GQ4wSHMxKIry/jxomC/GmJFZWpRblxxeV5qQWH2I0BcbPRGYp0eR8YGLP
	K4k3NLE0MDEzMzOxNDYzVBLnXTxDK1lIID2xJDU7NbUgtQimj4mDU6qB6foyIe01y+7nxfh7
	P2y+8eWLhWfiZ5HdK7tVnu+7u1O2RI1T/9v+/61aiurlK/b9KCw7fcvCTosxiTUv6Kr6T+ei
	lWsa//HP/3OmXyTw7kKD1eWuc1d/Fk0ysD/7REzetPSiqLSK7JWW0OpXHy2XfnFgsZP6YPc6
	QXt53bnPe9Lmn1tXud4vd961hQILJx794qhgre2QM/9IwX/mxR+DPXzFVk6Vf/Lc9lP058aU
	8PjFn81/6p2f3yB+4M38JRy1rqcmt187uP9m8OXyT1sKeVXuFPNKbMs6kGzCviaTj90k7rCN
	4Yd562In3ll5RvVc44T76et4FusJVLw8OK+AgdP7eOoVufVfj03rEKvsuanEUpyRaKjFXFSc
	CAAoNg+JNAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSvG62tnGywYE96hZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi0mHrjFa7L2lbTF/2VN2B06PnbPusntcPlvqsWlVJ5vH
	5iX1HrtvNrB59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV0ZXVxNbwWHuirs3frE2MC7l7GLk
	5JAQMJF48e0ZexcjF4eQwA5GiQMTZrFBJMQlmq/9YIewhSVW/nsOZgsJPGGUuLYqH8RmEVCV
	uPVrPVA9BwebgKbEhcmlIGERASWJp6/OMoLMZBa4wijxZ/8SVpCEsECsxMYjv5lBbF4BXYmj
	5zcxQix+yiQxc/0MdoiEoMTJmU9YQGxmATOJeZsfMoMsYBaQllj+jwMkzCmgI/HzUgPYnaIC
	yhIHth1nmsAoOAtJ9ywk3bMQuhcwMq9ilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dLzs/dxAiO
	Ei2tHYx7Vn3QO8TIxMF4iFGCg1lJhPf3UcNkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7G
	CwmkJ5akZqemFqQWwWSZODilGphaFte4fWpWmnd4YnHN/+TTRnZJm8XuvmAs+2P5+Ra39hKV
	t+8fpebN+GH1LvCU7Cpug0RexgubNE7MmTe1vclWW/ZvyXaW98K5a/NWrFj5YMb8a5vf9i0/
	PqOAYcvFeWcLljXXFMVK2t4NXG5mdsE7tuDCVR/BhPRn85r9j3qH2HoLtGzZti2IXURT7pP5
	c45Jf5yUtypmBOzyO6ARn3pFvKeEf8Ufr27dhgNcIbOOH/YS43Wdx2h8QyGh+sDZDV/M7s0/
	m3HtyDQNj5Zzu/cE72UMueUezvs99uzfZwLbFnOLhfJsifvpnCi1/NieBy2VToeuRyT/tG8/
	80uzXrzIRvW1tNzxG4rFWTkPZAWVWIozEg21mIuKEwGlOvz3AQMAAA==
X-CMS-MailID: 20220927165715epcas5p28fdc79fc8bbac37658494595608eb19a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----.zUCO39MzbK7om0jLOM-xUZSVJvK3u431ZHR1RBC1kJrIMKr=_1769e_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220909103147epcas5p2a83ec151333bcb1d2abb8c7536789bfd
References: <20220909102136.3020-1-joshi.k@samsung.com>
	<CGME20220909103147epcas5p2a83ec151333bcb1d2abb8c7536789bfd@epcas5p2.samsung.com>
	<20220909102136.3020-5-joshi.k@samsung.com> <20220920120802.GC2809@lst.de>
	<20220922152331.GA24701@test-zns> <20220923152941.GA21275@lst.de>
	<20220923184349.GA3394@test-zns> <20220926145040.GA20424@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_095736_370615_FAC164A2 
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

------.zUCO39MzbK7om0jLOM-xUZSVJvK3u431ZHR1RBC1kJrIMKr=_1769e_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Mon, Sep 26, 2022 at 04:50:40PM +0200, Christoph Hellwig wrote:
>On Sat, Sep 24, 2022 at 12:13:49AM +0530, Kanchan Joshi wrote:
>> And efficency is the concern as we are moving to more heavyweight
>> helper that 'handles' weird conditions rather than just 'bails out'.
>> These alignment checks end up adding a loop that traverses
>> the entire ITER_BVEC.
>> Also blk_rq_map_user_iov uses bio_iter_advance which also seems
>> cycle-consuming given below code-comment in io_import_fixed():
>
>No one says you should use the existing loop in blk_rq_map_user_iov.
>Just make it call your new helper early on when a ITER_BVEC iter is
>passed in.

Indeed. I will send the v10 with that approach.

>> Do you see good way to trigger this virt-alignment condition? I have
>> not seen this hitting (the SG gap checks) when running with fixebufs.
>
>You'd need to make sure the iovec passed to the fixed buffer
>registration is chunked up smaller than the nvme page size.
>
>E.g. if you pass lots of non-contiguous 512 byte sized iovecs to the
>buffer registration.
>
>>> We just need to implement the equivalent functionality for bvecs.  It
>>> isn't really hard, it just wasn't required so far.
>>
>> Can the virt-boundary alignment gap exist for ITER_BVEC iter in first
>> place?
>
>Yes.  bvecs are just a way to represent data.  If the individual
>segments don't fit the virt boundary you still need to deal with it.

Thanks for clearing this.

------.zUCO39MzbK7om0jLOM-xUZSVJvK3u431ZHR1RBC1kJrIMKr=_1769e_
Content-Type: text/plain; charset="utf-8"


------.zUCO39MzbK7om0jLOM-xUZSVJvK3u431ZHR1RBC1kJrIMKr=_1769e_--

