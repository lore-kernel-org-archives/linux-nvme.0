Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026EBC77B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Apr 2023 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	Content-Type:Content-Transfer-Encoding:Date:Message-ID:In-Reply-To:CC:To:From
	:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O/zeu0IMNnIo8BkHHfaGAMiYGuHwPxRRxQNOfP/rWFw=; b=ng2zXmQ3tEtgsTUulsFV02Lm6y
	b2FhMQAntmDp8L5I7/9wSERHuJg5quXKaqacuNrQaDqwk2iCC5UqbYcnWWkZm99OUtYF30YRfAOIv
	E72tzJ7oivR5YYfWg5Fp4acL0lGMDY3HdF+kS5F9YV+1tyDQqhXH7dRJpmOHrAnTtTY9dycryNqP+
	4l5osSM1qdrXkjpMfFfR+mLbyEZ/6kFes/WJJ5goseaSyC7F6HSdE7AjIlpTFkEltexda1yC8nfc9
	LM4OBGAiGpUuT7o40wer4spDNQvUrkH0u6UrTQ5nLrvC0DFVncFH3VwILho938GerwX8nkMRGwDeu
	cwgjiuXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUf2-0023tS-0L;
	Wed, 12 Apr 2023 07:12:56 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmUey-0023ql-2t
	for linux-nvme@lists.infradead.org;
	Wed, 12 Apr 2023 07:12:54 +0000
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230412071232epoutp011613d6c8bfa9f0f9ae2e39859ca014ee~VHnuinB3_1658516585epoutp01-
	for <linux-nvme@lists.infradead.org>; Wed, 12 Apr 2023 07:12:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230412071232epoutp011613d6c8bfa9f0f9ae2e39859ca014ee~VHnuinB3_1658516585epoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1681283552;
	bh=O/zeu0IMNnIo8BkHHfaGAMiYGuHwPxRRxQNOfP/rWFw=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=mgdp2iKSt8bdMFqwl9COg03VSvoyPx3BVJUIsD4igxzjfxFotEeUZV43d4jPGbO/K
	 HSOIa7sQQfjg1aEkxe9uKveb7Iw297FpoCS3o0h3E2m8pTemiVhJ/wsN0KNoms8WE1
	 s0XuCGGvTRpnj5uxcB3ti+aAdhFbsJFWaixsuHZw=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20230412071231epcas2p2f6e82092c76730f33ac1214ba0b8508c~VHnt_Gkaf2003620036epcas2p2q;
	Wed, 12 Apr 2023 07:12:31 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.90]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4PxDRz0gSRz4x9Pq; Wed, 12 Apr
	2023 07:12:31 +0000 (GMT)
X-AuditID: b6c32a48-023fa700000025b2-3c-643659de9b0c
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	2E.1C.09650.ED956346; Wed, 12 Apr 2023 16:12:30 +0900 (KST)
Mime-Version: 1.0
Subject: RE:(2) [PATCH 2/2] nvme-pci: fix metadata mapping length
From: Jinyoung CHOI <j-young.choi@samsung.com>
To: "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "chaitanya.kulkarni@wdc.com"
	<chaitanya.kulkarni@wdc.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20230412065736.GB20550@lst.de>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
Date: Wed, 12 Apr 2023 16:12:30 +0900
X-CMS-MailID: 20230412071230epcms2p145d53bfc8e40eede25f282b80247218c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLJsWRmVeSWpSXmKPExsWy7bCmqe69SLMUg09nrS3+7znGZjHr9msW
	i5eHNC1Wrj7KZDHp0DVGi8u75rBZzF/2lN1i+fF/TBbrXr9nceD0mNj8jt3j/L2NLB6bVnWy
	eWxeUu+x+2YDm8fHp7dYPPq2rGL0+LxJzqP9QDdTAGdUtk1GamJKapFCal5yfkpmXrqtkndw
	vHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0IlKCmWJOaVAoYDE4mIlfTubovzSklSFjPzi
	Elul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMifdWMBX8Zq1YemgSYwPjc5YuRg4O
	CQETif1HKrsYuTiEBHYwSix7v4sNJM4rICjxd4dwFyMnh7CAo0Tz/OtMILaQgJLEuTWzGEFK
	hAUMJG71moOE2QT0JH4umQHWKSIgK3FlRT3IRGaBz0wS/d/2sYHUSAjwSsxof8oCYUtLbF++
	lRHE5hTQkfh+u5EZIq4h8WNZL5QtKnFz9Vt2GPv9sfmMELaIROu9s1A1ghIPfu6GiktKHDr0
	lQ3iq3yJDQcCIcI1Em+XH4Aq0Ze41rER7AReAV+J3cuXgNksAqoS77/tYIWocZH4+3IPmM0s
	IC+x/e0cZpCRzAKaEut36UNMV5Y4cosFooJPouPwX3aYBxs2/sbK3jHvCRNEq5rEoiajCYzK
	sxCBPAvJqlkIqxYwMq9iFEstKM5NTy02KjCBR2tyfu4mRnA61fLYwTj77Qe9Q4xMHIyHGCU4
	mJVEeH+4mKYI8aYkVlalFuXHF5XmpBYfYjQFenIis5Rocj4woeeVxBuaWBqYmJkZmhuZGpgr
	ifN+7FBOERJITyxJzU5NLUgtgulj4uCUamDa8HKWwCGe0juZIlr2ZxYuuddj9kYk5/Pxr7Ez
	V5ptmHA5YvaXowUfDpVVfFs4Y//f6aX3A5XMPJjCr9qYW1n3R9Z9OrKp7FHvhRVrjCqSuw4w
	LXGdoNHq2f1H64P16eUrnD6feH+Qn82getrUut3T7EqW8lz6OZ+5bMPml2+/3I41ysxqFzg0
	aadkdAKvZeFV1t89bn++mm4q2dU2Z3/JV9VLXyo+27Ps+Vyb2OvBm8upZvX9jFO2WOD0W2kX
	PlpUiE7j7X7D/il58d/Y/T9OfL/k2J84NfzZxK9fRZQDT3+S7p386Xf1B4EZgbn31SUtrO79
	0J726duKh1oZJ55dz9rFsfjkHuf279/7DTaYHlRiKc5INNRiLipOBABwqtrwMAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230412052443epcms2p836b669a12c4e81368bec2cd340656f73
References: <20230412065736.GB20550@lst.de>
	<20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8>
	<CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230412_001253_450712_18F27996 
X-CRM114-Status: GOOD (  21.07  )
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
Reply-To: j-young.choi@samsung.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

>> Even if the memory allocated for integrity is physically continuous,
>> struct bio_vec is composed separately for each page size.
>> In order not to use the blk_rq_map_integrity_sg(), the length of the
>> DMA mapping should be the total size of integrity payload.
> 
> Hmm, looking outside the bio_vec is pretty nasty.
> 
> I think the problem here is that bio_integrity_add_page should
> just add to the existing bvec, similar to bio_add_page and friends.

I agree with you.
I think the problem is bio_integrity_add_page().
If it is modified, sg functions for blk-integrity should also 
be modified.

If you think the blk-integrity modification is better, 
I will send an mail to block mailing after modifying it.

Best Regards.
Jinyoung.

