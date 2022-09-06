Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87094C38145
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mXtYey9BOEe5meXH32KaatPnqUaXnW09cu8qczFDkDo=; b=MwRR+4S2+fAs9iCF8UrI/eYaLX
	sjGOPjKLNA3ecL+TsXYArRKAZ4aSAjdXPaLIfHPbhNGhNpSblzHflAP1iLRwqUUgHog/uVr8Rk+Uj
	Vvcm6s2mhxp0ipKW+C+IfUU+uXUlrYjz2cXV8b/Q2Q7XjfkdYpQsGdopqXxO1MXmkhrsjYBWSDj3N
	zPvGxWOa3442WbORey5YdHPjBw+QrPTmFxpXtlqRt6ZM20tDxSTHx+pVr2FgF5iXX2RXLgThamxaQ
	nQXVU7sthn8D4NDtc1cWyO1m9TWx/1F+tX72zEZyhCJ9NcCXgNaah8AwOLeiwgaqczdqRXg0n1XI5
	8nIfv9eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSWv-00AbKJ-Nt; Tue, 06 Sep 2022 06:57:53 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSWs-00AbEa-DG
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:57:52 +0000
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220906065738epoutp023551c193f2202176d2e0cebcccb5cc72~SMyfcLMNQ2651226512epoutp02U
	for <linux-nvme@lists.infradead.org>; Tue,  6 Sep 2022 06:57:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220906065738epoutp023551c193f2202176d2e0cebcccb5cc72~SMyfcLMNQ2651226512epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662447458;
	bh=mXtYey9BOEe5meXH32KaatPnqUaXnW09cu8qczFDkDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m50SVdIWBZJy2Fu2A0Q9ET0UAlV4AxW/ZymI1ovqlCoLhvFa7P0/PMJazU28eta9n
	 irkzuqAa04yggvQUWTyW4P8M6SR67u7ncO1FSjjp9OP6xFYIf8CCJeyl/BgLCXTaP9
	 dAYC1Q2YEk9CuA9iFbCd2j7w7JcBsfU7XGYjFfAQ=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20220906065738epcas5p427593c0a86c7d9364be297853b9f97df~SMyfI3V7F0623406234epcas5p4P;
	Tue,  6 Sep 2022 06:57:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4MMGRM4s3Cz4x9QD; Tue,  6 Sep
	2022 06:57:35 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	13.58.53458.A5FE6136; Tue,  6 Sep 2022 15:57:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20220906065730epcas5p3156f8ce73a64434da190d0ce686ac2ea~SMyX9sZcZ1813218132epcas5p3E;
	Tue,  6 Sep 2022 06:57:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220906065730epsmtrp26ab3fbe6c5bd47e4901908e41793478c~SMyX8uV522471624716epsmtrp2o;
	Tue,  6 Sep 2022 06:57:30 +0000 (GMT)
X-AuditID: b6c32a4a-caffb7000000d0d2-f6-6316ef5a4055
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A1.C7.14392.A5FE6136; Tue,  6 Sep 2022 15:57:30 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20220906065728epsmtip1e2f77be2882ae7b80d66ad6fbd6fee07~SMyVzFD3k1609616096epsmtip1W;
	Tue,  6 Sep 2022 06:57:28 +0000 (GMT)
Date: Tue, 6 Sep 2022 12:17:45 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v4 3/4] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220906064745.GB27127@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220906063329.GA27127@test-zns>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDJsWRmVeSWpSXmKPExsWy7bCmpm70e7Fkg1dnWCyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFpMOXWO02HtL22L+sqfsDpweO2fdZfe4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZD9a8YSqYwlPRecS2gXEFVxcjJ4eEgIlEw4pDzCC2kMBu
	RonWD0BxLiD7E6PEk6a1bBDON0aJ68efs8B0zFjcwgqR2MsosWpWHxOE84xRYuGGT4wgVSwC
	KhJ3tpwE6uDgYBPQlLgwuRQkLCKgJPH01VlGkHpmgStAK7rWMYEkhAViJf71HgWzeQV0JZ7v
	3MkKYQtKnJz5BGwzp4CexNxpr9lAbFEBZYkD246DLZYQmMshsfNlIxvIMgkBF4mvZzQhLhWW
	eHV8CzuELSXx+d1eNgg7WeLSzHNMEHaJxOM9B6Fse4nWU/3MIGOYBTIkLj3IAQkzC/BJ9P5+
	wgQxnVeio00IolpR4t6kp6wQtrjEwxlLoGwPibNNG9ghQfKHUWLP0ntMExjlZiH5ZhbChllg
	G6wkOj80sUKEpSWW/+OAMDUl1u/SX8DIuopRMrWgODc9tdi0wCgvtRwewcn5uZsYwclUy2sH
	48MHH/QOMTJxMB5ilOBgVhLhTdkhkizEm5JYWZValB9fVJqTWnyI0RQYOROZpUST84HpPK8k
	3tDE0sDEzMzMxNLYzFBJnHeKNmOykEB6YklqdmpqQWoRTB8TB6dUA1NoxNdZW/9vnhL8cK2j
	15/SA7wzNsX039387OOVPfJre3quH9ySOd+V61E6t+3VPW2b9oUt/Jf1z+Wch2jhuqUMylwS
	lR6brj/3jPlyvdMia27QkZRpFzxtrHW2hQnzyP6RO8+6d2mBf+1G6/X/GfnX/ugv65m1W/zS
	Dd0ZX4Vfvfgiyv7hfmK4jFnqUi3ppHK+BfMF1ky98TXjHOObzSKe+ic3THt0zff+5BvVzfv7
	2ibNSo740Xbj2sOvr5+vlsqYf232qiRxjp7/j5qXbpnCMX1v2/HrATXidzVyTnhURBuaCQuJ
	fdVd1zbF7dmuRRm357bsnK18cYPVHKbGJXIs135cfNixSaDlMvNOV5sPIUosxRmJhlrMRcWJ
	ACS53jUvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHLMWRmVeSWpSXmKPExsWy7bCSnG7Ue7Fkg1WdyhZNE/4yW8xZtY3R
	YvXdfjaLmwd2MlmsXH2UyeJd6zkWi0mHrjFa7L2lbTF/2VN2B06PnbPusntcPlvqsWlVJ5vH
	5iX1HrtvNrB59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8amfSeZC45xVvyf/oO9gfELexcj
	J4eEgInEjMUtrF2MXBxCArsZJf73n2CESIhLNF/7AVUkLLHy33MwW0jgCaPEoheuIDaLgIrE
	nS0nWboYOTjYBDQlLkwuBQmLCChJPH11lhFkJrPAFUaJP/uXsIIkhAViJf71HmUCsXkFdCWe
	79wJtfgfo8SGd9PZIBKCEidnPmEBsZkFzCTmbX7IDLKAWUBaYvk/DpAwp4CexNxpr8HKRQWU
	JQ5sO840gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERwl
	Wpo7GLev+qB3iJGJg/EQowQHs5IIb8oOkWQh3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYL
	CaQnlqRmp6YWpBbBZJk4OKUamPoW1Ytfr8p4u/+9uYKIopOd7Nknd2U1Xn7um7nH6MSc145C
	ok/fC3yZWi3yp0nx7XJvpceVvb/bp16KvOvO3dnlwJWfYX6JM8bilUKr7zmmiLLumv3rVC22
	sMy6wtjsEVelVHzy/uKfSffrei7+W6L8Jf+sfNC+1p1dZZvZ9ny7e+DIyYfV4suqFFcdu29Z
	9K/40v1dV90Pyzf9/lt+zPaRenej0QyvY7zym7hZMk7tKvQQ4FPQOzdBdXaTeZ/DtRXz1x+d
	MuuXfYZIaWevMvONlI6vCe4L+BuWaKaqf/y22plvKfvcCXN6vVbtP3FU7ej1PX9k5jbGrJ2m
	7hz9ZY+AyJGt/WsPc/Zd/7tM5LQSS3FGoqEWc1FxIgCkF7MGAQMAAA==
X-CMS-MailID: 20220906065730epcas5p3156f8ce73a64434da190d0ce686ac2ea
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----pcQIgMQ_HVXS4qWPbWHvSbnTt3jWAgM.sCJInyI3qCVu2Rgf=_5165d_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1
References: <20220905134833.6387-1-joshi.k@samsung.com>
	<CGME20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1@epcas5p3.samsung.com>
	<20220905134833.6387-4-joshi.k@samsung.com> <20220906062522.GA1566@lst.de>
	<20220906063329.GA27127@test-zns>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_235750_877341_EEE6D3A3 
X-CRM114-Status: GOOD (  13.38  )
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

------pcQIgMQ_HVXS4qWPbWHvSbnTt3jWAgM.sCJInyI3qCVu2Rgf=_5165d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Sep 06, 2022 at 12:03:29PM +0530, Kanchan Joshi wrote:
>On Tue, Sep 06, 2022 at 08:25:22AM +0200, Christoph Hellwig wrote:
>>On Mon, Sep 05, 2022 at 07:18:32PM +0530, Kanchan Joshi wrote:
>>>+static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>>> 		gfp_t gfp_mask)
>>> {
>>>@@ -259,13 +252,31 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>> 		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
>>> 					&fs_bio_set);
>>> 		if (!bio)
>>>-			return -ENOMEM;
>>>+			return NULL;
>>
>>This context looks weird?  That bio_alloc_bioset should not be there,
>>as biosets are only used for file system I/O, which this is not.
>
>if you think it's a deal-breaker, maybe I can add a new bioset in nvme and
>pass that as argument to this helper. Would you prefer that over the
>current approach.

seems I responded without looking carefully. The bioset addition is not
part of this series. It got added earlier [1] [2], as part of optimizing
polled-io on file/passthru path.

[1] https://lore.kernel.org/linux-block/20220806152004.382170-3-axboe@kernel.dk/
[2] https://lore.kernel.org/linux-block/f2863702-e54c-cd74-efcf-8cb238be1a7c@kernel.dk/

------pcQIgMQ_HVXS4qWPbWHvSbnTt3jWAgM.sCJInyI3qCVu2Rgf=_5165d_
Content-Type: text/plain; charset="utf-8"


------pcQIgMQ_HVXS4qWPbWHvSbnTt3jWAgM.sCJInyI3qCVu2Rgf=_5165d_--

