Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D322CD4F3C
	for <linux-nvme@archiver.kernel.org>; Sat, 16 May 2026 18:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I35m0Gg23Ckb9Z6dmkktvUrd8qWXVN87P14gvSWmNqM=; b=LJaXfTCgEV1Vkzce16jixKfeqs
	2iAKS6T//QJ+TpBTP0rdcXI0RyKPimzasS00EalXp2EAoXSkLYJFQdXrT8L2zL7WCBZnWe7sjRRSi
	tVWsuzKmWnJsga3j9sZU3oWXUwY54BHFihTbg4VCWu8vFukqqW7lIlaFZEMIhwGPPdzYYtioGXnZu
	yOyrYeoiUjga6CP3dqrx4vtMYmLW58ENUVmhsxz2aPg0IQvKvgH+bfjSBPPeFRrYcdNkIZ1hqY2/z
	DGrxFxhqDt1mgZNQ7MhvsaC+17gf/1FLpwBWh59QeEjweefPajopTaI4BNcLMb1Vn2RNbF3bbUhQx
	DTAhZ+Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOK2n-0000000BIbC-2GDs;
	Sat, 16 May 2026 18:47:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOK2l-0000000BIab-00ZH
	for linux-nvme@lists.infradead.org;
	Sat, 16 May 2026 18:47:24 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64G7mMeT1041837;
	Sat, 16 May 2026 18:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I35m0G
	g23Ckb9Z6dmkktvUrd8qWXVN87P14gvSWmNqM=; b=f9yyYjel3q8ys0cSlVrbid
	N8Z8liQVlHD5WjHr61kPxyRZ9TkN5FCdAvk3oChHZkTxkXbHkjQ6jetGZKftC9e0
	1zGA5bP1ZDOvZAa7NZ1RxbvciIl+LCWg6iIbFFHXiyyY7e0nBqji6A3kzdb2pB/U
	3CCZhigjJf28KCfdS3HfDfA/28EcFnpWP/N22RnDsTNtRyd8BschJY/0gzQrutWr
	EyhQuVPlF/KeAqMZtKpTgl51Hm6MxH8BUI+Z4K8nQbZAOSL05f8YeXdHUsbbHPlv
	4H2nEhsFRFCqwjpjIFi2sGMPPdPjYZmxLDiuiI0SqvRxgrOdo+FmaK7MCCaqg7yQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9xhwe4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:47:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64GIdBuX005520;
	Sat, 16 May 2026 18:47:11 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e5kvcgtuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 May 2026 18:47:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64GIl9QI14156414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 May 2026 18:47:09 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A480358050;
	Sat, 16 May 2026 18:47:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F9258045;
	Sat, 16 May 2026 18:47:04 +0000 (GMT)
Received: from [9.111.59.249] (unknown [9.111.59.249])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 May 2026 18:47:04 +0000 (GMT)
Message-ID: <46d6cb42-70e1-4678-9501-7b9eee2f2116@linux.ibm.com>
Date: Sun, 17 May 2026 00:17:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 0/8] nvme: export additional diagnostic counters via
 sysfs
To: Keith Busch <kbusch@kernel.org>
Cc: dwagner@suse.de, hare@suse.com, hch@lst.de, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com, venkat88@linux.ibm.com,
        gjoyce@linux.ibm.com, wenxiong@linux.ibm.com,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE2MDE4NiBTYWx0ZWRfX/DzQfNP54fDq
 xfLNx62RlovwPRIZ2g+P5+//QAaveTEvLviXDVlNPdd9U/X/jvP2yqsqg5GQABKw2TNnnkbqATc
 25NfTOyPozDpmMRlx1i0jNeWkIY4XmRU4WaiCpr4f1r7oF6ZM8vDMyxqCS6EuIfS1tMIxo0CZBr
 qkG+DwsIRnZExAwZm1Gv07HxJ/fBxILaLsWRijb6JvUiEjqlBa7StGpUBpIQhzaW9sChDTmqXxa
 zPaRrJyXOTNn12pxmo27ENO+HWfXZM0CSgRrLzOkNh6Y4JaHLLMJXMeW8XnJkpg+9E48Yx5IMq+
 thfp8aupXb7e/T6273LB3mW5cOrEuQA76V0016cJ+QgzeTOA4SRrGQtcl0Nk9dOUUdE9ylLo/xT
 z0ePirPaGsk1yFGwOwzX74xLvpKhu0OHUQRqzUJmpnaQgnHW+trfJl4i1kEvLJTg47zcpBhyTDV
 LSCjyDOLbutnQuTGDPA==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a08bbb0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=a84WJmvbQVjgoY9DVrQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: VZw7xYb9k6ULjUojipqi9qO4D_OKu4JX
X-Proofpoint-GUID: VZw7xYb9k6ULjUojipqi9qO4D_OKu4JX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-16_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605160186
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260516_114723_055852_51FAE6E5 
X-CRM114-Status: GOOD (  18.97  )
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

On 5/17/26 12:06 AM, Nilay Shroff wrote:
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
> The first patch in the series adds a new diag attribute group under per-path,
> ns-head and ctrl sysfs directories so that all diagnostics counters could be
> grouped together under diag sub-directory. The subsequent patches in the series
> adds diagnostics counters listed above.
> 
> Please note that this patchset doesn't make any functional change but
> rather export relevant counters to user space via sysfs.
> 
> As usual, feedback/comments/suggestions are welcome!
> 
> Changes from v3:
>    - To be consistent in naming, all counters are suffixed with _count
>      (Keith Busch)
>    - The first patch in the series creates new attribute group named
>      diag and all counters are now grouped under this new sysfs
>      attribute group (Keith Busch)
>    - Counters are defined as atomic_long_t instead of size_t (Keith Busch)
>    - Removed RB and TB tags due to above changes
> Link to v3: https://lore.kernel.org/all/20260220175024.292898-1-nilay@linux.ibm.com/

As discussed during LSFMM, I have incorporated all of your feedback listed in the
changelog above in current patchset, except for integrating command_error_count into
the generic gendisk statistics.

While working through the implementation, I realized that although some namespace/
path-level error statistics could conceptually fit within generic block-layer accounting,
controller-wide error statistics do not naturally map onto a gendisk object. This is
because NVMe controllers themselves do not have an associated block device representation.

As a result, controller-scoped telemetry cannot be cleanly integrated into generic gendisk
statistics. Therefore, this patchset exports these counters through NVMe-specific sysfs
attributes instead. Let me know if this approach looks reasonable.

Thanks,
--Nilay


