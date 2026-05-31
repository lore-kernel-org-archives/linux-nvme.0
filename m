Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B09CD6E52
	for <linux-nvme@archiver.kernel.org>; Sun, 31 May 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lu2csOfhc1/kyY/keb7HAYD2b9vRJNpMBYxVJbBcET4=; b=BkBhHAQFRK2S5sjje2KE6PJp1X
	7UGRE8krQe6Fvnq5pipd0Ygs6UWqwk6x7HktA+GovviHgKzIvjHhVw6F/xijsmxZTtJw520AiipzA
	1XH8X1olzJB3+9VKeSaRKXs71KLAYwD+BYEh4IvjA54qd54vkChtyNW0miLzHD/TWF5lshMRc/SR5
	v0TCxaq7bLuHcxclOV8E1KCLK8rozUw3fEgz8r6R54jzJ4TEfSdy9gu4qdJT51ZGdp+s/IB8pBJnU
	cJyPGTc9ueodHr0vH7Nn8WrbuvJcE2/CdQxTv8Td/5Tl2JgUoUVqekmxbul72SHgrYNQx9Q4WFayJ
	bwS94HxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wThzR-00000009gLo-19eR;
	Sun, 31 May 2026 15:22:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wThzN-00000009gLS-3w0g
	for linux-nvme@lists.infradead.org;
	Sun, 31 May 2026 15:22:12 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V2jIba392882;
	Sun, 31 May 2026 15:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Lu2csO
	fhc1/kyY/keb7HAYD2b9vRJNpMBYxVJbBcET4=; b=fM9N+Tv8OArXIOoO5/OvGz
	XuGjuP42tpe8OWqL9RB47I//2jKJV1gv8gXvG/EZwwo+J3n4JZgrSRBN99Thv+zW
	3OAPmxdhZ2QdfRS4zS8Sjl2dgvtv6Xhhqt+Lp9Ir/F6ErO8+BSt5/F6lRwllVTAS
	5hjWdyPUTyKclctSDuQsNJX0IDUvlcB1SN73Hx1Emxx61zLuNkyyI4coryie+/9H
	oepoex6BFU8i/v0xU6K5hkxmRY+lBY1uolGHDE/p+ucM97mDcU00VmOQ9TeDvtga
	a6EahlZkbHpoR5vfTMyczNuusr3TE/hQgrtH6Jd3+xkba1hxAlyG9UA4ivLFk7OA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4mxrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:21:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VEs75r000521;
	Sun, 31 May 2026 15:21:50 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ega7q2c17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:21:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VFLoPG63635956
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 15:21:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 060C658055;
	Sun, 31 May 2026 15:21:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3F785804B;
	Sun, 31 May 2026 15:21:47 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 15:21:47 +0000 (GMT)
Message-ID: <f93b8aca-50bc-4d0a-bc28-a00f400e1d0f@linux.ibm.com>
Date: Sun, 31 May 2026 20:51:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-tcp: move nvme_tcp_reclassify_socket()
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
 <20260530052045.296749-2-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260530052045.296749-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PKLzRQuCm2aGKh3XZVbr-Tzf4si7rgUO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE2NCBTYWx0ZWRfX1+FH/4yDA/Uq
 SkLhdTIemQ09SiryHN3BhC0+5wNb6zy19K1gh9DmbjQz+MOBM9jryQDCCreUJBjabQ3F0CcVfRo
 hakg1162z5dcYNO5N7mijwwzY8AMXvC2VHjkJdzHaj96RSFBOwNoalCV6qiQCOXGMVdTFH/v0DO
 CAATpfiCeucICWQ6phH82wsbyrvMmheqyPnHuhmK0WMpwtyMrZeiEggw9YAVHbB2zF6Y7p3cv/w
 qU5VWtcOuqVKZGq3aH06Eblg1W0hPLD7NHbcxuHd/Wv2y1/srH6WNNxqsMqLx34zmERBZUrLSaR
 G2cHC4iWlRKWT9rG25HirJyY4n+tQ/acXGUoZIwtvMslf4/+ds+Qr7ifdsWKorzHgKzhNBIkm9I
 GxzFwXzENJk5PILkxCmKDhLC9TNiTvu/aHWYZcR5Xm1cN4FbUcyVfl2LFtuHejGd4s9bxCpJqS0
 x9PtYB/YZ8KGO3GOoZQ==
X-Proofpoint-ORIG-GUID: PKLzRQuCm2aGKh3XZVbr-Tzf4si7rgUO
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c520f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=JF9118EUAAAA:8
 a=VnNF1IyMAAAA:8 a=LClqJrE8pOexBVp5_SEA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-31_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605310164
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260531_082209_987478_E81BF5FB 
X-CRM114-Status: GOOD (  13.73  )
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

On 5/30/26 10:50 AM, Shin'ichiro Kawasaki wrote:
> Move nvme_tcp_reclassify_socket() in tcp.c after the struct
> nvme_tcp_queue definition. This is preparation for adding a reference
> to struct nvme_tcp_queue in the function, which would otherwise cause a
> compile failure due to the struct being defined after the function.
> 
> Move the entire CONFIG_DEBUG_LOCK_ALLOC block along with the function
> to maintain the code organization.
> 
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 76 ++++++++++++++++++++---------------------
>   1 file changed, 38 insertions(+), 38 deletions(-)

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

