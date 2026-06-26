Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AFEC43458
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nAuLcBhAzZk2hin9+0OS6NaDJmdJYm6kyXCMgMEC71M=; b=agqkfkfq4a/cmHztIgeHFh8JMd
	4Diq7Dx1sImHJOEZeveEnyQa1F1vW49z0cLNlBjB/F0/xYrrzO8Jfmil1oPmVDxPirELY2dH3VS/c
	XOiur1oGB2D94NkEuGEzZIL80zouPoznt9EB5xPr9452z5Wf2vX89PsuDxzxCfqKelTvum0cWCNGu
	vORDggYhjQZJ1OUtmGRwpD6J6fzJQf9TRyfIObgEUxwc7+Z34ucvnZvNf/NPS46r5LMQOgoMjFYo/
	23hBt403QSo/Z3cG36sJYnFCvRuTIz90gu2EXKycQVifboaxQDpDJm4Y7JqB7pXJCeuf3HgpgKykw
	GAEBmwBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7j5-0000000BTx4-2Ypv;
	Fri, 26 Jun 2026 14:40:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd7j3-0000000BTwL-18Un
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 14:40:14 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QAIDNj2719750;
	Fri, 26 Jun 2026 14:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nAuLcB
	hAzZk2hin9+0OS6NaDJmdJYm6kyXCMgMEC71M=; b=tF3C0JMwqmwUVhwFFgDV6+
	HxDOQ7s6iev80b9bdOY4PC5D7E3ff/AeGO2+J6LXyQj28KzGRMYpyyLNvIzTCa0T
	GHboV8srDPearwq400VGlJBn2i0fepj2mBAIUHy5Argss5YqJlxtTE/XsepziDGR
	O4qapjbxBgDxP3gLpH9YcV6Ho96zbv87HX/PhN0Q6fXnaqvs2+dwTdE6cnQEGFpe
	ElZJt6XnxUCehJBg1Fv9gajySoFjouD6xSys3pH4TUXJLjOK77JWDIOh6QwcD/63
	6XVH6vAcrfGpkaxtkW/mCrSQfQLBztKxdrR74ybSYg1F8exbB/Px4033Q+GcRKdQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4yj2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:39:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65QEYeeK017196;
	Fri, 26 Jun 2026 14:39:57 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7w0363b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jun 2026 14:39:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65QEdvQ833751494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jun 2026 14:39:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 273CE58059;
	Fri, 26 Jun 2026 14:39:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB35158057;
	Fri, 26 Jun 2026 14:39:53 +0000 (GMT)
Received: from [9.43.54.234] (unknown [9.43.54.234])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 26 Jun 2026 14:39:53 +0000 (GMT)
Message-ID: <0f3add6e-4e2c-4656-ad82-e86e18f6fcb7@linux.ibm.com>
Date: Fri, 26 Jun 2026 20:09:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 07/17] nvme: add Clang context annotations for
 nvme_subsystem::lock
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com, bvanassche@acm.org,
        elver@google.com, gjoyce@linux.ibm.com
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
 <20260614131541.2017845-8-nilay@linux.ibm.com>
 <20260626064335.GG10731@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260626064335.GG10731@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDExOCBTYWx0ZWRfX/7/fAgS/ShgK
 DYHc3Hc/pUVrdrssUtw+Hx020YbFg8bJUQRDYqq03BldNFub45xNnhXZXRpYGy6y9+NbM8Uca5/
 spkxzX/QX58l8qZbp7/sXxzzBVQvMNw=
X-Proofpoint-ORIG-GUID: jWk5Ikd2caDGueK_afnYT1Pqe7VX1fdz
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3e8f3e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=r08CrkAqRjIWnyq6ipMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDExOCBTYWx0ZWRfX02qfGUVdxQvJ
 tgCQhcq4xPpOX+WKgTOBYr7kSCM+sbV15YgW4iFzzRXkR4aTdgEBTnOnCjsS3JKmmEv+zIAmEBi
 x5D8bKaKmhvQBY3PGE64zXwSe5hpPSnKNmKa45xtZxsR+1khMVVdDS78rNKsgCVr64dQu9tIrjc
 jIKw14tGJadwcUtTr9nnxeiKClv7MMOfyoQDPTDPI2Umh717CeNM+vLBek2vetYMTGNgJIfxuVi
 BRmwnDNbRBAPqrdpCGpOGIaSEehkhioE440BzJdtSq7vNYuoSPikSjW2GyPtTlZy0WL98S8yOYt
 PyF164t+LQyYwuL02pMXI5Cq/Osb1Oa5cVxPCkeNqPwGBkjjl61MSZEu//6OGfAiEabAMMUxxKs
 KYwnoWXI7kY85QNKH2nc/TwAP420yPnbWYQb8daOOOt9OxsdU2MDTL7CyVj05D+mXAdF602T7u8
 Oec8vXExHhRrdERgoMQ==
X-Proofpoint-GUID: LC2FAc3Hj0lfY9W97Nq3SfSp2qlQdRvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_074013_322232_ABAC1AF6 
X-CRM114-Status: GOOD (  20.77  )
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

On 6/26/26 12:13 PM, Christoph Hellwig wrote:
>> +	scoped_guard(mutex_init, &subsys->lock)
>> +		INIT_LIST_HEAD(&subsys->nsheads);
> 
> Same init mess as a few patches earlier.
> 
yes correct, but this one is tricky as the list has to be inited
with non-zero value. Another way to fix this is by adding
context_unsafe wrapper around INIT_LIST_HEAD(). Again overuse of
those unsafe wrappers hinders readability.

Would it make sense to introduce a helper, e.g. INIT_LIST_HEAD_UNSAFE(),
that simply wraps INIT_LIST_HEAD() with context_unsafe()? It would document
that this should only be used in cases where the caller knows the object
has not yet been published and therefore no concurrent access is possible,
such as during object initialization.

>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -719,7 +719,14 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>>   	INIT_WORK(&head->requeue_work, nvme_requeue_work);
>>   	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
>>   	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
>> -	head->delayed_removal_secs = 0;
>> +	/*
>> +	 * The namespace head is not yet visible to other threads, so
>> +	 * initializing delayed_removal_secs does not require holding
>> +	 * subsys->lock. So suppress Clang's context analyzer warning by
>> +	 * annotating initialization of delayed_removal_secs using
>> +	 * context_unsafe.
>> +	 */
>> +	context_unsafe(head->delayed_removal_secs = 0);
> 
> head is a zeroed allocation, and we call nvme_mpath_alloc_disk
> exactly once on it.  So we can just remove the initialization
> of delayed_removal_secs entirely here.
> 
Yes that makes sense. Will handle this in next patchset.

>> +	struct list_head	nsheads __guarded_by(&lock);
>>   	char			subnqn[NVMF_NQN_SIZE];
>>   	char			serial[20];
>>   	char			model[40];
>> @@ -562,7 +562,7 @@ struct nvme_ns_head {
>>   	struct mutex		lock;
>>   	unsigned long		flags;
>>   	struct delayed_work	remove_work;
>> -	unsigned int		delayed_removal_secs;
>> +	unsigned int		delayed_removal_secs __guarded_by(&subsys->lock);
> 
> Btw, I find throwing the __guarded_by at the end of the line really
> hard to read, especially with all these long lines.
> 
> What about moving them to the next line with an extra tab indent
> instead?
> 
Yes sure, will address this in next patchset.

Thanks,
--Nilay


