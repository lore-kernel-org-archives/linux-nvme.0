Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BFBE77197
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jan 2025 07:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inaSEMpTVKk1ST+3srG8V1U/0h9KEiFBTVU1i7Qk0gU=; b=n+xi1PS1cswifafwgB70xIAStI
	F9r3t0fIihPLaHiYPKJ4alXahBzUxZOexJYR5dqp02LfJOYBXRaoWWH8ygdoonnf/ae1bwaBj8z1t
	AfXNobqwJ0hNDLD1AYqt5CPnp1TqvBY9pHVnEje2g5cjj3VvaKm3+mbUiO9kLuKxLxRr90WzsEWm0
	GKa9918C8SMP93Zmr+AoFun1q/iVPm6Z2I3ADpmQ8LcXOGxZmOBfkfGQ7SpqP7RuLbS7xaZixqkhU
	Wq3irWjgB6J2noImQ4Iq/dVd9pY3ADzn2iL0QGG/65+viWUSg7ClQ2sK/lHTqNLNUk60L0MAmrUAm
	WyxobVOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV3g5-00000003iv9-3NpQ;
	Tue, 07 Jan 2025 07:07:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV3g3-00000003iuX-2sTp
	for linux-nvme@lists.infradead.org;
	Tue, 07 Jan 2025 07:07:00 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5073s5ae013495;
	Tue, 7 Jan 2025 07:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=inaSEM
	pTVKk1ST+3srG8V1U/0h9KEiFBTVU1i7Qk0gU=; b=dr8hnk+jtUP5Iz3VCNvTvO
	cUgORr4Di+uZ8SzVPZCgkxtwSGNKSduqENIm2R0DmBsWWmvOnHm2hsDjmCrlbi9q
	mAgt+JFLxEuJKu/Tcvo3T1UV3VVEG/Q8+HjAvzN/UdyuR5XtMdOXp8gQxfWsm19X
	go1Z1l6vhaoXYQtQl/r1qx/xyV11EqAUamjMCuI7d5yKT7mk1ieR+JNNLcqMN69N
	Y+EKe1NQAnb8D6e4qPen8uC9hgOGu/ZdzcMK6sNaNi+cJI7Q7zRwrcT/TvFJjG2G
	v/4hTjVmEJBS9UxhLngKVk8M3P4e8kXtr1LSVkh2wFXppJjyu+HmEVzo+FM455JA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 440vrc8q1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 07:06:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5073RCiW008851;
	Tue, 7 Jan 2025 07:06:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyse6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 07:06:55 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50776sHI32768646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 07:06:54 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 900C258064;
	Tue,  7 Jan 2025 07:06:54 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 191ED58063;
	Tue,  7 Jan 2025 07:06:51 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Jan 2025 07:06:50 +0000 (GMT)
Message-ID: <bb8ea315-cf16-4fd1-9680-bbc390ac1756@linux.ibm.com>
Date: Tue, 7 Jan 2025 12:36:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, nbd@other.debian.org,
        virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-6-hch@lst.de>
 <4addcb5e-fc88-4a86-a464-cc25d8674267@linux.ibm.com>
 <20250106110532.GA22062@lst.de>
 <3fb212e4-8fff-45fc-9cff-f5b5eaff4231@linux.ibm.com>
 <20250106152708.GA27431@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250106152708.GA27431@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fjpHHO44d6r9IEMzw536FE7K15i-7J20
X-Proofpoint-ORIG-GUID: fjpHHO44d6r9IEMzw536FE7K15i-7J20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=305 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070056
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_230659_733166_58E4B74F 
X-CRM114-Status: GOOD (  20.89  )
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



On 1/6/25 8:57 PM, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 05:36:52PM +0530, Nilay Shroff wrote:
>> Oh yes, I saw that you moved blk_mq_can_poll() to blk-mq.h and 
>> made it inline so thought why bdev_can_poll() can't be made inline?
> 
> It can be, but why would you want it to?  What do you gain from forcing
> the compiler to inline it, when sane compilers with a sane inlining
> threshold will do that anyway.
Hmm, ok, I was thinking just in case we want to force compiler. What if
in case compiler doesn't inline it? However, if we're moving this function
to a header then it would be made inline, anyways.
> 
>> BTW, bdev_can_poll() is  called from IO fastpath and so making it inline 
>> may slightly improve performance. 
>> On another note, I do see that blk_mq_can_poll() is now only called 
>> from bdev_can_poll(). So you may want to merge these two functions 
>> in a single call and make that inline.
> 
> I'd rather keep generic block layer logic separate from blk-mq logic.
> We tend to do a few direct calls into blk-mq from the core code to
> avoid the indirect call overhead, but we should still keep the code
> as separate as possible to keep it somewhat modular.
> 
Okay, make sense.

Thanks,
--Nilay

