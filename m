Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9A9E63F30
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Feb 2026 06:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ziQmSVpqO3eS+LCV+2ac42zjhmOf5EtRKaeBx4pkGUg=; b=iq0Z8QkzffoyjIuzVaNDXUzcoh
	UcVOmhT1P02Lx0O/r1XdcHuin8rQQDH9IO/6JpGrH2XRSOXhan+AGDavM7jEhD3FIBcGLr4KgG9M4
	t8qq4G1Dr8bCogUjQJxPS7Bsg0aklsP+8jQaxr5KayHQbBNguzEvAIuQppoVYmcoLwBCZjd7ZiNJ0
	HqgUf88whB+3zYh59KmIjBvWR+9d//bF7gNTOGntF++iDlAvZHCYJ5S1vwMyOe0ZIDR9gvM+sKPPU
	atwaNJ5XFI+d7YlHQ0NoqVQOrK6siIVR2HckafW646mz6oGioI4Z27Hn8GqHzLj4iwDLQZfyM8ih3
	aexdroVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrsQj-000000063Fq-23SK;
	Mon, 16 Feb 2026 06:50:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrsQh-000000063F8-24a1
	for linux-nvme@lists.infradead.org;
	Mon, 16 Feb 2026 06:50:00 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FNHZvb3694814;
	Mon, 16 Feb 2026 06:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ziQmSV
	pqO3eS+LCV+2ac42zjhmOf5EtRKaeBx4pkGUg=; b=HiBiL22ADwQ5A1etOkj4XC
	oCpicWsdnvwd5+EQ9JG7aEdANJE4JVGP/eir5cx2XILD4pS5WdTk+sMIhCyjPl5L
	1hlZMRImJDhw8KqTrTKpIRvVT65AYXZmQRi292mn/PHz3c50MPNhf2U/dEUWwAeg
	AnYl+5bDmfey3xiJeWzJmuzM9hLf78lFN2/p0DnKkJpDRth604htso6BnLRsroPa
	UCiLuT2y4NTuMzAqYSHuhOCWu3nypH1sZuILIrhGdQ0AzNtkF70COWupNawxUkK6
	cWVbnHEmNCN2rZ2+ZqJW82vkxK0+970WiEaDodsONkhf+gd22cxtaoPcxfx/BR0Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj4k633d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:49:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61G27sbS032487;
	Mon, 16 Feb 2026 06:49:47 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cb4vjv9n5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Feb 2026 06:49:47 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61G6nk6d16450298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Feb 2026 06:49:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B35FC5805A;
	Mon, 16 Feb 2026 06:49:46 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15BB558054;
	Mon, 16 Feb 2026 06:49:44 +0000 (GMT)
Received: from [9.109.198.164] (unknown [9.109.198.164])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Feb 2026 06:49:43 +0000 (GMT)
Message-ID: <8e3bc0f7-d69e-4556-b8c2-14c2701abd42@linux.ibm.com>
Date: Mon, 16 Feb 2026 12:19:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Topology-Aware NVMe-TCP I/O Queue Scaling and
 Worker Efficiency
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
References: <5db8ce78-0dfa-4dcb-bf71-5fb9c8f463e5@linux.ibm.com>
 <055b2be5-96c8-4882-b7a0-93b1765f80b9@nvidia.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <055b2be5-96c8-4882-b7a0-93b1765f80b9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA1NCBTYWx0ZWRfXxcvNhm/nQpnL
 Ve9xmeTrACnLoRTi3aWEzdSDb+w43juTbxqFmuBqXLwiypXfw4bKEsHsoZC8SDXYgiYyVNC/QCH
 9eiaOqGbJsXqOrrkupRNXRQpTVPUxBdSvNQwGQug/Yxk/d9E+oGPFHEi6gh7gZi4Cc3YWRV1h/J
 ftShoOM3VT8VUJE3KllV/at+ez4zHUq0of/WZX6r9bldD1fygSBe/0uTCA/b5zfIQBbzXQet7dZ
 JvJlljTHneyng85OfPk9Sr+i6uMhXBGUqfu1VekqXdWwXfWWvtakRIveM7HeNRHYsSiOboOvmlw
 pjRv2jHaySX7l29ui36b5MyJbXa8gNE5zbPBJCtW+StEkxZh5TbCbYq0zQgS76Iqx5iPhDFvfjG
 7s28ymGvBJtIuKhTxtDKpcvu5xJDv5aLnZbJDK1t6ajNBnBAikbEL1MW2wCSyhu0LKkFmvZa8P4
 E53va5nZpT4BgzJb9+Q==
X-Proofpoint-ORIG-GUID: LHEMgtPlNIrGwjXzjf7-WiM7p2mElC02
X-Proofpoint-GUID: LHEMgtPlNIrGwjXzjf7-WiM7p2mElC02
X-Authority-Analysis: v=2.4 cv=M7hA6iws c=1 sm=1 tr=0 ts=6992be0c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=ow_K-2P-sz8p5fD3VioA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_02,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602160054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260215_224959_652819_0CC4C7A3 
X-CRM114-Status: GOOD (  13.83  )
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



On 2/16/26 6:05 AM, Chaitanya Kulkarni wrote:
> On 2/15/26 09:06, Nilay Shroff wrote:
> 
>> The NVMe-TCP host driver currently provisions I/O queues primarily based on CPU
>> availability rather than the capabilities and topology of the underlying network
>> interface. On modern systems with many CPUs but fewer NIC hardware queues, this
>> can lead to multiple NVMe-TCP I/O queues contending for the same transmit/receive
>> queue, increasing lock contention, cacheline bouncing, and tail latency.
> 
> 
> Can you share any performance work that you have done prior to the
> 
> LSF session ?
> 

Yes — I’ve started prototyping the queue-scaling and CPU/IRQ-affinity changes and
have some early performance results from a local setup. These are still preliminary
and I’m continuing to expand testing, but the initial data looks promising enough
to motivate the discussion.

Test setup (current prototype):
- 32-CPU system
- NIC exposing 2 TX/RX queues
- fio (io_uring, direct=1, 32 jobs, iodepth=64)

Throughput results:

              Without patch    With patch
Randread:     263 MB/s         986 MB/s
Randwrite:    849 MB/s         1047 MB/s
Randrw:       R: 142 MB/s      R: 419 MB/s
              W: 142 MB/s      W: 419 MB/s

The largest gains appear in read-heavy and mixed workloads where multiple NVMe-TCP
queues were previously contending for a small number of NIC hardware queues. Aligning
I/O queue count with NIC queue count and improving CPU/IRQ locality significantly
reduced contention in this configuration.

I’m continuing to refine the prototype and expand testing across different queue
counts and NUMA layouts. My goal is to have more comprehensive data available ahead
of the LSFMM+BPF session, and if feasible I plan to demonstrate the impact live using
fio workloads.

Happy to share updated numbers as the work progresses.

Thanks,
--Nilay

