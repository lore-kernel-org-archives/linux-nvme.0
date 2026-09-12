Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13DEC79FB6
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 12:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e6lQSTtoGYqGPR7kXlx3K6vZHzq50tA6UO7shRshLUo=; b=PnsEy2t0xyXji6CZ+idTGvtJXf
	7MaSG9ZeYdRc3gyQMednRo1wA6Dd0u8nMo64sA7QmM6F5Gv9XGO4KAghYt6WAlxD5AR5gGBFQTdBN
	llut5keM3GX+UuvUPKNvmTjr6n1z+JOhHVwFU8tzWlXWHP+xzhFahmB/OvAn7nJ1ruhpgbzrQU1T5
	aOM4fZFh/9dFdN3pYWQMaihZ/MQmosAHIZOhp44n4XMiHaFbvhUOs+bnewBWNMHy9kazk6q2ii1R7
	DuY3rZ7gUyAtVnALUhlAY0FpdVzMSFT9Us6keWjQfHdnlzyLBG7vMitG+aVx5vKRrhWnUcS5kmwIH
	Rphi6bNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5MZv-00000000r9v-0LEJ;
	Sat, 12 Sep 2026 12:11:31 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5MZq-00000000r9Z-3qaf
	for linux-nvme@lists.infradead.org;
	Sat, 12 Sep 2026 12:11:29 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68CC1RNc488564;
	Sat, 12 Sep 2026 12:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e6lQST
	toGYqGPR7kXlx3K6vZHzq50tA6UO7shRshLUo=; b=EzA1hj9PUyL1WWfsIxIusZ
	+F8FjvMw5CLgvSddCNMfKr9OPz1Xq/RmzReG2TOPNyD1DxyfPM3RTfYHn2fsyycO
	m74d2M1eK2iIY0tqDt1SL212zvQmXYUvKmG/wNdMA88JQmb3mQ7XdOHcCal9xucD
	8lM7H1qBIIF3I4aXO3kXYBbIWW6zqLKWKk8qcyC4bMAoxwvKj7I+KE4wGBDTwIZ6
	zbeYTkMjPV359NKBHdIsr44mTe8jPRU7O37jdcSpdHnmcGo2VtdOW702wxVSEVJe
	vNC0eNbfrrt8cWt5XBZMRBeN4QVk2AztF9Unj+wMHpfvKxCznYYlNirp2UtODDmQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx83997u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 12:11:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68CBbNVe3253416;
	Sat, 12 Sep 2026 12:11:12 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq332we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 12:11:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68CCAT4w55247158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 12:10:29 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B1B658055;
	Sat, 12 Sep 2026 12:11:11 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F05758043;
	Sat, 12 Sep 2026 12:11:09 +0000 (GMT)
Received: from [9.61.162.129] (unknown [9.61.162.129])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Sep 2026 12:11:08 +0000 (GMT)
Message-ID: <26f90121-b787-4d06-8741-4fac21b46ecb@linux.ibm.com>
Date: Sat, 12 Sep 2026 17:41:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
From: Nilay Shroff <nilay@linux.ibm.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
 <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
 <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDE3MyBTYWx0ZWRfXzG7trGaX+27f
 GQ++/uN15EjUWjdLwMOByY+ndia63RQ6qcTgIVY1eRJ2wK/d/kbed5aqpe9prSe7dFqVElzVSsb
 4U2cUZIXimarwvp+jYA7ZDbNPjgq4+ewQ+F01tWorxdK6DgDhlyAYU2YYZgiIgRk2bm9yBL1F5t
 55xDRTCbheqcftosZTINg/q/dCo4hut65a60JYI8zFqXt0hZ/wT0Qal2fE0F7CK3nOf60j6bLCA
 IeM6tDkhiKCAd3hCnyYDBFVkJ/uC44L8C5/ZvSmmXvrNWeHDGaxUUF4X9Nro23qEs2KDRsJv828
 y3a5SB6+cf8/+A6c2ZYJb5w233AkL0Fh8H5fS1p+dREdh+rkgN4GLNTnq7urQtVsWdzFGClvGB8
 OZUqDsZacBdCqtjf37J0sxmmCKPm3AkUraX9WhoBxdu/f504CyDc06LGTENmtAY3R08ixy0rYvA
 jlEGAO9I7h6p/QBpg9Q==
X-Proofpoint-ORIG-GUID: 6GnGwKU5hbVIF3blEx5QoF9jnNRBS9Kj
X-Proofpoint-GUID: 6GnGwKU5hbVIF3blEx5QoF9jnNRBS9Kj
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDE3MyBTYWx0ZWRfXzYA9Rrhu9L+R
 uvDRJVi7n1rR1DvN6N68GTEHGlG24emB/ROegDtCwNOMdVj3seQhmkb1kilrq8FFuzejyysqBku
 kWD3rGv7jH8hngZnccWhheV0TgjYhtI=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aa54161 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=IovIIfFjA8YJeCggkCQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_04,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120173
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_051128_385761_F0BFA2B9 
X-CRM114-Status: GOOD (  25.72  )
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

Hi Sagi,

A gentle ping on this one.... Does the proposed solution address your concern?

Thanks,
--Nilay

On 8/31/26 10:34 AM, Nilay Shroff wrote:
> On 8/31/26 3:36 AM, Sagi Grimberg wrote:
>>
>>
>> On 24/08/2026 11:48, Nilay Shroff wrote:
>>> On 8/23/26 3:13 AM, Sagi Grimberg wrote:
>>>>
>>>>
>>>> On 21/08/2026 17:43, Nilay Shroff wrote:
>>>>> Hi,
>>>>>
>>>>> This series is a rework of the earlier patchset[1]. The main
>>>>> difference is that --nr-io-queues is now calculated in nvme-cli
>>>>> instead of in the kernel when establishing an NVMe/TCP connection.
>>>>>
>>>>> This rework is based on the feedback received[2] from the netdev
>>>>> maintainers.
>>>>>
>>>>> The original patchset determined the number of NVMe/TCP I/O queues
>>>>> based on the number of online CPUs and the number of hardware queues
>>>>> available on the NIC in kernel driver. This series moves that logic
>>>>> to nvme-cli.
>>>>>
>>>>> When --nr-io-queues is not explicitly specified, nvme-cli determines
>>>>> the egress netdev for the NVMe/TCP connection, retrieves its current
>>>>> hardware queue count, and calculates the default as:
>>>>>
>>>>>     min(nr_hw_queues, num_online_cpus)
>>>>
>>>> This looks reasonable Nilay.
>>>>
>>> Thank you...
>>>
>>>> I am wandering tho if we want to place some lower limit here.
>>>> For example, my laptop has a virtio device with 4 cpu cores and
>>>> a single combined ring:
>>>> -- 
>>>> $ lscpu | grep NUMA
>>>> NUMA node(s):                            1
>>>> NUMA node0 CPU(s):                       0-3
>>>> $ ethtool -l enp7s0
>>>> Channel parameters for enp7s0:
>>>> Pre-set maximums:
>>>> RX:        n/a
>>>> TX:        n/a
>>>> Other:        n/a
>>>> Combined:    1
>>>> Current hardware settings:
>>>> RX:        n/a
>>>> TX:        n/a
>>>> Other:        n/a
>>>> Combined:    1
>>>> -- 
>>>>
>>>> It would be kinda annoying for me to now explicitly pass the nr-io-queues...
>>>> I am wandering if some sort of threshold make sense as what you are aiming for
>>>> is reducing the amount of queues for large cpu counts...
>>>
>>> I think you're running a QEMU guest using user-mode (SLIRP) networking, so having
>>> a combined queue count of 1 is expected.
>>>
>>> I also tested this setup before posting the change. With QEMU user-mode networking,
>>> increasing --nr-io-queues beyond 1 (I tried 4 and 8 with vCPU set to match those
>>> numbers) did not improve performance. In fact, limiting --nr-io-queues to 1, which
>>> matches the netdev's single combined queue, gave slightly better performance.
>>>
>>> My understanding is that in this topology there is only a single underlying
>>> virtqueue/network queue, so creating multiple NVMe/TCP I/O queues does not provide
>>> additional network parallelism. Instead, those NVMe/TCP queues end up contending
>>> on the same virtqueue/network queue, which can add overhead without providing additional
>>> throughput.
>>
>> I don't care about performance. I care that if I am testing stuff, I want more than a single
>> queue. And it is annoying to explicitly change the queue count...
>>
>> Also, I don't know if your performance statements are correct for TLS.
> 
> Okay, in that case, if nr_hw_queues is 1 and the user hasn't explicitly specified --nr-io-queues,
> we would not limit the number of I/O queues based on nr_hw_queues. Instead, we would use
> num_online_cpus as the default.
> 
> So the policy would effectively be:
> 
> if (nr_hw_queues > 1)
>      nr_io_queues = min(nr_hw_queues, num_online_cpus);
> else
>      nr_io_queues = num_online_cpus;
> 
> This would preserve the existing behavior for single-queue devices while still using the
> NIC hardware queue count to constrain the default on multi-queue devices.
> 
> Does this look reasonable?
> 
> Thanks,
> --Nilay
> 


