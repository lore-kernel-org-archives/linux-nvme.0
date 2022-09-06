Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1FB6ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tFz/u5eudbZmuZ5IBaxyO4rRD70ftNseSzcgxZbVS9g=; b=ddEZATPKXJACjU+H9LOCSZYztm
	ISoE5B8JXEziSK8ycnB+1STfeaVCN9Sa4JArDsAb4OVkCSGFk41rcA1dT/SguioOCnoJ5jT2DOEPw
	I608gauCWxNX1zcIy7UMZgTY5O9K4+YfX0URNiKwyMyg1VrphPFIifP/4XF3cjjDIikJcr8J3PT9C
	WtZeysDsYjmYDJpX8OTHvk9tMfzzCOe+eWrFYtRhfedWck6r8hf/mOu1/aYnVqUZCUMv3BjyGhnXv
	44nEsLZwIP1YQVEzBKFdJJlhEFzTBW0+d9++IS0RZ/rdp+bVSE1J6snpx5pWnT7Nrd/3RqaKZ5uLQ
	+CiYoQ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSJ7-00AVxi-I4; Tue, 06 Sep 2022 06:43:37 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSIv-00AVsm-6q
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:43:27 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220906064321epoutp01c44ed6040df02f73c6e55d1e44cb1e04~SMmA6d80q1356613566epoutp010
	for <linux-nvme@lists.infradead.org>; Tue,  6 Sep 2022 06:43:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220906064321epoutp01c44ed6040df02f73c6e55d1e44cb1e04~SMmA6d80q1356613566epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1662446601;
	bh=tFz/u5eudbZmuZ5IBaxyO4rRD70ftNseSzcgxZbVS9g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XIKdto73uFRHs0DdDLEbWuP9AxVTfM8Reov9BZBQTkDLOM610xBvJBbn4Wh2vH7h7
	 o4eVmD2B1pmF8fe2KId2EGIhRh3SusgbuxnwOjWhrYO2dT172I+Al5u6VoYP8UqVlV
	 9ajYynq5bIZH+5QKTQZ1R2/ANG19Dn6VBSPziU94=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20220906064320epcas5p3ff78d71fd03d582b045d49aff86e2393~SMmAeGw5Y1445614456epcas5p3h;
	Tue,  6 Sep 2022 06:43:20 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4MMG6t3gkkz4x9QG; Tue,  6 Sep
	2022 06:43:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	DC.5E.54060.20CE6136; Tue,  6 Sep 2022 15:43:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20220906064314epcas5p20f26e7075aea4c6067281c10a0abac33~SMl6t1RdL2836928369epcas5p2F;
	Tue,  6 Sep 2022 06:43:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20220906064314epsmtrp2998aee2f5b5ce079df0dc0b7559b2101~SMl6sxNrq1725217252epsmtrp2N;
	Tue,  6 Sep 2022 06:43:14 +0000 (GMT)
X-AuditID: b6c32a4b-3f15ba800000d32c-d8-6316ec02bcb5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.16.14392.20CE6136; Tue,  6 Sep 2022 15:43:14 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20220906064313epsmtip25a40853d01ff441856eb237c0014d67f~SMl5OnhhP0041800418epsmtip2D;
	Tue,  6 Sep 2022 06:43:12 +0000 (GMT)
Date: Tue, 6 Sep 2022 12:03:29 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v4 3/4] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220906063329.GA27127@test-zns>
MIME-Version: 1.0
In-Reply-To: <20220906062522.GA1566@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmui7TG7Fkg79LrS2aJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFpMOXWO02HtL22L+sqfsDpweO2fdZfe4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5APaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtz
	JYW8xNxUWyUXnwBdt8wcoLuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrF
	ibnFpXnpenmpJVaGBgZGpkCFCdkZxy5NYSp4zlEx/cdBxgbGFexdjBwcEgImEktm1XQxcnEI
	CexmlGid9YS5i5ETyPnEKHHjpB+E/Y1R4sXtYBAbpL55+jpWiIa9jBI3f79ggnCeMUpseNfO
	AjKVRUBFovWeN4jJJqApcWFyKUiviICSxNNXZxlBypkFrjBKPOlaxwSSEBaIlfjXexTM5hXQ
	lbg6+TA7hC0ocXLmExYQm1NAW+LN3ImMILaogLLEgW3HwfZKCMzlkNh5Zx4bxHUuEvOmvWSF
	sIUlXh3fwg5hS0l8frcXqiZZ4tLMc0wQdonE4z0HoWx7idZT/WDfMwtkSHS1nmaDsPkken8/
	YYKEFq9ER5sQRLmixL1JT6FWiUs8nLEEyvaQONu0gR0SJjcYJdr//GSbwCg3C8k/s5CsgLCt
	JDo/NLHOAlrBLCAtsfwfB4SpKbF+l/4CRtZVjJKpBcW56anFpgXGeanl8BhOzs/dxAhOp1re
	OxgfPfigd4iRiYPxEKMEB7OSCG/KDpFkId6UxMqq1KL8+KLSnNTiQ4ymwOiZyCwlmpwPTOh5
	JfGGJpYGJmZmZiaWxmaGSuK8U7QZk4UE0hNLUrNTUwtSi2D6mDg4pRqYzPSv+/Z22zKuLHRY
	dnRV1rEvl6LnzrxUaJtR8a3t1MyqW6vT7ic4PbJw7J8tsPpDXfoG/lcPmGwtH1/MrVuzc7ry
	8ce3/3bLrDdg++hlKrlmkmHJsyl/Xb3zd815/dbyV1/5iZnvvB1uMSfcWRM7n9VL32/B3mun
	tGccrrydnr18pXPokvnc3eXGjYvr+O3Sb/1ZOVOiZ/HBh3Of7l26/G5+evgUhcTi5EeTNaU9
	DlXlJf9RyG3luLmyUHWBrPLrc6sista6usjlZU++x5zFnzCnd8KEOcEcnhPfvT2U1hW/5NHq
	4xKuC3h0Pv0v4Vje9+X+nK8GOQ37jvLFtm3d6RY/K9Xs+Cu23euvSTa3TFNiKc5INNRiLipO
	BABtyU8vMAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsWy7bCSvC7TG7FkgyXL5CyaJvxltpizahuj
	xeq7/WwWNw/sZLJYufook8W71nMsFpMOXWO02HtL22L+sqfsDpweO2fdZfe4fLbUY9OqTjaP
	zUvqPXbfbGDz6NuyitHj8ya5APYoLpuU1JzMstQifbsEroy1jy8yFsxkq2j7doqpgfELSxcj
	J4eEgIlE8/R1rF2MXBxCArsZJX7NnskGkRCXaL72gx3CFpZY+e85mC0k8IRRYsNm9S5GDg4W
	ARWJ1nveICabgKbEhcmlIBUiAkoST1+dZQQZySxwhVHiz/4lrCAJYYFYiX+9R5lAbF4BXYmr
	kw+zQ+y9xSix/vNjFoiEoMTJmU/AbGYBM4l5mx8ygyxgFpCWWP6PAyTMKaAt8WbuREYQW1RA
	WeLAtuNMExgFZyHpnoWkexZC9wJG5lWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMEx
	oqW5g3H7qg96hxiZOBgPMUpwMCuJ8KbsEEkW4k1JrKxKLcqPLyrNSS0+xCjNwaIkznuh62S8
	kEB6YklqdmpqQWoRTJaJg1OqgUk7hoGJ7ZWGQ8f8jcZfOZkUC5JdVvDEFgkdV/yTKnJ85+GM
	Tzwv5gsF/lfxkZqQpRRu3LFx2mS1lyE5fj2O3/5+57fJnC7/5+2m1LTCtbvSFlYoHw1OqJUN
	ee23fhf/bPdA50svn/57dmzG/qR9++avs1j610moO+HoseROp7nLlfLDjl9es/quTeYrhflf
	voTqxeRdvlEVauqQNSmb+3adgUfl9zR9rozrd09N26i4/uc6FcNb00NXqaxQb1gWcipu1d3f
	l6b+Td0srrBTlTPzAd8r/q9GU6SKG6Xs1A5fnSmRXR+WVJ4s80vyMlfX4R+zt2t8j13+8HHF
	0mOrlokxaUtFuBY65Ob1xWvMUVdiKc5INNRiLipOBABUuM7aAAMAAA==
X-CMS-MailID: 20220906064314epcas5p20f26e7075aea4c6067281c10a0abac33
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_e34e4_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1
References: <20220905134833.6387-1-joshi.k@samsung.com>
	<CGME20220905135851epcas5p3d107b140fd6cba1feb338c1a31c4feb1@epcas5p3.samsung.com>
	<20220905134833.6387-4-joshi.k@samsung.com> <20220906062522.GA1566@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_234325_822106_1CEEF775 
X-CRM114-Status: GOOD (  17.04  )
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

------W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_e34e4_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Tue, Sep 06, 2022 at 08:25:22AM +0200, Christoph Hellwig wrote:
>On Mon, Sep 05, 2022 at 07:18:32PM +0530, Kanchan Joshi wrote:
>> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>>  		gfp_t gfp_mask)
>>  {
>> @@ -259,13 +252,31 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
>>  		bio = bio_alloc_bioset(NULL, nr_vecs, opf, gfp_mask,
>>  					&fs_bio_set);
>>  		if (!bio)
>> -			return -ENOMEM;
>> +			return NULL;
>
>This context looks weird?  That bio_alloc_bioset should not be there,
>as biosets are only used for file system I/O, which this is not.

if you think it's a deal-breaker, maybe I can add a new bioset in nvme and
pass that as argument to this helper. Would you prefer that over the
current approach.

------W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_e34e4_
Content-Type: text/plain; charset="utf-8"


------W1bEPTvsorsTcy9-0QGogbD0KLvGmowfrJUeCoG.R5S2F01G=_e34e4_--

