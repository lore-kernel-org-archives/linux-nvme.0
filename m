Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD70CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2NPoxAaGasL37raEP1Jl5GYOmDaywvb1BtsiX4Q6cQg=; b=oVxbOGbHAdRRw7f07vpUhKZm4i
	VtAxBC/tDexLyqru67wZ87k+zq7gn1pxQ4k9Y2qfYqv8+qvcVgNud3WBjG6L0gUJ0uv5AGcLNj6v8
	aA3gMzXHe0EGqkKuUyNu35hO3rXHot7WnIq8t+BOifSWf1jJ5Di+zAvK2zTx7YMfCbKEf6SS76aan
	5YpJMEEK8FyPwur9xRqlF7B0c++DuxHwy8/apxExy13rZc+AyY795QayxrVnDmF8IAmmN/nVRlPzc
	hQNnNTwgStaAzkq674HJRBiAYSTzV95ghRNL080zcBRIXxXLhz4zKf//aF9+pE4Fe5rBXZivoCVuC
	Bu1dZYFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFqa-00000004NBX-08sR;
	Wed, 27 May 2026 15:07:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFqX-00000004NB2-1rV9
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:07:02 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RD64we3594720;
	Wed, 27 May 2026 15:06:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2NPoxA
	aGasL37raEP1Jl5GYOmDaywvb1BtsiX4Q6cQg=; b=sBRCn/hF878ExQKXbIv1rv
	E+J9WIG067/BD0rMY+ELSNK43nvbJYBmaQO0ufcx/EfnRvdRIK5JgDk0uMKrv3zH
	ZCl8BUIZ75BjTVnJXBQXjAH4P0zD/du2/upwdFvgxx6ylt6n8NUHa8ngHrwLb4sY
	ljSdYgYaZHWfLQK4o42uQF8jeb1Eu4lDy63tm2wXv5GWaeCU6HYvI5DfuGUux03V
	ZbGoG1UFPir6XO47dT5Almcp3DvCbfgaaDR72bsqgIyOT4uj3+h2vxwu3T2QK4hv
	+UR+x91Z0g+xPrTNC8CuQIfFnI30iR6CKidY9bb8t/ipdDvwGg9oi3F4jBk3kFNA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2hytd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 15:06:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64REs88h019653;
	Wed, 27 May 2026 15:06:49 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbujpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 May 2026 15:06:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64RF6mjr65667452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 15:06:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD275805D;
	Wed, 27 May 2026 15:06:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 75AED58054;
	Wed, 27 May 2026 15:06:45 +0000 (GMT)
Received: from [9.61.100.224] (unknown [9.61.100.224])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 May 2026 15:06:45 +0000 (GMT)
Message-ID: <aa4f6003-ffce-41dd-8b79-1f0eaa3a40e6@linux.ibm.com>
Date: Wed, 27 May 2026 20:36:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@fb.com, sagi@grimberg.me,
        gjoyce@linux.ibm.com, mkchauras@linux.ibm.com
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
 <ahb2UTQsJywNagyk@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ahb2UTQsJywNagyk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QVpmtpa15MPQZXBvwi7m5f22LS-FOKbM
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a17088a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=v03BjGrjmnrylUnVmboA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE1MCBTYWx0ZWRfX8qNkpcM8YC/P
 WvDRXJZVmLtMwN/d+cAtBM/TNKsoc5mVIp/XHYZ6uNE306OVJJsdOrpQjVPnBGHYRFYfMMeea3w
 ZRXWy/QH4KxTdBtiE32DzsFcm7HBERXT0+dpmQJXMUkLU1svIEPa/oSudaLFGGeeTqac3euzV+U
 2SZ97BFAV3AbkuHZ93L9bzRjvWxs3kpKFB+LCBLseW8XH71czgsW0KtJZQOnz8fTU/fAkO64Bao
 0jOmna35uHyI65xqh7j8vNhfo1uAHUQ5i8e+XwKOw1CDsYp0kQMbnk6yXN70dvnwnos22+WE1ss
 FaEECh6WisJT9dDfo/2z3NFUs4HR1RwuA4V5FIfvxzsE7DERUjY//+ImBHovHzaWRAAnuoe7qK4
 72ZHLx/nS5i9ssIK1VAOaxxWd6+i1W559j32/XkIIaa6Z0hLhQ4hXhF+ELUI0d7hncNlP0jS6te
 lQnrUwjT1WYQAkI1e8g==
X-Proofpoint-ORIG-GUID: QVpmtpa15MPQZXBvwi7m5f22LS-FOKbM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_080701_494190_47F05B2A 
X-CRM114-Status: GOOD (  13.96  )
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

On 5/27/26 7:19 PM, Keith Busch wrote:
> On Wed, May 27, 2026 at 11:50:00AM +0530, Nilay Shroff wrote:
>> Fix this by allocating the flexible array using nr_node_ids instead
>> of num_possible_nodes(). Since nr_node_ids represents the maximum
>> possible NUMA node IDs, indexing current_path[] using numa_node_id()
>> becomes safe even on systems with sparse node IDs.
> 
> What is the largest nr_node_ids we can reasonably expect to see? I don't
> want to end up trying to allocate a billion entry sparse array just to
> index a tiny fraction of them. Not that we didn't have a similar problem
> before, but this patch makes it clear we haven't been checking.

The nr_node_ids value is bounded by MAX_NUMNODES, which is a compile-time
constant derived from CONFIG_NODES_SHIFT:

#define MAX_NUMNODES    (1 << CONFIG_NODES_SHIFT)

nr_node_ids itself cannot exceed MAX_NUMNODES.

For example:

x86 (arch/x86/Kconfig):
config NODES_SHIFT
         int "Maximum NUMA Nodes (as a power of 2)" if !MAXSMP
         range 1 10
         default "10" if MAXSMP
         default "6" if X86_64
         default "3"
         depends on NUMA

arm64 (arch/arm64/Kconfig):
config NODES_SHIFT
         int "Maximum NUMA Nodes (as a power of 2)"
         range 1 10
         default "4"
         depends on NUMA

powerpc (arch/powerpc/Kconfig):
config NODES_SHIFT
         int
         default "8" if PPC64
         default "4"
         depends on NUMA

Looking across the architectures supported by Linux, CONFIG_NODES_SHIFT
appears to be capped at 10, which gives:

MAX_NUMNODES = 1 << 10 = 1024

So in practice, nr_node_ids should not exceed 1024.

This means the flexible array allocation remains bounded and should not grow
into an unreasonably large sparse allocation.

Thanks,
--Nilay


