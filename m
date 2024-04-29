Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EAC7C25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Apr 2024 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSxYOjd0frKCPsKoWugqcbkUyt0c+f3M/5NDs6bSevA=; b=r5irnZkNN0ZhP3NtSGE7O/+4Ly
	zYtVwqiZqhxXNtqUAuseOQm5ppycHxC11cSi73z8vGIa63yciQREdNUUAd8svZfUCVWyE1U8L0CFV
	ACWXAlKeuVcZ0ttm/4k7w1HQqg9T8kAPSkjnS9yVCHUGbxSQ6kR2+O4KflgZmdrJIksl4Hhb3oUnx
	2PWNtQqN9z64snWwO1BWO+keaOX14prb6llRD+lyVa54vxFaKv7u6+l3wZn8Sn29fFVuQsT28De2n
	/S9hMsHaDGL7DHziZ/YlvAAujGRH8SoW5F/XrpcJYJCKUf8HtyBUFCtuEie1Xiu4sMl076TKmM6rj
	75uJURLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PHS-00000002TME-3Apk;
	Mon, 29 Apr 2024 11:34:46 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1PHO-00000002TJP-3ss7
	for linux-nvme@lists.infradead.org;
	Mon, 29 Apr 2024 11:34:45 +0000
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240429113436epoutp02e61c05eb73fad987067e29a33c3112c2~KvQ41tMFf2441924419epoutp02u
	for <linux-nvme@lists.infradead.org>; Mon, 29 Apr 2024 11:34:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240429113436epoutp02e61c05eb73fad987067e29a33c3112c2~KvQ41tMFf2441924419epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1714390476;
	bh=eSxYOjd0frKCPsKoWugqcbkUyt0c+f3M/5NDs6bSevA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Z1bX9ViwyEYplCR77UW+8Bvd0DkMD/GStLfUBst5iOp1sUsqFFmYv4OnBHW5kp1WO
	 WYYI+sbfr0Axwrztmopsajbit5g1NcbGoWZlAAtd+62DElq8vuu28o0FjWIAss0J/n
	 JYNdEzCMxO4kDK7EzEWX/+OQQivgLV5oHL3RWIug=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240429113435epcas5p155efda7085cf40d8f17b9487a70d5196~KvQ3wxrjm2705027050epcas5p1E;
	Mon, 29 Apr 2024 11:34:35 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4VSh7Y4QRmz4x9Pq; Mon, 29 Apr
	2024 11:34:33 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C0.07.08600.9C58F266; Mon, 29 Apr 2024 20:34:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240429113432epcas5p100d0b64abcc567cfbc64b98477142c96~KvQ1E55o01172211722epcas5p1N;
	Mon, 29 Apr 2024 11:34:32 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240429113432epsmtrp1a62d8cdf149d8c79c87a766a0831896a~KvQ1D5FXL3030730307epsmtrp16;
	Mon, 29 Apr 2024 11:34:32 +0000 (GMT)
X-AuditID: b6c32a44-6c3ff70000002198-6a-662f85c9b466
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	BB.68.19234.8C58F266; Mon, 29 Apr 2024 20:34:32 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240429113431epsmtip24e5d66539f94bff1d8b4bf51b2cdda58~KvQzW5xF_2080720807epsmtip2G;
	Mon, 29 Apr 2024 11:34:30 +0000 (GMT)
Message-ID: <56f3d65b-5dda-f5fc-68c2-ab9cf368f066@samsung.com>
Date: Mon, 29 Apr 2024 17:04:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 05/10] block, nvme: modify rq_integrity_vec function
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	brauner@kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com, Anuj Gupta
	<anuj20.g@samsung.com>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240427071834.GE3873@lst.de>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmhu7JVv00g5ubFSyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGdUtk1GamJK
	apFCal5yfkpmXrqtkndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0MFKCmWJOaVAoYDE
	4mIlfTubovzSklSFjPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMTctXMBb8
	Z6/413eWrYFxGVsXIyeHhICJxNLvH5i7GLk4hAR2M0pcWXmPEcL5xCix9dQqZjhn07JrTDAt
	7+YvhKraySjxovsJG4TzllFiUe9XVpAqXgE7idntz8E6WARUJe7MaWKBiAtKnJz5BMwWFUiW
	+Nl1AOwQYQEPiavnWplBbGYBcYlbT+aD9YoIKEk8fXUWbBuzwDQmibU9U4GaOTjYBDQlLkwu
	BanhFNCWuDbrLBtEr7zE9rdzmCEuPcEh8etNCYTtIrFn9yt2CFtY4tXxLVC2lMTL/jYoO1ni
	0sxzUF+WSDzecxDKtpdoPdXPDLKWGWjt+l36EKv4JHp/P2ECCUsI8Ep0tAlBVCtK3Jv0lBXC
	Fpd4OGMJlO0h8brtBAskqG4wSnyZfYVxAqPCLKRQmYXk+1lIvpmFsHkBI8sqRsnUguLc9NRk
	0wLDvNRyeIQn5+duYgSnZy2XHYw35v/TO8TIxMF4iFGCg1lJhHfTHO00Id6UxMqq1KL8+KLS
	nNTiQ4ymwOiZyCwlmpwPzBB5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0
	MXFwSjUwLai58efv1mrjY2deTGZWEtvfGG+vcZ7thJy81nvvRcUc27fM05ouY2+suraZ40RD
	HP/D8rijnxjeL7vUZfZ6H+O7c3XtaSdWTTxSUn1878xFfc6FMytnCh8qUZ35lTFYyv18WfoH
	mUlpn6SyknZJ/j8gk3xf+saXVuNzJvsnc2+f/fTWxrchXh/qb3wTXiIjebH6/fyHOaxlrzI0
	tr7cPfv61j1O3aYXt/3tXlzMt/nHtM7jtr/SnqWearOc87H0k6CrVsvUt61MHpMlTR+mq6pP
	dH7IlCH4LfrvExW2FN6Fa8x2TU57yat9MnROROo2b5l/JpY3Vy4q0+7YIerN+0I9P49dgJdt
	U+maE/GutkosxRmJhlrMRcWJALIeh25YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsWy7bCSvO6JVv00gxPvdSyaJvxltpizahuj
	xeq7/WwWrw9/YrR4NWMtm8XNAzuZLFauPspk8a71HIvFpEPXGC323tK2mL/sKbvF8uP/mBx4
	PK7NmMjisXPWXXaPy2dLPTat6mTz2Lyk3mP3zQY2j49Pb7F49G1ZxejxeZNcAGcUl01Kak5m
	WWqRvl0CV8am5SsYC/6zV/zrO8vWwLiMrYuRk0NCwETi3fyFjF2MXBxCAtsZJRoaG1ggEuIS
	zdd+sEPYwhIr/z1nhyh6zShx/WIXI0iCV8BOYnb7cyYQm0VAVeLOnCYWiLigxMmZT8BsUYFk
	iZd/JoINEhbwkLh6rpUZxGYGWnDryXywXhEBJYmnr86CXcEsMI1Jov/nZlaIbTcYJS4/fQzk
	cHCwCWhKXJhcCtLAKaAtcW3WWTaIQWYSXVshDmIWkJfY/nYO8wRGoVlI7piFZN8sJC2zkLQs
	YGRZxSiaWlCcm56bXGCoV5yYW1yal66XnJ+7iREchVpBOxiXrf+rd4iRiYPxEKMEB7OSCO+m
	OdppQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NTC1KLYLJMHJxSDUziUu/2
	nHmr+2dyd6Sw63/X7cZ/jY3CvGQ21i5j8/btcpnMyXq09nlT3VHrkxJWr4OP3f1RL77yOes3
	hS6fBwqmTLPU/ukbuqvN0tC/sPWpQ8OhvNXhkw9UXFx8clKrpHDW628JifqPQzfUmIoeOcQk
	tnCl1X3rLUqJhcfqarqETrQ/OH7xuNidiA/a/9f/d/jYUK59esPL67+VD94VuzBd4Dr3FOF/
	Ut9DAu/UfF4sw1B+OezPZMHF3RMaE2unnk3I+ZsmkjmNMbszZcJ627XmN9w4LSYwrEqTnn+a
	eeP3Vd/YGqIsY2VuRC1xV9B+Xvypc5nPmk+pZ59fXfnZfYpr2ZWKm38Oat2IczwYf2O3Ektx
	RqKhFnNRcSIA1aib7DEDAAA=
X-CMS-MailID: 20240429113432epcas5p100d0b64abcc567cfbc64b98477142c96
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca
References: <20240425183943.6319-1-joshi.k@samsung.com>
	<CGME20240425184700epcas5p1687590f7e4a3f3c3620ac27af514f0ca@epcas5p1.samsung.com>
	<20240425183943.6319-6-joshi.k@samsung.com> <20240427071834.GE3873@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240429_043443_702629_CD695247 
X-CRM114-Status: GOOD (  16.88  )
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

On 4/27/2024 12:48 PM, Christoph Hellwig wrote:
> The subjet is about as useless as it gets :)
> 
> The essence is that it should take the iter into account, so name that.

Sure.

>> --- a/include/linux/blk-integrity.h
>> +++ b/include/linux/blk-integrity.h
>> @@ -109,11 +109,12 @@ static inline bool blk_integrity_rq(struct request *rq)
>>    * Return the first bvec that contains integrity data.  Only drivers that are
>>    * limited to a single integrity segment should use this helper.
>>    */
> 
> The comment really needs an update.  With this rq_integrity_vec now
> is a "normal" iter based operation, that can actually be used by
> drivers with multiple integrity segments if it is properly advanced.

Right, will update.

>> +static inline struct bio_vec rq_integrity_vec(struct request *rq)
>>   {
>> -	return NULL;
>> +	return (struct bio_vec){0};
> 
> No need for the 0 here.
  Um, I did not follow. Need that to keep the compiler happy.
Do you suggest to change the prototype.


