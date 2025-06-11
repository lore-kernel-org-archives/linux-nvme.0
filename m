Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA84C677C4
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 04:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eXvjjf2WjrVKO46HZM/bZgx/Bfc7ewWA1zUZkqYWPZo=; b=agl6AE1IwNpZe2Tv7EEHdsvODJ
	dPNlcVoR+yrFu4Kh/hso27VPrBEbYdtkdp1o0+u54/s1+5NhVRjUrvVfDzKpoQ6MGmppLdWpWZieY
	1pfwmrOIkpyCKGrKNVuEpuDDqJ8wHVJ2N+n3HKL5agL0BBKL32WOX9aPM7/9CHK+1iy3580yDGj5O
	ZWJcqGNNqEN6CSiFNuBbEcaDgRtAqxdU3QSCq33qn4SyinglB6Oo4jx3hWT+gBmzX3gAK7DY208s5
	IUqvws0ojY2YWzxIequqM5EHs2qgBKfLeN0aUkP445efuFJM3inUOHqPexIZzvO6IycYKsnx6HLxy
	Igv4sBEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCy3-00000008os7-09V6;
	Wed, 11 Jun 2025 04:21:39 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCxz-00000008org-3X0f
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 04:21:37 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AKGiE6007553;
	Wed, 11 Jun 2025 04:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eXvjjf
	2WjrVKO46HZM/bZgx/Bfc7ewWA1zUZkqYWPZo=; b=AtFKmXmDb5E48q61VAsRTa
	/WJ72xsaO/ocdt/SiDDPXk5RpLkSJ1/qMadoo6adqw4y23tlz1wmq6PRL5mZevyI
	KyVVZmZM/z0HE3reZnl65pRbH549gcJyfZDOI1bdKp4bVL4b7NNC72wUhtu8jeJW
	v4uS+ImB2VpmZiIuFJqxRwR7RssOyE2EH4qePYRelY1Br2riqDiMpzXmtCiTKBr6
	eZpmSi5XGDi2OguwNsRxYlP2CQeZIRFLyyroJ7ufpZxpdK7m3NUQqibhXwoElG6I
	xUZs09xpHKMa2LGlv81XQsAMBDj7dMO5vqub2a7ie2SdPqxmrUqXTrKH43ByNBDg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474bup27rr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 04:21:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55B0X0Bu014908;
	Wed, 11 Jun 2025 04:21:24 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750rp5x0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Jun 2025 04:21:24 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55B4LNpZ14222042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 04:21:23 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 371D158059;
	Wed, 11 Jun 2025 04:21:23 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E45F85805F;
	Wed, 11 Jun 2025 04:21:20 +0000 (GMT)
Received: from [9.61.37.3] (unknown [9.61.37.3])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Jun 2025 04:21:20 +0000 (GMT)
Message-ID: <a15abb04-cd2a-4032-b1e3-d269f729dfc7@linux.ibm.com>
Date: Wed, 11 Jun 2025 09:51:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: reset delayed remve_work after reconnect
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, hare@suse.de,
        Keith Busch <kbusch@kernel.org>
References: <20250609184844.3158382-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250609184844.3158382-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=H4Hbw/Yi c=1 sm=1 tr=0 ts=68490444 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=b40kGQ7eMB33sPGsUP4A:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDAzNiBTYWx0ZWRfX/qSYUDwE6D5q 8Km/YihMrl8+g8u7JXqGTvFxFygU6KcQtKVI3b0GhDgTW18n9BrLYw+RM9a8xnSQ5E2NENeTdCs KkmaF+RZUCFN7IyKCGlcp3XVzvXckbQkr79km4/L5K1/q+ZEeH4JzVXAVUEBuJ3Qeo7YR5QgDFp
 FND+gsplg9Blqy3sNQw33MymWkG3OdK270TcIkL1pH+i9+AxBCsAdFdRUFBW0UUNrASCHvaM3k/ nnVifTO1twLmvOZmB8w+N5L/YmePFaPF6CslCJbvToTgoxPvSVpvZrtcCs2k7JI9JWSZixsGxRE G2uQy7cRGcpdOjtnYntxbP7oO+42JNLRmQNbQ2WxD1fenf/C100ro/Caum0AeNInLfBaGAZhiq3
 0YMpnagco+x9ASvGfINljRHK2Yrdyy2zZ0ypHoHMaiW27uEEL7hKoiCNKwi2ySHkDAtGdCUu
X-Proofpoint-GUID: 6vXIgZf0uuyzW4_WLNlYEKuxhBQMUI4-
X-Proofpoint-ORIG-GUID: 6vXIgZf0uuyzW4_WLNlYEKuxhBQMUI4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_01,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=796 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 malwarescore=0 mlxscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506110036
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_212136_352872_823B09CD 
X-CRM114-Status: GOOD (  13.07  )
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



On 6/10/25 12:18 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> 
> The remove_work will proceed with permanently disconnecting on the
> initial final path failure if the head shows no paths after the delay.
> If a new path connects while the remove_work is pending, and if that new
> path happens to disconnect before that remove_work executes, the delayed
> removal should reset based on the most recent path disconnect time, but
> queue_delayed_work() won't do anything if the work is already pending.
> Attempt to cancel the delayed work when a new path connects, and use
> mod_delayed_work() in case the remove_work remains pending anyway.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


