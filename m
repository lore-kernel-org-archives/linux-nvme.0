Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD1FEA853C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Mar 2026 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u1LKCmc+VNEggmuvPA93nsmONhKai0+cB0m/mRYsqBw=; b=jk8d70NJdb8BQKoUlUSszYnWPF
	XPUIG3t5wWzpOqQxuJ+ZUWKHclVdn7xa/efgRO3k5BfqmoGBBfhMHf2SzdjUZPrZQL7+HoCT6VDfG
	i7ZzoFCSFbZnGjywUOzJmsNgR000w8OcaRlljU4E+nIsWcSe9DIYwI+oGxydNqZrJz3TlE11qJWeP
	hcDbKH+tecPnaVcyXcRaRHpSu/qkkmz6UERRQ/xpzBLLkgbbZuqx7U/SXkwwa6unnuDcEwt24Lib7
	LfStZOhx5FWvx+w1PzMhmMsAIL3Q9y07POtyx0rgqA2Mikg4ZHRV0X48TRVIRYzewshUaFDOkz446
	Gq+fl39g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzJIY-00000006GxP-06qG;
	Sun, 08 Mar 2026 18:56:18 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzJIU-00000006Gx3-2Hxa
	for linux-nvme@lists.infradead.org;
	Sun, 08 Mar 2026 18:56:16 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6283rWGu3727606;
	Sun, 8 Mar 2026 18:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=u1LKCm
	c+VNEggmuvPA93nsmONhKai0+cB0m/mRYsqBw=; b=pfCJ/mOOfuT7r9DuuH2R09
	+zIOc3iGIXoR71zl0h8U5D3TTqS90JEwFHIhRY5MTr0RbjPX8/ptsfrrg2qUFsiU
	jn0t7mlfEK7vyhRLpEGldJkDzVucXnuuUc4r1RHsm2ke0Ng1lNLjlowj/u/f5J1q
	Ws8gQK4WrKWhPh9E79+eoVcb5HWxGR1IqUI2koNYkfQSw+OXQTygSiLHV/nCyyuh
	90uT0wImuylilsS15K1KD+EBJZA/VcPdqNkL9m3eC78U3F9RDBxGzDkLa9LQcr8D
	GAHDthQlW4OpVchBtwujrHdenKgVPUtyqkPvUHdYWxBi1p69Pd0Z3TLN2mDxlf3A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr3ycg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 18:55:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 628Ffv6N023217;
	Sun, 8 Mar 2026 18:55:56 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cryuka7bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Mar 2026 18:55:56 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 628Itthp32244462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 8 Mar 2026 18:55:55 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0A34758059;
	Sun,  8 Mar 2026 18:55:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 725D758058;
	Sun,  8 Mar 2026 18:55:51 +0000 (GMT)
Received: from [9.39.20.31] (unknown [9.39.20.31])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  8 Mar 2026 18:55:51 +0000 (GMT)
Message-ID: <a1acd62e-3e22-42eb-b634-3e9ab18bc39a@linux.ibm.com>
Date: Mon, 9 Mar 2026 00:25:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
 <aar6j8S1O-mjqqxN@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aar6j8S1O-mjqqxN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA4MDE3MSBTYWx0ZWRfX+B3CZsI7VJAQ
 RObEQzDqsK0xM5c491qptRqTCOyHLxfMXNkJmEZ+RF8zMh+f3mqtZB+LJOSMBqqtzfBxn/pOZUS
 rcr5PmRnIU0MnLL5MeAuBkImkEFwPgbpSAnt/h+nAJTxwGtIuJu9QprFaL0ZkQtw9WAoqeCX0VS
 AZNrarmz1F806yvUzkz/VjoLBiIDE9NIKQbNCpRw/xeaIJmQAvPptS0fkXO3ngJdIxtjwckMmud
 IGlynT7hv7D1T+VYQ7NC2RT312dDsPErUiYqJ/7IfItAlTRTYxMPHBFBERBlq3Dczr03r4JZlyE
 XZ+jDMlU0in2wmwMhtkiG5vMhOP2VcE6ebN1YpV+775JzWTcG7l/A2NQuwGxqye7kMeCNMX0OrV
 5ZV3hcEHKbaXhmLqgwoZongUxkPN0Y08k3kDqQ7rBAh7tft6Bnd5PzX6wCsUlbmaPWts5eYdwLq
 acNmJo0kzuoUbLOzHAA==
X-Proofpoint-GUID: yFXYLCByQ7fPtH3-n8JiyCscETKSxcUo
X-Proofpoint-ORIG-GUID: yFXYLCByQ7fPtH3-n8JiyCscETKSxcUo
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69adc63d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=DF0ByOvgJZtk_k9QTT0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-08_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603080171
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260308_115615_067228_A96EDE34 
X-CRM114-Status: GOOD (  31.60  )
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

On 3/6/26 9:32 PM, Keith Busch wrote:
> On Wed, Mar 04, 2026 at 08:03:02PM +0530, Nilay Shroff wrote:
>> Hi Keith,
>>
>> A gentle ping on this. I´ve incorporated the review comments,
>> and the series has already received Reviewed-by and Tested-by tags.
>>
>> Could you please consider pulling it? Also, please let me know if
>> you have any further comments or if additional changes are needed.
> 
> Thanks, I was hoping free time would show up to let me look closer at
> this, but that doesn't appear to be happening, so looks like I have to
> force the time :)
> 
Thanks for your time and review!

> We always need to be a bit cautious on adding user visible attributes,
> so just throwing out some thoughts on this feature.
> 
> The event counters are not atomic. I know these are informational, so
> maybe it's not important to be 100% accurate in the reporting, but I
> don't know. Maybe you do want accuracy in which case using atomic_long_t
> might be the right type. I think that should be okay to use since none
> of these counters are in the normal fast path.

Currently the counters are implemented using size_t and updated through
the size_add() helper to avoid overflow (as you suggested earlier in the
review). Since these counters are not updated in performance critical
paths, switching them to atomic_long_t should be fine. I'll  update the
implementation to use atomic counters.

> 
> The names of the attributes are a bit inconsistent. Some have a "_count"
> suffix, some have "_events" suffix, and some have no suffix at all.
> 
Yes, I originally chose names that I felt were descriptive while trying
to keep them concise. However I agree that consistent naming is more
important. I'd update all attributes to use a uniform "_count" suffix.

> In order to keep sysfs a bit cleaner, should we consider moving these
> attributes under a sub-directory specifically for reporting event
> counters?
> 
The counters are currently exported from different objects depending on
what they represent. Some are per-namespace path, some per-controller,
and others are associated with the namespace head. Because of this
separation, placing all counters under a single sub-directory would
not be feasible.

If the concern is reducing clutter in existing directories, we could
instead introduce a dedicated sub-directory under each object and export
the counters there. For example, we could create a "diag" directory under
the per-ns path, controller, and ns-head directories and then export the
respective counters under "diag". What do you suggest?

> Last thought, as you are probably aware, John Garry is proposing to
> lift the nvme multipath into a generic library, which suggests many of
> these events would also need to be generic. Should some of these, like
> error and retry counts, be appended to the generic disk stats instead?

Yes I am aware about libmultipath work.
I agree that retry and error counters might conceptually fit into
generic disk statistics. However the intent of these diagnostic counters
is to capture all relevant events, including passthrough commands.

Passthrough requests are typically not accounted for in generic disk
statistics, which makes that interface unsuitable for these counters.
Additionally some counters are reported at the controller level, and
controllers do not have an associated gendisk or block device.

For these reasons exporting them through the dedicated sysfs interfaces
appears to be the most appropriate approach.

Thanks,
--Nilay


