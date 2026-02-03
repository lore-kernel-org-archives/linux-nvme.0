Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085FDE8305D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bSuXuNOrUrG4AGf3Y8XO++Hp1DvYsJxHkI4SoDjb+Y0=; b=XdKyyCGcvU+3AqjjbtJ2f2PYQ4
	0afa+6LOwCCoFcxT0Kjl3EjiFq19U4fLkkvfU1VXqUs3aQw5/1N3YxHQcJcMmiLldeojUD+x91dGP
	k4ht5vWHXon/ftyL1FXH287p/d0Xmbug8TFBzVDJPe/cbbQMKsdMYglNQs+wRrPv5oSe70pZOO6Ov
	U+7Vemdef1eUD477p8xHI82TY8massr2lJcHW8K6fzDsTUMSPIodyzqPS6hc98p8mBePWbAm4WHKd
	9jUrs95ZDCj1d/eHv93nWlRVDtL6U4n8rEf+s14JP0oI0ud0a3h92BqsmJetvGATH+crW1qrcBDP6
	uJblzLsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnCNv-00000006Lvb-3Elf;
	Tue, 03 Feb 2026 09:07:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnCNs-00000006Lus-438F
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 09:07:46 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6138kqWG006454;
	Tue, 3 Feb 2026 09:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bSuXuN
	OrUrG4AGf3Y8XO++Hp1DvYsJxHkI4SoDjb+Y0=; b=ogFj8ZYyQ7rQ0aWwxB1Fkx
	20QuF8SbWmg/9xhujK1kuHpb3NWb1eqkR8eN7i/EvimYmsME+fzf1miN4Cz6FPVO
	dxrFE0XJyWhQyLLOevLcvAGtUoDEIgGLfJDx+b2SZ9XU75VYkQI1qUppIcTivTQv
	GMGLK16GTkgguYghwnsz2aNI4S1I0r7u9bGeVfpjZ65WeMtNzJULtBJxAYqt/pj/
	FKeo41eZrDRqSP/hQO3JyhIg2xa1NCSdRsMgFOOszhoaBbdSLSJ/82/mQ6g3hJgT
	oy/HZmYfILiy93Bad2xblc1o9VN42Cr3fbPKmC6RCVJx1zurfRwO+3xsFLoBtEQw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19cw2a6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:07:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6135o5Jr025735;
	Tue, 3 Feb 2026 09:07:30 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2mrf81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:07:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61397T3H48431520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 09:07:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0114058043;
	Tue,  3 Feb 2026 09:07:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D5C55805F;
	Tue,  3 Feb 2026 09:07:24 +0000 (GMT)
Received: from [9.111.10.240] (unknown [9.111.10.240])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 09:07:23 +0000 (GMT)
Message-ID: <141abf9e-19e3-467a-9c49-c0d6cc9c64d6@linux.ibm.com>
Date: Tue, 3 Feb 2026 14:37:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] nvme: export additional diagnostic counters via sysfs
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260130182028.885089-1-nilay@linux.ibm.com>
 <e55134c8-4429-477d-a2cd-290a2eb31d20@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e55134c8-4429-477d-a2cd-290a2eb31d20@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3MCBTYWx0ZWRfX5ltU4+J4DrIo
 EY2JxACOgE98NzmCSkV/C7TLZqaRm4d7VyYpJm/V7Pbv21tcy/G5oljSh5dD07oAX81Fq2sP20f
 NNytn228maodYCQatGhljVyNAEhsXfyb1rQI3nhUPXcTWe0e0SHfD6M9WqORxURblheKpDNhm/Q
 pk13sYlwDqIoMlvIC34TJ/KsqWFTTZy/vUiAzRxp2toTXI2YOcdKV5hWTuwFBuuxQxQLHWhc2jv
 h4fY4Osog/3Nde9JXZ6rcIfG3X86IZiCpoZa+A5U+YAvTkC2SDy5Qgy7cG8CacyWn3fvo1vrU47
 SpLzitkIKW1zVxPAaSHnmzrmeqPyKZcdp0gQiHo5hlor7Zpq6XmfNupNkGBIQ0vyNSn3QXIPXe5
 IouuRhQaYnNXqr0kOLWQiiqs/zYqKf+GE3aKcM5lYrSmR65XfJqYv4qeh5dt2r6qq0+8JdIHp4k
 mz48iZMoIrbPfQVivxA==
X-Authority-Analysis: v=2.4 cv=UuRu9uwB c=1 sm=1 tr=0 ts=6981bad3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=ICEAtLpkEK5fc4LwV1wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RZtSGyn-AMcQDMQsWA68RJHwFfv6uURN
X-Proofpoint-GUID: RZtSGyn-AMcQDMQsWA68RJHwFfv6uURN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_02,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_010745_148283_59930461 
X-CRM114-Status: GOOD (  20.14  )
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



On 2/3/26 4:26 AM, Hannes Reinecke wrote:
> On 1/30/26 19:20, Nilay Shroff wrote:
>> Hi,
>>
>> The NVMe driver encounters various events and conditions during normal
>> operation that are either not tracked today or not exposed to userspace
>> via sysfs. Lack of visibility into these events can make it difficult to
>> diagnose subtle issues related to controller behavior, multipath
>> stability, and I/O reliability.
>>
>> This patchset adds several diagnostic counters that provide improved
>> observability into NVMe behavior. These counters are intended to help
>> users understand events such as transient path unavailability,
>> controller retries/reconnect/reset, failovers, and I/O failures. They
>> can also be consumed by monitoring tools such as nvme-top.
>>
>> Specifically, this series proposes to export the following counters via
>> sysfs:
>>    - Command retry count
>>    - Multipath failover count
>>    - Command error count
>>    - I/O requeue count
>>    - I/O failure count
>>    - Controller reset event counts
>>    - Controller reconnect counts
>>
>> The patchset consists of seven patches:
>>    Patch 1: Export command retry count
>>    Patch 2: Export multipath failover count
>>    Patch 3: Export command error count
>>    Patch 4: Export I/O requeue count
>>    Patch 5: Export I/O failure count
>>    Patch 6: Export controller reset event counts
>>    Patch 7: Export controller reconnect event count
>>
>> Please note that this patchset doesn't make any functional change but
>> rather export relevant counters to user space via sysfs.
>>
>> As usual, feedback/comments/suggestions are welcome!
>>
> 
> While I do agree with the general idea, I do wonder whether debugfs
> would not be a better suited place for all of this. Having all of
> this information in sysfs will clutter is by quite a bit, plus we
> do have the usual issues with ABI stability if we ever see the need
> to change (or, heaven forbid, remove) any of these counters.
> 
> (And when doing so it might be an idea to add a 'version' entry
> to debugfs such that we can manage userspace expectation).
> 
I understand the concern regarding ABI stability and potential sysfs clutter.
However, one of the challenges with relying on debugfs is that it is not always
guaranteed to be available or enabled in production environments. As a result,
exposing these statistics exclusively via debugfs could limit their usefulness
for real-world deployments.

These counters are intended to be consumed by user-space tools such as nvme-cli/
nvme-top, which are often used in production systems for monitoring and diagnostics.
Depending on debugfs in such cases may therefore not be reliable.

In fact, there has been prior discussion expressing reservations about relying on
debugfs for NVMe-related statistics. For example, Daniel previously raised concerns
in the context of nvme-cli:
https://lore.kernel.org/all/803f429d-60f3-4af7-9535-37a2038e53c1@flourine.local/

Given this, IMO, exposing a carefully scoped and well-documented set of diagnostic
counters via sysfs seems more appropriate for long-term usability, provided we
remain mindful of ABI stability considerations.

Thanks,
--Nilay






