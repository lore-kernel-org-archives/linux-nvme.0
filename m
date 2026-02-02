Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E90E7316F
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Feb 2026 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ewn0iH3KEpVKwSdvZLlI6P7TBqv9dLAsefp//lvAtWA=; b=sBSSpOM6TVhADB2Hm5IzsL83mW
	A/153iMLFmguk0SgDFu+Hrpq3wXG0eYM0QwwV+ehl+oCiJFC9/yo94F1KDi54opUUMlnXeQv2HMCC
	bJW32vgitcNGALqf2xh+xNwMiQ1rM9iuDtkqNi0EfgnAG+nqTQyQZhyNcv3QbjVcx7gp7QXcYdQAL
	violSnDyT4WJuBifvaBoJxEGYDYxbRewHVQa7dTzCAOtIq7kM3E5Nas6NZ0EOxJ77gS+M3zjRoWbf
	g20rmMQwI0xf2yjXIR0gc1pVeCnvFXxf/YL8cwfN2zvz5ejtpRtpIwG+MYKtWLYVQHJvCouh6EmNV
	SXSTgmsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmu41-000000050vv-3GzM;
	Mon, 02 Feb 2026 13:34:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmu3z-000000050vX-1Cnh
	for linux-nvme@lists.infradead.org;
	Mon, 02 Feb 2026 13:34:00 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 611MmDDw009119;
	Mon, 2 Feb 2026 13:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ewn0iH
	3KEpVKwSdvZLlI6P7TBqv9dLAsefp//lvAtWA=; b=XwNZ7zbJAz4xjfMzKTPaFe
	1YooESE7OfFd8Eo+yufdoQYJ6SfJIQluxDsz8ROHkkY6+DCMWvF6sTPliWdovrG5
	41Eo5loZqtY6HO+FUjhdmytDsJxnOO67f+tPcwGn7Xb5ol0ViW+pCLUaaDZrlMAy
	yfiWKKBgMtoNrEilwf2Qftr2YyJ/tJjI8Rroygxks6F3iS3VQ9POUow6tlb1sS1c
	zVe30bCQTHsE1jobUBgDbjg1Anh5pif1chVUkHFo1VvRssmnV3gdE8tzU4alF/hy
	cn9EWKwd6+LMBwt52LXggw6yKVvSPTPf9rORT3ZyutDfp9A3rcuBx2oyerVXJMPg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f68hqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:33:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 612At20D027348;
	Mon, 2 Feb 2026 13:33:40 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1xs14w1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Feb 2026 13:33:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 612DXbPE655928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Feb 2026 13:33:38 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D57EB5805D;
	Mon,  2 Feb 2026 13:33:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6078E58057;
	Mon,  2 Feb 2026 13:33:35 +0000 (GMT)
Received: from [9.109.198.179] (unknown [9.109.198.179])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Feb 2026 13:33:35 +0000 (GMT)
Message-ID: <72bf891f-5ffc-40aa-9b83-3e13065cabcd@linux.ibm.com>
Date: Mon, 2 Feb 2026 19:03:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] nvme: export command retry count via sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260130182028.885089-1-nilay@linux.ibm.com>
 <20260130182028.885089-2-nilay@linux.ibm.com> <aX0VgduYJckUaZ3O@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aX0VgduYJckUaZ3O@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HNR-Oi-TxjAU7WhVPjAKJ7qq0qe0L0Y3
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6980a7b5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jzdkrixA0WbepINQwXUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HNR-Oi-TxjAU7WhVPjAKJ7qq0qe0L0Y3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEwNSBTYWx0ZWRfX4gsG4XecYV1L
 JiZjx6OSOCysg+zWBM0qS/LNAVTMzSx9cKw/1S1l6vR+OT0Lj/8wgKGFmdT86xxlMU7aPGaRoRY
 pJJ+XzQ37c7lkup9GPGRRbdBY3lXskppCyv2THZxS//lfvH/9NffsMOpbD3Icmx2RROKehKbC3r
 MDFeVA8d4pGys/iS+C0fXrHO098tPIcGvO86aPE1hnRa/UgO3KfVm700YM3HZXj16rJwCHojNVj
 Yr57VQNA8Em2S2XrD8r8+UhU6ui3NT1AeWoyfAmfvJgVJRewApGAXhpxNegF+1ydmW4Bsp8soVZ
 d1UTETp3Aceo8VzRwWBKwxaDv7MpKmWvRgLzv6BRIMd2v3kcsyNnwp1nTyQ+ZnmK/A2y1DERA0H
 +UUFxwESru0vLdG+VSPKdi98P57FWVbwrC/hFfUHX6zxzUkqbbcqlZgrlARthDKYWCiVm6QyJ1P
 qDT6z+Aw8bOkzWFJ5/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602020105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_053359_370681_79306789 
X-CRM114-Status: GOOD (  13.92  )
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



On 1/31/26 2:03 AM, Keith Busch wrote:
> On Fri, Jan 30, 2026 at 11:50:18PM +0530, Nilay Shroff wrote:
>>  	nvme_req(req)->retries++;
>> +	if (ns)
>> +		ns->retries++;
>> +	else
>> +		nvme_req(req)->ctrl->retries++;
> 
> I don't think admin commands ever retry with this driver, so probably
> not worth tracking it.
Yeah got it. I will drop retry counter for admin commands.
> 
> And as unlikely as it is to happen, might want to ensure it doesn't
> wrap back to zero. The size_add() function handles that.
Sure, makes sense. 

I will fix these in next patch revision.

Thanks,
--Nilay

