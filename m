Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DD7C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 15:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NmfEZ5nloVnMKnpa4+SiXcTPTB2J3ofmALHRz5KYbBo=; b=CGhEcWRkemeHj9YuIOa+l2ruoE
	7zKkfJnBtTP8I2H37V6/y2xP3N560A4pARRZyi6g8FdVfpy65PkgFvMfZvdR7bdWXw5D4uN3eHm4X
	IQEb6K2cB9px/hjAD67yQaZ2vZLlXNSRzvfmrnFbEd4hGrfN2dN82XEEdfqULkyZAot1Ma4u5ZUco
	XAE3+uPGxk+XDx3rqj/IaGt9TLj/TM2WbbYaxRN0Sul1KH4yMf35KokBawmCFqlvz/bVPtoX2aSsS
	zdbBT8K8JCNGsHXnZq5ortlHI5D55kVDd/A2XZmTPzihuGLmezqEsE2X+Q61fusNVRn/ufi+McCpu
	iIlYLhKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbLa1-0000000Eyau-0Gsk;
	Fri, 24 Jan 2025 15:26:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbLTr-0000000ExIv-49K4
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 15:20:25 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O7QipN013507;
	Fri, 24 Jan 2025 15:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NmfEZ5
	nloVnMKnpa4+SiXcTPTB2J3ofmALHRz5KYbBo=; b=TLXQWYx5M636ipgGMwlYcQ
	Brl+dFRRkCK/Jdggy4Q3xy8aGL+2a81Gck4B0PU1HngMfFsEy/1Wo3XtvQSrtSal
	aByaG7GOvRDyGpu2kLVR+GttBeqfy/OWOga7a98uc7RulcvuNbFexDWANbnbhj6F
	J7hFdVRJrrf59V51q8+0V7UOX3hHSzVGZlIZbFi1VURLpex3i4g+/FxISvxU9i6z
	GrdcW4k4s3uTQjtqBLbJJUhCCUADiY8TodP/7bZVn0ZJm41AJ3J2Ig82zPKYWxt0
	J84A0w92knhAx67RAlIzXFaJWpjbEXg07xPJ08gjn/YCYpeEyFsolIgj7ibLW49A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c4p7u78n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 15:20:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50ODjCdx032261;
	Fri, 24 Jan 2025 15:20:12 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk3my4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 15:20:12 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OFKB3j57999836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 15:20:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 898C658063;
	Fri, 24 Jan 2025 15:20:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 76C085803F;
	Fri, 24 Jan 2025 15:20:09 +0000 (GMT)
Received: from [9.171.53.174] (unknown [9.171.53.174])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 15:20:09 +0000 (GMT)
Message-ID: <27504947-0407-4c8f-9431-b9e13de1168a@linux.ibm.com>
Date: Fri, 24 Jan 2025 20:50:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
        hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
References: <20250124082505.140258-1-hare@kernel.org>
 <afe8968e-ff56-4907-b3ec-a79ac75d5250@grimberg.me>
 <f2dc374b-0a08-48fa-bd9f-1cfccd34446d@suse.de>
 <c125b796-d1f7-4c6a-8e96-79aa80143456@linux.ibm.com>
 <0f18f1ec-5164-483b-99ec-2c6afdb45675@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <0f18f1ec-5164-483b-99ec-2c6afdb45675@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: St4rEWclqS0_LcV0aJiBEZalupU3VJNe
X-Proofpoint-ORIG-GUID: St4rEWclqS0_LcV0aJiBEZalupU3VJNe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_06,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=738 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_072024_041992_76ED715D 
X-CRM114-Status: GOOD (  13.37  )
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



On 1/24/25 8:39 PM, Hannes Reinecke wrote:
> On 1/24/25 15:06, Nilay Shroff wrote:
>>
>>
> [ .. ]>
>> Though I was never able to recreate this issue on my setup even after running
>> nvme/058 hundreds of times, still I think the issue reported by Shinichiro
>> appears plausible. So we need this fix and your changes look good to me.
>>
>> Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
> 
> Yeah, we definitely need this. I was able to trigger it quite consistently with qemu after just a few retries.
>
I was using PPC machine for testing, on which I couldn't recreate, but I would try using qemu.
I saw that Shinichiro also reported it on qemu.

Thanks,
--Nilay

