Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56784CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gl6Wns9rXCgS8UFQnZpdy7bAeepNodW6mTmzL1t5Axs=; b=0Kn7g3PZAWDvmPcYLS3tjR0hXJ
	afB3okYHrX74AjHU2SrXDF4BFeSszs1yZKGd8ADmLEWYCEbe36SPURC+4vRwQkj+7YJKO5tZsi/A0
	L2cwf1YjTYoOiICesGSnaNWibyFLVYdH8J2BBSoQ/YXRf5lEXvAtJwePIBI4zOCwi5+eCx3ezXQJe
	nmbDtXuZ0KGgVEcbKqhx1cRU1ln22C3FgIAxjIEcRnllHqrn8Oz1gGZGY5dEQH/N0ECw6WD30QRIO
	FtTsJFAcHrO6t3AhkqJG6MuLbVPcWnd2sQY/qxMRHRHJWEqkBhXFCNoG64Z3CDh7fbrcmlxfwhPdM
	wvrGTnow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE73p-00000001YaY-0yXZ;
	Wed, 29 Oct 2025 14:22:01 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE73n-00000001YZX-2q8a
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 14:22:00 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59TBgAM2008800;
	Wed, 29 Oct 2025 14:21:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gl6Wns
	9rXCgS8UFQnZpdy7bAeepNodW6mTmzL1t5Axs=; b=B4g9aWLTqUpHKSOS8kS8LT
	zXXk1arF2BGp7hbLpqVXQb0QeVUA2ILHfqp8yI5G6ufrJUhz2nKJbEZC1SiizTmV
	hXHb1dLCBc3yYShCH/mhCkxWQDBdWZpDPJ8qaHX7RvHmMk6xuTW0q9Iw16yrqsHB
	fjS3jqg9XU7Kk0qXxc+7KJ83cF4HdVmcSx3/4aFCuvERZLwqHQ2NnfntHq857S9Z
	hE9UCOtROJRQZHJKZ5JLdx8EPYtVx1yL/EsvPV3vI7DJcFxtHBaE6CfbpJpmze3r
	7y8xz1yt7c56uCten1xElHKSr37CXxbNjQSS3QDr7t922GzkU80u9JIXmULFU19w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a34afbqat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 14:21:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59TDiH4c019541;
	Wed, 29 Oct 2025 14:21:42 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a33xy3p7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Oct 2025 14:21:42 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59TELfoD27460340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 14:21:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A885F58056;
	Wed, 29 Oct 2025 14:21:41 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D271758045;
	Wed, 29 Oct 2025 14:21:33 +0000 (GMT)
Received: from [9.61.159.127] (unknown [9.61.159.127])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Oct 2025 14:21:33 +0000 (GMT)
Message-ID: <069d66e4-8e96-43cb-8a83-44f003ae9800@linux.ibm.com>
Date: Wed, 29 Oct 2025 19:51:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 2/6] nvme-multipath: add support for adaptive I/O
 policy
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, kbusch@kernel.org,
        sagi@grimberg.me, dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-3-nilay@linux.ibm.com> <20251029094040.GC1066@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20251029094040.GC1066@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MIrq4sbg-81yMtB0u45mhlO3YvBlCbE2
X-Authority-Analysis: v=2.4 cv=WPhyn3sR c=1 sm=1 tr=0 ts=690222f7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=89S2xFkeY4CF052sch0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2NiBTYWx0ZWRfXz6Zwuz8cvWyD
 qJPqc8XlGuxbf0YHHkQ7Kdf1gJF+1bat7pe+zd8e6dXfbjXIRPFWKrpEOaEha8IYlWDQiAVauKb
 ZXjlBFcbqoZqkXAxtKuMu6EEA9QGhae8N5I3aaoHxzuJIKb0K6I73ue+tMLTa9QnldXCsPBODqY
 7Yd7WIVx/Lbfq0V9fs8IQPoBOS25e4vlJFabqmnKnXL2ly2tzqAIyGwfA/UIJu6XKX3+qJe7tkd
 vz4P875EDh249C1qj9uxlS/cvUOBQc5wvtVdsYBwkGSs7Q+DhUKDVnHqiwJvCCXfkEzY9qS6anS
 Ub9lzF7ZCt3uZ8FlMSKKn8q2VDN1wIdxyoHwtoueBXqIec25Jt9aZa7DtaUTGFoap9C7VMklwVs
 B5EodAsEjwvwWJRpMxPdQdsewVtrGA==
X-Proofpoint-ORIG-GUID: MIrq4sbg-81yMtB0u45mhlO3YvBlCbE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2510280166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_072159_726591_54CE1507 
X-CRM114-Status: GOOD (  17.34  )
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

Hi Christoph,

On 10/29/25 3:10 PM, Christoph Hellwig wrote:
> On Mon, Oct 27, 2025 at 02:59:36PM +0530, Nilay Shroff wrote:
>> This commit introduces a new I/O policy named "adaptive". Users can
>> configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
>> subsystemX/iopolicy"
>>
>> The adaptive policy dynamically distributes I/O based on measured
>> completion latency. The main idea is to calculate latency for each path,
>> derive a weight, and then proportionally forward I/O according to those
>> weights.
> 
> This really sounds like a lot of overhead, and really smells of all
> that horrible old-school FC SAN thinking we've been carefully trying
> to avoid in nvme.
> 
> What's the point here?

Thanks for the feedback!

The primary goal of the adaptive I/O policy is to improve I/O distribution
across NVMe paths in cases where the backend latency varies significantly —
for example, with asymmetric paths in multipath environments (different fabrics,
load imbalance, or transient congestion). So it's mainly focused on the
NVMeOF deployment.

The mechanism itself is lightweight. The policy samples I/O completion latency
periodically (with configurable sample window and EWMA smoothing) and derives
proportional weights per path. The intent is to avoid excessive control overhead
while providing better path utilization than simple round-robin or queue-depth
based policies in heterogeneous environments.

That said, I’m happy to share some profiling data and latency distributions
from test runs to demonstrate that the overhead remains negligible (<1% CPU
impact in current measurements) and that throughput improves when path
 latencies diverge.

For example, with NVMf/TCP using two paths (one throttled with ~30 ms
delay), fio results with random read/write/rw workloads (direct I/O)
showed:

        numa         round-robin   queue-depth  adaptive
        -----------  -----------   -----------  ---------
READ:   50.0 MiB/s   105 MiB/s     230 MiB/s    350 MiB/s
WRITE:  65.9 MiB/s   125 MiB/s     385 MiB/s    446 MiB/s
RW:     R:30.6 MiB/s R:56.5 MiB/s  R:122 MiB/s  R:175 MiB/s
        W:30.7 MiB/s W:56.5 MiB/s  W:122 MiB/s  W:175 MiB/s


Would that context and data help clarify the motivation? 

Furthermore, the goal isn’t to micromanage path scheduling in real time, but
to let the host bias I/O slightly toward faster or healthier paths without
violating NVMe’s design principles of simplicity and scalability. If this still
feels too policy-heavy for the block layer, I’m happy to consider ways to
simplify or confine it so that it stays aligned with NVMe’s overall design
philosophy.

Thanks,
--Nilay



