Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C49C61DF0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 05:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZrXZuXPsahHTosCia8k5kiAr2uEYUWX9YzsB62ryEQ=; b=KibTYPCSSDylf539RE6FartIRu
	4J8iZTS1txlfZKVCeB1B+m9wxjQH+zQl3nb6JkVugQo3sm+DbzcRis3ZhKPS9A8Z2JUBpJWhNr860
	5j5I+7aVdU6Vs3bhBNeuY8UzPr5RKd7vqxmGwKjnK4bTs2xYdXflIbAEbXDWPGwaR2GrFKQ38jJ+4
	61QJz4KD2nHuggV/UDB2uvfltNjAb5DkjksHho8RjEInesVbqUtbd34hLOwMOW/dtk+AAubE4nnre
	NAwujDz3DgERPsET7ko+1uAlKhliKX3Vv4pye9YbO3nac3Bp0S0qZbwslN04yRHANWgWPLdANkQhf
	W1HXqqgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0uD2-00000008Vil-13sY;
	Mon, 31 Aug 2026 05:05:28 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0uCe-00000008Vho-2yZW
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 05:05:26 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52YIU3591412;
	Mon, 31 Aug 2026 05:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6ZrXZu
	XPsahHTosCia8k5kiAr2uEYUWX9YzsB62ryEQ=; b=I4JzSM7iprsJjgZ83YlEW0
	NyuKwgAms265YpiNwFhbBZAlHwJTcarQXVXnLcZmSq4OdH4eraSySbT2zile1/D7
	1t3m50vAEIWRl4e8HET2n9ynaWySOD2/zuBosSBnJ30b0lTmbCMVmHkYbLmsYOpR
	97p18uHVkBL7rfkTg50RG1lym58wgsrT7ZvTOvpN5jtkzPqNoayOCIK+1TokvBSy
	EaZ6/+gGbbnU/Wt1oZy9yuvPoALVKoh1BT/ZBRhgHrizoNW/VYnUwtTOy0hVZJO1
	VBpA7l4fzSciK7f+5+wIFzWy7mW/9SyU6B8vNlH/Akx/vs4VJ1JjsfsxZOGPiMrQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3qy5ha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 05:04:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V4uHXD031829;
	Mon, 31 Aug 2026 05:04:48 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg3tmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 05:04:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V54lQJ41550432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 05:04:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E735580B9;
	Mon, 31 Aug 2026 05:04:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E49158064;
	Mon, 31 Aug 2026 05:04:44 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 05:04:44 +0000 (GMT)
Message-ID: <9691f1d3-ec06-45d2-a427-ba46df5fa57c@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:34:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme-cli: NIC topology aware I/O queue scaling
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, hare@suse.de, kbusch@kernel.org, hch@lst.de,
        gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260821144329.3620389-1-nilay@linux.ibm.com>
 <4a80220a-2cba-4a4a-85c2-7c3d3ae8a20a@grimberg.me>
 <32bcaf68-a142-4612-9967-815dd28ee2a0@linux.ibm.com>
 <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <9271266f-3d7e-426e-93b6-6f1f28bc9b0f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a950b71 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=y_ueknYH1AKcKQBZOEwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX33Sxm4lRxamw
 fika2ge6NsBQgoZGualsAkOnyMHGRdkqhlorIa05zJKrnJtGnbejETROkDXzjahKofy7Z4qtAun
 RHurD2+fmJTpsM1mn34aX1WFNzf4+XopO5JH3yiIz2ZfQoBhqFwxT+bgPOLM7QP8MFhD9DpZZpy
 KYaziNJnumg3PU26hxZsRjycPNo5zdzemQgpEP7PKHq+yaCtOkzpZq0umPoGUK0z/FU4bDzO0oC
 BORzMhN4vGhqyRp6tP6Yjor+wY1V5z39agXAa0K9DiHq3TjMQ33Bt14EjmU18AgBD4srU52k8Lw
 cpJw6dthUIVcqMUxHYwZugk2Py4XKf7z3L42cPmk2So4oWH6x6ca234z7OY+6yVcLk7xP/es2I0
 UiUK9c2y70FLiFFlzPw6ARYXFyIyexJGxDRsD7ph6frEgdPfBKQbggBDkt33GiAZQPIenrFiJ6A
 EXf4v8xR7YmCRyh/8Zw==
X-Proofpoint-GUID: 9wCWy9kE4NmkdIldnotLnt1qPVatVCoY
X-Proofpoint-ORIG-GUID: 9wCWy9kE4NmkdIldnotLnt1qPVatVCoY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA0MSBTYWx0ZWRfX6ordGj4xvEMc
 9uCCgOqqhpb96/UuWk0FQNGL/LHah1TUWApJj7YhNMXTT9QwuTRJ4qWQ2eiTPMn1KKxF3RNWdgW
 oAoN8XLkxHS5Q33jezPZfpPZfbcUmzE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310041
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_220504_760405_EDBC96E7 
X-CRM114-Status: GOOD (  23.85  )
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

On 8/31/26 3:36 AM, Sagi Grimberg wrote:
> 
> 
> On 24/08/2026 11:48, Nilay Shroff wrote:
>> On 8/23/26 3:13 AM, Sagi Grimberg wrote:
>>>
>>>
>>> On 21/08/2026 17:43, Nilay Shroff wrote:
>>>> Hi,
>>>>
>>>> This series is a rework of the earlier patchset[1]. The main
>>>> difference is that --nr-io-queues is now calculated in nvme-cli
>>>> instead of in the kernel when establishing an NVMe/TCP connection.
>>>>
>>>> This rework is based on the feedback received[2] from the netdev
>>>> maintainers.
>>>>
>>>> The original patchset determined the number of NVMe/TCP I/O queues
>>>> based on the number of online CPUs and the number of hardware queues
>>>> available on the NIC in kernel driver. This series moves that logic
>>>> to nvme-cli.
>>>>
>>>> When --nr-io-queues is not explicitly specified, nvme-cli determines
>>>> the egress netdev for the NVMe/TCP connection, retrieves its current
>>>> hardware queue count, and calculates the default as:
>>>>
>>>>     min(nr_hw_queues, num_online_cpus)
>>>
>>> This looks reasonable Nilay.
>>>
>> Thank you...
>>
>>> I am wandering tho if we want to place some lower limit here.
>>> For example, my laptop has a virtio device with 4 cpu cores and
>>> a single combined ring:
>>> -- 
>>> $ lscpu | grep NUMA
>>> NUMA node(s):                            1
>>> NUMA node0 CPU(s):                       0-3
>>> $ ethtool -l enp7s0
>>> Channel parameters for enp7s0:
>>> Pre-set maximums:
>>> RX:        n/a
>>> TX:        n/a
>>> Other:        n/a
>>> Combined:    1
>>> Current hardware settings:
>>> RX:        n/a
>>> TX:        n/a
>>> Other:        n/a
>>> Combined:    1
>>> -- 
>>>
>>> It would be kinda annoying for me to now explicitly pass the nr-io-queues...
>>> I am wandering if some sort of threshold make sense as what you are aiming for
>>> is reducing the amount of queues for large cpu counts...
>>
>> I think you're running a QEMU guest using user-mode (SLIRP) networking, so having
>> a combined queue count of 1 is expected.
>>
>> I also tested this setup before posting the change. With QEMU user-mode networking,
>> increasing --nr-io-queues beyond 1 (I tried 4 and 8 with vCPU set to match those
>> numbers) did not improve performance. In fact, limiting --nr-io-queues to 1, which
>> matches the netdev's single combined queue, gave slightly better performance.
>>
>> My understanding is that in this topology there is only a single underlying
>> virtqueue/network queue, so creating multiple NVMe/TCP I/O queues does not provide
>> additional network parallelism. Instead, those NVMe/TCP queues end up contending
>> on the same virtqueue/network queue, which can add overhead without providing additional
>> throughput.
> 
> I don't care about performance. I care that if I am testing stuff, I want more than a single
> queue. And it is annoying to explicitly change the queue count...
> 
> Also, I don't know if your performance statements are correct for TLS.

Okay, in that case, if nr_hw_queues is 1 and the user hasn't explicitly specified --nr-io-queues,
we would not limit the number of I/O queues based on nr_hw_queues. Instead, we would use
num_online_cpus as the default.

So the policy would effectively be:

if (nr_hw_queues > 1)
     nr_io_queues = min(nr_hw_queues, num_online_cpus);
else
     nr_io_queues = num_online_cpus;

This would preserve the existing behavior for single-queue devices while still using the
NIC hardware queue count to constrain the default on multi-queue devices.

Does this look reasonable?

Thanks,
--Nilay


