Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A9B8C5B548
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 14:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pupbnGfWeNRdoCnvuS0X6cju7U4buS/r8MZGN0NqYmw=; b=tDizIVBVk2lydeqSwjCFQi/9Cv
	tCt5+HRlaegX226vtkSXPHojdeDyrKuBc6r/rBhWuiosyRcyNrgbtwA9HUhZJfyIDwY0jDy+dUOxt
	ZYmHcrYMqtuM6jEuAtVbp2HwP2Q2FI/8HXEfDSQVvL7fEzYwQSH7yFbjnImZ9MCe9r4OuaCHSVQk8
	74HTN2GU+iixU3WUjZgfl+c36WKiuFnUziVmlkbqiHauSqfUSkExTfgR8OwKPKmDTQn6mAZHqro7p
	V3qgCK1YVxRZHdzXqNFCStBEXDDsGgD4wAfbXzMkujTd87CbCSAv1YEaypeFvGuLXhcEZ2s7L3Khv
	PX81g49w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjJvd-0000000FoDB-3o1D;
	Wed, 28 Aug 2024 14:45:45 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjIwh-0000000FZGU-2r4C
	for linux-nvme@bombadil.infradead.org;
	Wed, 28 Aug 2024 13:42:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=pupbnGfWeNRdoCnvuS0X6cju7U4buS/r8MZGN0NqYmw=; b=Ix3Y6k+U/xwx2YOpvWnOy69A3F
	9ffycBTBkoyfMvK+VxL+l076yiYz+2J8QeQ8A7u6I2RMvoNEjgrLN5mdv0Ju9bjiW0+bTSl+H9jxH
	fYcvbGI8ryWFEONGPZJFMbUpruI0D9LP3sWzZeNtA6M/xHzWbt+uWgHqSe/om+day7lb4cYlx35hz
	yVndq/Gb8NrQu7Sb1qu++BRSKWpH3JwoaKKxlrKW2otOI5bGpAvIrXs8Jip9EoZTHo0S6oSWy8WFm
	dTxScmEY2oCgPmHCxB+52Nl96WZP37no2yTslvKAANuv4Higaw9hhl8aBRdnZOifiV8eF/K3aiFRz
	ENmMyphw==;
Received: from mailout3.samsung.com ([203.254.224.33])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjIwc-0000000BBGO-3o0R
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 13:42:46 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240828134229epoutp03955f27d48b95c30ba610f616cb81c753~v6EFSOk3F0042700427epoutp03B
	for <linux-nvme@lists.infradead.org>; Wed, 28 Aug 2024 13:42:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240828134229epoutp03955f27d48b95c30ba610f616cb81c753~v6EFSOk3F0042700427epoutp03B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1724852549;
	bh=pupbnGfWeNRdoCnvuS0X6cju7U4buS/r8MZGN0NqYmw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=JZC8DrhkC8tdYS6Nz6CyX+s45Y7NminfGYX352iX8NlucjOlDg6mq/9q1+sOIk3qv
	 TLXLjCRmkNSKZa+SKRBhgn8nozeUCjms11x7piW+tIbLbKSCkCbrdS72auN5Gx1fU4
	 e5lbtCcxdF6F5ZvpnoULqTVpOzPj4XN0L1kqJW+A=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240828134228epcas5p3f510b3eab13dbc4bb4c2b55d9f96d65d~v6EErr3zP2724627246epcas5p36;
	Wed, 28 Aug 2024 13:42:28 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Wv5FH1hzKz4x9Pq; Wed, 28 Aug
	2024 13:42:27 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4C.0C.09642.3492FC66; Wed, 28 Aug 2024 22:42:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240828134226epcas5p3a5b9111def9d3467e80a9d0cc1db8c88~v6ECbszA72725527255epcas5p34;
	Wed, 28 Aug 2024 13:42:26 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240828134226epsmtrp1bb066930072ca3411f44ced6a1c38b64~v6ECbCfR_2641726417epsmtrp1V;
	Wed, 28 Aug 2024 13:42:26 +0000 (GMT)
X-AuditID: b6c32a4b-613ff700000025aa-83-66cf29434ec2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B0.DE.19367.2492FC66; Wed, 28 Aug 2024 22:42:26 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240828134224epsmtip1195ed1d55737a47d10223d8238267584~v6EAMBTNd1110811108epsmtip1b;
	Wed, 28 Aug 2024 13:42:23 +0000 (GMT)
Message-ID: <fe85a641-c974-3fa7-43f1-eacbb7834210@samsung.com>
Date: Wed, 28 Aug 2024 19:12:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 07/10] block: introduce BIP_CHECK_GUARD/REFTAG/APPTAG
 bip_flags
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, martin.petersen@oracle.com,
	asml.silence@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240824083553.GF8805@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEJsWRmVeSWpSXmKPExsWy7bCmuq6z5vk0g55PbBZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi0mHrjFabD+zlNli7y1ti/nLnrJbdF/fwWax/Pg/Jgce
	j52z7rJ7XD5b6rFpVSebx+Yl9R67bzaweXx8eovFo2/LKkaPzaerPT5vkgvgjMq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAG6V0mhLDGnFCgUkFhc
	rKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQndHTdYW1YD1r
	xZI/xQ2M01i6GDk5JARMJI6sWc/WxcjFISSwm1Hi5rQuRgjnE6PEtMWTmeGcHc+uscG0zFg7
	gxUisZNRouX0MVaQhJDAW0aJXX1WIDavgJ3EwolXwXawCKhK7L54kB0iLihxcuYTsLioQJLE
	r6tzGEFsYYEIiZ/XesDmMAuIS9x6Mp8JxBYRcJU49eAi2BXMAr8YJZZN7wNyODjYBDQlLkwu
	BanhFNCWWHRwAxNEr7zE9rdzwOolBI5wSHz5fIoV4moXiWmnfkPZwhKvjm9hh7ClJF72t0HZ
	2RIPHj2ABkyNxI7NfVD19hINf26wguxlBtq7fpc+xC4+id7fT5hAwhICvBIdbUIQ1YoS9yY9
	heoUl3g4YwmU7SHRdeoNOySobjFKrD0ZP4FRYRZSqMxC8v0sJN/MQli8gJFlFaNkakFxbnpq
	sWmBcV5qOTy6k/NzNzGCE7OW9w7GRw8+6B1iZOJgPMQowcGsJMJ74vjZNCHelMTKqtSi/Pii
	0pzU4kOMpsDomcgsJZqcD8wNeSXxhiaWBiZmZmYmlsZmhkrivK9b56YICaQnlqRmp6YWpBbB
	9DFxcEo1MNUpKHveSFurK3tPXlqNa7XEYcFoYatHl7L6dH48X7km/Wpgwbf9qyWTU3TluLf1
	t5zimiQnoC20s1Mu5ON8qVm2YYFnzjSYBnzieTort/qDyFK5GfO1LjFOkOB0vlbwO++j8MK6
	Kzaaa6d7/svboaxXNJVxucyD06wqojd9ladk/vq+eI45k0RKgozRnbSQuQx8Tf2zAr7PM9wt
	IdP5YVljg7N/yZyeGWq/hHjPLnJ4/DigYdlKYR2jJTFf3LpSrG5NeiTVfoiLi+NHiEyM1JG9
	YZ1lU843751V//eWxhGPd5PKxL7If649FM3h9Xj3A9b8RKGCGUrV51h8ZOd7SKwzF7rl2bv5
	qfJNpyhuJZbijERDLeai4kQAnNcDRVUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsWy7bCSnK6T5vk0g3uLRSyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFpMOXWO02H5mKbPF3lvaFvOXPWW36L6+g81i+fF/TA48
	Hjtn3WX3uHy21GPTqk42j81L6j1232xg8/j49BaLR9+WVYwem09Xe3zeJBfAGcVlk5Kak1mW
	WqRvl8CV0dN1hbVgPWvFkj/FDYzTWLoYOTkkBEwkZqydwdrFyMUhJLCdUWLni49MEAlxieZr
	P9ghbGGJlf+es0MUvWaU2HvhJStIglfATmLhxKtgk1gEVCV2XzzIDhEXlDg58wlYXFQgSWLP
	/UawocICERI/r/WA9TIDLbj1ZD5YXETAVeLUg4vMIAuYBX4xSry62AK17RajxKXdn4GqODjY
	BDQlLkwuBWngFNCWWHRwAxPEIDOJrq1djBC2vMT2t3OYJzAKzUJyxywk+2YhaZmFpGUBI8sq
	RtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjOAI1Arawbhs/V+9Q4xMHIyHGCU4mJVEeE8cP5sm
	xJuSWFmVWpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwLT72d5rU5lZ
	PDb6qLb3yIjFtfxU7t/zfd4y02kfDj446bSv5X3kZg6toGD1Tv5v5SeMb0isfuq/3Spl6het
	NXf3tH4qWj6l/3a0zgN34zxvUd3gCtnpz+5rH+S4LbbnQ9gPFtayQ/0CibJh1i88TJe4O9s1
	Wp3dHzux7IVwy+tU3tqqzyv+c7Y++56WGTHJktNL623KljVrawTOLdq8O+qtaKdPTXW3v33Z
	9s0X1x2IlQ07mPDrzIajP9c0Loj+kcBwSLC5f/e98nNcV0707Lti7fKqMvq924JblmEKKyM8
	Vt9ZqxT3/FDDytdclw/v/rVI/YMn/+u7XEeesDEqh3jv5vO+cWTN0QChIL131d+VWIozEg21
	mIuKEwHirIN/LwMAAA==
X-CMS-MailID: 20240828134226epcas5p3a5b9111def9d3467e80a9d0cc1db8c88
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8
References: <20240823103811.2421-1-anuj20.g@samsung.com>
	<CGME20240823104629epcas5p3fea0cb7e66b0446ddacf7648c08c3ba8@epcas5p3.samsung.com>
	<20240823103811.2421-8-anuj20.g@samsung.com> <20240824083553.GF8805@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_144244_206646_E3E0CDA1 
X-CRM114-Status: GOOD (  11.76  )
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

On 8/24/2024 2:05 PM, Christoph Hellwig wrote:
> How do we communicate what flags can be combined to the upper layer
> and userspace given the SCSI limitations here?

Will adding a new read-only sysfs attribute (under the group [*]) that 
publishes all valid combinations be fine?

With Guard/Reftag/Apptag, we get 6 combinations.
For NVMe, all can be valid. For SCSI, maximum 4 can be valid. And we 
factor the pi-type in while listing what all is valid.
For example: 010 or 001 is not valid for SCSI and should not be shown by 
this.

[*]
const struct attribute_group blk_integrity_attr_group = {
          .name = "integrity",
          .attrs = integrity_attrs,
};

