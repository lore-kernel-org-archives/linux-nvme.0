Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7064C74A5B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 15:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bctyMVUmY0qhLzKm25OFhS4f4wHOWRg4Noj6rlrn2TI=; b=Kk/Nv18cMlNOIDHF5CsVb/VHxG
	MmOEYyw9fNaFnOiBZPIkdMg1VWtPsQZbhHdfRtaIre8Ayjj0sKvVNj+U6cALPy/NZEo4zYZ878sCR
	WrVUNUX5e/JV7g9UPiKyTf6apPfy5FCeqN2t3NQ0haNPamBchFBSGqr3rUO2/XVJXoViVQV2Xn5oP
	r+vHyC/I9umOaYBbFrj28YaLi7NCFDc7uUV1HYNqss/LcX29ZecIF9q/ZuUze8SbAYt4dKWXzFhpF
	+eHFCfmNxXQUaPcfFvkbyKXHRV+hwdWa4aG4vva8nl5an+3opNoFadU3jIDnF1VYrC1hOWznlIEAD
	DcR5YFsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phXmD-000n6a-2T;
	Wed, 29 Mar 2023 15:31:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phXmA-000n44-3A
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 15:31:52 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230329153146epoutp02db13aad8cd97e933329545474fe039a2~Q7ZnwXLQn2379423794epoutp02i
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 15:31:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230329153146epoutp02db13aad8cd97e933329545474fe039a2~Q7ZnwXLQn2379423794epoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1680103906;
	bh=bctyMVUmY0qhLzKm25OFhS4f4wHOWRg4Noj6rlrn2TI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kqVl1qcRsJaP4w0DSKlH7e68M15t8YYMzalcn4QGbRbx4v54ei/GL0M+uwI/8xB0D
	 xh1LTzI+oOtyclOETGhBm8liKWtLS8jTTtL8/Jims8CQfIy7b7k6Rpvb0TvRgCye/p
	 +SluoMzyx93qbINkNHTdKqXLqVhutQl8CnOCmB8s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20230329153145epcas5p35b6fdeb14808610a8be55f99ff00fab3~Q7ZnBqelD2866228662epcas5p3c;
	Wed, 29 Mar 2023 15:31:45 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4PmrBS0h0xz4x9Pt; Wed, 29 Mar
	2023 15:31:44 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.DD.10528.FD954246; Thu, 30 Mar 2023 00:31:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20230329123527epcas5p19f78611d6900111716a43a3c4286c5e7~Q4-rYhrYm1108811088epcas5p18;
	Wed, 29 Mar 2023 12:35:27 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230329123527epsmtrp1161d3c81b432a24ee110b1121b0de50c~Q4-rXY9h81008710087epsmtrp1S;
	Wed, 29 Mar 2023 12:35:27 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-cc-642459df9d3a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	84.F7.18071.F8034246; Wed, 29 Mar 2023 21:35:27 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20230329123524epsmtip1138b35b1bdc68767a1329c754dfb5ae9~Q4-oYsfK82800228002epsmtip1c;
	Wed, 29 Mar 2023 12:35:24 +0000 (GMT)
Date: Wed, 29 Mar 2023 18:04:44 +0530
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, James Smart
	<james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander
	Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
	bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com, joshi.k@samsung.com,
	nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
Message-ID: <20230329123444.GA3895@green5>
MIME-Version: 1.0
In-Reply-To: <03c647ff-3c4f-a810-12c4-06a9dc62c90e@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxTZxTG8957e7llAy8F5AU2JZcxAw5oR8suDsYWjbmTmREF2VwUG3oD
	SFualk43E4ZzwCATCoJKp8A2RcEFQqmMr06sAaTKYONrIF8jYCKgfGwKrAIrXFz873ee85y8
	7zknh0AFF+w8iERlCqtWSuUUbo/V3vH18x/99A2ZcOTyLrrK0orSX+tWUPrGcC5OT99ZAPT5
	uWWUtnZ0orTpyfc8eqC5HqGbfsxH6PIbLQjd+MM8QresPcbpfHMfoCd79QhtGtxJN5naMbq7
	4RJOl5RN2tHmc2cQum7iNKArp2cx+u6gJ9250sZ7343p7olg9KMdOFOvH7ZjOkeqMaa7Q8sY
	KrJwpubKV0zjQBrOnD3zxGZIH+Uxs7/24kyOsQIwNfdOMX8btjGGicdI5JbDSaEJrFTGqr1Y
	ZVyyLFEZH0ZFHIzdHSsJFor8RSH0O5SXUqpgw6g9H0X6702U20ZAeX0ulWttUqRUo6EC3wtV
	J2tTWK+EZE1KGMWqZHKVWBWgkSo0WmV8gJJN2SUSCt+W2IzHkhLMl2Yw1czWk8NllWgamHPK
	BnwCkmJYUriGZgN7QkA2AthvyrbjggUAx7sMGBc8A7D50Z+8bEBslGTm8derBaQJwOfXnTjP
	BICWmae89QRG+sAG4+KGHyd3wntrxLrsQkrg4+/SsXVGyTIenB3asDuTUfB8z5jdOjuQfnC1
	9Q/AsRNsL5rY8PPJvXBhdHXD70p6w+baNmT9XUjW8OFSda8d184e+OzmRZRjZzjVZtzUPeCj
	3IxNPgHLC67jXPE3AOr79YBLhMN0Sy7K/S4RppvyMU5/HRZaKhFOd4RnrRMIpzvAuuIX7A1/
	rirFOXaHfYunN5mBupUrmyPtR2Dx5DKmA9v1L3Wnf+k9jt+CpY0LuN42PJT0hNdWCQ59YVVD
	YCngVQB3VqVRxLMaiUqkZE/8v/C4ZIUBbFyI34d1YHhsLsAMEAKYASRQysXB2kfJBA4y6Rdf
	surkWLVWzmrMQGJbVh7q4RqXbDsxZUqsSBwiFAcHB4tDgoJFlJvDjrD2OAEZL01hk1hWxapf
	1CEE3yMNKQxxbvCc6CrBrmZFlSiWfwoURL9acGh/xlQ6Y4z+uPyVcGNrvs7icHnfay1XhZ88
	XOx9ntpoyQjfFi25VVy8UC5Zi0LlMb8trZXFiOTK0eMKRXYoVN46mvdu5uzyVLFAp629Tekm
	ne4uNMUpLD2p47PH662f+R6bLr5QxX+zqilL8wsLC3us6L8X/TNLqx29bh445H2/TfvXQaP7
	kUHX2x98W3tYuf1B+7WynAMJLkP7jGOZMquvwbvraX1O4MkdQ85Fv88v+WwZqdASVp6LdDLe
	L8qU1y32CZs/4tjndnSrfUzB+P7UwlMRA2JZ84OHVJCRsOBFvtNOnSWt/ySeux9EYZoEqcgP
	VWuk/wGpNaFjqgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RWUwTURiFc2em0ylKHAqGKxhNqiSKrEaTS0Jc4sIoPLiGaIxY6YgoLU1r
	BcVo2VzADURSBokWjUhVVERkaQVaBUuDiKgshkVEXAgUaxRRW6Wg0bcv/znne/kpXNhOeFGx
	sn2sQiaOE5EuRLlJNMv/TNBcSdD7jxDdaqzHUcpZO46ud50h0aDJBlDuyBiOfjQ148gwnM9D
	HbWVGNIXZmOo+PojDFVrP2Ho0a8hEmUbXwL09gWHIUPnAqQ3mAnUWnWBRBevvuUj47lUDFX0
	JwNUMmgl0ONOb9Rsb+At82Ran4czXE8TyVRyXXymufsOwbQ2qZhS3QmSuXvlCFPdoSaZU6nD
	44X0Hh5jffCCZE6X6QBz15LEfC6dxZT2D2Hrpm11CZWwcbH7WUXgkh0uu1s4Gykv9kjUFqfx
	1KB+WgagKEgvgseyBBnAhRLS1QAWphWCDCAYv8+AV+0P8Ul2h8WOd/zJUh+AYz9HCWdA0D6w
	qmyU5xSR9AJo+UU5zx70Yjh0Mn2igtM6Huyu8neyO70J5j7v5TvZlfaFjvpnYNLZhkHHUe2f
	wA2a8/r/jH1hu+MD5vTjtDcsckz4BfRqaOtx8Jw8nZ4Da8sbsLPAjftvzf235v6tLwFcB2aw
	cqU0RqoMlgfL2IQApViqVMliAqLjpaVg4vm+8yvAfd1IgBFgFDACSOEiD9cfL0USoatEfOAg
	q4iPUqjiWKUReFOEyNP1aYY5SkjHiPexe1lWzir+phgl8FJjy0dLfOruGR8nZZUtfNfrIbH4
	1dRk7uxNNkeUDDFj/tr1pzfn2wcqB+pS3m+/EtcGxAXZn6oz16qx3HBST0xdrAm5XLt0unam
	Z81C/ZgmVhgfbU9Pk/PJn+qIqMyqyBUrWmbro/eENK75tqwrb6Z1w6Cpz3GtQmrbn+ijCc1c
	0lLAYTGhmqLDD78riloMi9rnmSwVtYHXIr03iueav0rbSnIirHNeqwwai9/KTnd+Wt9OS07A
	KiwnsnBq58rzz5K+qHhh4VMEbxLdygcab9tYzy2yJ2t3jbxKiOL8biZuOy7SBt4wDTvYlL7+
	1LAir6xDq5Kt7XV1x+8nBTXUq7ZFiwjlbnGwL65Qin8D0vJpxWsDAAA=
X-CMS-MailID: 20230329123527epcas5p19f78611d6900111716a43a3c4286c5e7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_1191b7_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084216epcas5p3945507ecd94688c40c29195127ddc54d
References: <20230327084103.21601-1-anuj20.g@samsung.com>
	<CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
	<20230327084103.21601-2-anuj20.g@samsung.com>
	<e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
	<20230329104142.GA11932@green5>
	<03c647ff-3c4f-a810-12c4-06a9dc62c90e@opensource.wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_083151_342860_CC32E659 
X-CRM114-Status: GOOD (  30.53  )
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

------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_1191b7_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Mar 29, 2023 at 09:24:11PM +0900, Damien Le Moal wrote:
> On 3/29/23 19:41, Nitesh Shetty wrote:
> >>> +What:		/sys/block/<disk>/queue/copy_max_bytes
> >>> +Date:		November 2022
> >>> +Contact:	linux-block@vger.kernel.org
> >>> +Description:
> >>> +		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
> >>> +		device, 'copy_max_bytes' setting is the software limit.
> >>> +		Setting this value lower will make Linux issue smaller size
> >>> +		copies from block layer.
> >>
> >> 		This is the maximum number of bytes that the block
> >>                 layer will allow for a copy request. Must be smaller than
> >>                 or equal to the maximum size allowed by the hardware indicated
> > 
> > Looks good.  Will update in next version. We took reference from discard. 
> > 
> >> 		by copy_max_bytes_hw. Write 0 to use the default kernel
> >> 		settings.
> >>
> > 
> > Nack, writing 0 will not set it to default value. (default value is
> > copy_max_bytes = copy_max_bytes_hw)
> 
> It is trivial to make it work that way, which would match how max_sectors_kb
> works. Write 0 to return copy_max_bytes being equal to the default
> copy_max_bytes_hw.
>
> The other possibility that is also interesting is "write 0 to disable copy
> offload and use emulation". This one may actually be more useful.
>

We were following discard implementation.
I feel now both options are good. We can finalize based on community feedback.

> > 
> >>> +
> >>> +
> >>> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
> >>> +Date:		November 2022
> >>> +Contact:	linux-block@vger.kernel.org
> >>> +Description:
> >>> +		[RO] Devices that support offloading copy functionality may have
> >>> +		internal limits on the number of bytes that can be offloaded
> >>> +		in a single operation. The `copy_max_bytes_hw`
> >>> +		parameter is set by the device driver to the maximum number of
> >>> +		bytes that can be copied in a single operation. Copy
> >>> +		requests issued to the device must not exceed this limit.
> >>> +		A value of 0 means that the device does not
> >>> +		support copy offload.
> >>
> >> 		[RO] This is the maximum number of kilobytes supported in a
> >>                 single data copy offload operation. A value of 0 means that the
> >> 		device does not support copy offload.
> >>
> > 
> > Nack, value is in bytes. Same as discard.
> 
> Typo. I meant Bytes. Your text is too long an too convoluted, so unclear.
>
Acked, will update in next version

> -- 
> Damien Le Moal
> Western Digital Research
> 
> 

------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_1191b7_
Content-Type: text/plain; charset="utf-8"


------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_1191b7_--

