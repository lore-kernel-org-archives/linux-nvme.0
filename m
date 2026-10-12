Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23741CA9ED6
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 04:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9eYTkGl5oo0Kdw3qwx5Z794rZLTMiDY6xjAz4qWiuoM=; b=Dssf7WskQJ8C7ES1kOwfrYyiou
	JcgJJRbctu+hPcipBdfr3wN84kf69o1XY7jlV2xVywd8Chte7IqtywcTLfR/TiIJNefLhFf8YLppY
	6QAF7VQVtmSnFDo05U3r1G4lhaPEB6z83BQGHsGKRz6WSWF/pX3pcoUrU5E+J+9flHwhr+Ke3lIM1
	VzPHpxYWBZnRcf8poMCvqhpUQfSSAUx9urc3FRpYkY8JSowrsMuYXBACWyUA6Yaf8wIm8XAxM3Joh
	1ArccftnpayzxVfuCFYIoVFjQ5JbuWXpPtDjlH9tbgJiXK5hvB0xuliPztYhKdhI5j+XGiIi6Uo6L
	6oq8zeXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xG7lS-00000009eJa-32lc;
	Mon, 12 Oct 2026 04:35:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xG7lN-00000009eJ2-2Utm
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 04:35:52 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C2EcCh2912982;
	Mon, 12 Oct 2026 04:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9eYTkG
	l5oo0Kdw3qwx5Z794rZLTMiDY6xjAz4qWiuoM=; b=i6JYfh92WQMOwy73PsLb2/
	DuLBqQuGmFqpWq3vFBLMBp/Zs5y4SXiz6GL/N3xZ97WhUuXbJ3hiMX5DwU66UNxU
	CHrRu46q8ZGC30Bd/9Slbpjq1NRfCg9p3YdOue8GSLukkrqpgM/39Eus8NxSei/P
	R3rVVuGF0nSIl6bhNvzvrYYgVsCj3cAoS0d01gX81+yGSJmMXPv9QQu6sNat7FpZ
	ptboZUO1rn6Xa/DLcTNC6VAtqmSGhWsc3q1goKwZ7NupVVr6wDFTGQFN/tNEgF+s
	6vz3B2E/QDc58BBs5sbikQCAyDec0NZxLAIMgfSGrdGwqDFKBxVWbACpNAMg5yTg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhpvq4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 04:35:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C24o3K563434;
	Mon, 12 Oct 2026 04:35:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vkthv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 04:35:34 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C4ZYIL33620638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 04:35:34 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E072858156;
	Mon, 12 Oct 2026 04:35:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C6F6758155;
	Mon, 12 Oct 2026 04:35:29 +0000 (GMT)
Received: from [9.61.185.118] (unknown [9.61.185.118])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 04:35:29 +0000 (GMT)
Message-ID: <840fbc39-dbab-45c3-9743-8f21a8259c29@linux.ibm.com>
Date: Mon, 12 Oct 2026 10:05:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] nvme-multipath: add fail_on_ctrl_loss sysfs
 attribute
To: Krishna Iyer <kiyer@crusoe.ai>, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, hare@suse.de,
        saravanand@crusoe.ai, sjpark@crusoe.ai
References: <20261008141407.22992-1-kiyer@crusoe.ai>
 <20261008141407.22992-3-kiyer@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261008141407.22992-3-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfXzJvBb0I+2nqg
 ar29cHj4bK3YITyLWcDS0MfhXT9gnfUMcXZT6gEHRHUIMNkXmy8KL9QUmR5K/uAo5qesuiCuerF
 WnaJgdGB1am1kaPjpSygnNuMf7n54e+Wh5AKRVDPrJqtJY3OKEKiOj0kv0pqNn0TBwW3hNApGUz
 61cLPkKaf5RhtzZwKgDzhjVcpiep+EDvZN2Hbzm6ISplDCEf/1ArXVKryTwSEJE1ujZMNcHg1Wh
 OWYj0n3gLPit4htMfTlMRJ708ZLZCDTL8J8W6LF3SEJZQd7ctfRPBeNTDopVg8BLtTX1+8Wqt+6
 Z60H2FHGvhf5EevChhmQnp+YZx7+3nvKvT5eWGfQ7ZBChRZ/HjPAZ3gk5qDGU6ePe2NkfTvj40P
 4ewxKRb4YcFrLMjTHFEOBJBWZOxBxYjP6PhVMbzWfwi9v7tf24mgEPG36ycGISauLn9ZGqI/IXI
 VnDL4/PBHN+V5mMZO/g==
X-Proofpoint-GUID: -biNSCGHsiHKTpV0i3But0QLYWUXFc1r
X-Proofpoint-ORIG-GUID: -biNSCGHsiHKTpV0i3But0QLYWUXFc1r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX0LVwG8BhXBlQ
 VQEx5KN+HuGt7A7f0VuGv28Gf0zSZdnv01okgmPNwveTVgOXHbuFicD6z4x0RmtdRFU+B6/M/Md
 RphgcX8Nim3IYg5lKke+GI2fOVYTa1Q=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6acc6397 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=FMbtR3q6Wjg1j8aBuHgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120016
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261011_213551_527980_FF2889B3 
X-CRM114-Status: GOOD (  17.22  )
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

On 10/8/26 7:44 PM, Krishna Iyer wrote:
> When no usable path exists, I/O on a multipath namespace is queued
> until a path returns. With ctrl_loss_tmo=-1 that can be forever:
> during a long fabric outage any process waiting on the I/O is stuck in
> D state. We hit this on virtualization hosts, where a SIGKILLed VM
> process cannot exit while draining I/O to an unreachable NVMe/TCP
> target.
> 
> Nothing can fail this I/O without tearing something down: controller
> deletion takes every namespace on the controller with it.
> 
> Add a fail_on_ctrl_loss attribute on the ns-head disk: a persistent
> per-namespace policy to fail parked and newly arriving I/O instead of
> queueing it when no usable path exists. It is the namespace-scoped
> counterpart to the controller-scoped fast_io_fail_tmo: the trigger is
> an event userspace observes (a consumer known to be gone, for us a
> SIGKILLed VM the host must reap), not a duration picked up front, and
> sibling namespaces behind the same controllers keep queueing and ride
> out the outage.
> 
> A CONNECTING controller stops counting as an available path, and with
> no controllers left the policy overrides the delayed_removal_secs
> queue-if-no-path window; the two are opposites, so fail_on_ctrl_loss
> takes precedence when both are set. ANA change and controller resetting
> still queue, since both are transient. Controller state is untouched and
> reconnects continue. Like dm-multipath, the policy is transport
> agnostic.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Krishna Iyer<kiyer@crusoe.ai>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

