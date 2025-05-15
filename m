Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD732C3ABDD
	for <linux-nvme@archiver.kernel.org>; Thu, 15 May 2025 09:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G+EQkhHvgHBMPhYhRol/0Wf6gGl/2coxmRPwnpZ5c0U=; b=DlgR/yj55E5vGE76M30G+K1kKO
	4HIok0Ch1Cr2bMON8xnUhNsG7FLSLNiFJKrZ9re9z9pJalKYDkYKwIWnFJy1L1BXhnocKoG9jCeI7
	OfG4VlXQKt9g2dkgh4dyxB7HGdrzTevilGJ+bcwnXh/Dvgisxce/lpIsPhdRj2UNTbhxExYI/3//i
	eftkdyu798iuHV3H6aZuPOv21BpHR2la3rX9k/mbBVGLuYaudfAAhnXtsQWkurt3LwKDrIVO9dbyu
	xzS0GIz34rasBygtk83kuK1q58iCp0aLubCfZ94Hhp6lg8JJtEdtL/XxF8ic6KQsniSqgUWlqkb3m
	KdcmYcVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFUVH-0000000059U-0neh;
	Thu, 15 May 2025 09:03:47 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFUHg-000000002mw-1vy1
	for linux-nvme@lists.infradead.org;
	Thu, 15 May 2025 08:49:45 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F5aEIF012931;
	Thu, 15 May 2025 08:49:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=G+EQkh
	HvgHBMPhYhRol/0Wf6gGl/2coxmRPwnpZ5c0U=; b=HLZELtRZjjSvXa3h0dnF0y
	8ePgGjiPDKq0wm11PMJU7hQTq2/pAfxS8vYlq0O/8qf/C3DPPbIi2qZJofQRm6rR
	9zb4z4qY+ppRNwRTvCUBwEQ3XOUVnecxqcTdMZ9Lj1IF8PM1kmFVlGxtZErJg5qn
	Vo3f8CoiN2Oi0DF8lKm33OISPpM6lITncFifeVge8SbTKG03sYtTwDMqWlHySLH7
	twklzDsVUHuyZh+yNuPEQIw0mM4b3HLCHbeLQv6w2nE6mCiaQDizGbC7U9e2E4zz
	sIpsAfD98mfd4Wq9NY95xfUVEGKAIPtnol77eAwGhUqfdVqgroIKieGKX0/UopWA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcje6u8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 08:49:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54F6wh7G021809;
	Thu, 15 May 2025 08:49:34 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfps8g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 May 2025 08:49:34 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54F8nXPS20316712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 08:49:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D0F75804B;
	Thu, 15 May 2025 08:49:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01A5D5805B;
	Thu, 15 May 2025 08:49:30 +0000 (GMT)
Received: from [9.109.198.223] (unknown [9.109.198.223])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 May 2025 08:49:29 +0000 (GMT)
Message-ID: <11f2ccf0-8f3e-4195-bc1a-8bdaba017d84@linux.ibm.com>
Date: Thu, 15 May 2025 14:19:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 0/3] improve NVMe multipath handling
To: Niklas Cassel <cassel@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        sagi@grimberg.me, jmeneghi@redhat.com, axboe@kernel.dk,
        martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250514130322.393656-1-nilay@linux.ibm.com>
 <20250514152244.GA32525@lst.de> <aCWkOhlsfma3w17c@ryzen>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aCWkOhlsfma3w17c@ryzen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=6825aa9f cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=NIdGJDgNpMOa8F61CrsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 705nfSm2LGYfbmC_JQgq8lSkVVTY6S7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3OCBTYWx0ZWRfX5NxsCIMvJGCW jON3IqWESWd2SJpqVC93xmDyoGAGj+aIdbafL3Fj2eT6/KykEtrhDEWWtQViS5i2ngPQDCkNmdt G2QDqB+5q+HkGios3j2SvpfC/cb03MwgmJs5DK2yRmLd+0BPMdCrvgyHZdjIA9nsQEN/oB6jD+z
 45j9yjsnyP0RgBNS/+N3tTjWT0VlNKeX+7QGq/G4QyC83wXVZgErfuVr9bIeaZuvJ5RAJYuAxwl ei+rzQ7tnyiMfksZVBLFMtEUaM1KwbT4fOyS1nggU2O0IX5ghn5L48C21KcfsSDnFg/QNbLOqKH rowmeW/BsDUDmbnDkF8nC4pxPdIpTwF/xcG2JsSaonACSOG3askYlZpZMxXwvzoJIcbX52W9MPn
 Ch+GSOoK/63iY2Enj0fBvYvDyzrQA6kDdyaE1CXGGH6CtCMCfs+vKgt1HU1aLgFBWqbp6oA2
X-Proofpoint-GUID: 705nfSm2LGYfbmC_JQgq8lSkVVTY6S7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=574 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250515_014944_626983_5BF755A4 
X-CRM114-Status: GOOD (  12.23  )
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

+Christoph

On 5/15/25 1:52 PM, Niklas Cassel wrote:
> On Wed, May 14, 2025 at 05:22:44PM +0200, Christoph Hellwig wrote:
>> Thanks,
>>
>> applied to nvme-6.16.
> 
> The patches for this series on nvme-6.16 seem to be missing your SoB.
> 
> 
> Kind regards,
> Niklas


