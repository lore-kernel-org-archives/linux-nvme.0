Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3D8CA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 05:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yYaJtc7RuvgY1Ra8B+ajTl2nOuAh7H9zsChrSAlPBv0=; b=JW/MIDeleQiPtNPyMgVIhc1Qxq
	BXLZ2003UpaavQUFX5eZ9meQ50hnDOoanXvsTK97Lm6OqZKpLT19jMWK9R1faliIPT5coz6IlD6Ml
	CcAKk9pQqBq+jkf7xyf3jbUaBRv+Hz4OKNTAbeWguV9qsq2DjPFzN+SxTT0IOzwEfis8dwo21gAWV
	3kQex0PwMFEbmQMgJUEO4sxThvqHoCKPuoVinmmgj8raZFbAD/VD3QUpBn3vcfjWaUrU0/HBRbrxj
	gSls8G7ZjdnGxsT9xjQrmUZCNNk5pLaLjPx5NCeVPoWrEAomEn715UD6PZvLxy0QhaXg7EohjTzrt
	EfukChHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxo6-0000000FsUI-0ImH;
	Thu, 21 Aug 2025 05:25:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoxo3-0000000FsSx-2Jfl
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 05:25:48 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KMlurg026121;
	Thu, 21 Aug 2025 05:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yYaJtc
	7RuvgY1Ra8B+ajTl2nOuAh7H9zsChrSAlPBv0=; b=c5bl2M5WSzuyyqYu0NQSHm
	pxPEB9S3oL+29JI3Sjpsb7r3rwu0MK2OxjsM2CKYjby1O9yoWOkbWgOrYu6nA7n1
	L7Los9AwvKoPc3lAx4yHyP5MgLjTTa7/PPMxXyZpgx2zHq9n4rIUjGc2QV/ZxV/j
	weCKemTKu/pW62KP99tODI6XBDZi/UMJgj2xmtgLtXqlL5EhDz1sMjfJmCpHlZwJ
	SETVZ7p6Nz/j3wN018JzheKVBTbaBaFMLpJcZ4s7sTZNkGT/XbfOQSwrlOxYTvwH
	OPHc4t6Z43oDWBv4A4K8pXf38cVDJGPN8QQm6AmUdbTt3MXs1cgc1+W70GoqgKiA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vev1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 05:25:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57L2hwtG016038;
	Thu, 21 Aug 2025 05:25:38 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48my426r80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Aug 2025 05:25:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57L5Pbqk19530240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 05:25:37 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F17058056;
	Thu, 21 Aug 2025 05:25:37 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 353A158052;
	Thu, 21 Aug 2025 05:25:33 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Aug 2025 05:25:32 +0000 (GMT)
Message-ID: <b8156bb1-b7fe-4036-9dbb-98fdcec3ff65@linux.ibm.com>
Date: Thu, 21 Aug 2025 10:55:31 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
To: Keith Busch <kbusch@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, martin.petersen@oracle.com, djwong@kernel.org,
        mcgrof@infradead.org
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
 <aKZDRrfUTxJoFA1m@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aKZDRrfUTxJoFA1m@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXw8zxww9smSiF
 pN80EtrZVprrZOl8SgTAkDo+XM1Xa0sVE8b0j5a5RXOuZrJ8yj+n7KyNbwySdv6dEpel03H9HEK
 4vR37rUfE9fNEhEE/vq6NXA9cSOOMnkfz29YoBB/kYgdms2fJ56YMLoZMmLTSUd3AkrrAnaHXB0
 jQz9gQtvixthLqh6zYkUCuMfq7onKipBwPZGidJ9+a9cNlTL5iPqWEg3elJceIa5L+ZM4VEQaTq
 RtrY78wYrSvDwQGkz3McvOpVqocUnflLkwOqpxoRpBMzUlWjpM03WWOrQASde2snr7d9/QrtZGa
 7OqCYi2Bb0nAxJtwbnbeaVKz3oTjS+zwkHtiV71+RMfknBcOYBfKyzBsZrotQVIprl/4oWRIFdL
 nD6jROKL4JScvGuebrd/9mV+Q5zwoQ==
X-Authority-Analysis: v=2.4 cv=PMlWOfqC c=1 sm=1 tr=0 ts=68a6add3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=xiRpjWrZGW_SbaGU0d0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: FdsaARlXUgnrR_MZ-4H1Ngj0Qr7UKuy0
X-Proofpoint-ORIG-GUID: FdsaARlXUgnrR_MZ-4H1Ngj0Qr7UKuy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_222547_619462_D642C33B 
X-CRM114-Status: GOOD (  16.82  )
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



On 8/21/25 3:21 AM, Keith Busch wrote:
> On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
>> It would be preferred to stop honouring AWUPF altogether, but this may
>> needlessly disable atomic write support for many "good" devices which
>> only specify AWUPF. Currently all validation of controller-related
>> atomics limits is dropped.
> 
> These "good" devices that only report AWUPF, is there some set of
> characteristics that generally applies to all of them? 
Yes, I know of such “good” devices. Typically, they report a consistent
AWUPF value across all controllers, and that value does not change when
the namespaces attached to those controllers are reformatted.
As we know, though, validating this in code is difficult. A past attempt
to implement such validation failed because there are disks in the field
that do change the AWUPF value when reformatting namespaces.

> I tried to list out conditions for when I think the value could be counted on here:
> 
>   https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> 
Regarding the checks you listed, they seem too restrictive. They only support
AWUPF for single-controller devices and for disks that either have only one
namespace or support formatting all namespaces together (i.e., do not support
formatting individual namespaces).

> I just don't know if you know of any devices where that criteria doesn't
> git. If not, maybe we can work with that without introducing more user
> knobs.
Given this, IMO, an opt-in approach should be considered, letting users
decide whether they want to enable atomic write support or not.

Thanks,
--Nilay

