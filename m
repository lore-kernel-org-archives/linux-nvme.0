Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DE51C54EE9
	for <linux-nvme@archiver.kernel.org>; Sun, 25 Sep 2022 17:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wn3owIiRrqebeRrpClsxxYrDbcdT5MbtOFOfzqNQPnw=; b=lvHLsTuPpG/gg0RxnQWo7FuhDs
	RKkbNWqJRa1eh6u9N8EsIcUJPZLLs2JwtqiRoFkS9xARrKl6Hep3tlaEzvI+ra3V2FDhhWjWdGmpt
	F3jQL8JC85LOoTMOM3Ny7XXOyB0oD9J4j6uqinnTcj2pwUPofVOdQmFWoWaNDZHgY8gCBW96Fwox+
	1ZzkP7Jp9Q0Ex7kC0w8/L4TI50r3PM1Agn0StuFe3qzCqVBf79DVf7AgIZgnjSV3fwqTP47FqPPLm
	LvQ4C8ffKCOQzmEo1SzWWMp0oUT8nVBKb+Y+6LE1Oy2xIzCXe+3iWMDGiddL6D9rw0/Zch+Qgdlkk
	M6uKrVmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocVlO-00FQsX-PW; Sun, 25 Sep 2022 17:49:58 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocVlH-00FQoT-If
	for linux-nvme@lists.infradead.org; Sun, 25 Sep 2022 17:49:54 +0000
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220925174941epoutp02dcacd60f00359238c6d4ed66f2d4d5a7~YK8Om3j5v0987009870epoutp02R
	for <linux-nvme@lists.infradead.org>; Sun, 25 Sep 2022 17:49:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220925174941epoutp02dcacd60f00359238c6d4ed66f2d4d5a7~YK8Om3j5v0987009870epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664128181;
	bh=Wn3owIiRrqebeRrpClsxxYrDbcdT5MbtOFOfzqNQPnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ep7jtY01eNtC/NlsNBq1rkWW5xsUEq0pPzuDtLkuTwwWV3QXN5nCwxeyMr/eSd0xq
	 7JtWf28X2eToOlFF1evEZX8In4NM63IGmPW8nMW0WzTvHeLiEdgKhPZ5Nl1/8No46d
	 XjYO10kgK6zFmTj3QHjjGKmCcUYVptM0qHp5AiZ8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20220925174941epcas5p16ddbe4ce0eb43b47c8a4fdad45aad854~YK8OFq1I90920509205epcas5p1j;
	Sun, 25 Sep 2022 17:49:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4MbD0y1WJzz4x9Pt; Sun, 25 Sep
	2022 17:49:38 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0D.0C.39477.2B490336; Mon, 26 Sep 2022 02:49:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220925174937epcas5p2de3e7d6080cd7d5736228005dd268903~YK8KtZ9Wr1572915729epcas5p2S;
	Sun, 25 Sep 2022 17:49:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220925174937epsmtrp1078da0d05e35334a39e05db32cafe0df~YK8KstZ_32542125421epsmtrp1W;
	Sun, 25 Sep 2022 17:49:37 +0000 (GMT)
X-AuditID: b6c32a4a-007ff70000019a35-19-633094b2de2c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E3.8E.14392.1B490336; Mon, 26 Sep 2022 02:49:37 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220925174935epsmtip2c85d43416dd44e493cc28efc37c99e5a~YK8JCNqZq2983429834epsmtip2d;
	Sun, 25 Sep 2022 17:49:35 +0000 (GMT)
Date: Sun, 25 Sep 2022 23:09:47 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com
Subject: Re: [PATCH for-next v8 3/5] nvme: refactor nvme_alloc_user_request
Message-ID: <20220925173947.GA6320@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220923153819.GC21275@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmpu6mKQbJBje+c1isvtvPZnHzwE4m
	i5WrjzJZvGs9x2Ix6dA1Rou9t7Qt5i97yu7A7nH5bKnHplWdbB6bl9R77L7ZwObRt2UVo8fn
	TXIBbFHZNhmpiSmpRQqpecn5KZl56bZK3sHxzvGmZgaGuoaWFuZKCnmJuam2Si4+AbpumTlA
	hygplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1JyCkwK9IoTc4tL89L18lJLrAwNDIxM
	gQoTsjM671xmK5jBW3G6ZQt7A+Nzri5GTg4JAROJnfMWs4LYQgK7GSUOPtfrYuQCsj8xStxf
	3c4M4XxjlFiyYAsbTMeya79ZIRJ7GSVu3F4OVfWMUeLF6gdADgcHi4CqxOR30SAmm4CmxIXJ
	pSC9IgJKEk9fnWUEKWcWmM4osff1HiaQhLCAt8SceVvYQWxeAR2JT0ePsELYghInZz5hAbE5
	geLf3jwAqxEVUJY4sO04E8ggCYFGDolfK1pYIK5zkfhx9SaULSzx6jjEUAkBKYmX/W1QdrLE
	pZnnmCDsEonHew5C2fYSraf6mUFsZoF0iZsvF7BD2HwSvb+fMIE8IyHAK9HRJgRRrihxb9JT
	VghbXOLhjCVQtofEvdVvoAF0k1Fi6f2trBMY5WYh+WcWkhUQtpVE54cm1llAK5gFpCWW/+OA
	MDUl1u/SX8DIuopRMrWgODc9tdi0wCgvtRwex8n5uZsYwUlTy2sH48MHH/QOMTJxMB5ilOBg
	VhLhTbmomyzEm5JYWZValB9fVJqTWnyI0RQYPROZpUST84FpO68k3tDE0sDEzMzMxNLYzFBJ
	nHfxDK1kIYH0xJLU7NTUgtQimD4mDk6pBqZyQdkqhTk8p0x2REnbCbr5RuRfSJaXYdv96fwx
	nVU+htuznhZr3rq4Muye/Jw/rpH/j9yVm3fxwZp1u74+Y1z0925HcgXDbt+or0LK8r/u2Csv
	kbr5V4QpYfKV/tMaER0GL5wqtks9u39Y84C2rHKWtnBHTI2wdOVnzcCNdadjy8teHHZSORFX
	Pfdt9ATVo3Mts171BQsFPQ5x/fiSRysnaMfJow3zNJgOsLDfLnxgq7/+5KFJ81tL459MUV13
	5mvFy9NR8p195vKr4u4k7X1weH6h7Dv3jtysFxX1h9PKl0zxL7uguOOA1oYN09Zk+LwI4DJR
	mzNnQ6resk6fQ6bue36dXLRJPS5p9ufeO7+VWIozEg21mIuKEwHtNHBvIwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvO7GKQbJBt+miFusvtvPZnHzwE4m
	i5WrjzJZvGs9x2Ix6dA1Rou9t7Qt5i97yu7A7nH5bKnHplWdbB6bl9R77L7ZwObRt2UVo8fn
	TXIBbFFcNimpOZllqUX6dglcGWuW/2QpOMtV8ebgTqYGxm0cXYycHBICJhLLrv1m7WLk4hAS
	2M0ocf7QciaIhLhE87Uf7BC2sMTKf8/ZIYqeMEos//kPqIODg0VAVWLyu2gQk01AU+LC5FKQ
	chEBJYmnr84ygpQzC0xnlNj7eg/YTGEBb4k587aAzeQV0JH4dPQI1OLbjBJnvs5ihkgISpyc
	+YQFxGYWMJOYt/khM8gCZgFpieX/wI7mBOr99uYB2BxRAWWJA9uOM01gFJyFpHsWku5ZCN0L
	GJlXMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEx4GW5g7G7as+6B1iZOJgPMQowcGs
	JMKbclE3WYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYm
	FTmNp4KnZz403NHLZipauCjph+2yZ4FZCft3u+1ok+G5/GSdz88lQsF7Zmpq5pRNrZjXsGdC
	UWq5o/r/ibVOur/UxTuK8oPn/lUKU5+Tap2oot7LHBa7YoJvy5nvDXlPGGPPK0tNZ7a5H2Sw
	3r22ckVk/ftalQj/fW1u0uvsdp52v/Oux+jeQac1ErOitt6WtW9rtkxK0bz9TjZauydf5Uhy
	6NN3ggc0LrrvzglntdXeYid2z6mnf6nDlyWLb0YwGO5/8WWC+2332UILNSfxLHR6uuj5jveG
	e85GJETeq/C4zH3tX+6ZxFeMtT6Okxx+1t+X+7JTM+HgsvkhZ7ov3c+oPfaEszT4tWn7zBtK
	LMUZiYZazEXFiQBV4c8h8gIAAA==
X-CMS-MailID: 20220925174937epcas5p2de3e7d6080cd7d5736228005dd268903
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----vvYgYHrBmeYkJOpSn.dge_kBrYmc10ewv9PqSf1ctZwbMX08=_b6f0_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220923093916epcas5p387fdd905413f6d90babecf5d14da5b67
References: <20220923092854.5116-1-joshi.k@samsung.com>
	<CGME20220923093916epcas5p387fdd905413f6d90babecf5d14da5b67@epcas5p3.samsung.com>
	<20220923092854.5116-4-joshi.k@samsung.com> <20220923153819.GC21275@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220925_104953_020630_BCAA7CBF 
X-CRM114-Status: GOOD (  18.28  )
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

------vvYgYHrBmeYkJOpSn.dge_kBrYmc10ewv9PqSf1ctZwbMX08=_b6f0_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Sep 23, 2022 at 05:38:19PM +0200, Christoph Hellwig wrote:
>
>> +	else {
>> +		struct iovec fast_iov[UIO_FASTIOV];
>> +		struct iovec *iov = fast_iov;
>> +		struct iov_iter iter;
>> +
>> +		ret = import_iovec(rq_data_dir(req), ubuffer, bufflen,
>> +				UIO_FASTIOV, &iov, &iter);
>> +		if (ret < 0)
>>  			goto out;
>> +		ret = blk_rq_map_user_iov(q, req, NULL, &iter, GFP_KERNEL);
>> +		kfree(iov);
>> +	}
>
>While you touch this:  I think thi block of code would also be a good
>separate helper.  Maybe even in the block layer given the the scsi
>ioctl code and sg duplicate it, and already missed the fast_iov
>treatment due to the duplication.  Having this in a separate function
>is also nice to keep the fast_iov stack footprint isolated.

Totally agree on goodness. 
I think instead of new helper this seems suited to go inside
blk_rq_map_user_iov itself. That will make it symmetric to
blk_rq_map_user which also combines import + mapping.

But if I go that route now, I will have to alter parameters of
blk_rq_map_user_iov, and that will make it mandatory to change the
callers (scsi-ioctl, sg) too. Nothing hairy, but that means further
growth of unrelated elements in this series. Hope you agree that
separate series is much better, which I will post after this.

Will fold all other changes you pointed.

------vvYgYHrBmeYkJOpSn.dge_kBrYmc10ewv9PqSf1ctZwbMX08=_b6f0_
Content-Type: text/plain; charset="utf-8"


------vvYgYHrBmeYkJOpSn.dge_kBrYmc10ewv9PqSf1ctZwbMX08=_b6f0_--

