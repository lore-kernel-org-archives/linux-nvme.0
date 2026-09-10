Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D78AC79F9F
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+yz3BRkdAokO04A7Rf20m/zglgAa8AOrj9pXzNWBaLw=; b=BZ0usv8iGvLVYk0v4kjfNUegBe
	tAE288FkpheF+Ipqu22Y9GvXMLgyWNRfSFKnQzaZ/T3SkEv9vRmR8walZgRA36gprgjSM7dGRkbTP
	dgaXrNYjrBh3F6CqnCDdXQpMRJOBWYwJq/LIp46KEgoC9fhyGmDutBed6onIIoqFjouM+2dhPKAPx
	2px9SpmQ1YW87ejrJEGpuGS7absLVlOqmtuHnAnsv1Nuojjv+L6OC8lh9jBn5SKFJ/wXkSBVFHeso
	aD6qzs08A+CJhqHTb05TJG2FokfCfvcEw+W4fK75GWn/lk06uqq/ZhBzfUEb0a/nwWmGyDy1BneE3
	mcR3IK2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4a6v-0000000Djlr-264l;
	Thu, 10 Sep 2026 08:26:21 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4a6t-0000000DjlG-1GyB
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 08:26:20 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5VMbX103872;
	Thu, 10 Sep 2026 08:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+yz3BR
	kdAokO04A7Rf20m/zglgAa8AOrj9pXzNWBaLw=; b=TIw2R9QFXjVwmpcPTajDnn
	jQ6/0/OmX9mdxFSNi1SFY7ybA6E0KJq4T5CTaEb/L3lqOVLl9uS8/l9OHUl6+HQ4
	rWGA5NXZfQCfmlQrT/0rtJu+58zI021YhHSouX3yimxftJsR9EFHifrdnevj1+49
	TU/WRkplMM/FjIrPFTTTfOvJAgt1gYANjDuHqPZeeWQkpYlUoxZIidPpuAZCoGL3
	u0MUZGsVZH0HHcGzVGtrzBWVbWaptidyCZWQID/R3YTS1d3ACnKq6EzpdDLmdfSA
	yjeprC0HMQbaSgOSeFgMFVBXVMGGWAuaJa/YGX7XEPNMlLEa+YfSb1/VW0PUzCPA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n3axs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 08:26:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A7uYKa014691;
	Thu, 10 Sep 2026 08:26:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3bc7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 08:26:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A8Q8Pw27329124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 08:26:08 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021D058064;
	Thu, 10 Sep 2026 08:26:08 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B2BF58057;
	Thu, 10 Sep 2026 08:26:03 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 08:26:03 +0000 (GMT)
Message-ID: <8dfee10f-89f3-463b-8d16-587873c3394c@linux.ibm.com>
Date: Thu, 10 Sep 2026 13:55:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-tcp: allow setting per-queue io_cpu through sysfs
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, linux-kernel@vger.kernel.org, iyamahata@crusoe.ai,
        kiyer@crusoe.ai, ganbalagane@crusoe.ai, sj@kernel.org
References: <20260909211432.6741-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260909211432.6741-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa269a1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Swr8LgwRl-hf65YLT7AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6STJJ1tSbV-_Y0TuKoKFzaTZDU2Ok3hB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4OCBTYWx0ZWRfX44tSxnh+IqVE
 BFONQ/dKxJyiFqCqJgv9YBSEaaP6GTbAVn6vkwof/e0bgVpqEE8nVaNVPCTsVPxW9a+n1RH6I0C
 sQreAMkP21KtDrchVu/TfV7evM2xgx8FMxmiq2PNDQA4zCtzTHUw6JTBR5fK7TbrZG/vrGq+APV
 KB6+2Gx3PjAV+WnpB3GR32FjCBM3PPThjxp0NptNsZAZ+87IUc6VvXxQ9ocQvpmZM0UniOXD/S0
 VCluIT0hGgVB3PodfFifrd+i2XvIlre/muvQx77a2+9lh6ky1KsLVJvbeV5N6HhzKlJ+waJS2P1
 rCNhuCOvl8AEYX19dutkeV9PILD55o5W1eq0kTp3ORyiUPm7nbj5JA9eyBnpVz+4kI7DYgok0re
 5P8uZQT6L892Rg+Jol9gg0WRlhpJRxR5cOgwCu32zw2kWbvcK+57CA3T7xd5ZDiT3qHmIuL6rgf
 txogfu+/Kzz6k7YDUAQ==
X-Proofpoint-ORIG-GUID: 6STJJ1tSbV-_Y0TuKoKFzaTZDU2Ok3hB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4OCBTYWx0ZWRfX2b2TRnGyEZYi
 1dvtNks1l7xasafxzJgDOyTuBN/zw29lJGKOyZvipZwHe+LrE+lzc5xGuPcvAQmy5gu1Dim8Nn2
 gdzpkQ4txZ7C/rdycFRQvkWwt3PN6x0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_012619_366196_09D4334E 
X-CRM114-Status: GOOD (  19.03  )
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

On 9/10/26 2:44 AM, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time
> as the least loaded CPU in the queue's blk-mq map group, and all socket
> work runs there for the connection's lifetime. This decision falls
> short when the host partitions its CPUs after connect time. On a 384
> cpu multi tenant host with 128 queue controllers, blk-mq folds three
> CPUs into every map group, some groups straddle two tenants' cpusets,
> and 9% of nvme_tcp_io_work executions ran outside the submitting VM's
> cpuset, seen by the neighbor as steal time.
> 
> Expose each I/O queue's io_cpu as a writable sysfs attribute
> 
>    /sys/class/nvme/nvmeX/tcp_queues/<qid>/io_cpu
> 

I wonder if we should avoid introducing a transport-specific tcp_queues hierarchy
here. io_cpu describes CPU placement of an NVMe I/O queue rather than something
inherently specific to TCP, and other transports may have similar queue-level
attributes in the future. Could we instead introduce a generic "queues/<qid>/"
hierarchy under each NVMe controller, e.g.

      /sys/class/nvme/nvmeX/queues/<qid>/

and have transports expose queue-specific attributes there? The "queues/<qid>"
object could be created for every controller, while transports that need queue-
specific sysfs attributes can populate the corresponding <qid> objects. This
would give us a transport-independent ABI and avoid introducing separate
tcp_queues, rdma_queues, etc. hierarchies.

> so a control plane that owns CPU placement can set it directly instead
> of relying on the driver's heuristic. A written value persists across
> reconnects, marked by NVME_TCP_Q_IO_CPU_USER. Writing -1 clears the
> mark and re-runs the connect time selection. Reading returns the CPU,
> or -1 when the queue is unbound.
> 
> The store, the connect time selection and queue stop serialize their
> accounting of nvme_tcp_cpu_queues under the queue lock.
> 
Also, based on the current design, it seems possible to have some queues whose
io_cpu is driver-managed while other queues are explicitly managed by the
control plane. This gives useful flexibility for the tenant use case. However,
looking at the io_cpu sysfs attribute alone, it is not possible to determine
whether the current CPU was selected by the driver or explicitly assigned by
the control plane. So could we expose this state through an additional read-only
attribute alongside io_cpu, for example:

     /sys/class/nvme/nvmeX/queues/<qid>/io_cpu
     /sys/class/nvme/nvmeX/queues/<qid>/managed

where "managed" indicates who currently owns the CPU placement. For example, "1"
could indicate that io_cpu is driver-managed and "0" indicates it is managed by
the control plane or user. This would make the current ownership state observable
without making any wild guess.

Thanks,
--Nilay

