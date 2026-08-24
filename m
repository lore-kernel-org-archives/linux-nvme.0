Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15990C5DF94
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 08:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GtyS1D6K4/wbFCLMp22u/imsbR47gCjrDfl8lEB1Oy8=; b=La0ebP543jHLPAEP0lQsVRKJzr
	XIfYxzn4EQk4mTo0cqXa6Q7zT9f8h4Z9C8pJFOuoV3G6MVPV+BQI5ADUGvvOQVH38dNd1cUkg0xTv
	ioDWzSWI6JXO6PFOqXrBg7lcXtEHTyr7st23LksOHNi623LXf1rS35OxvjXI0xaR2lhzju7wn7YRS
	jK9OXfwjtcpXjr6uny8awIZqjZNIXUeYEGL5Qo2655X1qNlsIGdmglSIvm6XVYDCs91licoHiZfRV
	HF3IcegAacOBxDOVUcq9aRnUZQiunp7qlt335i7YmYiJdgNGnKJeSVJl4exTq6Q+q+CmoAu0WElzP
	BPRdPnNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyQMC-0000000GEDf-2h5K;
	Mon, 24 Aug 2026 08:48:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyQM8-0000000GED3-0BUR
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 08:48:38 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O5VUhZ939008;
	Mon, 24 Aug 2026 08:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GtyS1D
	6K4/wbFCLMp22u/imsbR47gCjrDfl8lEB1Oy8=; b=B3Gl9xXFHTpjA4oDjY79Zs
	LsOl8b31FGbnyru2zE5oxJbaIMJ0UHs07xDv4IMbeedGDCtCM0cadzVN94b4UGPK
	xtHtVDJ7Doq4oA8DaPDJxJMGwq7A6Wf5ZTFaUfr4W8of1SD0watF1pFV1485X3vJ
	Vdb0g+p/7IfIQa3/JEKV3zIgspi2TWvvngVndZmeAR2fQxvhxR1oY3YBWgAqHK4z
	rOa9LPeVmYBKa9UaDm7v7EzhojSnp/MyafUK0UZ7ZKbLLo3aq7dtMM0u4hL6jMK/
	4ScmgIbhDWEUZBoACe0YUiBbb+yoO9pnC4tZQSXE2POgnGz56OYn2DAMzIKIC69g
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7393r5yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:48:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67O8fN7I015163;
	Mon, 24 Aug 2026 08:48:26 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxvmt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 08:48:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67O8mQLo9568792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 08:48:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6D55808F;
	Mon, 24 Aug 2026 08:48:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F96A58056;
	Mon, 24 Aug 2026 08:48:23 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 08:48:23 +0000 (GMT)
Message-ID: <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
Date: Mon, 24 Aug 2026 14:18:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: AmWpxEvEtIXIeWEuK4cHHrI7IK6g1agp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfX3RFcOAw3FEoE
 +znd24xLguA9+QF1CESompFeIa+cneM1dhga6Tw1XWjMC0FuLdQw7gNgDf30IAvf6g5UAVf72Vq
 8z1k5Zzvu4NqwuV+r0xcSUR/5mPAeIfcA3o4J18QBSEszGKCwzjv/g5T+CL3OkdioJUnQzeoy5L
 TBIA+mg8cx456yPXzrVH6zZEqDqM0R11Iy9FNcg9/hUscsoojQgBl0y6GW5m/lE8XGt4oOrZlDT
 KmdUuaFzyV64geg+09VlzV2aIV3duPKKaBx0Z48057yH0fNYI2ixOgUA1z+/3CqeRcOcJAdsfBl
 m9FUVo4zqpSx5O05xKqUSBa9zXCR3kCyvQ+HurKOW8Vim86ozlnQyeUseFbQUZPtdwIhAx+LaNE
 +6RWiE/8VfeU7twPoasQmz+GDRcAjvCws7pmt+p/6EsARW6hmnDveaC8i3JwPGDiGE9lUTdkUUO
 9Q8BPrKAlNtz1o3qUig==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8c055b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=DTaaC5Rm1_Pzg6dT-csA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NCBTYWx0ZWRfXwPmuXXF0CzmL
 JgcXEFiPEq95MuVTZ0N2n7P9K7jsEYf2P1Nyg3RmPej0o1abyqws8Ll9MBmsDJ3sHdWGK80KMvB
 82HGdYPspltTpw0IvBHG0fO6zal2TAI=
X-Proofpoint-ORIG-GUID: AmWpxEvEtIXIeWEuK4cHHrI7IK6g1agp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260824_014836_092482_D65B0DAB 
X-CRM114-Status: GOOD (  23.99  )
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

On 8/23/26 3:13 AM, Sagi Grimberg wrote:
> 
> 
> On 21/08/2026 17:43, Nilay Shroff wrote:
>> Hi,
>>
>> This series is a rework of the earlier patchset[1]. The main
>> difference is that --nr-io-queues is now calculated in nvme-cli
>> instead of in the kernel when establishing an NVMe/TCP connection.
>>
>> This rework is based on the feedback received[2] from the netdev
>> maintainers.
>>
>> The original patchset determined the number of NVMe/TCP I/O queues
>> based on the number of online CPUs and the number of hardware queues
>> available on the NIC in kernel driver. This series moves that logic
>> to nvme-cli.
>>
>> When --nr-io-queues is not explicitly specified, nvme-cli determines
>> the egress netdev for the NVMe/TCP connection, retrieves its current
>> hardware queue count, and calculates the default as:
>>
>>     min(nr_hw_queues, num_online_cpus)
> 
> This looks reasonable Nilay.
> 
Thank you...

> I am wandering tho if we want to place some lower limit here.
> For example, my laptop has a virtio device with 4 cpu cores and
> a single combined ring:
> -- 
> $ lscpu | grep NUMA
> NUMA node(s):                            1
> NUMA node0 CPU(s):                       0-3
> $ ethtool -l enp7s0
> Channel parameters for enp7s0:
> Pre-set maximums:
> RX:        n/a
> TX:        n/a
> Other:        n/a
> Combined:    1
> Current hardware settings:
> RX:        n/a
> TX:        n/a
> Other:        n/a
> Combined:    1
> -- 
> 
> It would be kinda annoying for me to now explicitly pass the nr-io-queues...
> I am wandering if some sort of threshold make sense as what you are aiming for
> is reducing the amount of queues for large cpu counts...

I think you're running a QEMU guest using user-mode (SLIRP) networking, so having
a combined queue count of 1 is expected.

I also tested this setup before posting the change. With QEMU user-mode networking,
increasing --nr-io-queues beyond 1 (I tried 4 and 8 with vCPU set to match those
numbers) did not improve performance. In fact, limiting --nr-io-queues to 1, which
matches the netdev's single combined queue, gave slightly better performance.

My understanding is that in this topology there is only a single underlying
virtqueue/network queue, so creating multiple NVMe/TCP I/O queues does not provide
additional network parallelism. Instead, those NVMe/TCP queues end up contending
on the same virtqueue/network queue, which can add overhead without providing additional
throughput.

So I'm inclined not to impose an arbitrary lower limit on --nr-io-queues. If the
egress netdev reports only one hardware queue, min(nr_hw_queues, num_online_cpus)
naturally gives 1, which seems like the appropriate choice for this topology. If
the goal is to achieve higher throughput in a QEMU guest, using a networking
configuration with multiqueue support (for example, multiqueue virtio with
vhost-net) would be more appropriate. In that case, the number of available netdev
hardware queues can scale beyond one, and the calculated nr-io-queues can make use
of that parallelism. Alternatively, with PCI/VFIO passthrough, the guest can directly
use the queues exposed by the physical NIC, allowing --nr-io-queues to scale
accordingly.

Thanks,
--Nilay


