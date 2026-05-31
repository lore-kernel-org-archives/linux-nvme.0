Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59BFECD6E5D
	for <linux-nvme@archiver.kernel.org>; Sun, 31 May 2026 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GN0QhmQXyhmxMIp/8e8VVk1e+mXt0+EGJJRIvJmPN4Y=; b=eeVT5wwJXQg0jAku+FDlqFQxM1
	aWOUYfD3WW4xBaBqkMsKI2P0m1vo6j53AyLb8foovB6nN9sMGFXPhwgWsEcVrchlpHYNbB4UZpaKE
	JkcVmlqnbx9I5r/A6Wf25Vi69Dl9dT9XXhQIx9MqaeWifMfGp27dLcP4fm/CqIVMwncNSXq3M4HrC
	ftEI/+SmVAC81X0JWxOD0oPivYHYp6yQTLkc88EwTvlxfSKSWjBvhMW7iyaBIr+QNzyhonTAayfRS
	jklTKf4AFURdyEWnNhl25Zc/j9zviX3vBMfgJFruNQlUQ5kpqZt/kZ3q38CSFwPdiHa3ENPdrZOoA
	AgeuLg9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTi0S-00000009gS7-1tmH;
	Sun, 31 May 2026 15:23:16 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTi0P-00000009gRg-2FKr
	for linux-nvme@lists.infradead.org;
	Sun, 31 May 2026 15:23:14 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64V4vbHJ643123;
	Sun, 31 May 2026 15:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GN0Qhm
	QXyhmxMIp/8e8VVk1e+mXt0+EGJJRIvJmPN4Y=; b=B4R1BPGtAgJH1bGEdT6ufF
	OEtROtMwBQV6KZArHQyxUb6N57vr2tU2DuYwQbWQG0Y2uQzNEPR9eQKiDOVoi34O
	d/K0XT3gIWmY8mmDej1UoAOX2Xa/YyKiPysK0xrR7jph/0au8aHMy9HxzkqOMF69
	yZA2dPxEhX00hLLn1rtAANoT/CHfAATGsvZgK/SP4mbEFkp6fsfX9frt7gEtW0CF
	Z+dMgrRY4mPlsB+XG4ktZg8Od6oKXUX91k9C7VAUz+Uh2TzOCrdhGCEhQhwvp62v
	0zW46xj9CqHnHtb3DEIzsG6O6XPX/OpfMDjCITXBDB9VBlLWh874tCKC+NzJO4hA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4mxty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:23:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64VF98lE010760;
	Sun, 31 May 2026 15:23:03 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7jt5qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 May 2026 15:23:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64VFN2cP8847886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 31 May 2026 15:23:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CFD558055;
	Sun, 31 May 2026 15:23:02 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02BC95804B;
	Sun, 31 May 2026 15:23:00 +0000 (GMT)
Received: from [9.43.126.202] (unknown [9.43.126.202])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 31 May 2026 15:22:59 +0000 (GMT)
Message-ID: <a1ed9efa-c235-4cbf-8ba4-113ca2f070be@linux.ibm.com>
Date: Sun, 31 May 2026 20:52:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-tcp: lockdep: use dynamic lockdep keys per
 socket instance
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20260530052045.296749-1-shinichiro.kawasaki@wdc.com>
 <20260530052045.296749-3-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260530052045.296749-3-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2mb2FOW_kV2rqzoL4OZDHZPeK_p1Cxtv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMxMDE2NCBTYWx0ZWRfX0QIZEpQF/rny
 crJSa0n0tx1zf8HHden/VXXDpMq2L4oaUM46V2FiNq5QTjkUsWZsviVmCHQlllvpumtoP8WAQnh
 n3i2RGfGS9G4oC5r3J2C+qhocT96dn86N+ACMTwvIqXoMQXfgxdfDm08gRFnkIugaYzBiYx4jKi
 9UeGOSU3sexciuD2Aq+xSDWP7Q0By+qHDFCB5YbBHQJ/0/cDBKWyNGHLxATH7vK2ddoMQDrFS9P
 pNQieql857VW3fnE1wI4zm0IOfXUOJ7hnMv83aJfubaJH9QOTqwJtfmDdmON/rxSazDxDNeRbC+
 VvvFJcz6FVWBGNjQEHAFePuiNMbTdpEhpeTijHkokV4H/gdw8MFs2HEgIJVG6XN6pRnT9pWASOq
 EIl//NjAL/Z7+0o+ydHHdpnaW334bSXQznf8UBaBOa3rSE/5Mz+IGrGuXp/N9Yi8bEB0FgYtZNa
 58JCOW7CEYxLLPsVfiA==
X-Proofpoint-ORIG-GUID: 2mb2FOW_kV2rqzoL4OZDHZPeK_p1Cxtv
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1c5258 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JF9118EUAAAA:8 a=vl-7ltgXDohAsIhOFTgA:9 a=QEXdDO2ut3YA:10
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
X-CRM114-CacheID: sfid-20260531_082313_581524_A8942747 
X-CRM114-Status: GOOD (  17.74  )
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
> When NVMe-TCP controller setup and teardown are repeated with lockdep
> enabled, lockdep reports false positives WARN for the following locks:
> 
>    1) &q->elevator_lock        : IO scheduler change context
>    2) &q->q_usage_counter(io)  : SCSI disk probe context
>    3) fs_reclaim               : CPU hotplug bring-up context
>    4) cpu_hotplug_lock         : socket establishment context
>    5) sk_lock-AF_INET-NVME     : MQ sched dispatch context for the socket
>    6) set->srcu                : NVMe controller delete context
> 
> The lockdep WARN was observed by running blktests test case nvme/005 for
> tcp transport on v7.1-rc1 kernel with a patch. Refer to the Link tag for
> the details of the WARN.
> 
> This is a false positive because lockdep confuses lock 4) (socket
> establishment) with lock 5) (socket in use) for different socket
> instances. The locks belong to different sockets, but lockdep treats
> them as the same due to shared static lockdep keys.
> 
> Fix this by using dynamically allocated lockdep keys per socket instance
> instead of static keys nvme_tcp_sk_key[] and nvme_tcp_slock_key[]. Add
> nvme_tcp_sk_key and nvme_tcp_slock_key fields to struct nvme_tcp_queue
> and pass them to sock_lock_init_class_and_name() for proper lockdep
> tracking. Change the arguement of nvme_tcp_reclassify_socket() from
> 'struct socket *' to 'struct nvme_tcp_queue *' to pass both the socket
> and the keys.
> 
> Link:https://lore.kernel.org/linux-nvme/afB5syZbUrppgsDQ@shinmob/
> Suggested-by: Nilay Shroff<nilay@linux.ibm.com>
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>
> ---
>   drivers/nvme/host/tcp.c | 32 +++++++++++++++++++++-----------
>   1 file changed, 21 insertions(+), 11 deletions(-)

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

