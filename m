Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DD0E77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 11:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y7iVEcWO5At8egsQ1XIfYQNkwCODsRYagLwt487qBFk=; b=hqPKVop4ONJIg/OZBUjDthKCo1
	q/yBQLHrYuffDM93eqELp4B7/6yQuc+YZgfq95SR51t4w161pHB6fxOIm1VL/rk0BFCLvrrR0WnlD
	4apToRhrH/yNyhl7FwwaH03ywWXr18wYKuzxLom6BWH/LFFD1nPHMW/JjMEKP/njH7vypNI62WRuE
	JJglGJhLg9ABVxa6nYpcopMyKb8dI7wIJzUZKJDZtnQ1ILxtwEOz/mTOmYFOjg58UB08hfnSes3f2
	H5IA4se9CHSAHX5hp3D6dFhXKelrWXg938UQIFLr2uLbGGB+X09/LVKUCEcNhRWh7ObbBvxnnSvB+
	wQq3fsUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqeh-0000000Bhkk-2ga7;
	Thu, 09 Jan 2025 11:24:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVqef-0000000BhjZ-0b12
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 11:24:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5093qwa3005688;
	Thu, 9 Jan 2025 11:24:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Y7iVEc
	WO5At8egsQ1XIfYQNkwCODsRYagLwt487qBFk=; b=YZWk4C2RfFXydUbFgYT14m
	TzqaEbrNgUjDIECjVfJukKjBgVJavfE2HZdaPrGEFk9ssFEN7jnKMoYAIy5N6c/0
	KjqzJOaq+Kh0wiA5g2dEEEjrluFrlEqmtvrGRn8cDmCqidrEfjQJMfTlFiOMSGfe
	cBIcemW9rG6KEfcRizevDVKseYa1J4pjIP7J/7vxo/ge7Yd/4Cjizd1o48h/Duwb
	cZWAuNoyTS64xiHYRC69YAtfCowSCAj6Lyy8Pxa7Sd+foFUtzOCB7uf1p2YQ/t4E
	hbAKzfMIegWqb/CHwmqA60DU51Dai3NyJSlvKgqITXi9HmLwiMJFFRVPCq4diLmw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4426xc9sxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 11:24:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5097jukl008851;
	Thu, 9 Jan 2025 11:24:44 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfq04ybm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 11:24:44 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 509BOhM418154092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jan 2025 11:24:43 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DF3358058;
	Thu,  9 Jan 2025 11:24:43 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D33B858059;
	Thu,  9 Jan 2025 11:24:39 +0000 (GMT)
Received: from [9.171.90.198] (unknown [9.171.90.198])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jan 2025 11:24:39 +0000 (GMT)
Message-ID: <279f282c-1fc3-4771-8460-c1a980fb0517@linux.ibm.com>
Date: Thu, 9 Jan 2025 16:54:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] block: fix docs for freezing of queue limits updates
To: John Garry <john.g.garry@oracle.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        nbd@other.debian.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net
References: <20250107063120.1011593-1-hch@lst.de>
 <20250107063120.1011593-2-hch@lst.de>
 <33386009-9d1b-4a7f-96a5-a2f0ed2fb075@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <33386009-9d1b-4a7f-96a5-a2f0ed2fb075@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJ1uIGvels0GVoFE-W6QTYp62ZTRBanU
X-Proofpoint-ORIG-GUID: HJ1uIGvels0GVoFE-W6QTYp62ZTRBanU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=916 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501090087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_032449_185738_CB34A680 
X-CRM114-Status: GOOD (  18.23  )
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



On 1/9/25 4:49 PM, John Garry wrote:
> On 07/01/2025 06:30, Christoph Hellwig wrote:
>> queue_limits_commit_update is the function that needs to operate on a
>> frozen queue, not queue_limits_start_update.  Update the kerneldoc
>> comments to reflect that.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   block/blk-settings.c   | 3 ++-
>>   include/linux/blkdev.h | 3 +--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/blk-settings.c b/block/blk-settings.c
>> index 8f09e33f41f6..b6b8c580d018 100644
>> --- a/block/blk-settings.c
>> +++ b/block/blk-settings.c
>> @@ -413,7 +413,8 @@ int blk_set_default_limits(struct queue_limits *lim)
>>    * @lim:    limits to apply
>>    *
>>    * Apply the limits in @lim that were obtained from queue_limits_start_update()
>> - * and updated by the caller to @q.
>> + * and updated by the caller to @q.  The caller must have frozen the queue or
>> + * ensure that there are outstanding I/Os by other means.
> 
> is that a typo - /s/outstanding/ no outstanding/ ?
It's already fixed in v3 here: https://lore.kernel.org/all/20250109055810.1402918-2-hch@lst.de/

Thanks,
--Nilay

