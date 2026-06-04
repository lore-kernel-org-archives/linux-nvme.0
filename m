Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1696ECD6E6D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 05:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mNsVmMBmx6ZbmK6R6Nwa6mlUQ8+jvUB8ZuR317YAgms=; b=nQPYEhMQ7lYr9SisWGGjfdF/0m
	v5Zljuf2gx+pRXipqV1SZLE/lA3VmQ9NffhnDO/9OzMk8CCX7zA+FQAH636CYV9poY2thi/kFxpZb
	5lbqY6twMukwjC8ZmuutTXNtfTXNk9rkNqSzvpveFUzHqhS5BHDeibonDpt1+Z9Aos+JEtG+qTd3R
	1nnNozII4wZtKFLO66if4RWrIon0pi8lg1G5b65HbflCdBq7+ncRx5dsOuyk3JcMdxkD8XP7aSwaB
	NBg07JhmQ0OFNhkptjsiZWbbeXXj8cVLlcPqmoxcfIcO1GI/McJqmlP9Jok42HxpBCZRhZOgsXcmg
	w+e9DLLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV0p8-0000000GBYJ-3EG9;
	Thu, 04 Jun 2026 05:40:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV0p5-0000000GBX6-3uL7
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 05:40:57 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 653MYjrb2242832;
	Thu, 4 Jun 2026 05:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mNsVmM
	Bmx6ZbmK6R6Nwa6mlUQ8+jvUB8ZuR317YAgms=; b=LlVMBTdzIZa9aKrQTg5ZMi
	7xWRhwhPlmZ3j2sJTHxlpj7XHqhC/Kuf0RKCv6z99yRD3nXtm31jdTHu7dpol05n
	VxMPw7v4j75v6HPiGL6iGeFWCeLsAFKpzo58qK0vma8hr4/XAKF6FBITKKGSH0SJ
	e2k3WJGwzl76BUWwM3viB5aEX37dICIThN9UPh5kS+UK7V4R2f3iIvKUwSplIGu/
	1YOIPixRN9KBcsyuoZJlUbQXabnrbe6YVkjpbFDDuhvSQfhnTrgVGs2b7yv7V+kI
	IONski+FoA3T/oy68UStQENYGzkjczFnC7pz7L/v5xK7BVyddE5mVpLBQzUDKD4Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqhtdpdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 05:40:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6545d7Tp000398;
	Thu, 4 Jun 2026 05:40:32 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcegueh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Jun 2026 05:40:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6545eWrw32309836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jun 2026 05:40:32 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C435805D;
	Thu,  4 Jun 2026 05:40:32 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2873158056;
	Thu,  4 Jun 2026 05:40:30 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jun 2026 05:40:29 +0000 (GMT)
Message-ID: <7215e1ab-a8b8-4190-a7ee-db125ccc4412@linux.ibm.com>
Date: Thu, 4 Jun 2026 11:10:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-tcp: lockdep: use dynamic lockdep keys per socket
 instance
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>
References: <20260604023208.388157-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260604023208.388157-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TKjo3_fmcLdyKX8GFLggEcjzXjsnqs6O
X-Authority-Analysis: v=2.4 cv=fv/sol4f c=1 sm=1 tr=0 ts=6a210fd1 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JF9118EUAAAA:8 a=vl-7ltgXDohAsIhOFTgA:9 a=QEXdDO2ut3YA:10
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDA1MiBTYWx0ZWRfXzRCV0vhpKrSS
 HM1pXugL+qTI18Ykvx6ynIWxcW3KHkKn9+nh7YRyZtSGEoYL6ttzN6wYykGiVBWA3S85eLYwObF
 y8BB5exqkipYPNr+kkwaQzdbbP3VnCUFVmvO2G0wR52ZPKlW24wCkO3IsmzkG2iLOk0hQgdtIaB
 lghh5qcYdQOdTSnovo1Qz351c7Dd32OU7XwyledSSAsP5o7d+Y5bFYqgrlV53QaR4n91oHI2pOm
 6wtldUeF5gkXrYBgxyOkaPPPyBC4/Sgu4O5Y1N2SH4TYDKzl/jEIT88yuZsOGDfHbEOIRgAQQjn
 VAdHqgP65jlZWapn74t9F71HRHGfju/8G24COwjDW56i5OeNcw+5GeOAOOyfssGYvBVnVx6lV89
 9Zzvc8hoeuFL6wHJbNt4vq7G/u8tp3iDY+eRwKBxBFktCzewT/y0efUodTv2mGoGzTFhPlqSdZD
 1+q98j4YNd5ACZBTv0Q==
X-Proofpoint-ORIG-GUID: TKjo3_fmcLdyKX8GFLggEcjzXjsnqs6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260603_224056_115267_08714002 
X-CRM114-Status: GOOD (  17.45  )
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

On 6/4/26 8:02 AM, Shin'ichiro Kawasaki wrote:
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
> tracking. Change the argument of nvme_tcp_reclassify_socket() from
> 'struct socket *' to 'struct nvme_tcp_queue *' to pass both the socket
> and the keys. Add CONFIG_DEBUG_LOCK_ALLOC guards to nvme_tcp_alloc_queue()
> and nvme_tcp_free_queue() to register and unregister the dynamic keys.
> Additionally, move nvme_tcp_reclassify_socket() inside these guards since
> it's only needed when lockdep is enabled.
> 
> Link:https://lore.kernel.org/linux-nvme/afB5syZbUrppgsDQ@shinmob/
> Suggested-by: Nilay Shroff<nilay@linux.ibm.com>
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

