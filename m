Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05456C7EE30
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 06:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAcvY+rzCGKwOJqAbFDOXh11HvNDRQuGoH8UPJYjLag=; b=xxMGPhZTya68OXoDS+MWWdSWSK
	G2jm/8Ogp4TnCQxTXy8BOUKCTvT7NIngh4/lRWvVBPtrKky9GK577F56mnpxsEZDb2O7JD3dWdnYf
	SXolUapNSrcOpdjmYBdHJgZHOLVFG1u9e6CDIm4P69HQlYRN/K9udJRVhcaowFemtrHBFIZkicKHS
	y3yEH/c5vNImZJWAHgqh7hpAdGFozEPPaBvTe1ddCIE4SPtrp/cV4aOxMhdzu3X42/5IDM5gExGm8
	CX/cqS937SIm8mXPhQBr1CyBZR/R5jR+bG7nfV7RG5LxDYetTNVG00LwnKiJJO5xxziW0H9MwoCJX
	1hj2fdWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJNq-00000007dTs-0yVN;
	Wed, 25 Jun 2025 06:13:22 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUJNd-00000007dP8-2iYm
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 06:13:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OK8tkT003343;
	Wed, 25 Jun 2025 06:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mAcvY+
	rzCGKwOJqAbFDOXh11HvNDRQuGoH8UPJYjLag=; b=bN+sQmCv5kg+yU0339lqUO
	wpLd8JUvfKMHp4qs3nWQ95qbZD305mQBNYwypOueLIFgg1KpsdWCK9GuXCUPt2Jh
	4pY7NkaJN1GvpVdvwOmebx6QNd8Zkyt1P7c0Eot/jk2nO0w6DF4VWpk6cniiurbw
	IYQ7g1xUonHBF4RHVuX7lkyBXhOqqJwgQU8lnrLBGWY7TofrUp0+Zu8kltB4ddel
	Fh/2HrMkX1vXoKqD9ByhNQRGqpdr3B9xgrndFsqb39Pj/4sSKHJO0Y2q8OLiLEZT
	+1WF02yFLifD6L1cge6H9MwgKCDg69OgZQhQS1Tfp+nlMPQpcKKK+HNc4SKLYjTg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dme1da79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:13:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P2P5N0002502;
	Wed, 25 Jun 2025 06:13:00 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jm7qn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 06:13:00 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55P6D05i28443326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 06:13:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2952F5805A;
	Wed, 25 Jun 2025 06:13:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F346658063;
	Wed, 25 Jun 2025 06:12:56 +0000 (GMT)
Received: from [9.61.76.241] (unknown [9.61.76.241])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 06:12:56 +0000 (GMT)
Message-ID: <c2e2aa93-9213-4322-a95d-27447f8b08de@linux.ibm.com>
Date: Wed, 25 Jun 2025 11:42:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvme: correctly account for namespace head reference
 counter
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250620080257.27993-1-nilay@linux.ibm.com>
 <20250623122019.GA22176@lst.de>
 <a16bceaa-cb73-4d23-b145-25d5bc74eded@linux.ibm.com>
 <20250625061040.GA9457@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250625061040.GA9457@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Tc6WtQQh c=1 sm=1 tr=0 ts=685b936e cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=zgojslbI5iAkGsbHfXkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0FZ9mxWGg0bQ0y5k7hM_RbloeBxOHKlV
X-Proofpoint-ORIG-GUID: 0FZ9mxWGg0bQ0y5k7hM_RbloeBxOHKlV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA0MiBTYWx0ZWRfX6Q3sWJFkRAQT tCvu/oB9rxiXmsGqHbQtnyUG8z7JixlsXHttiS+fQWNup/HWDN2DhWMwYDkCzjCA/Qf/N9jBtVE 6QMbJYNLUukLqkqUebLaBzznTaKPrOBryZcNz8vGzhco6KOlRA/JFWGx/f4ADdrWhT0vOOm5qWr
 yf/BGRTs8UL1y7VtE5LuEpkk2c0TEnBS4SL8XgBSZOuh1nu4sfgFB7PbTrQQVXaFqhcXsMoPBS+ r/laMGRtFHAO60Cs5q+n55X6u7Ns8o8VTvq4bPesHxDQgsI1CNYYx9Uj3I9BKS6vLNtDdXM/6yg 4ijRo05feI+kXsCsuGnYzD2xZ63d4Lu/SexfvBkYHq4i8wkekmExuoABWfbeNtqjR4EIKT8msyn
 2D77UJ2HEI4fL+5gQwv6jr/VBRx8TwA8J/lG4vYbW5I68QxdspCA3M6hY4YX2w7C+x3TV+SK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_01,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=904 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_231310_158983_DB5DCA97 
X-CRM114-Status: GOOD (  13.80  )
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



On 6/25/25 11:40 AM, Christoph Hellwig wrote:
> On Tue, Jun 24, 2025 at 07:54:29PM +0530, Nilay Shroff wrote:
>> Thanks! I'd update the above typo, however today I was testing some code 
>> after disabling CONFIG_NVME_MULTIPATH and I realized that although the
>> namespace head (ns->head) is still created, its associated head->disk is
>> not initialized in this configuration.
> 
> Yes.
> 
> 
>> So I'll send out patchv2 with the above changes.
> 
> Thanks!  Please also add a comment to nvme_alloc_ns as the logic is
> fairly complex now and future readers will benefit from an explanation.
> 
Yeah will do the needful.

Thanks,
--Nilay


