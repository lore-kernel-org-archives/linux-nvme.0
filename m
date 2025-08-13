Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04188C87FCF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 06:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+dZqnfFPrv4et8EQ0GCE6tDiPGdQs9wvkwh9nuLc5+k=; b=MF+y2JAEGh3FbPJvbimoBi0Tjt
	/r3+eogzWZ1P9Nme7eHVTeXZ2o6QRctj/lfpWFV8FhvqZ7ObuOCqKcKDb8UVki2zhFW4JK00e4Rud
	pPtm58JkrOWO84W9TKGOlKGzTRikVP+ABbDb8NidqlZx4YwNfWs9cN55mrz7oYVVwj32GfsBtbeCm
	S+vIr/dWY7/mgG7IfDXSPcQrJGGCjjXGyLF/S3dKIGgWngK6ftN8rkdoWgzMNRQdWYydMxJFgyh0f
	P5IeToIlDvEUP9ljQl6BqxazAyortzrDtzJ5BBkHJop9GY0Ucvbwocc0z0zU1j7fWLyQ2RVkWAAHR
	cL2iSwdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um4dd-0000000Ck2F-2s74;
	Wed, 13 Aug 2025 06:07:05 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um4YZ-0000000Cj1u-2Idn
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 06:01:52 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNur5S028484
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 06:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+dZqnf
	FPrv4et8EQ0GCE6tDiPGdQs9wvkwh9nuLc5+k=; b=VcW+f4g8lMO26be7hAfg7Y
	/jv6ltlrTuEIs+9869IM52pvmIvcAH4IPpIF5ZGGdsRaamSiMo+lEGI8EC2FAx0s
	nszDZNL/YAA3PB31BMd7IhDYhi4atfUT2Pl25ElrMpRDvJL8THmsbo9uXAdJgYl6
	LQn3vvTips/TxAc/BtNFpkY/pBME97vPQF5LL+sV2BVM5N2O7Giiah3SbdKX0I/c
	rS0nT8/NZbuznUvJDBI82DvqjCCn0AmHlKfihsqEkSajSkGBOoZ1vdLRHafbRCi3
	4ui1ExIiipBEXyV1NyxGujta8UPFrYNrqhqlnphaSF//tAM95mMPGsJ0+uja/52Q
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruashu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 06:01:50 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57D5qUnW013994
	for <linux-nvme@lists.infradead.org>; Wed, 13 Aug 2025 06:01:49 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48duruashs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:01:49 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57D4LdQ7017600;
	Wed, 13 Aug 2025 06:01:49 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3njy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 06:01:49 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57D61msD28770900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 06:01:48 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4CCB958043;
	Wed, 13 Aug 2025 06:01:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C8A258053;
	Wed, 13 Aug 2025 06:01:47 +0000 (GMT)
Received: from [9.61.63.67] (unknown [9.61.63.67])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 06:01:46 +0000 (GMT)
Message-ID: <cfdeca6c-bb83-4379-aff4-8a9f9b70f45d@linux.ibm.com>
Date: Wed, 13 Aug 2025 11:31:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to reconnect namespace via NVMe/TCP
To: Anton Gavriliuk <antosha20xx@gmail.com>, linux-nvme@lists.infradead.org
References: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <CAAiJnjqKqMHjrPLOvY5sCXiQR0n6pMvm2mS5pQEqy2XY1cD_6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WTEURRSbq_7UfMH7fPNUtaiGuG_qvAe1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX7KuVxGtlkT8n
 fXKr/RrbLvolqAE1MbJtnRNeopQXhOzsDOO2PxoZNjUwXi2k5JWpHnnwQQIR4Vdaa6GQ135poBI
 010dZNRAhiBw5TVHQkR5yofFB7SZ966v13JZGoEyMsbA/58YgUK/z0Jxee+GqsCBt/M1D7bBlGJ
 vfl8apjVl35JzJui2JTRorM598gG+y7JiIWjCEP+ns5wkMdN5Medi3n/pvm5PtuWmAQS/IPPCe2
 Q2RT+Nf5DNlUyj9rnm0VGPypNipXx8A9MN0YFQ2zkkrrDLwX7rp7izaX1DVCMno+22aBGp0h9vD
 PjbQN6smexNCxI1h2/Qc8YAQhBtK+/HYvP+vEY4KGTP6YXc7S7E3nqCgZ0t8ob3FWZrV1cxNNOL
 URStCI0/
X-Authority-Analysis: v=2.4 cv=QtNe3Uyd c=1 sm=1 tr=0 ts=689c2a4e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=wCSkzWKFi4b8S2Gbj9gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: TokyUPKbDYbEIYj7LL82PyH83-RG8xSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250812_230151_718546_9B352DA2 
X-CRM114-Status: GOOD (  18.40  )
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



On 8/12/25 9:18 PM, Anton Gavriliuk wrote:
> Hi
> 
> There are NVMe/TCP target and initiator servers, both running on
> RHEL10 (6.12.0-55.25.1.el10_0.x86_64)
> 
> NVMe/TCP target exports single NVMe SSD
> 
>       "namespaces": [
>         {
>           "device": {
>             "nguid": "01000000-0000-0000-8ce3-8ee3064aa4f2",
>             "path": "/dev/nvme0n1"
>           },
>           "enable": 1,
>           "nsid": 1
>         }
>       ],
> 
> If NVMe/TCP target is not available, initiator tries to reconnect
> every 10 seconds
> 
> [ 2586.071048] nvme nvme9: failed to connect socket: -111
> [ 2586.071403] nvme nvme9: Failed reconnect attempt 16/-1
> [ 2586.071565] nvme nvme9: Reconnecting in 10 seconds...
> [ 2596.310921] nvme nvme9: failed to connect socket: -111
> [ 2596.311186] nvme nvme9: Failed reconnect attempt 17/-1
> [ 2596.311349] nvme nvme9: Reconnecting in 10 seconds...
> [ 2606.550772] nvme nvme9: failed to connect socket: -111
> [ 2606.551252] nvme nvme9: Failed reconnect attempt 18/-1
> [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> 
> when NVMe/TCP target become available, initiator failed reconnect the namespace
> 
> [ 2606.551592] nvme nvme9: Reconnecting in 10 seconds...
> [ 2616.793080] nvme nvme9: creating 16 I/O queues.
> [ 2616.829881] nvme nvme9: mapped 16/0/0 default/read/poll queues.
> [ 2616.833685] nvme nvme9: Successfully reconnected (attempt 19/-1)
> [ 2616.834446] nvme nvme9: identifiers changed for nsid 1

It seems after the initiator re-connected to the target, the namespace
identifiers (UUID/NGUID/EUI64 or CSI(command set identifiers)) have
changed for nsid 1. So host kernel removed this (nvme9n1) namespace.

> [ 2616.835618] block nvme9n1: no usable path - requeuing I/O
> [ 2616.856602] block nvme9n1: no available path - failing I/O
> [ 2616.856811] block nvme9n1: no available path - failing I/O
> 
> and there is no nvme9n1 namespace in the "nvme list" output.
> 
So you may check on the target about what could have possibly changed
during reconnect time window for nsid 1. 

As a side note, it’s generally best to reproduce and report issues with
an upstream kernel when posting to the kernel mailing list. This helps
ensure the report gets prompt attention and makes it easier for others
to debug and assist.

Thanks,
--Nilay


