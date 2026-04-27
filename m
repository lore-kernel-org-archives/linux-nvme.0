Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 180C0FF8860
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2026 12:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGxk6NznZUid/NvM41MotOX2xn2TG8Ldmg7OYiO4o0U=; b=iL12xIjcvKhDirB0E6xoVsGW8s
	jzg45zMocq12RDFaiLtkmIbVhFDxuKS4OvX+Y3/VKE7i33DZ/ROes3zq38kiAliJzx51nEYkNcmlw
	zF6Bkv5k4dbR7wrw2+fNPY5WA28beiwBW/bG4+MPa3YI81WQjKeD2FvyzGLyROYIeYG17Q26mbciT
	tlOwW6YuWwA0OfefxyKfmyNx1C5SfTXJEOKkdLxWL1fKUwIyMRyMdTDU1kwooS/C7EvzCzlvVOajY
	4H6/KWQ5idGUXP54+DL2wDDJEnHk37GVXtqOL9aCXlKX013/1bXVUHmYS7WFOshfA48A/CSDPFStH
	ElbynAjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKr9-0000000Grne-1qHj;
	Mon, 27 Apr 2026 12:14:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHKr7-0000000GrnC-2D1Y
	for linux-nvme@lists.infradead.org;
	Mon, 27 Apr 2026 12:14:30 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63QLsxO23476348;
	Mon, 27 Apr 2026 12:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PGxk6N
	znZUid/NvM41MotOX2xn2TG8Ldmg7OYiO4o0U=; b=m1kcO3vnU+nmxEG0aZh5KF
	pkjBcp3ZvfGlzds0UrSLY1gPVF8h+FsypoHUMiJXKau1K3I/QgENv7YqMzmOy3A+
	X+PYEaGnbUrpaVaOJwwsSJejtbtE/B1Bs7MN+5SS+Je6fCIn7G9YCkWn1Sqxl5Xi
	MhA3ju6AywdDkpZYzPLXiPfkFGqKqgRwk9exLXQ64cknqQQO0mwDi/dZkV13P/q1
	1qWkezxns3pPmKg1P+iI8NpX5Y5tqIZgTZKmOhrlYvuCrEP1pzSUNG7UFu93B95i
	PYDoX3obMJ4FhaAG5r0kVQssMyxPZsqVovMSINmhQKUB8OyuA4RElgtBsJ81czsA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dqhgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:14:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RBroK5032434;
	Mon, 27 Apr 2026 12:14:23 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsa5g4w18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 12:14:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63RCEM1V33293046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Apr 2026 12:14:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9695058062;
	Mon, 27 Apr 2026 12:14:22 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2623758059;
	Mon, 27 Apr 2026 12:14:20 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Apr 2026 12:14:19 +0000 (GMT)
Message-ID: <473c8172-75eb-4ebb-9b77-3df5254b005b@linux.ibm.com>
Date: Mon, 27 Apr 2026 17:44:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] nvme-tcp: add a diagnostic message when NIC
 queues are underutilized
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
 <20260420115716.3071293-3-nilay@linux.ibm.com>
 <443c5fe0-de0a-4bf4-a502-055984102997@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <443c5fe0-de0a-4bf4-a502-055984102997@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jaogb_4jf6bcyXwE8dVODqeeNhNUckh3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDEyNSBTYWx0ZWRfX9rruODvJ+JVT
 PrJ6d3RM8d1g9kgmqEhQ8P+ibUqGzxeA25OvOENsntaB+DBiGOhI3jgOqI1XeMUnOWVYgGWQuYa
 cok1ADvPL7/aBVTpBE2OgQsHRTjepuxOP54N5LJ5018o6SMh4JOre3aqXtIqdlVAXE8gFLaS0cv
 dBg/o1PKrk4WqaffT3OaGvH4+yye4mfAM0xWiUXu8zPeG+Pqd+RhwfL2CWi3faj2z2u+uKXoBnk
 qaggjBHc6z/X9vV9Wn53Zh2aAHOpsXDuVxrBFoZ/Xegg8rHY0FlxePM2G7CaWKNvngO7GoCNqpM
 YGSLEHOF1jstb9DtAILlXC9t/3gy60h6+P3aK/JC2WRCtWMzz6qKB7wVk1l10tSLZH+VSB60GcY
 hS0oH5aK1ACMwl6exi9s8IxUYAhMuGgl6L1Oc75ffieCLQ1WeBi2AEbflABQLXNooOmiWHWQM22
 h5iOOOP4bfIS6w1F6nA==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69ef531f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=KOBI-mHOxK60PFNNsrAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Jaogb_4jf6bcyXwE8dVODqeeNhNUckh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260427_051429_685643_2A8C947A 
X-CRM114-Status: GOOD (  17.75  )
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

On 4/25/26 3:45 AM, Sagi Grimberg wrote:
> 
> 
> On 20/04/2026 14:49, Nilay Shroff wrote:
>> Some systems may configure fewer NIC queues than supported by the
>> hardware. When the number of NVMe-TCP I/O queues is limited by the
>> number of active NIC queues, this can result in suboptimal performance.
>>
>> Add a diagnostic message to warn when the configured NIC queue count
>> is lower than the maximum supported queue count, as reported by the
>> driver. This may help users identify configurations where increasing
>> the NIC queue count could improve performance.
>>
>> This change is informational only and does not modify NIC configuration.
> 
> I don't think that we want this at all. I don't think this is nvme-tcp place
> to print such a log message at all. Especially not every time it connects
> to a controller.
> 
> If you think you need to add this, create a userspace nvmf tool that
> tests/validates a host.

Okay we can drop this from kernel and may add it in userspace tool such
as nvme connect...

Thanks,
--Nilay

