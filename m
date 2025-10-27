Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514E7CCF9E5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 12:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xYMhGxDxiGCjYFeQczU7avC8TptCuGU7QwG/NkXwRvs=; b=aahx9i8oCwaHaT1tRPwgklF1BE
	QB9FWZ37FonwBvzgJJgoRuni0PsilQHeEdQyRkn9R+3BXELcxdhitv0exboPDpfieaWHGayXBcAeX
	1fKVheO71q6O6r9T3a3JItdAWio3EDhRUMsoEHP1s71mJcSY+gDgjF2GHDGS9AuNwoWClq1WaqtVQ
	ZzsiaOzTHQHfeO2X+UtYlrSqn89wRmCGXkot7aH9he4DU+5uponCUEHKenYXKShVZipGz3/HQ+Aww
	205+OUKYzgl0a/Zubbz/kzZKefVj/+8zsEwmbFDqvjvZlWA8lEn45rGQEK4rNvfnKF7BlWSA9MbRK
	s3TLCYzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDM3B-0000000DrBc-3pZ8;
	Mon, 27 Oct 2025 12:10:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDM38-0000000DrB4-3WCX
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 12:10:12 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59QMR598029911;
	Mon, 27 Oct 2025 12:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xYMhGx
	DxiGCjYFeQczU7avC8TptCuGU7QwG/NkXwRvs=; b=pZraaQQXxoAh7krFoCX6cV
	+XxDN6rmSSIfP33jJ+x7CbaEmFQK2SJadwR5hkGZMqxWc5MhyWHtGtLaQfmQntMe
	9qCjcVHx0rbJUg0EoX3mP026759A+HnEivDGJhtQsF/FxBDmsAzaWWnxaC7fj45K
	2k7IUOyrJV2TgUkZJUb9DCkmiRq5auz+Y7wfG+7Kq7aq8363XSITT1FCWXYdSupV
	ZTh64T+iTfgtZ/peW1wgC34cXVIYjOZDHdmVYjQXxM/solZoZMJ8wb2ab0K2XTK/
	KyEL24CvWbLOD1STlaWIpxLOuajgEOFbrWPw0Q2izrq/GLmvGqNuKB1l9YjAsYQw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0kyt6qc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:10:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8ZDoi009404;
	Mon, 27 Oct 2025 12:10:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hw753-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 12:10:02 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59RC9mD914942818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 12:09:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DA8158057;
	Mon, 27 Oct 2025 12:10:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C01B58059;
	Mon, 27 Oct 2025 12:09:56 +0000 (GMT)
Received: from [9.61.186.32] (unknown [9.61.186.32])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 12:09:55 +0000 (GMT)
Message-ID: <8d2b7d1b-5e0d-4d66-b5fc-505f16da73a3@linux.ibm.com>
Date: Mon, 27 Oct 2025 17:39:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 2/6] nvme-multipath: add support for adaptive I/O
 policy
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, dwagner@suse.de,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20251027092949.961287-1-nilay@linux.ibm.com>
 <20251027092949.961287-3-nilay@linux.ibm.com>
 <9a637581-eeff-486c-97e3-ba2ab8b5ceed@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <9a637581-eeff-486c-97e3-ba2ab8b5ceed@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pWH2eEuDrW5cGbDcJUq0UBDi4lq_inOg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX7uC6yQNT/Rrb
 z0yl4pF6keS0l2mUmspb6nDuKsRlmyQfr8anWd/yECJLu4sESBx1uJ9vZWcw2MEod2Yn6gFH66z
 e9I4a3tLDfWK+vDKKJw3HqLG452rCcsz9h+zshiM+hcgIniUtiI/9SnbfQ6KUHXbOK4suCc33pM
 xuWCvFncJE0jc0QNJ2lldGgb5ndbuUvMYaDX0SBOTAyibKV845BQ8Jc84YD1eVas6JOvK2fxHDH
 1+pH0I9EFxLh2afJvoLEa5ZvgF0mJQf4KHwFUN2XxwKmviUTi5gZPvKExXAfbmX5qWX0G4JOSWt
 HhXcNzxvysufzWsQ2zOQTL/5TugJ1EGPkec8xJM7MB3jVMSZ3TMkY4r4P/RMnAZzAt/PaGg2Gdq
 owszdPONs2bEjvxrbxImbkOSmTrXPw==
X-Proofpoint-GUID: pWH2eEuDrW5cGbDcJUq0UBDi4lq_inOg
X-Authority-Analysis: v=2.4 cv=FaE6BZ+6 c=1 sm=1 tr=0 ts=68ff611b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=IMtRz4eSDtV6zLgheRgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_051011_011996_FF29F05B 
X-CRM114-Status: GOOD (  13.55  )
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



On 10/27/25 5:04 PM, Hannes Reinecke wrote:
>> +static bool nvme_mpath_set_current_adaptive_path(struct nvme_ns *ns)
>> +{
>> +    struct nvme_ns_head *head = ns->head;
>> +
>> +    if (!head->disk || head->subsys->iopolicy != NVME_IOPOLICY_ADAPTIVE)
>> +        return false;
>> +
>> +    if (test_and_set_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return false;
>> +
>> +    blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, ns->queue);
>> +    blk_stat_enable_accounting(ns->queue);
>> +    return true;
>> +}
>> +
>> +static bool nvme_mpath_clear_current_adaptive_path(struct nvme_ns *ns)
>> +{
>> +
>> +    if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
>> +        return false;
>> +
>> +    blk_stat_disable_accounting(ns->queue);
>> +    blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
>> +    nvme_mpath_reset_current_stat(ns);
>> +    return true;
>> +}
>> +
> 
> Hmm. I think this is a misnomer, as for the adaptive path policy we
> don't really have a 'current_path', and as such we don't clear
> the 'current_path' setting. Rather we disable the policy altogether
> here.
> Can we reflect that in the function name and name it eg
> nvme_mpath_enable_adaptive_path_policy()
> or somesuch?

Yeah you are right, I'll update function name as suggested.

Thanks,
--Nilay

