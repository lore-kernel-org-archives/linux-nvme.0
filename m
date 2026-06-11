Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6C8CD8C9D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Jun 2026 04:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YX2cqt43HITd8kpaXThWXN5pEq5FYyPTg6EV9PoyboY=; b=LTY+tIlUkKm2ae+/33LD7KzwcE
	PxdGSsdK7ns0lbwl7YxcQNsKH7cu0yCzr6Omvn+T4JcWWseePatRyYxXpZQ5Ot990+fqaE8+2XJyI
	OsTrFKa1LiP2Y0gaXNSy9RtkgAkNFetFG8xUyC48lxjxeDYfVx9xSV0EmLAwCML3QC9KiNqH8sI8p
	gGpwtFRu7wc8pQbBDkZBpGMudxiPC4UuNDM8GKIWyWixfnwriW2w4OzKkx7IB8MXOH5C0W/9+Fve8
	MDjIT/n+rTl2UNNwNXA3Bj+gUVatWKUg8hCtqC6ni383tz0fPoHm1T40+3/Oh+NNF1xzmCJXcPrr7
	VaeyhOBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXX7z-00000008g8Y-1DQb;
	Thu, 11 Jun 2026 04:34:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXX7x-00000008g8D-1Iji
	for linux-nvme@lists.infradead.org;
	Thu, 11 Jun 2026 04:34:50 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu8aZ722342;
	Thu, 11 Jun 2026 04:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YX2cqt
	43HITd8kpaXThWXN5pEq5FYyPTg6EV9PoyboY=; b=HRnLx/HAPB/OZMQDY7ZTqN
	UlnsHx8Aq1pUtp+3AUkDMGZ3EkBkRdFeIfxXWM94o5GlKSLu4900JaIzfMcMYbO7
	yaFJg/SHy09ptgZES55Ve1iCG3Pb/pzLXD8gu9MM441IpKsnFmdmWZUHnqZRVHSY
	AAsl7xJ31xyndbnK/jdsvBcDUO9nSsx0PiBxRbhUypoMA6CLMsm2wRiNoNaxxgsS
	K+v9nwPH+hwERBMVMegxFbG5eGP9RXCMZyFuEovvRPayMC0Qa9NU5CurajbSDjjc
	d7asmSTJnL8Reog90bIn3MexqoBxDqbuAXVNlMdrPPvyTGw41hV3C6NRs8FoNXtg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8d9dxp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:34:32 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65B4JhdS007789;
	Thu, 11 Jun 2026 04:34:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe0a1m4j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 04:34:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65B4YVIH33620688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 04:34:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5C058055;
	Thu, 11 Jun 2026 04:34:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C93F58043;
	Thu, 11 Jun 2026 04:34:27 +0000 (GMT)
Received: from [9.43.60.77] (unknown [9.43.60.77])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 04:34:26 +0000 (GMT)
Message-ID: <4dcc2ee4-fa8e-4bd7-a684-0711cc3840d5@linux.ibm.com>
Date: Thu, 11 Jun 2026 10:04:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/15] nvme: add Clang context annotations for
 nvme_subsystem::lock
To: Bart Van Assche <bvanassche@acm.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260610142743.115898-1-nilay@linux.ibm.com>
 <20260610142743.115898-8-nilay@linux.ibm.com>
 <bd51432e-616a-4a87-b006-3ff7e5aaaa27@acm.org>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <bd51432e-616a-4a87-b006-3ff7e5aaaa27@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDAzNyBTYWx0ZWRfX23GMzc1q2Big
 VZflO0O7nST61bsGDbyOuIUejhtJnN0ql0GYKo7+gtdsU8G04pX3fx+Qms4MdKJiY6/jIUjLDwt
 B37eCBb8GWm5vQh2y1F2LRdP3efk9XY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDAzNyBTYWx0ZWRfX6nOGkdnC9dO1
 lb9wZAq/2CHf/U1USV3Bjs96EZbFvLU9D7jioaD2776rxu0eLk882UCzRuiBJDOXgcT2UIrirrc
 uUrXpC+34VgBliHHNiYMYZWB/KzTz8pNShuNxTo1GtUqwTTSgN7AHwyO5sUqCCaGskMdrk6pC92
 /VfFa+lsnY5EpJmq5GaE3dOAX2Vl5/374cWqBqWktU0XMtGWNUubC6fPE6Qn0XFY717wMUll/ms
 zyZHlpnokTVxxX/cG+cVqgne1nDimbCyrPIXrsifyhLFJOHEK30tC0p3XYVAQ1x0strTTaogEi7
 Mzm99MvrF1lsiBx6WGFtpHhuca/pn8QcVGAvSIdHeBuUig/BivUymDimpdKyUGnd08tuNexO1Ip
 gjcmKomkGdjPVuTYmcGqrakn+ZnEBqniHqoHewBELNp1JTZi1mjSy/jaZZAlN42AOdaT0FNCU2R
 fV1yfNYBH3japhzaPXg==
X-Proofpoint-ORIG-GUID: N9BunT_qCe3bV685UuZNiMy3j7_0ggCN
X-Authority-Analysis: v=2.4 cv=GIM41ONK c=1 sm=1 tr=0 ts=6a2a3ad9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=WVSBx0R5LBAGHgG7FIIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 75rTasKohI7GqmgO-mStRPdl216qpdju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_213449_386949_B11ACAAF 
X-CRM114-Status: GOOD (  11.24  )
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

On 6/10/26 9:58 PM, Bart Van Assche wrote:
> On 6/10/26 7:27 AM, Nilay Shroff wrote:
>> +    mutex_lock(&ctrl->subsys->lock);
>>       list_add_tail(&head->entry, &ctrl->subsys->nsheads);
>> +    mutex_unlock(&ctrl->subsys->lock);
> 
> Has it been considered to use scoped_guard()?
> 

Yes, scoped_guard() would work here. However, my preference is
to use the guard helpers primarily for object initialization,
where they create a temporary synthetic acquire/release pattern
that helps Clang's context analysis understand accesses to newly
initialized objects.

In this case, we are simply protecting a list update with a
straightforward lock/unlock pair. I find the explicit locking
pattern a bit more intuitive and easier to follow here, since
the locking scope is small and there are no early returns or
error paths that would particularly benefit from scoped_guard().

Thanks,
--Nilay

