Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909B1C369A2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Apr 2025 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2/pJCncFwcx06LWM/cQrsrxIZExf31+a7ik2X5+kcc=; b=AAXdxWksSVUpXZpqGtxWqUITq4
	/wgHHnpqgaq9474l/wxEd75Y3SZR1Ew8pMeexIoreGqV5nFOPOsL6VB9RX1JQgepKQyLVKRGMVbCd
	o7OILEx/BSXuoDvYVfYox9Q/P39IlE6mlNGwYPYE5gpVCJfgIDzmXD9lq8Bk3TqRWZGhhPTl780hP
	E4wSt95r6BhSHvneY1uzVyeWzhSnMPf7Y5hE+7WYDrEbeWPRBFAjpClzSvBWlTqSph3TSGAIttX92
	1S/4zD7pyqKviYlGD84Dv6zmh98lRpvKCfZNAWWhTmjRFB0K/avPaYjcIKdKzvSjvTJKOUnD3MIpM
	y/Jne+QQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29i2-00000004L8O-3w9a;
	Tue, 08 Apr 2025 14:13:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u29cP-00000004Jzx-1P0n
	for linux-nvme@lists.infradead.org;
	Tue, 08 Apr 2025 14:08:02 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5386e1He005729;
	Tue, 8 Apr 2025 14:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=A2/pJC
	ncFwcx06LWM/cQrsrxIZExf31+a7ik2X5+kcc=; b=XEJAao4l22mYp5J5WSfc3w
	Vgcv45WwlKEnO3dq14OGWJPQm8sUqosHtOxXsT6ERrfO2xaVNZBxyX0q9KZik1kt
	Wbb9al+N1n69eW/Pj1lMT9sbfRI0KD7EBNHY01h8rh4seQ3wZCmeHqNw8vLXh8EH
	FMSJniOZUJyl3eX8fZzySVVfzhFSJ9z5r1i+uMYpNYcIeAIiUKsdBc0SVW1PEZ6W
	TGHnoSWXw7nxc//2DuL+Gtt/IyEGe/yZr+EistkIHvFlhb4TLigqvLByQh8oJqTK
	ydwQuJhp98N91qCfGh+LhBqacCjKai2QIXgdvlZQoE+toi8RROhQyWK7G7ofS0Ew
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45vjvxmt16-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:07:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 538BJBPc011326;
	Tue, 8 Apr 2025 14:07:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45uf7yk3y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 14:07:53 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 538E7pYH27591330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Apr 2025 14:07:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CFA658059;
	Tue,  8 Apr 2025 14:07:53 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDF4758063;
	Tue,  8 Apr 2025 14:07:49 +0000 (GMT)
Received: from [9.109.198.149] (unknown [9.109.198.149])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Apr 2025 14:07:49 +0000 (GMT)
Message-ID: <5db5ab7b-fdf2-4b40-86fc-3ab4ccff9a41@linux.ibm.com>
Date: Tue, 8 Apr 2025 19:37:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] nvme-multipath: introduce delayed removal of the
 multipath head node
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        kbusch@kernel.org, hare@suse.de, sagi@grimberg.me, jmeneghi@redhat.com,
        axboe@kernel.dk, gjoyce@ibm.com
References: <20250321063901.747605-1-nilay@linux.ibm.com>
 <20250321063901.747605-2-nilay@linux.ibm.com> <20250407144413.GA12216@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250407144413.GA12216@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 32_HpdCv_2VM5qJUIJrcV9OzrxMSNMLC
X-Proofpoint-GUID: 32_HpdCv_2VM5qJUIJrcV9OzrxMSNMLC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_06,2025-04-08_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504080098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250408_070801_502582_2FA1D6CB 
X-CRM114-Status: GOOD (  25.93  )
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



On 4/7/25 8:14 PM, Christoph Hellwig wrote:
>> @@ -3690,6 +3690,10 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>>  	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>>  	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>>  	kref_init(&head->ref);
>> +#ifdef CONFIG_NVME_MULTIPATH
>> +	if (ctrl->ops->flags & NVME_F_FABRICS)
>> +		set_bit(NVME_NSHEAD_FABRICS, &head->flags);
>> +#endif
> 
> We might want to make the flags unconditional or move this into a helper
> to avoid the ifdef'ery if we keep the flag (see below).
Yes okay, this could be moved into a helper so that we can avoid ifdef'ery.

> 
>> -	if (last_path)
>> -		nvme_mpath_shutdown_disk(ns->head);
>> +	nvme_mpath_shutdown_disk(ns->head);
> 
> I guess this function is where the shutdown naming came from, and it
> probably was a bad idea even back then..
> 
> Maybe throw in an extra patch to rename it as well.
> 
Sure will do.

>> +	/*
>> +	 * For non-fabric controllers we support delayed removal of head disk
>> +	 * node. If we reached up to here then it means that head disk is still
>> +	 * alive and so we assume here that even if there's no path available
>> +	 * maybe due to the transient link failure, we could queue up the IO
>> +	 * and later when path becomes ready we re-submit queued IO.
>> +	 */
>> +	if (!(test_bit(NVME_NSHEAD_FABRICS, &head->flags)))
>> +		return true;
> 
> Why is this conditional on fabrics or not?  The same rationale should
> apply as much if not more for fabrics controllers.
> 
For fabrics we already have options like "reconnect_delay" and 
"max_reconnects". So in case of fabric link failures, we delay 
the removal of the head disk node based on those options.

> Also no need for the set of braces around the test_bit() call.
> 
Yeah agreed!
>>  }
>>  
>> +static void nvme_remove_head(struct nvme_ns_head *head)
>> +{
>> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>> +		/*
>> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
>> +		 * to allow multipath to fail all I/O.
>> +		 */
> 
> Full sentence are supposed to start with a capitalized word.
> 
> (yes, I saw this just move, but it's a good chance to fix it)
> 
Yes, I will fix it in the next patch.

Thanks,
--Nilay



