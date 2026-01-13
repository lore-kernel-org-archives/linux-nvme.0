Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 065A8D29DCC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jan 2026 06:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vSPcnLH1R0tlJp56AG+KIebpXgkBkwNl22OIaNCgUwg=; b=LhSlMs4nIyGdkcR0q8DlsjkJgJ
	zAZlX9uYwPOSL80u1WW3EMFNiTP1kQa+n/W3G3obc0fPrcoOzIiyPNR0CEz8nFRVLp6CqgwHbzoIi
	me/uQXyvYFzlEyJaLvf6lwUBK8IO+bRk8JIIuZ2Kf+TaxVq+iOqvcF6l1m2cGQ3oOE1/zmaKi0SFd
	QkRr2lboYU/lTRNAR297+Ur0idoI87qbsNd1rzDGQgTLenwbIY+2OJ0hmQ0XF3MLDadZxwDZPIDXN
	fch87aCHf+zKvnBhMiXumfNgTDEDyygb16DaslYGtdIuiZwaCD3xAE9BkYu3ck+IQasJdwgHdnZJh
	URMtxLAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfXbs-00000006Zzw-38mE;
	Tue, 13 Jan 2026 06:10:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfXbj-00000006ZzY-1K0j
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jan 2026 06:10:29 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CMbZUl019683;
	Tue, 13 Jan 2026 06:10:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vSPcnL
	H1R0tlJp56AG+KIebpXgkBkwNl22OIaNCgUwg=; b=ZJ9H42tWa+oDB7kDAjqw46
	S3rycdLYdTNMaT0KX6yOwDBpQh/LEt1zudTKem+Y4Z0MK5sccG7mPv5bwTcODbay
	yD+GcRp7jtF0MJfIotIK693geo2k76VHVobl+lwdhkTTUiOyNzIxkyhqrlWOUeV5
	DBrlQvqAWhcnWSawA5O6xQ8Fh3Uz0PAj6TTfIERU89JTMzQ6pP5rnPCbNW6zhasj
	hsg2YhI9Rrbpt4QWQur2uzk1cPG6lvcRgTcXh7KGqvHX75A8JRnox0f57FBU1cdb
	Pig9keDR1cvh9iLOhW2SQwTBhoPjsALM/1SaPxWeq/b/t023Y04mRcST8u2OsFdQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkc6h2v9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 06:10:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60D66XhV025799;
	Tue, 13 Jan 2026 06:10:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm2kkaf3j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Jan 2026 06:10:12 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60D6ABXw5505582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 06:10:11 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5187358058;
	Tue, 13 Jan 2026 06:10:11 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BD9B58059;
	Tue, 13 Jan 2026 06:10:06 +0000 (GMT)
Received: from [9.109.198.193] (unknown [9.109.198.193])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Jan 2026 06:10:05 +0000 (GMT)
Message-ID: <2356e974-2595-429d-983b-42cfa0e24ba8@linux.ibm.com>
Date: Tue, 13 Jan 2026 11:40:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: only allow entering LIVE from CONNECTING state
To: Daniel Wagner <dwagner@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Daniel Wagner <wagi@kernel.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Narayana Murty N
 <nnmlinux@linux.ibm.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ewan Milne <emilne@redhat.com>,
        Maurizio Lombardi <mlombard@redhat.com>
References: <20250214-nvme-fc-fixes-v1-0-7a05d557d5cc@kernel.org>
 <20250214-nvme-fc-fixes-v1-1-7a05d557d5cc@kernel.org>
 <8574c297-fc02-40d6-ba67-ab43e3d5e394@redhat.com>
 <833fd772-da6c-4f91-87e3-e13883f1815d@linux.ibm.com>
 <d8512cdc-bdcd-44ff-a56a-974b4464a7a5@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <d8512cdc-bdcd-44ff-a56a-974b4464a7a5@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mpRlT0uE3H9zx-2Z1kOldGloV2ctfnXW
X-Proofpoint-ORIG-GUID: mpRlT0uE3H9zx-2Z1kOldGloV2ctfnXW
X-Authority-Analysis: v=2.4 cv=TaibdBQh c=1 sm=1 tr=0 ts=6965e1c5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=0x9SmRVZ2wh8L790xScA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDA0NiBTYWx0ZWRfX0f4To3xintlC
 Qe80E3FC3K+50J8PgcqSVWxI/NH47eJ2epad4mm50gDmOO7u/mXypQwtbfYvhn7aZmNDvzTMYmX
 xW5eskwc3k7yF8SGwP24GdYwPu8Z3AkLJL4QP2yvwR66Z5EbSMi1hgOLfTr8pyhWcCGLim8RATe
 Q12JKsRNeHrwGfebCETl8wYYht4/vo0mlyaQSM1hy+pWLe/l4yPdSkU9Y6JzAnrnF4CkfQrqYNi
 OIlixC2WS3nhOxESOObmC9oRCTynjXQgRvlwh8ptNQI82spwcJ4LluaA8XyZVzEzH2XzqeBeEAD
 XKQrzZ0q/dqtGjZ/Vx9ZVqjRWa37NF6IGuxXid7kaC5dDFVcqXy+rQqKwxkqyBlOzat8v48S2EU
 c1hRliWrdz8oKyKXHeFLjmd6Vc8tU9dZlvCmoEa/GqLpz52wfMvZvdfewCnfM8yaDFzLwa1WGr7
 Qa8RXwI72aiN52GpElg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_07,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601130046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260112_221025_121777_D19AA6CB 
X-CRM114-Status: GOOD (  27.06  )
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



On 1/12/26 1:44 PM, Daniel Wagner wrote:
> Hi Nilay,
> 
> On Sun, Jan 11, 2026 at 03:03:43PM +0530, Nilay Shroff wrote:
>> This was broken because with this commit d2fe192348f9 (“nvme: only allow entering LIVE
>> from CONNECTING state”) now we don't allow changing controller state from 
>> RESETTING -> LIVE. I saw we also had similar state change issue with firmware activation 
>> code which was fixed by explicitly transitioning the controller state through RESETTING ->
>> CONNECTING -> LIVE. We may employ the similar solution here for subsystem reset case as well. 
>>
>> Currently, the NVMe PCIe subsystem reset code performs the following steps:
>>
>> 1. Sets the controller state to RESETTING
>> 2. Writes the subsystem reset command to the NSSR register
>> 3. Attempts to transition the controller state directly to LIVE
>>
>> This effectively bypasses the CONNECTING state. The transition to LIVE is artificial but
>> intentional, since writing to the NSSR register causes the loss of communication with the
>> NVMe adapter and the controller must be marked LIVE so that any in-flight I/O at the time the
>> subsystem reset is issued, or an explicit MMIO read, can trigger EEH recovery and ultimately
>> restore communication link between the NVMe adapter and the system.
>>
>> With the stricter state transition rules introduced by commit d2fe192348f9 (“nvme: only allow
>> entering LIVE from CONNECTING state”), the direct transition from RESETTING -> LIVE is no longer
>> permitted, rendering the current logic ineffective.
>>
>> Taking a cue from the firmware activation fix, it seems reasonable to explicitly transition
>> the controller state through CONNECTING in the subsystem reset path as well. So how about making
>> the following change to fix this? 
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index 0e4caeab739c..3027bba232de 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1532,7 +1532,10 @@ static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
>>         }
>>  
>>         writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
>> -       nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE);
>> +
>> +       if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
>> +           !nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
>> +               goto unlock;
>>  
>>         /*
>>          * Read controller status to flush the previous write and trigger a
> 
> This seems to be similar to case where the firmware update got stuck [1].
> 
>   650415fca0a9 ("nvme: unblock ctrl state transition for firmware update")
> 
> From my understanding this should work, but it's probably better to
> double check that this doesn't violate any assumptions.
> 
> [1] https://lore.kernel.org/all/aBJJQoOBhaXj7P36@kbusch-mbp/
> 
I have tested this (and I believe John as well) and this seems tobe working good. From my code walk through, the controller state
transition RESETTING -> CONNECTING -> LIVE looks good to me, so I'll
send out a formal patch for review. 

Thanks,
--Nilay


