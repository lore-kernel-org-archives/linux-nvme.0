Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D62C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 08:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2AJ1yM5JJJhLZFyLNUe0DGeTsFSP8SJa+S1NM1KhR4c=; b=TrR/ir9vccXjKPgX0ArMiy17t2
	6aYva/kJnpVwx+9ZHXKebcLOhK7kakcTcz7mAZmw3iDIfe3i/sJIgUy5nuf8T0kiWB5uaQVGLhKsl
	tp5jsUdr3AHmm6QijB3z4n9KhabM6qlvBpGy3YYqYbJwP5NzP0EWAeEX50dU5rNgRQLKpFaA0WY6v
	Ai96MFS2KEZ1M8CgAIomreqAMq7WLokDf1hxrDB8jm/gYZ9RBFxghGdlgkTWpxEOu0KTbeHo2Hs+4
	A2YBXTU1pVfezjDfnQIPQX9sxmHmQYEbi4pJOiXkftfhKsaOvIhItAHhnBbp3qc1PLh8lF9Mwz4x2
	DMBqKBSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXycM-0000000B4Ae-2gPa;
	Wed, 15 Jan 2025 08:19:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXycK-0000000B4AD-0PSJ
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 08:19:13 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50ENaP4S010046;
	Wed, 15 Jan 2025 08:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2AJ1yM
	5JJJhLZFyLNUe0DGeTsFSP8SJa+S1NM1KhR4c=; b=q+3zP25qAiP4K1n3+1GZhQ
	XxxRMMN1PFhdhQ9oKv1tfssks40XbE2cQNLvD7GKNPW1t6XEbImXlOspyfvcI1X3
	C+Zx7KjDf2nRRu3mNjg7fTvkcvlFh9qcnk5grkIowp56d590vDKhU/GMMHffcqBv
	ow818OsigQ+3jfDUcnIJk6MjUO3YXAj9hYkBuiOOmVdML++PCEV/KMTHcnwsR+hh
	+IloR2pdtzmwB8yrBkU29fRHXQuulKUyipFbtvTr4Jbo5aS5AYK3U2rO0gl9xYSG
	MKuML42qDAous0z6z3c2u1C/brwf0w1FrpgIvuBEqkUwT7S+85SSqBeMp0ZDK0vg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4461rbhn0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:18:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50F6DaSr016976;
	Wed, 15 Jan 2025 08:18:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk791g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 08:18:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50F8Ivcp9306814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Jan 2025 08:18:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2497C5805C;
	Wed, 15 Jan 2025 08:18:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61E7458051;
	Wed, 15 Jan 2025 08:18:55 +0000 (GMT)
Received: from [9.171.6.63] (unknown [9.171.6.63])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 Jan 2025 08:18:55 +0000 (GMT)
Message-ID: <71a9fc62-c5ca-48fe-8eca-fc0812a769ae@linux.ibm.com>
Date: Wed, 15 Jan 2025 13:48:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove namespace when nvme_identify_ns_descs()
 failed
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20241129140608.115282-1-hare@kernel.org>
 <Z09Y30pUtAg0xwoR@kbusch-mbp> <4ba05af4-9464-4cdf-a306-60585793c46e@suse.de>
 <Z1CF2vn1_xkNIVAM@kbusch-mbp> <99025917-e201-4ec9-ba04-e979f61c411b@suse.de>
 <Z1HRkKr5LhfvfLAs@kbusch-mbp.dhcp.thefacebook.com>
 <c737d451-f8b9-47cc-a411-4b2ed349fab0@suse.de>
 <97a8263b-1efb-43ce-b6ad-8444cf148346@linux.ibm.com>
 <f71a0a75-1a79-4d0f-803f-5eb8835252ef@suse.de>
 <c0f49aed-2f93-4b31-b768-e9e354c98d42@linux.ibm.com>
 <7aacb2fa-a7b9-4eb2-ad87-bdd24e1cd308@suse.de>
 <b7f55b77-1bb2-4a0d-8ad9-aa78dae72cf6@linux.ibm.com>
 <7cd569e6-324a-45bd-b06b-754464806220@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7cd569e6-324a-45bd-b06b-754464806220@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a-iwIeZv6s9Ii5ChU7MnL2BL5mb1zwKm
X-Proofpoint-GUID: a-iwIeZv6s9Ii5ChU7MnL2BL5mb1zwKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501150059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_001912_264349_B897CD7E 
X-CRM114-Status: GOOD (  24.91  )
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



On 1/15/25 1:32 PM, Hannes Reinecke wrote:
> On 1/15/25 08:48, Nilay Shroff wrote:
>>
>>
>> On 1/13/25 7:59 PM, Hannes Reinecke wrote:
>>> On 1/13/25 15:12, Nilay Shroff wrote:
>>>>
>>>>
>>>> On 1/13/25 1:13 PM, Hannes Reinecke wrote:
>>>>> On 1/11/25 15:01, Nilay Shroff wrote:
>>>>>>
>>>>>>
>>> [ .. ]
>>>>> So my argument is that in this specific case the 'ANA inaccessible' nvme
>>>>> state should _not_ be retried, but should be treated as identical to
>>>>> 'invalid namespace' errors.
>>>>>
>>>> I think I got what you're trying to propose. So when this issue manifests, on host, if we
>>>> could possibly differentiate between nvme_identify_ns_descs() failed reasons : is it failed
>>>> because the nsid has been removed/un-mapped on the target or is it failed due to "ANA inaccessible"
>>>> state? IMO, for "ANA inaccessible" status, we may not want to immediately remove the ns from
>>>> the host (due to reason I mentioned earlier per NVMe spec section 8.1.3.3), however for the
>>>> other error case we may remove the ns from the host.
>>>> I think issuing ns descriptor list command to target for a nsid which doesn't exist on the
>>>> target would return buffer filled with all zeros. So that might be an indication that ns has
>>>> been removed from the target.
>>>>    
>>> But only if the NSID has not been remapped in the meantime.
>>> If it has (as in my case) the ns descriptor list will be valid, it just
>>> refers to another namespace.
>>>
>> If NSID has been unmapped and then remapped on the targer then in that case,
>> host would hit the mismatch uuid case (under nvme_validate_ns()) and so host
>> would then remove the namespace.
>>
>> I think there are two cases,
>> Case1:
>> 1. AEN triggers rescan
>> 2. List of active nsid is retrieved
>> -> NSID A is removed on the target
>> 3. Scanning of NSID A fails (i.e. nvme_identify_ns_descs() returns buffer filled with all zeros)
>> -> host removes the respective namespace
>>
>> Case2:
>> 1. AEN triggers rescan
>> 2. List of active nsid is retrieved
>> -> NSID A is unmapped and remapped (possibly with different uuid) on target
>> 3. Scanning of NSID A succeed
>> 4. host finds the mismatch uuid for NSID A (i.e. nvme_validate_ns() fails)
>> -> host removes the respective namespace
>>   
> Entirely correct.
> But Case2 results in the new namespace never to be scanned, and not visible to the OS. Which is the error I'm fighting with.
> 
Ok but then it seems that your proposed patch doesn't address Case2, isn't it? 
It appears to me that the patch tries to address Case1 but with error code 
of "ANA inaccessible and DNR" set. IMO for case2, we may want to schedule 
queue scan again if nvme_validate_ns() fails due to the mismatch uuid.

Thanks,
--Nilay


