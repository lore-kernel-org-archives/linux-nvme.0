Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BD3E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 12:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5VYWlzs54e2fOmMAsKWa3Enn7OneHP0TVzdAjmuEUBA=; b=uVCdmHNpN74U84Vew0fLDIAUPN
	TfJoGalI46Tlb2Qtt0IuC6ms8WdHXpiiF8bSj9XGi5/qE6ahlSB3zO34ZZMJM+Nego8KaMfDNoM06
	DosE5/V16ZsrBu48S0hqQQjLvuiJMesYMuTYQGm8qelNz+CGGBkvKAzLkRsHVrB9PQj847N+k6F/A
	4CsbEhqe/w8jk40AxS9LcGETT8ek7zx/C56ljFx+U1sxXILCrxYBekn0PpFqkh6bOyY5r7j4ViIsj
	8oPaovdBWMWh7IIHw+L4YZDx2u2eoP16V6EAHT9zrJnshrKBQs8MwpNk9bmMEKjmYY/mqHU2YLXmS
	oAODYu4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUm8a-00000001Cgh-3X2Q;
	Mon, 06 Jan 2025 12:23:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUlsy-000000018nm-3WW5
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 12:07:09 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50600EP9030214;
	Mon, 6 Jan 2025 12:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5VYWlz
	s54e2fOmMAsKWa3Enn7OneHP0TVzdAjmuEUBA=; b=MmnwOSfrasbMdxNoavd2+L
	4d7fSl3FOGZplpA4l0jmfDLoT9xlvB+sAsuxkdGIgqXdrZ+8XzudwBEaU6SRpvEn
	1uzFkzlm0CHPNoLibzdYj0GZLuGvNj8vgKYb64JZar11tcW3EfCoXL9rYebMJkHr
	TL1S2733SpeMdbLtDcSY6KjOxLLS1NOeodkCGC85+LwovgmIYUHHmivalelEMGPd
	bnPzz7e6mVBOIS6DRq6zVGgz6Mxc9Wckub2qUecurHEpV8fN3pZ0R0qIC4eRPksN
	gA62FgNVMFf6/gDTiGgv6dARaBzcBdmGVEIOMHflttA4tj6Jpo+AcwOrvvoMfuRA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44047haeuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:06:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50696WKH003630;
	Mon, 6 Jan 2025 12:06:58 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfaswspx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:06:58 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506C6vCc32244426
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 12:06:57 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62C0258058;
	Mon,  6 Jan 2025 12:06:57 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F24FD5805C;
	Mon,  6 Jan 2025 12:06:53 +0000 (GMT)
Received: from [9.171.85.164] (unknown [9.171.85.164])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jan 2025 12:06:53 +0000 (GMT)
Message-ID: <3fb212e4-8fff-45fc-9cff-f5b5eaff4231@linux.ibm.com>
Date: Mon, 6 Jan 2025 17:36:52 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250106110532.GA22062@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FGJElPxHemmUGQZFUCCrmUdflIso0Eah
X-Proofpoint-ORIG-GUID: FGJElPxHemmUGQZFUCCrmUdflIso0Eah
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=380 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_040708_896496_75879A3F 
X-CRM114-Status: GOOD (  19.84  )
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



On 1/6/25 4:35 PM, Christoph Hellwig wrote:
> On Mon, Jan 06, 2025 at 04:31:23PM +0530, Nilay Shroff wrote:
>>> +static bool bdev_can_poll(struct block_device *bdev)
>>> +{
>>> +	struct request_queue *q = bdev_get_queue(bdev);
>>> +
>>> +	if (queue_is_mq(q))
>>> +		return blk_mq_can_poll(q->tag_set);
>>> +	return q->limits.features & BLK_FEAT_POLL;
>>> +}
>>> +
>>
>> Should we make bdev_can_poll() inline ?
> 
> I don't really see the point.  It's file local and doesn't have any
> magic that could confuse the code generator, so we might as well leave
> it to the compiler.  Although that might be about to change per the
> discussion with Damien, which could require it in blk-sysfs, in
> which case it should become an inline in a header.
> 
Oh yes, I saw that you moved blk_mq_can_poll() to blk-mq.h and 
made it inline so thought why bdev_can_poll() can't be made inline?
BTW, bdev_can_poll() is  called from IO fastpath and so making it inline 
may slightly improve performance. 
On another note, I do see that blk_mq_can_poll() is now only called 
from bdev_can_poll(). So you may want to merge these two functions 
in a single call and make that inline.

Thanks,
--Nilay

