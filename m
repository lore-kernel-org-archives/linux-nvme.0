Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE01C5DF7D
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CmSvnEyIzit8GPRtexYH2sSMlmY/bbhSyRxLXUOEBUs=; b=H9PPtjIzjaC1vOuRrX9yWKqMC0
	TVazbFB76MMfNpfBoqtIANZ4IrK6Cbi3yFUv22ceRWhnXFnJ09BcB7g3PleOhsvYqOxUvHlv8zSRE
	6wlXfEf8VkYpGbG4bLRWRuvyiPfeOYJUEzQRNS8Ququmq8eMMx8mmYt6a2UfDMH+xEH/y+lIYjfT6
	VPCx/XIhVRMEFDwiNmdC/mWOwSsFRorqDjnuqnMdFl67byKle6tvaQDzwGh8ui63VD4b0Ceq0v3tJ
	G6/ZQ1ZVKd0aFgdwpS7c8eyN0xsbREce6AYpYCHFdwZYURlS9rgE27RnbGzql2Hl4xbJuriD0PTxU
	yFAsQOwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxRTT-0000000Din1-3otJ;
	Fri, 21 Aug 2026 15:48:07 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxRTR-0000000DimM-48Pn
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 15:48:07 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LD1nm21606096;
	Fri, 21 Aug 2026 15:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CmSvnE
	yIzit8GPRtexYH2sSMlmY/bbhSyRxLXUOEBUs=; b=Q98VlQGar4xhYli1ZjXUjW
	ASv7aVAhfqGvfgirP3lfudOMKkV53O+mUDaW1ANjL0J1mntYI39Mc1AY7oCgHcVG
	JDU67+zTGuERcxAoBlMXUJ3vfM+PYClgxsKHZH/74vK/2pESwkDppjoq/WmL5ykT
	+2mfNYSzROMI06ipOOB3lX3yjJsIi9s9yAtb54M7q5dkteG314MVJ+xJ/4e42Ywq
	xEnCXMVE2hvo0bEeGy6B0KMVUpIJepR6i2Wn7PRG8RFhzZQuGZVZ/XU415w+H9TK
	WUjrSqJ2xQ6NzAHTdGfmzfkS3Fz/P+gmkoG1QqjQT7ojL0aJM2SpDpv+0DtgwtFg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4j94x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 15:47:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LFfMwI024700;
	Fri, 21 Aug 2026 15:47:53 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqnmxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 15:47:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LFlr3g24380140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 15:47:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335CE5805A;
	Fri, 21 Aug 2026 15:47:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267F25803F;
	Fri, 21 Aug 2026 15:47:51 +0000 (GMT)
Received: from [9.61.26.100] (unknown [9.61.26.100])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 21 Aug 2026 15:47:50 +0000 (GMT)
Message-ID: <c194592f-6811-4eec-b5f1-2b015525c7a3@linux.ibm.com>
Date: Fri, 21 Aug 2026 21:17:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-tcp: pin io_cpu to submitter cpu
To: Saravanan D <saravanand@crusoe.ai>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
References: <20260820083634.71689-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260820083634.71689-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=CpuPtH4D c=1 sm=1 tr=0 ts=6a88732a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=MrSfwY1Xb4bpihXmphsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: hfjCmmJ383EuCeoag73MAq3rpWbhgPRN
X-Proofpoint-GUID: hfjCmmJ383EuCeoag73MAq3rpWbhgPRN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEyMSBTYWx0ZWRfX5ZrNpEb3dlNj
 XhWIScb88gBv8Z9/Cx5Qrnkjgmh21eplhKZzxmUGZTUNhAV3U+bmk53GZINdLckDByJTtEp0T5E
 2T2r9U3AqA09yfNOg9whviEbWF3InxU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEyMSBTYWx0ZWRfX67ZxSX4yy614
 mOfEEIIiY03SJ4yGuNIQ8xJ1sMaC7xY+4zPDsB9eiNQIdkebM22jsE+rjG9UV1v9CjiJt38x8sj
 WddJ6NVPp0aaxlvsuLCy12HhYMqmZZ17L3Z2sAoJLeRYPwOWoZoWNhvNaVtc/Ie6Qg66+1fcGSj
 wGr0yfC9dDX0MRQNhh3f0fnQCvPpT5nWA9jqBhCVesRWtIo8MezxYjuH1XbFdZrHPlKKU0BtivC
 ec8xdmUWugl5+/ZQqSONHJMSxfK8v9V8VHG3O3x9Ey8YiQ3Eds2G82tWKgPeNCg7GLAAnUxNWRt
 MB0nCPvQqkjV4KP10/h9+G6UYNhnHZmwFDp9F/XL9o5i8EybHWadkE1JJquV4ZP/Y6EDdKQeTlC
 7YC0Poa8RDjWd6oC4W/IpaceEvtP78W/6j6KKSR+1MqNr+zQV2Rrq1xOEPnBTKzrG6Va+/pnqIc
 pVKDiE1b6i2o0VP6WYA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_084806_171087_EA3D211D 
X-CRM114-Status: GOOD (  13.64  )
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

On 8/20/26 2:06 PM, Saravanan D wrote:
> nvme_tcp_set_queue_io_cpu() picks each queue's io_cpu at connect time,
> before any I/O exists, as the least loaded CPU in the queue's blk-mq
> map group, and all socket work then runs there for the connection's
> lifetime. On hosts that partition CPUs between pinned workloads a map
> group can straddle a partition boundary, so the pick can land one
> workload's socket processing on CPUs owned by another. On a 384 cpu
> multi tenant host with one VM driving ~1.1 GB/s of writes, 9% of
> nvme_tcp_io_work executions ran outside the submitting VM's cpuset,
> all on io_cpus of boundary straddling map groups, observed by the
> neighbor as steal time it did not cause.

It seems that here multi tenants shares the same NVMe/TCP controller.
Sp if the concern is CPU isolation between tenants, why are multiple
tenants sharing the same NVMe/TCP controller? Wouldn't a per-tenant
controller/connection provide better isolation and allow each controller's
queues to be mapped to the tenant's CPU set? If sharing a controller is
required, it would be useful to understand why.

Thanks,
--Nilay

