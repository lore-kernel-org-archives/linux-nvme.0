Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61963FD375D
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 06:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5cnm5C1uKbiMJFmFQgYw66/MWPJQCRDv9Bghc3T66us=; b=gG8ZY4xUyiu0ZIuXKR8kUbNN0G
	3dGfVVACHuDFdC1tu2H/aFXH4Dg3F4oR4uxzRlHLqEaQiqCYxIbXRBCHMebRKD2a3rryQJmJhtRB9
	KbgG5V0rzcaXqCGG4RA/6Xba6o/PuxxsNbAKRpl4O5qAdP5wKd1oXSlxEq9U0Cc5uBdNgZwMqUK7A
	jWhnlUz694t8YuZGs8rHbDGPdPi77LgGZrBnXjFNiL8LrNx7a+vpElVT1y/6m37qUSHNubHSFVWk3
	UDNxHiqBgC53+wXjWv5oDkExFnUh87RVPB84BH+YtiiKqDDLMe7YcYxMkUZCZDVzFdfOt6ipoKTT4
	6tlgXe4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvUyR-00000005VHJ-2IYf;
	Thu, 26 Feb 2026 06:35:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvUyP-00000005VGy-0wPo
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 06:35:46 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61Q0HHUY839879;
	Thu, 26 Feb 2026 06:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5cnm5C
	1uKbiMJFmFQgYw66/MWPJQCRDv9Bghc3T66us=; b=ooATpS+ocyUqtkRySrV/qj
	Yly9WKiv9dHKRsvQkUAmvyRkyg3aNSFpWJAtWHYddTK8bGo5MnzFm6BVGrwP1TWV
	ffY+ujFhRyLr2JGEQ1BYN/ZDrhFbFVCt29jPMyEQsmKltKqNayO8Lbuofqt66FU+
	g5mmYBNAvpSncZzmCuhWl+Eon1BlDUsVVf6Zikp49Vi/t6dH9mPANb2jnr8DbFle
	s8VKR3sJke61efMuyoz6Ldau/r2Ui0XBbzimZtrIXnwMsU8bvEcN9X4rcAbmeVBx
	RvSHFIh1M1lHd1EYVsocAbwrWblRV14D8Pf8tvG8jQsgZuWXI0iXzhqg4631gR9w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf24gm336-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 06:35:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61Q2vdC5013431;
	Thu, 26 Feb 2026 06:35:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cfqdy9rwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Feb 2026 06:35:41 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61Q6ZewH33161886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Feb 2026 06:35:40 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 859D958043;
	Thu, 26 Feb 2026 06:35:40 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3CBC58059;
	Thu, 26 Feb 2026 06:35:38 +0000 (GMT)
Received: from [9.109.198.198] (unknown [9.109.198.198])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Feb 2026 06:35:38 +0000 (GMT)
Message-ID: <3a027b32-3a5f-485d-8913-2e8773a35f97@linux.ibm.com>
Date: Thu, 26 Feb 2026 12:05:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>
References: <20260225202109.447144-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260225202109.447144-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TNRIilla c=1 sm=1 tr=0 ts=699fe9bd cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pmqacTn8WLMEFy0JGJsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kpAj-IHfjcn1bZbqvurcfehJgWx7zkAx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDA1MiBTYWx0ZWRfX0WXTn0vwNKUA
 AaR2WB1ANo1TOE9KqNPKBypfgW0LgZwpuxbJ39aVeOh52e7HLofDFAc8713bA1If6eI074OH3rK
 tCFWbyTe7IJy8xTU1ackVsOKJyfUGEuHGkHmlGCLAYb7R1pyAPvFIcXl/0j4HJcQLXd7EcM0aVU
 6VZ/damPUQEzj3odMBo0ABxiRolINtgumPGcGvb61Ryoehekzt3OKFEAgxHDTKaMx8DIgMxMrs6
 i4lwHLGcCc/oYw/eQEpZdolcAfN2dIfwrOrKwQ798437/PXuSvc6jkJ70+dN/xmf4ZtGbGNiJAW
 Rg3fr/igh8KpfzCeKFHa5UjlgisqQYuwSaE+ENAkea42okvSe+/y3do8abU4UnoAyqyuxW11Xa/
 uznpd9RkR/o6uexJZMrW/xLq3UBdUVRKqGG4X8YjP9ro9/uXyAwkuLZ+gdvhBqoFtnWa4nx51sh
 cOPc/HxnOgjgGF+2BUA==
X-Proofpoint-ORIG-GUID: kpAj-IHfjcn1bZbqvurcfehJgWx7zkAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-25_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602260052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_223545_392997_61E7413A 
X-CRM114-Status: GOOD (  10.64  )
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



On 2/26/26 1:51 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to fall back to the synchronous removal if we can't get a
> reference on the module needed for the deferred removal.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

