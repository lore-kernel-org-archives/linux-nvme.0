Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C76C88E41
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 09:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsWl47GwyHeZ8bg2dcGk1gk0f4DjVU7QhB2I2ptenhE=; b=mHdIGs6w9fNhE4CCE/v6ahnDHn
	UmvauR4LzlaZusdGfCn+I4Ls7Ph7wdVQZzNMCwAUtBl/P/PMCqiNSBujEqknbKFwsgvo9GbtPQRKx
	Me/5hYVf3r20ZNCYoc5262anb1xHesYCxCD6IURhaqZMMaRnAiZ8I5KkGr4xe6CUHEASE44WudzGe
	SHZ/yQqh267zSGV6xdEFiA3JeVaKwd2tRzzJQOwbmojUxUK1cznO0Fz0cIVe2jhkNA+c3eOGvZJqZ
	GWbElSOHkDJRlQYvopLZbN0Ca329BNq3CXVrrrhmmjjvhJWui3wBl48Tu9VH79x/9sQRY+FsUpiP/
	aSiCLBEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4aeM-0000000Doi0-39vu;
	Thu, 10 Sep 2026 09:00:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4aeK-0000000DohQ-2oA5
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 09:00:53 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5VNaq103898;
	Thu, 10 Sep 2026 09:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MsWl47
	GwyHeZ8bg2dcGk1gk0f4DjVU7QhB2I2ptenhE=; b=r0FjHl0YQu5Bv56Jt/UAj1
	MaCBBTuK3g82YeM8vGg2QEF+Mfd3R36+m35ISkt/AQhRvgCD2pRpY7qNEnGdk2vx
	Qtpy5QLD/+AwGK0PARCCTFo2CAdpme6oG299vEeXLps8TxBfwMP7ddaL2tmoTzV7
	B7vtcxvJ1HnMrWGtxJ+RRwZQYf+9+2AFJFe/EB2Q3UKASIUQ/Oa61pxHssaZ1diw
	q+DG/OS42N+F4ALOwhi+Bu7wFCtSbpmCz4stVX194G2b0Sb9iWPcoL2iiAuXEBIY
	y4A8KPDa78r8fsGnMzq4w1jtM5+N/FtpQuB9P7xUgEL7sLvEib7enf1tiiV/MaLQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8n3fvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:00:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A8uZAP015750;
	Thu, 10 Sep 2026 09:00:30 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3bfx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 09:00:30 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A90TCI42992000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 09:00:29 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0BFB58067;
	Thu, 10 Sep 2026 09:00:29 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A353C58061;
	Thu, 10 Sep 2026 09:00:26 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 09:00:26 +0000 (GMT)
Message-ID: <361d1726-ae09-4d21-a507-a792989e9f44@linux.ibm.com>
Date: Thu, 10 Sep 2026 14:30:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: add fail_io_now sysfs attribute to fail
 queued I/O
To: Krishna Iyer <kiyer@crusoe.ai>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        sj@kernel.org, saravanand@crusoe.ai
References: <20260904032605.65758-1-kiyer@crusoe.ai>
 <84112f53-5c05-46ca-97d0-550565fb941c@linux.ibm.com>
 <20260910015457.77845-1-kiyer@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260910015457.77845-1-kiyer@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NMVAaE6g c=1 sm=1 tr=0 ts=6aa271af cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=i6_9AHJ4UYTudbWR4IAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RSW1OUnAXn4DsJ59X6uBH7YRScl-18t_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5NSBTYWx0ZWRfX25lgJoU1g+AJ
 Wu2XXJkGH7DaP6YHkRU5PJvP06s2Rtwn5970byXQtNExXoJLYgtpZTfDat/EtY49zvrynrOobZQ
 /0HArF/NYahPshsY5pBOAuLzsrkwdmSjWTXMU5q55Qo71aFFq2aZuA1lwZThYQJA4ltFG95y/M9
 Q8lerC9fTwOCZoG1MysBPRw35DzuZtIdUr4h4fp3QR55SQDBY4Jec6XsTyoA1xv4waBKzVZUIlL
 fYl+SU2hDXYzWib9oz6GWd1P+5oKXbbErJ654T1AuWz8aDI34SC5nkSsuEwbEGz7L8A3UbfL2+x
 WPBcT6atT0ni3Qu4vOOlutSQb3MmqjXkJJkTtueBvEuPV59oxAMd19rn1sTvrVt18cFxJCPrBsN
 AypPq0BhgmtwUHP7SX6KeLmvb74YW8GMhApFZFAi3O8L1vUyNcrLhiBVg9SZNKWWBEB7VEjuxW3
 u1n/WxXnivYsnwYgE1Q==
X-Proofpoint-ORIG-GUID: RSW1OUnAXn4DsJ59X6uBH7YRScl-18t_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5NSBTYWx0ZWRfX3CTmzJEQWLGr
 3wQ1q/cZzvfb6AUQQx/EFHUX38THN+qSsLFIWDRZkBn09KOITVU+PlYa5k3AWy3nmwoviLOufAU
 +EM8JZtL2r5pGLynXCJ9z4zaQgAeykg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100095
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260910_020052_719805_B0F8A315 
X-CRM114-Status: GOOD (  23.57  )
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

On 9/10/26 7:24 AM, Krishna Iyer wrote:
> On 9/7/26 6:15 AM, Nilay Shroff wrote:
> 
>> Does the intention here is to force I/O to fail irrespective of the
>> controller state, or the intention here's to fail I/O only when no
>> usable path exist? If it's latter then I believe this is not the right
>> place to enforce this policy as since this check makes nvme_available_path()
>> return false unconditionally when NVME_NSHEAD_FAIL_IO_NOW is set, without
>> considering whether a usable path exists.
> 
> The latter. nvme_available_path() is only called once nvme_find_path()
> has come up empty, so the flag only decides whether pathless I/O is
> queued (default) or failed.
> 
Not always, nvme_available_path() could be also called in case
controller is resetting or controller is live but the ns/path ana
state is neither optimized nor non-optimized. So I think the policy
would be better enforced at the point where we have actually
determined that there is no usable path, rather than making
nvme_available_path() return false unconditionally when
fail_if_no_path is set.

> Agreed on the rename. For v2 I'll make fail_if_no_path a plain
> per-namespace policy: admin-set, no self-clearing, toggleable at any
> time including mid-outage.
> 
>> This attribute should be only exposed for fabric controller.
>> It looks this is being exported for non-fabric controller
>> as well. Moreover, I like attribute fail_if_no_path better
>> than fail_io_now, since it describes the actual policy being
>> enabled: when no usable path exists, fail I/O instead of
>> queueing it.
> 
> Right, v1 exposes it everywhere. Since v2 makes this a plain
> fail_if_no_path policy though, is fabric-only still what you'd want?
> The queue-vs-fail choice isn't fabric-specific: a PCIe head kept
> alive by delayed_removal_secs parks pathless I/O the same way, and
> dm's fail_if_no_path is transport-agnostic. If you'd still prefer
> fabric-only, I'll have the visibility callback check a sibling for
> NVME_F_FABRICS under head->srcu.
> 
For PCIe controllers, we don't have the same ctrl_loss_tmo/max_reconnects
semantics as fabrics, so initially I thought supporting fail_if_no_path only
for fabric controllers might make sense. However, looking at this again,
we already queue I/O when no usable path is available irrespective of the
transport. So I'm okay with keeping fail_if_no_path generic and transport-
agnostic. The policy is essentially about what to do when there is no
usable path i.e. fail the I/O or queue it— and that behavior isn't inherently
specific to fabrics.

Thanks,
--Nilay

