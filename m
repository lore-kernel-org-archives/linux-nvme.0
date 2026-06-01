Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73B0CD6E4C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 06:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEfKct+yq7x8QADBhtX8ax8M340MSsFVRrf3ik9DM/M=; b=vR1cldNOp3P3D9Gh/Q93BomwHA
	RhkGQhdTlcfu4hQel3WVAfQ4iqUJ3LP/Qyl5LJUNJvUNCXc8Zfl0z4BIBBLh/aUOC8ZZPWbAt6mia
	2Zpdo2kMWubqchCynjrnkP6DVrfDNC+6NP4m01kHXPYu4wb/LmzZCsRu52d6dj+mSb36h+H5HJEiN
	LBBzN1PBwGyeh1kKNrv/wZevbBUk4mP2zitxM07/K77rgwl0GSmf90E7tGP7e2z8e3Iv1WwyL/L4F
	NOeMX6p8eBGZesnJ8aNG5JAjZKi2l39wM/sNs6PO8bbjFhvZcWp/DyupVQLQqPoqFY9YKZGPyP65m
	lWYJvQww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwQa-0000000AEEI-2gFP;
	Mon, 01 Jun 2026 06:47:12 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwQX-0000000AEDx-13RS
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 06:47:10 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65137w3O3293619;
	Mon, 1 Jun 2026 06:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hEfKct
	+yq7x8QADBhtX8ax8M340MSsFVRrf3ik9DM/M=; b=GuSyOYffQ3X3VnwaDCO90G
	sxAZ47rnSOZ6Y7vMu21qhbzKkMVB3L06BXhPhgSolhL1cHzdfuJ/2mhcMR9gRbbs
	E2fpi37mM302YIxgpb/aqf3O8VJHJBcr2fh3CJfjDSQnCw6eVyviu60CQmtGu8s2
	fsPz0prezfsEgC0uI/d4o6ovxrSb8vkCXez/yMU3j6lArkGd7WD6gEUfi0wxJq0U
	jgjBe8iK+48nkn4hCvu7R59FybXu3I0FmCqWaOdDg6T5Oe63y/gM/Q5wqpBpv9ZH
	v8fHVFbsZsVw4NS7+RLGw9X8na1D0tIVNMYPJodDYVcih1YKla0uC71TbSph7VvQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahf8gk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 06:46:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6516dPcH005184;
	Mon, 1 Jun 2026 06:46:56 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jvt1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 06:46:56 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6516ktRw41550554
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jun 2026 06:46:55 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6633458043;
	Mon,  1 Jun 2026 06:46:55 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3868058055;
	Mon,  1 Jun 2026 06:46:52 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jun 2026 06:46:51 +0000 (GMT)
Message-ID: <0bd4b5ed-c292-490d-ba2a-df4e7590012a@linux.ibm.com>
Date: Mon, 1 Jun 2026 12:16:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linux-next20260529] WARNING: kernel/workqueue.c:5855 at
 __alloc_workqueue+0x62c/0x690
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
        jiangshanlai@gmail.com, hch@lst.de, sagi@grimberg.me,
        kbusch@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
        marco.crivellari@suse.com
References: <dab729b3-fa8e-4d17-894d-07f0c6845e01@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <dab729b3-fa8e-4d17-894d-07f0c6845e01@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA2NCBTYWx0ZWRfX07TDZSsbIHaE
 DNl5MdElL7LZjVmnNBn4eSni40qtqQmheKKgV/PImEmqtIvclKRlnbJFscGNLQG3k7nnzF03jDw
 h7IKQLIHRBCQY247DTbScYXiPXs+Z27w9pRwWns/nCkOtcrO79wBOGVb66qmTEl/9YndYskzRXQ
 ORQP1xmRHxomLGmj3fumGTSNy0GL4z6EERMdLKuO1pD8NGzkE/39pcjJgO9eQfNTaHueBEkr9AJ
 0AjKdIGEphOW7d4QhN5PFmyvFr7E5SqXuLbKoiBUme0OlD157Rh3f3nJrZZIGmPDgokJldRp6S0
 fYu+XiYYAPysu8GiJtHJNnx7QH6vJplYlMu8Kx8Lv55ZDI//eB9fRTgIGQYM5LybzC7C1POE2wf
 Pr82BEbfTJbSJxYj8U7VYokTgWn/qDz9eD+MNZFT5T+tuixYuuIKCkEQpkP8Vg4mzqIst+7cQx+
 ATd7zCuc92P4vsnSleg==
X-Proofpoint-ORIG-GUID: 0gbqG-G1f3uEu1hwLQsBjJu8VTDbpLhu
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1d2ae1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=1XWaLZrsAAAA:8 a=sqeWFfpG6kVFigcpmYgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: mjXFN--hxfJkAaetAiIR67fJA77mBedn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_234709_406821_8A68FC92 
X-CRM114-Status: GOOD (  11.86  )
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

On 6/1/26 11:40 AM, Venkat Rao Bagalkote wrote:
> Greetings!!!
> 
> I am observing following boot warning, appears to be triggered by recent WQ changes.
> 
> Test environment:
>    Kernel: linux-next-20260529 (7.1.0-rc5-next)
>    Arch: powerpc (Power11 / pSeries)
> 
> 
> Warnings:
> 
> 
> 
> [    1.933519] ------------[ cut here ]------------
> [    1.933523] workqueue: nvme_tcp_wq is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
> [    1.933531] WARNING: kernel/workqueue.c:5855 at __alloc_workqueue+0x62c/0x690, CPU#19: modprobe/573
> [    1.933539] Modules linked in: nvme_tcp(E+) sd_mod(E) nvme_fabrics(E) nvme_core(E) ibmvscsi(E) ibmveth(E) scsi_transport_srp(E) dm_mirror(E) dm_region_hash(E) dm_log(E) dm_multipath(E) dm_mod(E)
> [    1.933553] CPU: 19 UID: 0 PID: 573 Comm: modprobe Tainted: G   E       7.1.0-rc5-next-20260529 #1 PREEMPT
> [    1.933559] Tainted: [E]=UNSIGNED_MODULE
> [    1.933561] Hardware name: IBM,9080-HEX Power11 (architected) 0x820200 0xf000007 of:IBM,FW1110.01 (NH1110_069) hv:phyp pSeries
> [    1.933565] NIP:  c00000000026f59c LR: c00000000026f598 CTR: 00000000005d54a0
> [    1.933568] REGS: c0000000097ff600 TRAP: 0700   Tainted: G       E     (7.1.0-rc5-next-20260529)
> [    1.933572] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 28222282  XER: 00000004
> [    1.933581] CFAR: c000000000234154 IRQMASK: 0
> [    1.933581] GPR00: c00000000026f598 c0000000097ff8c0 c00000000205b200 0000000000000053
> [    1.933581] GPR04: 3fffffffffff7fff c0000000097ff6b0 c0000000097ff6a8 00000013f6440000
> [    1.933581] GPR08: 0000000000000027 0000000000000000 c0000000c90b2a00 c0000000037ae1d0
> [    1.933581] GPR12: c000000003b2e160 c0000013fffa2300 0000000000000000 0000000000000000
> [    1.933581] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    1.933581] GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000003fb5d18
> [    1.933581] GPR24: c000000003fb55b0 c000000008acc2b8 c008000005390180 c0000000097ff9c8
> [    1.933581] GPR28: 0000000000000000 c000000008acc200 0000000000000000 0000000000000058
> [    1.933619] NIP [c00000000026f59c] __alloc_workqueue+0x62c/0x690
> [    1.933623] LR [c00000000026f598] __alloc_workqueue+0x628/0x690
> [    1.933627] Call Trace:
> [    1.933629] [c0000000097ff8c0] [c00000000026f598] __alloc_workqueue+0x628/0x690 (unreliable)
> [    1.933635] [c0000000097ff970] [c00000000026f634] alloc_workqueue_noprof+0x34/0x50
> [    1.933640] [c0000000097ff990] [c008000005316428] nvme_tcp_init_module+0x54/0xf4 [nvme_tcp]
> [    1.933645] [c0000000097ffa10] [c000000000010f7c] do_one_initcall+0x5c/0x45c
> [    1.933650] [c0000000097ffb00] [c000000000358b10] do_init_module+0x70/0x380
> [    1.933655] [c0000000097ffb80] [c00000000035ac10] init_module_from_file+0x110/0x130
> [    1.933659] [c0000000097ffc60] [c00000000035ad84] idempotent_init_module+0x154/0x3c0
> [    1.933663] [c0000000097ffd20] [c00000000035b080] sys_finit_module+0x90/0x150
> [    1.933667] [c0000000097ffda0] [c000000000034318] system_call_exception+0x148/0x4b0
> [    1.933672] [c0000000097ffe30] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec
This is already reported here: https://lore.kernel.org/all/6a1a9a86.323e8352.141b09.0001.GAE@google.com/

And the fix is posted here: https://lore.kernel.org/all/20260530081059.428303-1-kuniyu@google.com/

Thanks,
--Nilay

