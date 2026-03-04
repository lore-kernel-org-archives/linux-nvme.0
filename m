Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54783EF8FED
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2026 14:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LrqH2SjmPmjJjgNCF5JBINV1IFLel/O9GosCH1Q2vi8=; b=GgaC+dmaTT5FJ5BM+LCeyNab7O
	1IgZvjhD7GCIx+M2g9W+Yu1oN/7TpyN7r0cUsLOXb1ZJcXEJPohGx0rLJBFQeR+xWEJJApEjQcyOy
	Y4d5zS1Q0xOd4UJj9HF37Ws0R36jr4+SGQdN+YlH174PZ4huL18tuCLw/LlfhMeM7WmGDjWlT8UFU
	bzBdxFkB5rWnbNn3gYfkmLKdpW30R6Qu6FV5gw5LAQkB8O0foZWgJ/zd7TjumCB1gEIDS02plAlIN
	tXTyxUeYdFPJlblvpv+pRMJe4ELRefEUahIjyJxEfPcenouQLMuuqB0uEKvzP/tiJkwIorfx3ktrl
	/7wS6csQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnHv-0000000HPCR-1rhb;
	Wed, 04 Mar 2026 14:33:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxnHt-0000000HPBs-0KJU
	for linux-nvme@lists.infradead.org;
	Wed, 04 Mar 2026 14:33:22 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62494dQJ839232;
	Wed, 4 Mar 2026 14:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=LrqH2S
	jmPmjJjgNCF5JBINV1IFLel/O9GosCH1Q2vi8=; b=i6sEp3zC8SxWQHGmazbuDy
	+XR7GJj8AGCQWMV0zxnem/qSC3187efk+U/VV84hq3G89929uFTTjGcR7Cgxu/b8
	MzFC3vtMe2/2Ui1PDMe6onnR5nZgf3gS81qiDGyb2hhFhJuuNK9IIsY4s9w8GbrJ
	qx3PB5LMfvnQgGoUFKleDmJ3phhd79NcfRDj279Qh1A013s19lgAI8q4YwVrXSDo
	i5cie2kGV9NSDZZVKel837MPjDGmUno+sKXOTtHzCZ6X1j//oIKx0n7vr6IpcW8C
	F/k99clUwTIiyi1K/5PE+mucl1M1hnKhhDpAckGkiL3CT19V5IMa77C+QPram67g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskby9wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 14:33:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624Bev7l027713;
	Wed, 4 Mar 2026 14:33:13 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmcwjergg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Mar 2026 14:33:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 624EXCj117760938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Mar 2026 14:33:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A65358052;
	Wed,  4 Mar 2026 14:33:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5559858056;
	Wed,  4 Mar 2026 14:33:09 +0000 (GMT)
Received: from [9.124.211.174] (unknown [9.124.211.174])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Mar 2026 14:33:08 +0000 (GMT)
Message-ID: <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
Date: Wed, 4 Mar 2026 20:03:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de,
        dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260220175024.292898-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260220175024.292898-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _TaShbxNevJJR-c05l9g8iKAXjVjsX0e
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a842aa cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=k9BfXch_nmsN7oKeZygA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExNCBTYWx0ZWRfX2nCP+Jpt/ZzP
 G2Qzw3p+jnLQHWmDj7s/AmKaXgGZQSQIcpHBxY0p8glVx3klwmEUDcugPjsdn3RBxeCyZvuiCuc
 0Dkf1rzNW7CEQyp8eIVj79XIKyG7k/0lnP4pwTYeQbzm1tu4w0CZruMO8VUX5knoR+282jVkFwp
 ZovIgDPVrnN9uqUiu50r1OSpUJirtCmOps1mzjXIXMpxWyE2i/hHeH5R7oGavixYlMUh+9NaQ7o
 E4mH4WVx8znmeZCQXVsOeH9brEIfhrrrbf4S78mwiwo+fpNDKSjJSkpIVuFNhlRHJsXOBSSNFuH
 TZsGGk7DRtRCpdI8Ytq9aKYNOb4w5V0b3DLVgUYHxZ70QHWDfmKGuAzn6uCvwFLPqp/Gucbtvkg
 9Qrhs2WSY4UILJmZKgrlOajeMIUQMB3qgtjyrVkWlaAB6AUTdy33DqGkbr295YYb3uvjydrgR11
 ex8rVeOFvjnGjxnLMrg==
X-Proofpoint-GUID: _TaShbxNevJJR-c05l9g8iKAXjVjsX0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260304_063321_245465_DD760CA9 
X-CRM114-Status: GOOD (  23.79  )
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

Hi Keith,

A gentle ping on this. I’ve incorporated the review comments,
and the series has already received Reviewed-by and Tested-by tags.

Could you please consider pulling it? Also, please let me know if
you have any further comments or if additional changes are needed.

Thanks,
--Nilay

On 2/20/26 11:18 PM, Nilay Shroff wrote:
> Hi,
> 
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to userspace
> via sysfs. Lack of visibility into these events can make it difficult to
> diagnose subtle issues related to controller behavior, multipath
> stability, and I/O reliability.
> 
> This patchset adds several diagnostic counters that provide improved
> observability into NVMe behavior. These counters are intended to help
> users understand events such as transient path unavailability,
> controller retries/reconnect/reset, failovers, and I/O failures. They
> can also be consumed by monitoring tools such as nvme-top.
> 
> Specifically, this series proposes to export the following counters via
> sysfs:
>    - Command retry count
>    - Multipath failover count
>    - Command error count
>    - I/O requeue count
>    - I/O failure count
>    - Controller reset event counts
>    - Controller reconnect counts
> 
> The patchset consists of seven patches:
>    Patch 1: Export command retry count
>    Patch 2: Export multipath failover count
>    Patch 3: Export command error count
>    Patch 4: Export I/O requeue count
>    Patch 5: Export I/O failure count
>    Patch 6: Export controller reset event counts
>    Patch 7: Export controller reconnect event count
> 
> Please note that this patchset doesn't make any functional change but
> rather export relevant counters to user space via sysfs.
> 
> As usual, feedback/comments/suggestions are welcome!
> 
> Changes from v2:
>    - Allow user to write to sysfs attributes so that user could
>      reset stat counters, if needed (Sagi)
>    - The controller reconnect counter nr_reconnects could reset
>      to zero once connection is re-established, so instead of
>      exposing nr_reconnects counter via sysfs introduce a new
>      counter which accumulates the reconnect attempts and export
>      this accumulated counter via sysfs (Sagi)
> Link to v2: https://lore.kernel.org/all/20260205124810.682559-1-nilay@linux.ibm.com/
> 
> Changes from v1:
>    - Remove export of stats for admin command rerty count (Keith)
>    - Use size_add() to ensure stat counters don't overflow (Keith)
> Link to v1: https://lore.kernel.org/all/20260130182028.885089-1-nilay@linux.ibm.com/
> 
> Nilay Shroff (7):
>    nvme: export command retry count via sysfs
>    nvme: export multipath failover count via sysfs
>    nvme: export command error counters via sysfs
>    nvme: export I/O requeue count when no path is available via sysfs
>    nvme: export I/O failure count when no path is available via sysfs
>    nvme: export controller reset event count via sysfs
>    nvme: export controller reconnect event count via sysfs
> 
>   drivers/nvme/host/core.c      |  18 +++-
>   drivers/nvme/host/fc.c        |   5 +
>   drivers/nvme/host/multipath.c |  89 ++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  13 ++-
>   drivers/nvme/host/rdma.c      |   4 +
>   drivers/nvme/host/sysfs.c     | 167 ++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/tcp.c       |   3 +
>   7 files changed, 297 insertions(+), 2 deletions(-)
> 


