Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40D5C5DF97
	for <linux-nvme@archiver.kernel.org>; Sat, 22 Aug 2026 12:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yLAUOuWzZP2XlsWB7vmpKR01zaVGZ9B5JKjM779GxUQ=; b=fJVv2UIYDDCUKh7WzB9TG94c0B
	FFZ8Kyadxf9WO7HPotNiZvlkBUDN9Ls59jzzqxSKnj68L0ymjMU9L94XcbKpWgYoMz3q/QO4JQ3aj
	qLkJVQrdeEN+RgISCwyrIHP5imSUfbi5l249BImGAd3Yr+rBaaIagi2tobb/W8gyoxpMVX6ceXGSK
	sqIgTK2WfMX8AQPc0FBusEpVzZ2cwlA7aO98VAnh97BRabS8JH1XGhaZHWoPRmvsjA2ipFctbPW00
	//3OKxh3TyLy+VmpncssPwwtlSFXLjzL36zBSWajSnkPcYqdXem+H9p7G6Blbi0rw7vaCGZ/Bv98c
	jSRZSDgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxkgO-0000000EVZf-0Daw;
	Sat, 22 Aug 2026 12:18:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxkgI-0000000EVZ9-2Sqm
	for linux-nvme@lists.infradead.org;
	Sat, 22 Aug 2026 12:18:39 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67MBVbHb2547654;
	Sat, 22 Aug 2026 12:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yLAUOu
	WzZP2XlsWB7vmpKR01zaVGZ9B5JKjM779GxUQ=; b=sPjJwsjZsebXjfsKKSZxCr
	iuBF4YZs7LcXNuzpDMNuJ99w8itvoFiicNcnvlSdSOJVLMhklImDb4g7F1yfayuW
	FfpTA8hl2XFmD5aRe9Dqd3pVOs7tqqP2hDlF4X+tk5omPi94qAHJQYMN3mOTRm/1
	FqyslRcouep18JtV6pNUtAwVeMi8gkkxRYPQZ6leSonyXqa5EhqvTPxjHRzI1u8T
	tIbFTPyN50ZHytBwn0CU57aB36cuLfu5So/dY6JeR4LQagUHyIGtY7yRQ357kM4m
	vN5spfTlGiH4qCo+Rjt2J0BtHid5oW2PeDqrCQph9R3cAwize/cSUisJXWVWTsdw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eq9bjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 12:18:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67MCBluY015613;
	Sat, 22 Aug 2026 12:18:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhsasu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Aug 2026 12:18:23 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67MCIMPb46465462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Aug 2026 12:18:23 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DADE958055;
	Sat, 22 Aug 2026 12:18:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5147F5803F;
	Sat, 22 Aug 2026 12:18:20 +0000 (GMT)
Received: from [9.61.73.62] (unknown [9.61.73.62])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 22 Aug 2026 12:18:19 +0000 (GMT)
Message-ID: <f2fa6f32-9df3-4bc4-8acc-1b8a73da76db@linux.ibm.com>
Date: Sat, 22 Aug 2026 17:48:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
To: Saravanan D <saravanand@crusoe.ai>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Daniel Wagner <dwagner@suse.de>
References: <20260820083634.71689-1-saravanand@crusoe.ai>
 <c194592f-6811-4eec-b5f1-2b015525c7a3@linux.ibm.com>
 <20260822004932.79147-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260822004932.79147-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c7IcwTDV93NIF_R3YnpEnv3h46L8Bpi_
X-Proofpoint-ORIG-GUID: c7IcwTDV93NIF_R3YnpEnv3h46L8Bpi_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDA5OCBTYWx0ZWRfX8teFXZrRNGkH
 GZyEduytBrg3/FezYI7FOJrVxuuYZ4S+xTbeAtndSHOVNKNmrOU6sl7nuyKEHDSa3ENQHv/5fuA
 r9dQnrwwoczfGSCZplcEkNej9qZtCqCBBWGEcaQnxpiCZQUZGnOFq0T/Xv0gg65vqF/Ao4vTXgl
 Y817MyNKp/XFiCs+IHrdC+90D54dlLkKGRM6pEJoqRWgR7qSyigs3a3eh4ZSlH6qnMhV789IB1S
 EsHDdXkI4ranpI5N4ycxElKLKtxzM1eXpuCQzHAvsjfnoaKMyiI0nY0U5/bXDzIQUl3vl/EXyLg
 UGoAYFOks5TInFbMA/eEPf3+d1ppuasyPkVvV7FXmXptDiqE7/fhXhuMft9K80UJKKmfsAAdOrt
 BonffQkBIjbC6J/EBIp7G7TwbGpkdVsloAHPESh0kbOq+/j8jM8AgNVJ9IRQSUeDnRJv4lv3X5w
 fqoVnSm6bginx4Ibd0Q==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a899390 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=_UoOXGINWOthsTMRIeoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDA5OCBTYWx0ZWRfX5SES2iKvu1+R
 qpKrU1Dsrg9tUiWuXTVuXO5UMMzg8fHRFwh4N9N7k/BUsZzBTNxjiMIdBloZ0e3OXzzEo+a7H6w
 hMvklOWFruqNL3NRyuR6AYwbwEEAxo8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608220098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260822_051838_643225_11477D7B 
X-CRM114-Status: GOOD (  21.18  )
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

On 8/22/26 6:19 AM, Saravanan D wrote:
> On Fri, 21 Aug 2026 21:17:49 +0530 Nilay Shroff <nilay@linux.ibm.com> wrote:
>> It seems that here multi tenants shares the same NVMe/TCP controller.
>> So if the concern is CPU isolation between tenants, why are multiple
>> tenants sharing the same NVMe/TCP controller? Wouldn't a per-tenant
>> controller/connection provide better isolation and allow each
>> controller's queues to be mapped to the tenant's CPU set?
> 
> The controllers are shared because the tenant VMs' virtio-blk devices
> are backed by namespaces under one multipath subsystem the hypervisor host
> connects to. With many VMs per host, maintaining a per-tenant controller
> is not always feasible because of the overhead on the host and risk of
> running into target connection limits. blk-mq spreads any controller's
> queues across every online CPU, so nvme_tcp_set_queue_io_cpu() picks io_cpu
> from a machine wide map whether the controller is shared or dedicated.
> Tying socket work to the submitting CPU will reduce VM steal time in
> these deployment scenarios.
> 

Yes, nvme_tcp_set_queue_io_cpu() currently spreads the I/O queues across the
online CPUs, so I understand why a shared controller can end up with its queues
mapped across CPUs belonging to different VM/tenant cpusets.

My point was if we could instead  make the queue-to-CPU mapping aware of the
tenant's CPU partition when the controller is created. For example, if the
hypervisor knows the CPU set associated with a VM, we could pass a CPU-placement
hint/cpuset as part of the fabric connection setup and then have
nvme_tcp_set_queue_io_cpu() select the queue CPUs from that set rather than from
the machine-wide blk-mq CPU map.

This would preserve a stable queue-to-CPU mapping while ensuring that the
NVMe/TCP socket work for a controller is confined to the tenant's CPU partition.
Compared with dynamically adopting the submitting CPU, I think this could have
some advantages:
- the queue-to-CPU mapping remains stable
- it would make CPU/NIC topology tuning such as XPS/RPS and ntuple steering
   more deterministic
- As queues are not moved across cpus, it may provide better cache locality
   and potentially reduce cross-CPU wakeups/IPIs associated with moving the
   socket work.

There is another aspect I'm wondering about regarding the VM steal-time
observation. The io_cpu adoption addresses the execution of nvme_tcp_io_work,
but there are still other parts of the receive path such as the NIC RX interrupt
or NAPI and subsequent network processing that can execute on CPUs outside the
VM's cpuset depending on IRQ/RPS configuration. So I'm not sure whether moving
io_cpu to the submitting CPU by itself can guarantee that all NVMe/TCP network
processing stays within the tenant's CPU partition.

If the objective is strict CPU isolation, perhaps it would be useful to consider the
CPU partition as a property of the NVMe/TCP connection and keep the queue/CPU mapping
stable within that partition, while separately configuring the NIC IRQ/RPS/XPS/steering
to maintain the same locality.

But yes my above recommendation would require creating separate controller
per tenant/VM.

Thanks,
--Nilay


