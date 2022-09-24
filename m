Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA69EC32771
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Sep 2022 11:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:CC:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EVg47p0JhcCTGJg0TZxH7odD+YswmajLBxZkmpLFUSs=; b=aymhQuFtEBzurN
	2MPBBL5K7r6Bu/cAdyKntXPT26Y/7Hb1rgJRr/p889xzxduAEsJHRFgxnSm7tLoXOAAjuWgB2osR6
	qknwh30r7leRq+HYbr45PioZzLG8koRxo4mhoS7pNozoeXpZfheOY8H8gOIE1JacLM5cb+VqjpnYY
	tYI/+xZwKESP1u670vUFvHFHFOpvYzNtx2VP+fJts893GOW5UXh9Ch9VRGSbWgxMbKTQ760wy2egC
	hquED9OvISthVFtNpP+EVrbBGKnnlJgOuS62TBl2Vw3em+HL8bsj7lBQR6PHePSQ9u/0g5yqt+2RY
	d3DEYqCD6XL4QG11CZ7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc3m1-0073Oq-IA; Sat, 24 Sep 2022 11:56:45 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oc3lv-0073Ky-4F
	for linux-nvme@lists.infradead.org; Sat, 24 Sep 2022 11:56:40 +0000
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220924115630euoutp01a040f743ff6f366662dad18f7e6e8075~XyekULQc00041900419euoutp01n
	for <linux-nvme@lists.infradead.org>; Sat, 24 Sep 2022 11:56:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220924115630euoutp01a040f743ff6f366662dad18f7e6e8075~XyekULQc00041900419euoutp01n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1664020590;
	bh=EVg47p0JhcCTGJg0TZxH7odD+YswmajLBxZkmpLFUSs=;
	h=Date:Subject:To:CC:From:In-Reply-To:References:From;
	b=gP+DdZ8YTaA8W9eSwaaBJ6wXnHfDBWkf+U5StLvG7YI40nvngRmDhPBYttMXwZw2g
	 SlKXp1nIUC8k3IaHPFnmxvMJZAvMOnWvDpYwUcnfDh+QlPJSwXlOxb3LCAKRzJowLx
	 v+P52o+ENCDH5ORBv6aQTEYLBDGPqKPLJL2nUkfM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20220924115629eucas1p1ab30f4d338ef6a179d1a763a57a7eb22~Xyej95o9C2356423564eucas1p1C;
	Sat, 24 Sep 2022 11:56:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 7D.11.19378.D60FE236; Sat, 24
	Sep 2022 12:56:29 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220924115629eucas1p16b9ad95f3f797b2f4a6d2178e6426ff4~XyejfnfBP1392613926eucas1p1a;
	Sat, 24 Sep 2022 11:56:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220924115629eusmtrp12a86d614c2c27919bb3ed5cfe6b8335f~XyejfABOR1630216302eusmtrp1D;
	Sat, 24 Sep 2022 11:56:29 +0000 (GMT)
X-AuditID: cbfec7f5-a35ff70000014bb2-4e-632ef06da064
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id DC.F7.10862.D60FE236; Sat, 24
	Sep 2022 12:56:29 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220924115629eusmtip2ca42f7a320dfee98355591818a181d48~XyejT19ho0292802928eusmtip2R;
	Sat, 24 Sep 2022 11:56:29 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.168) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Sat, 24 Sep 2022 12:56:27 +0100
Message-ID: <59e40929-bc1e-5d1e-3dcf-b9ba39b3d393@samsung.com>
Date: Sat, 24 Sep 2022 13:56:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
	Thunderbird/91.11.0
Subject: Re: [PATCH 1/5] block: enable batched allocation for
 blk_mq_alloc_request()
Content-Language: en-US
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal
	<damien.lemoal@opensource.wdc.com>
CC: <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linux-nvme@lists.infradead.org>, <joshi.k@samsung.com>, Pankaj Raghav
	<pankydev8@gmail.com>, Bart Van Assche <bvanassche@acm.org>
From: Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.168]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7q5H/SSDZ7+MLRYfbefzWLah5/M
	Fr/Pnme22HtL22L+sqfsFt3Xd7BZrLn5lMWB3ePyFW+PnbPuAhlnSz02L6n32Nl6n9Xj8ya5
	ALYoLpuU1JzMstQifbsErowNB2oLXnBUTJpwirmBsYu9i5GTQ0LAROLgiVOsXYxcHEICKxgl
	zkw+ygbhfGGUODptBzNIlZDAZ0aJT2uDYDqWPnwJ1bGcUWLO740IRavPM0IkdgMlGieC7eAV
	sJNobexhBLFZBFQljj1/wwYRF5Q4OfMJC4gtKhApsWb3WbB6YYEwif3v1zKB2MwC4hK3nswH
	s0UEQiXuND0HO49Z4DijxP1zV4HO4OBgE9CSaOxkBzE5BWwlHr1VhmjVlGjd/psdwpaX2P52
	DjPEA8oSy0/PhLJrJdYeO8MOMlJC4AeHxJ9zO5lA5kgIuEic2ZsAUSMs8er4FmhwyUicntzD
	AmFXSzy98ZsZoreFUaJ/53o2iF5rib4zORA1jhL992dChfkkbrwVhDiHT2LStunMExhVZyEF
	xCwkD89C8sEsJB8sYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZiCTv87/nUH44pX
	H/UOMTJxMB5ilOBgVhLhTbmomyzEm5JYWZValB9fVJqTWnyIUZqDRUmcl22GVrKQQHpiSWp2
	ampBahFMlomDU6qByfkGq6eAi5v1s2XZTwtPTRerbDny/tc02bDLz/qD/hpbbYg8Oa3+WssL
	fo4ur8nm+34+2Byw0zHyAEvnSeUVj1j/5R+Uq7qt/GI6g7fNLZFrEmV9z0/fT7AXPar6hiNE
	LHGBwDp2o+JCwc8n48XeT7I73P8tYIFL72kdxi8x5pJG/BVTn4n+21AqPI39su+CWNbcFdFz
	mYqTFN8sdeqa9K9y5tQFufqP9oU+MhZMrWk02rtwg5hki7zJiSbj/90fo6JqtMrl9jTdC9cS
	PbTkr1Wc1LVd10///hTYbWp2YP7Lk5O/lyydZlBZc/jsCxcTBSlBhbkFP94FqJ+uLzjtcSUu
	L9jUlYGHv8nmtZiqEktxRqKhFnNRcSIAIr48PrADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKIsWRmVeSWpSXmKPExsVy+t/xe7q5H/SSDf7OErBYfbefzWLah5/M
	Fr/Pnme22HtL22L+sqfsFt3Xd7BZrLn5lMWB3ePyFW+PnbPuAhlnSz02L6n32Nl6n9Xj8ya5
	ALYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYwN
	B2oLXnBUTJpwirmBsYu9i5GTQ0LARGLpw5esXYxcHEICSxkltrVdgkrISHy68hHKFpb4c62L
	DaLoI6PEn+8HoTp2M0qc+juZBaSKV8BOorWxhxHEZhFQlTj2/A0bRFxQ4uTMJ2A1ogKREg+X
	NTGB2MICYRL7368Fs5kFxCVuPZkPZosIhErcaXoOto1Z4DijxP1zV6G2HWeSWHvgHlAVBweb
	gJZEYyc7iMkpYCvx6K0yxBxNidbtv9khbHmJ7W/nMEN8oCyx/PRMKLtW4tX93YwTGEVnITlv
	FpIzZiEZNQvJqAWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzEC43fbsZ9bdjCufPVR7xAj
	EwfjIUYJDmYlEd6Ui7rJQrwpiZVVqUX58UWlOanFhxhNgWE0kVlKNDkfmEDySuINzQxMDU3M
	LA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqY9Kc0KrTtf3X+5yyO/YrBpWW9RcJ8
	rbuMyqQSot53quYkBTJOfjRbgvPUT+87PUIyf/9f+Wg7f1JfrvSBH8yViTbLfphfmB52pLUy
	NJTNn6P2c9W1sG+T53tXxUvMvBA9/070N91XX86fufVyE/s1B5NjbqwHjAxvN5ywulZp98ho
	2X2/My38VTdYGJpK3fgbDtU+fcMVbXfuRcy3n7GOfd6ruJ8I90eFl2gtNw8++jn9XvHp15Lb
	Emw8j+5UEW66wvmNa/mfQgObV6sdHZcrZhcffDJBJkeX+/DFsH99C+V/tRkEpEao3rnmrBJW
	sCLz9vo/PPzbrky78YqxMZh7nf29jsglzd5TtOy2LJZRYinOSDTUYi4qTgQACiPo5GgDAAA=
X-CMS-MailID: 20220924115629eucas1p16b9ad95f3f797b2f4a6d2178e6426ff4
X-Msg-Generator: CA
X-RootMTR: 20220923145245eucas1p107655755f446bb1e1318539a3f82d301
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220923145245eucas1p107655755f446bb1e1318539a3f82d301
References: <20220922182805.96173-1-axboe@kernel.dk>
	<20220922182805.96173-2-axboe@kernel.dk>
	<CGME20220923145245eucas1p107655755f446bb1e1318539a3f82d301@eucas1p1.samsung.com>
	<20220923145236.pr7ssckko4okklo2@quentin>
	<c7b76fa1-f7e3-3ac6-c92d-35baa0d9a40a@samsung.com>
	<2e484ccb-b65b-2991-e259-d3f7be6ad1a6@kernel.dk>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220924_045639_470463_9FD1CCBA 
X-CRM114-Status: GOOD (  13.24  )
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

>>> As the passthrough path can now support request caching via blk_mq_alloc_request(),
>>> and it uses blk_execute_rq_nowait(), bad things can happen at least for zoned
>>> devices:
>>>
>>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>>> {
>>> 	/* Zoned block device write operation case: do not plug the BIO */
>>> 	if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
>>> 		return NULL;
>>> ..
>>
>> Thinking more about it, even this will not fix it because op is
>> REQ_OP_DRV_OUT if it is a NVMe write for passthrough requests.
>>
>> @Damien Should the condition in blk_mq_plug() be changed to:
>>
>> static inline struct blk_plug *blk_mq_plug( struct bio *bio)
>> {
>> 	/* Zoned block device write operation case: do not plug the BIO */
>> 	if (bdev_is_zoned(bio->bi_bdev) && !op_is_read(bio_op(bio)))
>> 		return NULL;
> 
> That looks reasonable to me. It'll prevent plug optimizations even
> for passthrough on zoned devices, but that's probably fine.
> 

Do you want me send a separate patch for this change or you will fold it in
the existing series?

--
Pankaj

