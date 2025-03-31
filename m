Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77C6C36017
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 06:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cU8ZjDVrKVfX1VkxH+yC4pcYzBmbmHhNz0/QzzT4Zv0=; b=zgDYoxecM1JYXIE5pbn5zK7KKW
	D6H/NfKtjY2ftUFLpJMTGyk8y3Om5eM41W7/aQnzkEhiI6jUFUeMI89cn2LrVqB8w/cxQzZeHN4JH
	kmdYg7H8RBLopLvWBrwRa2PbO11WwJwvdGBOp9qGPTqryJhAZOzIiD7xbeyvmI4m65ZUTj7V5PjX6
	IRmkT+KdPLFbeiB5IWFE13n9t9V0qbIWlslimNV9hmo23rrMWpWmMcbq3sogJE6c4pQ8ScZ0Ag9ET
	shgTfa1bM+Zz3792i3O8jG+eU21+RnkwTBc411dDETTEptUBcayaLRtf8ChztDX3S7fFixx2nSGgQ
	NdpTNN8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz8wG-0000000H8AD-2jcG;
	Mon, 31 Mar 2025 06:48:04 +0000
Received: from [203.254.224.33] (helo=mailout3.samsung.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tz8w8-0000000H89C-3zvi
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 06:48:03 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250331064747epoutp03fab863a613ed64916d8d67d6fa68c547~x0GYWsPVy3094930949epoutp03W
	for <linux-nvme@lists.infradead.org>; Mon, 31 Mar 2025 06:47:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250331064747epoutp03fab863a613ed64916d8d67d6fa68c547~x0GYWsPVy3094930949epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743403667;
	bh=cU8ZjDVrKVfX1VkxH+yC4pcYzBmbmHhNz0/QzzT4Zv0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=kHChQPbcsF45GT5LLZpQlRbjmJes60WLD21uxwms0+WVdQdth0pNzxOxJZaateGvL
	 vzvGxW5SyrxJVtOsi1pMr+1VRBiTLS7hZU8re5ovj/MICKn4QqJmSTeeVAXW0Es8oY
	 6rq4SzYL86RgWU8dsLLj4EyHOe7/GYuR7X0iL5ZY=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20250331064747epcas5p1c73b9c47280486dbd3e073f578e6101f~x0GYHtvUm1024410244epcas5p1y;
	Mon, 31 Mar 2025 06:47:47 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4ZR1sY1SMPz3hhTF; Mon, 31 Mar
	2025 06:47:45 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5F.73.10173.19A3AE76; Mon, 31 Mar 2025 15:47:45 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250331064744epcas5p246d4fb167638e93fa07f8d79f4894d42~x0GVl0icP1265112651epcas5p2j;
	Mon, 31 Mar 2025 06:47:44 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250331064744epsmtrp2f15506c5e0a78f1f1b527bede2f89b9c~x0GVk6n2f1429014290epsmtrp2r;
	Mon, 31 Mar 2025 06:47:44 +0000 (GMT)
X-AuditID: b6c32a44-8c1fc700000027bd-83-67ea3a91be53
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	D0.74.08766.09A3AE76; Mon, 31 Mar 2025 15:47:44 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250331064743epsmtip1738065b18eb9877c45e9f5459f18a1cf~x0GUF5CfA1389113891epsmtip1U;
	Mon, 31 Mar 2025 06:47:42 +0000 (GMT)
Message-ID: <48b9a876-0e3b-4c89-9aa3-b48f502868c3@samsung.com>
Date: Mon, 31 Mar 2025 12:16:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme/ioctl: move fixed buffer lookup to
 nvme_uring_cmd_io()
To: Caleb Sander Mateos <csander@purestorage.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov
	<asml.silence@gmail.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20250328154647.2590171-4-csander@purestorage.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNJsWRmVeSWpSXmKPExsWy7bCmlu5Eq1fpBpv/sFrMWbWN0WL13X42
	i/8L57JarFx9lMniXes5FotJh64xWjy9OovJ4vKuOWwW85c9ZbdY9/o9iwOXx85Zd9k9zt/b
	yOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js1j28Nedo/Pm+QCOKOybTJSE1NSixRS85LzUzLz
	0m2VvIPjneNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOA7lRSKEvMKQUKBSQWFyvp29kU5ZeW
	pCpk5BeX2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGfc+KVc8IitovXmTLYGxlOs
	XYwcHBICJhLXlwl3MXJxCAnsZpRYv+0YG4TziVFi+uQZTBDON0aJrxfesncxcoJ1bJx+gBEi
	sZdR4sDDFWAJIYG3jBKbluqB2LwCdhLnth1lA7FZBFQlds6HaOYVEJQ4OfMJC4gtKiAvcf/W
	DLC4sECkRE/3RrChIgIPGSW6lm1hAXGYBRoZJVZuhJjELCAucevJfCaQw9kENCUuTC4FCXMK
	2Eu8Xt3IAlEiL7H97RxmkF4JgQMcEp9+b2OFONtFYtbvuVC2sMSr41ug3pGS+PxuLxuEnS3x
	4NEDFgi7RmLH5j6oenuJhj83wAHGDLR3/S59iF18Er2/nzBBwpFXoqNNCKJaUeLepKdQneIS
	D2csgbI9JG72PmOBBNxxRolph/azTmBUmIUULrOQfDkLyTuzEDYvYGRZxSiZWlCcm56abFpg
	mJdaDo/v5PzcTYzgVKzlsoPxxvx/eocYmTgYDzFKcDArifBGfH2ZLsSbklhZlVqUH19UmpNa
	fIjRFBhBE5mlRJPzgdkgryTe0MTSwMTMzMzE0tjMUEmct3lnS7qQQHpiSWp2ampBahFMHxMH
	p1QDk+Y/hXN7o17seW9XeJbL0XDrIbMpzO9yvMpuqu6VnL70+A4V2/L3534uPe3d8HUL98Ky
	1/+1dMtVzTz+ML38qyu09dGD/du/vmB4fLjqR++GBIajma82xV6dNTXI1urmi/7jT1ctbFEq
	darxPN1/zuFIckfZ9NiLSu1TEqdr5L1oLNtleV3Onf+Sa4Gfm3Fp4hypxbyV91T/XarOk+Wr
	OrDsepLwzQr5ckH/3L3vvzQedL0kyJk+/+1RtczvlRFvZgV+eujP6nqB9VKw1yaG93XpppvM
	d9y6XeNVs3fXsdulR+yZZjhJvrRL/vD9ecX1sqDi/Znv/1xkEuK+wdOfqPX2qf6TdNs/5595
	TdjIJKPEUpyRaKjFXFScCAAaGeHyTgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnO4Eq1fpBv/Wq1jMWbWN0WL13X42
	i/8L57JarFx9lMniXes5FotJh64xWjy9OovJ4vKuOWwW85c9ZbdY9/o9iwOXx85Zd9k9zt/b
	yOJx+Wypx6ZVnWwem5fUe+y+2cDm0dv8js1j28Nedo/Pm+QCOKO4bFJSczLLUov07RK4Mm78
	Ui54xFbRenMmWwPjKdYuRk4OCQETiY3TDzB2MXJxCAnsZpS4197HDJEQl2i+9oMdwhaWWPnv
	OTtE0WtGiY7+m4wgCV4BO4lz246ygdgsAqoSO+e/ZYeIC0qcnPmEBcQWFZCXuH9rBlhcWCBS
	oqd7I1iviMBDRonlX/hBhjILNDJKzN4J0gCy4TijxNYrEB3MQGfcejKfqYuRg4NNQFPiwuRS
	kDCngL3E69WNLBAlZhJdW7sYIWx5ie1v5zBPYBSaheSOWUgmzULSMgtJywJGllWMkqkFxbnp
	ucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMGRp6W5g3H7qg96hxiZOBgPMUpwMCuJ8EZ8fZkuxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnFf8RW+KkEB6YklqdmpqQWoRTJaJg1OqgWml09Q+hnLXJeYc
	X9dqn91VJTyxcYLSWpUVvMdF/ld+1crnTM23KF1zYtrXuvPCL/XaLZcbyS5baFcSmHT2j/Oi
	l35C2gETk7Xnpq3ecoH5Q1jR4ZCQ1B92Nnk3jI3tr2gt7vYN6GZf5Vn6oSQ9Z9mNDivtXqlb
	C7ZM/fDKcve50hvMvNK3ffY/tHvzmvfr/B/C542/nX3X57UySWvv3pf6/+5wfppl11X54/rE
	nb+XtVQnlgoEbY78/Li0fa7kPV+3gwsVs2829Pn9vvb6lTcLq278vAyxaY8Kdsqs3cA2dUaV
	DrP3Vo9VXHOrf6zg/GriYvHpYUVqYqtwm/SF6Y/3TpbVt3+mtP1k6JYdve1KLMUZiYZazEXF
	iQDQ+iznKwMAAA==
X-CMS-MailID: 20250331064744epcas5p246d4fb167638e93fa07f8d79f4894d42
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250328155548epcas5p2368eb1a59883b133a9baf4ac39d6bac6
References: <20250328154647.2590171-1-csander@purestorage.com>
	<CGME20250328155548epcas5p2368eb1a59883b133a9baf4ac39d6bac6@epcas5p2.samsung.com>
	<20250328154647.2590171-4-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250330_234757_636336_4246CDC8 
X-CRM114-Status: GOOD (  15.64  )
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

On 3/28/2025 9:16 PM, Caleb Sander Mateos wrote:
> For NVMe passthru operations with fixed buffers, the fixed buffer lookup
> happens in io_uring_cmd_import_fixed(). But nvme_uring_cmd_io() can
> return -EAGAIN first from nvme_alloc_user_request() if all tags in the
> tag set are in use. This ordering difference is observable when using
> UBLK_U_IO_{,UN}REGISTER_IO_BUF SQEs to modify the fixed buffer table. If
> the NVMe passthru operation is followed by UBLK_U_IO_UNREGISTER_IO_BUF
> to unregister the fixed buffer and the NVMe passthru goes async, the
> fixed buffer lookup will fail because it happens after the unregister.

while the patch looks fine, I wonder what setup is required to 
trigger/test this. Given that io_uring NVMe passthru is on the char 
device node, and ublk does not take char device as the backing file. 
Care to explain?

