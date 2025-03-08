Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A80C282EC
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Mar 2025 07:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OxW4auNUvw5b5xUoTFkDffDghvbqv1E2gELwnGh1Mf4=; b=m87kjoJ/bQb5NgzrYxOPH2vNBG
	GZIH4p2VU8+IQAgG+iTMD4oHi87JdlkpUTa8xfyEyov1mf78Mzamh+BFwOySrc6zGwphAIAz6qBI8
	GbtJjJ91p1vIK/r6tT/3cYUx0r4liCh8yb5Q5rvGn8bYqQ8owIpuSnCekw4XNHyTO/FSuEd4o/WD3
	LWBCCTj/JkAJB+ULOVlKG2KafQ3X9U8iK2eYolmaqymaiHFdO6xHtnpvc3CrhzuOfE6iXL+x1uydS
	me0e9eE7so2bLjDojUp7cHrZajBRPSC/1K677s3CQcuNsqkCLmXqLT5OR952/zHMK8uYmmKOXe7Gr
	JR2uQcBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqobM-0000000GIXG-29ts;
	Sat, 08 Mar 2025 07:28:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqobJ-0000000GIW4-3Kov
	for linux-nvme@lists.infradead.org;
	Sat, 08 Mar 2025 07:28:03 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5285x8l1012346;
	Sat, 8 Mar 2025 07:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OxW4au
	NUvw5b5xUoTFkDffDghvbqv1E2gELwnGh1Mf4=; b=iDG6b5dcl6fZV7i96ocaRS
	CyfbWlXU/mZR06U2leebmLC6vSF2s9qXIkwmChoYvIQvGWRGq0TvYmDuQ2DnSuOd
	EW1gNyPI+hO75pZGA2NA6NeLe1Ms6t1loj/9+JGA1YXkadbGOqynkCWmYzQ3Mq4Y
	8qjte9lOPH28Z1Tr0RUhQ1pmPLUPU/I2yDZj4nCalWpaKNLS2/DM8vwDVEVK8Bx1
	fRfmzO8fw+q7FyPidaJAvySqEk05P6UhrKtiNAiBMcPrxc41lLNYaNiwp65YwSnv
	6mVvnySy+MditDuNYnNpysCOwzCQecnqNK6sJlyo40VvpdEJ+x5dqemJXSnqnNIA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 458caj8v7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 07:27:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5284k91N025016;
	Sat, 8 Mar 2025 07:27:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 454f92jqte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 08 Mar 2025 07:27:54 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5287Rrtd27001466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 8 Mar 2025 07:27:53 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A7B58059;
	Sat,  8 Mar 2025 07:27:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC5FC58043;
	Sat,  8 Mar 2025 07:27:51 +0000 (GMT)
Received: from [9.61.47.242] (unknown [9.61.47.242])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  8 Mar 2025 07:27:51 +0000 (GMT)
Message-ID: <3dcf210e-a714-4572-bd5b-01c66c594fd9@linux.ibm.com>
Date: Sat, 8 Mar 2025 12:57:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: fix stuck reset on concurrent DPC and HP
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me
References: <20250307002424.3655342-1-kbusch@meta.com>
 <46617499-17ea-44b9-9ed0-1fb5d238f54f@linux.ibm.com>
 <Z8sPwJw2oQH3slpT@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Z8sPwJw2oQH3slpT@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K_UHKb2q0Zk7net8y493memWAIzRS5uB
X-Proofpoint-GUID: K_UHKb2q0Zk7net8y493memWAIzRS5uB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-08_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=804 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503080050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250307_232801_967021_4A624D03 
X-CRM114-Status: GOOD (  12.74  )
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



On 3/7/25 8:54 PM, Keith Busch wrote:
> On Fri, Mar 07, 2025 at 06:28:28PM +0530, Nilay Shroff wrote:
>> Though one question: IMO, the DPC error handler shall invoke nvme_error_detected() prior
>> to nvme_error_resume(). And we already disable the device (and cancel in-flight IO) in 
>> nvme_error_detected() and so wouldn't that help? 
> 
> The sequence is error_detected, slot_reset, error_resume.
> 
> The slot_reset schedules the nvme controller reset. That work sends
> amdin IO, like identify controller.
> 
> If the pciehp removal starts after reset work's controller
> initialization, then nothing stops the work from sending new admin
> commands, and nothing will complete them. This causes the error_resume
> to wait for something that will never happen.
Ok makes sense, this appears to be a tight race condition and may not be 
limited to one platform. This should be possible even on PPC.

Thanks,
--Nilay


