Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8493EC19F32
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Mar 2025 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p9M0ani+vU9FgtUZfCm07TcwRXu/sPcqGJAqdQo24Vg=; b=sJD4WpUu8flyNC3ylxUksiy0Ns
	b0ixHEs3hGJy13uI+E7U3+KYqx6mZhgrQGqUxmxKsEd41B22/iDEF5f+LHKm9UMV7+VxEzo96xFWQ
	xC0ugmzVIDoTl0ud82mD3sBNTmuax90NQx9a1y3V59EUXSPcp66QaPvYRlemEgMahx2pWKETsbmDJ
	2/Jkv+VBpWB4CnFxFIFJdxBPNnI5IeetJzgsFRAQbMzH9Nvh3WfZhhpFkTmfk403RCM8VaDGIH9tz
	eSvrr6e7Y7J3HyvtIHVh9xN9b3s/VKcXacbae0h6xRb9DqxUv3XL/mEybOTcKbwfqhm7vYBluLsGA
	p5DLk0Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ton7g-0000000GQpX-1yMm;
	Sun, 02 Mar 2025 17:29:04 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ton7e-0000000GQot-34jV
	for linux-nvme@lists.infradead.org;
	Sun, 02 Mar 2025 17:29:03 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52260f0L022636;
	Sun, 2 Mar 2025 17:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p9M0an
	i+vU9FgtUZfCm07TcwRXu/sPcqGJAqdQo24Vg=; b=gynVeezErB63J6y4JCdzGz
	vRz40SoSnTTf/mdjRoo1Q3he2xnn5ruBWjO2sQ3pB7Vxvpil3nalynSKid9yZwP0
	y0PNrMgbYsnAZCp+z1yWNQFnfrAQTVwEKJVVjPEeJaS7cLFX/fm/JhckH4Gd5pb9
	p3cw8R71wi2esZ7QlKnMzNcxf4q1+aBhCBmniEji1J+5C82jsmdtojFZeXlurz+l
	Er3WfxkR7/1ry6CoASeBa71BMUguPz3HFUjAP9jGJF0MsbxsMGYmaMCryBGYV0x+
	CPTF1/5erdJZ/aEpp3KIkKyf/YUpDhnxWsLMoaa2BhFwCh4VQR7bxVBsO7QDYKcg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 454h82sy37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 17:28:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 522Drmnf032219;
	Sun, 2 Mar 2025 17:28:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjskcfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Mar 2025 17:28:42 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 522HSftS26608268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 2 Mar 2025 17:28:41 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6900658058;
	Sun,  2 Mar 2025 17:28:41 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD0AB58057;
	Sun,  2 Mar 2025 17:28:38 +0000 (GMT)
Received: from [9.61.128.138] (unknown [9.61.128.138])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  2 Mar 2025 17:28:38 +0000 (GMT)
Message-ID: <5bafe993-b78a-499f-9e57-3f315439f0cf@linux.ibm.com>
Date: Sun, 2 Mar 2025 22:58:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvme: update the multipath warning in
 nvme_init_ns_head
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me
Cc: loberman@redhat.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
References: <20250228032541.369804-1-jmeneghi@redhat.com>
 <20250228032541.369804-4-jmeneghi@redhat.com>
 <abd856da-7ca6-419f-943b-80dcc885f68b@linux.ibm.com>
 <72880abf-55c9-4dd6-872d-3c5b3faa4198@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <72880abf-55c9-4dd6-872d-3c5b3faa4198@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gge3y_9xcY1Si1uHrN8_HWcYdUEAbwoD
X-Proofpoint-ORIG-GUID: gge3y_9xcY1Si1uHrN8_HWcYdUEAbwoD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_05,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=873 suspectscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503020141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250302_092902_778765_F90DEED0 
X-CRM114-Status: GOOD (  21.25  )
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



On 2/28/25 6:44 PM, John Meneghini wrote:
> On 2/28/25 1:28 AM, Nilay Shroff wrote:
>> On 2/28/25 8:55 AM, John Meneghini wrote:
>>> The new NVME_MULTIPATH_PARAM config option requires updates
>>> to the warning message in nvme_init_ns_head(). Remove
>>> the old warning message and add new ones.
>>>
>>> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
>>> ---
>>>   drivers/nvme/host/core.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 818d4e49aab5..c2b7e6834535 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>>>               dev_warn(ctrl->device,
>>>                   "Found shared namespace %d, but multipathing not supported.\n",
>>>                   info->nsid);
>>> +#ifdef CONFIG_NVME_MULTIPATH
>>> +#ifdef CONFIG_NVME_MULTIPATH_PARAM
>>> +            dev_warn_once(ctrl->device,
>>> +                "Shared namespace support requires core.nvme_multipath=Y.\n");
>>> +
>>> +#endif
>>> +#else
>>>               dev_warn_once(ctrl->device,
>>> -                "Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
>>> +                "Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
>>> +#endif
>>>           }
>>>       }
>>>   
>>
>> As NVME_MULTIPATH_PARAM depends on NVME_MULTIPATH, it implicitly implies
>> that if NVME_MULTIPATH_PARAM is enabled then NVME_MULTIPATH has to be on.
>> So above logic could be simplified.
>>
>> However on another note, I really don't understand why do we need to add
>> new warning here as there's already a warning present just above your
>> changes.
> 
> Agreed.  How about if we just remove the
> 
>        dev_warn_once(ctrl->device,
>         "Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
>  
> This is real problem.  This is a confusing message since there is no now plan to remove any of these config options from the kernel.
I read it as "NVMe (native) multipathing is only supported when CONFIG_NVME_MULTIPATH
is configured". 

So personally, I find existing warning messages (we print two warning messages when 
multipath is false but shared namespace is detected) sufficient, however lets see 
what others suggest.

Thanks,
--Nilay 

