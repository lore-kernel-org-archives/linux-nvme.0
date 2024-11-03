Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16DFD11182
	for <linux-nvme@archiver.kernel.org>; Sun,  3 Nov 2024 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0uh9GktfPdpSpTNuWq50AU4F0FH5OzoauypPYCLL7Yo=; b=bJDHOpP/frq3IZhGE8jHv8eLrq
	0iitDQ3LWR4W1FPZZiQ9tDRPNW4LmukduMs66G1rVTpUAno6h2W6nMCtYs0tcxyYm27pyLBQ+VBVX
	M6/TXFAmTow9P5ARIsUY6DlN1+q9ggwqyYGRNc4SfWeSSpZguZ7/dcpAjkbXXkYkkXuOARhwJyd4Q
	c0BlLEhtwOE4T67ALFILlxidT3kvDclUSFgohegtFKRBeJg7vw8cJpt7wEEm+vZcPz/lzd2eh6iVC
	j3UbNR7bJzor6gAwggwf5STYEix3zDY0uWPPfYcTTw3aHkeurShsF31gIpVbAwfQUyCxq4xv/32n8
	dItMs+sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7eoD-0000000BoYC-458A;
	Sun, 03 Nov 2024 17:54:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7eoA-0000000BoXa-0pHN
	for linux-nvme@lists.infradead.org;
	Sun, 03 Nov 2024 17:54:39 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3HqXOe020217;
	Sun, 3 Nov 2024 17:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0uh9Gk
	tfPdpSpTNuWq50AU4F0FH5OzoauypPYCLL7Yo=; b=nWXQt/iYdwa5ck9nkrSSXX
	Via7Xd7YASCOXBi8VHrSDxDFLvPl0aync3mt73y11Xxa9T8fbOT3NmmD0nCjrvMo
	YNcyM9wkLuwduL4irEUaJ0OmqzIeCOd96Bv+HLCVpQBRxnkGJrAW7sNhV8Xi2fuk
	b0JkBaFNYqmSFVOgz8XnIIAxi/mWY2bcxzBEOaMXlvT4MIaE03NsCG8C1eadNX07
	/kLvQA77z15lbAGWVIbh72P3PMYVwl9L+E8xHwbXzjIK9wWlEnVYgcG7/+vAdsvc
	GXo2Tib3tWLXVrYjeItCsWruUF4RfVv6xtUXS6cTPTApUaArXrm/G0rmtBPdu3GA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pc1288a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Nov 2024 17:54:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3GsYw5032065;
	Sun, 3 Nov 2024 17:54:21 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nydmgx5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Nov 2024 17:54:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A3HsKrn56099226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Nov 2024 17:54:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6650B58052;
	Sun,  3 Nov 2024 17:54:20 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B69B5805A;
	Sun,  3 Nov 2024 17:54:18 +0000 (GMT)
Received: from [9.171.89.247] (unknown [9.171.89.247])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Nov 2024 17:54:17 +0000 (GMT)
Message-ID: <f35e7094-9f21-4b9f-9f05-1689ae995fbc@linux.ibm.com>
Date: Sun, 3 Nov 2024 23:24:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: use helper nvme_ctrl_state in
 nvme_keep_alive_end_io function
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, dlemoal@kernel.org, gjoyce@linux.ibm.com
References: <20241027170209.440776-1-nilay@linux.ibm.com>
 <20241027170209.440776-4-nilay@linux.ibm.com> <ZyD433W-caGMfVsv@kbusch-mbp>
 <480b7c6a-9f4b-4611-a3d6-de82c39bfe6d@linux.ibm.com>
 <ZyUoa33hvwEybcRf@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZyUoa33hvwEybcRf@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UKC1ICr530mCu-wuBe_W43mvkWLs7LK3
X-Proofpoint-GUID: UKC1ICr530mCu-wuBe_W43mvkWLs7LK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 bulkscore=0 spamscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411030160
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_095438_395072_F629AEAA 
X-CRM114-Status: GOOD (  17.06  )
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



On 11/2/24 00:43, Keith Busch wrote:
> On Wed, Oct 30, 2024 at 11:37:15AM +0530, Nilay Shroff wrote:
>> On 10/29/24 20:31, Keith Busch wrote:
>>>> @@ -1296,10 +1296,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>>>>  						 blk_status_t status)
>>>>  {
>>>>  	struct nvme_ctrl *ctrl = rq->end_io_data;
>>>> -	unsigned long flags;
>>>> -	bool startka = false;
>>>>  	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
>>>>  	unsigned long delay = nvme_keep_alive_work_period(ctrl);
>>>> +	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl->state);
>>>>  
>>>>  	/*
>>>>  	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
>>>> @@ -1324,13 +1323,9 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
>>>>  
>>>>  	ctrl->ka_last_check_time = jiffies;
>>>>  	ctrl->comp_seen = false;
>>>> -	spin_lock_irqsave(&ctrl->lock, flags);
>>>> -	if (ctrl->state == NVME_CTRL_LIVE ||
>>>> -	    ctrl->state == NVME_CTRL_CONNECTING)
>>>> -		startka = true;
>>>> -	spin_unlock_irqrestore(&ctrl->lock, flags);
>>>> -	if (startka)
>>>> +	if (state == NVME_CTRL_LIVE || state == NVME_CTRL_CONNECTING)
>>>>  		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
>>>> +
>>>>  	return RQ_END_IO_NONE;
>>>>  }
>>>
>>> This restores what you had in the reverted patch, which was a
>>> significant portion of the diff stat. If we're keeping this chunk, maybe
>>> a full revert isn't necessary, and we can squash the series to just one
>>> fixing commit.
>>>
>> This doesn't exactly restore what was reverted in the patch. If you 
>> closely look at the reverted patch then you would find that we reverted 
>> the nvme_keep_alive_finish function which is not exactly same as 
>> nvme_keep_alive_end_io function. We renamed nvme_keep_alive_end_io() 
>> to nvme_keep_alive_finish() for the upstream patch.     
>>
>> So the revert patch restores nvme_keep_alive_end_io function and also 
>> restores the nvme_keep_alive_work changes. Then the current patch in this 
>> patchset, actually works upon nvme_keep_alive_end_io function.
> 
> Not the whole thing. I'm just talking about the parts I've hightlighted
> here. Squashing this series doesn't show any changes to the state check.
> 
Ok got it! I will squash these parts in the next revision of the patchset.

Thanks,
--Nilay

