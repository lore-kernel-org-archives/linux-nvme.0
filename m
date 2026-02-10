Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F102EA3F18
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yacUS/5xn+i90L0A/5qoKjfR29+LuPyeO9WE9hzFMkU=; b=G+pXhcjh1plkr3gvstNVh5ydcO
	E1hUWNykYx3+r4TFcFAs/GheVNoX6Ui0WzJJtikhGJ/IcXyPjtUHcXxUB2567sxUNCej2vJxbc3Fg
	XXvbjfvv0xQQ1T7oJWESpRif2meGyD+TkBI2uisEIXEoMnkQzL1EyRby5ZhgdJ9u3xKyM3jo+ILvm
	x/y4rcqVnDZO5EZI38HeRBSQIY+2+5z3bIcYbP9pt6pKs8WWYoVASNelq8UR4jKQgzJ2vLScTXlCp
	udck7cg9e3IpGqs9fI/aVeVijTwiFiCu4qXbgJhxGvWK0Scm+jd8kI9Qikglu/B7TqTFCsxXe678A
	OBwasPIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpiqK-0000000Gfw0-0hp0;
	Tue, 10 Feb 2026 08:11:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vpiqF-0000000GfvP-1qP8;
	Tue, 10 Feb 2026 08:11:28 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619FmaAC328612;
	Tue, 10 Feb 2026 08:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yacUS/
	5xn+i90L0A/5qoKjfR29+LuPyeO9WE9hzFMkU=; b=V5eQnPx5KHdevGsjQRzfgA
	6ctJ0DjHFjeWatIVZd0sNmA+NSam7A/wvZLenYylDJbAJnsq65C0dc3R0rPO562t
	IUs5jP8+LLQQe7yF6jXsga/RqXWwnuqhH9J5cybCDwKWLSZpl376u4BYergfkaH3
	iUqylLsrf8ezTSu/klEZeviykt92ATR0NkLkltmyjD4vMmqPmmAcVfufwbgnZZj+
	Gen//NLVFka8WTgqj+V6DTugwDD8hoR3mLndBcsqPNqRlyy04gNkrPYUS65Cup9M
	fr1qXmFa9ohttlBjFvN4uLPAGQIp+szSuFiBLCvVElqr/epyrVH+A7E4H1SdECxA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696us7f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:11:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61A44FuT008400;
	Tue, 10 Feb 2026 08:11:02 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c6g3y8jch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Feb 2026 08:11:02 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61A8B1xj27067108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Feb 2026 08:11:01 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 641E458045;
	Tue, 10 Feb 2026 08:11:01 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A90DD58050;
	Tue, 10 Feb 2026 08:10:56 +0000 (GMT)
Received: from [9.109.198.160] (unknown [9.109.198.160])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Feb 2026 08:10:56 +0000 (GMT)
Message-ID: <ac55db2a-ab90-460d-9efa-e13c5a3f498d@linux.ibm.com>
Date: Tue, 10 Feb 2026 13:40:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, axboe@kernel.dk, sagi@grimberg.me,
        sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, tj@kernel.org, ming.lei@redhat.com,
        neal@gompa.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com> <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aYn-xwFHCpd7sITJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA2NCBTYWx0ZWRfX3oGi64WxoWN/
 GBeaVWITmRzlY94+3+Mjrz5uMdVtO3PI/urzjfFFcclJigRcI1Vwjsh8VCHcaO+5v8Ns6UVnBQf
 3m/iwm+LQ4Acb4l5RqpybHloQiOvW+al3Um1BHg6maUFfB3N5aTiK7V6b98KittQsAdBccQ82yx
 UD0euZe/6G+eFR4R4uILXRmEGVktqYlAsiGePEQAtop6AAyWVITc0v13+tPlT3VZ/YpoEvMzoqH
 w3DqLyVTMuLMsOmZVvVGS/j52BHMoo03uqNi0gu0f3qtb9YLRbqoNwgECsmZJisJQat0pPn62o1
 zgyn1jtY0/X3VKfxJ7Rgkh2E1RGZkzIdC4XrftUUAJQuvTgzGwknbVllzOteJtGEtBU9dQ9wirZ
 AXdYwTRN1qWqUiXlgQZosHjXnTgVJPWniFfdBiutTOLt058RP4EbVYKIYY/NHe960KwZC4Yrwfv
 3Hj5mU7B6KhgIr83vVQ==
X-Proofpoint-ORIG-GUID: AreZ9eDAwMrjE8TxGo49dw8sijoQhvpH
X-Proofpoint-GUID: AreZ9eDAwMrjE8TxGo49dw8sijoQhvpH
X-Authority-Analysis: v=2.4 cv=O+Y0fR9W c=1 sm=1 tr=0 ts=698ae817 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=tJLSzyRPAAAA:8
 a=TfStTScm9TuUUgMehrsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=H0xsmVfZzgdqH4_HIfU3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_001127_628083_E2E65A0F 
X-CRM114-Status: GOOD (  24.48  )
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



On 2/9/26 9:05 PM, Keith Busch wrote:
> On Mon, Feb 09, 2026 at 03:58:32PM +0100, Christoph Hellwig wrote:
>> On Mon, Feb 09, 2026 at 04:29:52PM +0800, Yu Kuai wrote:
>>> blk_mq_update_nr_hw_queues() freezes and unfreezes queues internally.
>>> When the queue is already frozen before this call (from nvme_start_freeze
>>> in apple_nvme_disable), the freeze depth becomes 2. The internal unfreeze
>>> only decrements it to 1, leaving the queue still frozen when
>>> debugfs_create_files() is called.
>>>
>>> This triggers WARN_ON_ONCE(q->mq_freeze_depth != 0) in
>>> debugfs_create_files() and risks deadlock.
>>>
>>> Fix this by moving nvme_unfreeze() before blk_mq_update_nr_hw_queues()
>>> so the queue is unfrozen before the call, allowing the internal
>>> freeze/unfreeze to work correctly.
>>>
>>> Signed-off-by: Yu Kuai <yukuai@fnnas.com>
>>> ---
>>>  drivers/nvme/host/apple.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>>> index 15b3d07f8ccd..1835753ad91a 100644
>>> --- a/drivers/nvme/host/apple.c
>>> +++ b/drivers/nvme/host/apple.c
>>> @@ -1202,8 +1202,8 @@ static void apple_nvme_reset_work(struct work_struct *work)
>>>  
>>>  	nvme_unquiesce_io_queues(&anv->ctrl);
>>>  	nvme_wait_freeze(&anv->ctrl);
>>> -	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>>>  	nvme_unfreeze(&anv->ctrl);
>>> +	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
>>
>> Looks good on it's own, but it would also good to align the
>> apple driver with the PCI one here more.
> 
> I'm pretty sure this series would deadlock nvme-pci, as that driver
> still leaves the queue frozen when calling blk_mq_update_nr_hw_queues.
> 
> We've left it frozen on purpose, though. The idea was to prevent new IO
> from entering a hw context that's no longer backed by a hardware
> resourse. Unfreezing prior opens that window up again. Maybe it's not a
> big deal; I don't often encounter scenarios where the queue count
> changes after a reset.

If an I/O were to slip through during the brief window between unfreeze
and the subsequent freeze inside blk_mq_update_nr_hw_queues(), wouldn’t
it still fail because the NVMe queues have already been suspended earlier
in the reset path? My understanding is that when the controller reset
reduces the number of online NVMe queues, the queues that are no longer
backed by hardware remain in the suspended state. As a result, any I/O
that reaches them before nr_hw_queues is updated should be rejected in
nvme_queue_rq(). And if that’s the case, then allowing a small unfreeze
window before updating the nr_hw_queue count shouldn’t result in a deadlock.
What do you think?

Thanks,
--Nilay


