Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA90FC36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 09:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBagdak8UF2hYUtnqRxLXkHyprWhO2cLKTFAETp86Wo=; b=1kvY2HBQElLV+S/Ofvge9M5VYu
	p7zqKY+SsM+Hx6zCp897xCiipxzcYSx2NAi0SEBEQTnJkRfVDw7W2HiP2BRzQZ976EzcMTs97oFZI
	QLTYh46c/6WYQ7JI6H7uVuPerBypd0M38GKfZiGq6BQvN7kQISnanYP2hQsqbW+9E3O/GHwBtu9da
	WyGHEItU47PtnEEpZCB9I5pAaOWQFkoRGmWg9K9DV6p5xs4YyeYj3rYqA3/MCc7nWZ1GGDrQVHVNn
	SRhb6AS4Mkyu6fVpE9T+xU5akzGrxtVF3Zp/mEVgZUbW1Jb6d1yt0cmgFDcbaCzhGj8FFWVHZLM5n
	SmOjwYjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RtT-00000006j6K-2oQ1;
	Wed, 09 Apr 2025 09:38:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2RtP-00000006j5i-35VM
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 09:38:50 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538MBf2A018156;
	Wed, 9 Apr 2025 09:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TBagda
	k8UF2hYUtnqRxLXkHyprWhO2cLKTFAETp86Wo=; b=ZxjSAywxj1JDnjDIe8rnJD
	V+xZ76uc6tmdCAugVuzhLAbkohhY223Xqt5tQwr9tQY9cFYZlnTO7BO23jJj/hJA
	hzSOL+0stN+FtYQ/12Pfjc4tZ4o3OZyJr1jzU3hUHyQ8PAcj0ASRb0khPPUMv8j9
	SoDvc+QKkNL13KjvakHvzdIlyuLmmt7ooY3Gdul8dBg26RptUvH4vzKicfw4wwAu
	CsEN6r7m9lwULFd6+ry9HqsZHnzsTkYhxy1euVPrHH9FB0Rn9Yif2wIMq40IVskg
	OCNpj0NSVXIbU8LWVCGxC9P3R5+zSQ24et1jqCMO6qsuYWAy1Gk8MwAbr7NgdiRQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u35bmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:38:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5397E9Er018851;
	Wed, 9 Apr 2025 09:38:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uhj2epd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 09:38:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5399chWm27722310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 09:38:43 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4752A5805D;
	Wed,  9 Apr 2025 09:38:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6385F58056;
	Wed,  9 Apr 2025 09:38:41 +0000 (GMT)
Received: from [9.171.27.28] (unknown [9.171.27.28])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 09:38:41 +0000 (GMT)
Message-ID: <50c27880-70e6-49c6-a1d4-6be1eb272c38@linux.ibm.com>
Date: Wed, 9 Apr 2025 15:08:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tree: add attribute numa_nodes for NVMe path object
To: Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@kernel.org, kbusch@kernel.org,
        gjoyce@ibm.com
References: <20250405130255.448345-1-nilay@linux.ibm.com>
 <20250405130255.448345-4-nilay@linux.ibm.com>
 <1f88256a-f36f-4a34-96e2-53d2b6da7764@flourine.local>
 <4db3b302-3a07-4e82-aa5c-c63c55de2c6f@linux.ibm.com>
 <89bce70c-8eac-4dee-a5ca-4aa52fa5687f@flourine.local>
 <fd2407c9-e180-4785-a71f-944ea40edfe3@linux.ibm.com>
 <9b957880-ec3b-4b22-a923-f5b91dee9b76@flourine.local>
 <72649ea2-35c8-4c97-a3af-3f1c38bf7303@suse.de>
 <cb240c7d-ce29-4c7d-a205-13466d5b749f@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <cb240c7d-ce29-4c7d-a205-13466d5b749f@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cVGEUPvsfsiXiwj2pJ_NUUIFxASY8Qiz
X-Proofpoint-ORIG-GUID: cVGEUPvsfsiXiwj2pJ_NUUIFxASY8Qiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_023847_778717_9DD795E3 
X-CRM114-Status: GOOD (  18.12  )
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



On 4/8/25 5:12 PM, Daniel Wagner wrote:
> On Tue, Apr 08, 2025 at 07:58:40AM +0200, Hannes Reinecke wrote:
>> On 4/7/25 17:19, Daniel Wagner wrote:
>>> On Mon, Apr 07, 2025 at 07:49:41PM +0530, Nilay Shroff wrote:
>>>> Both approaches — either adding a no-cache flag or introducing dedicated
>>>> __no_cached APIs — would work. However, in my opinion, we should aim to
>>>> use a consistent method across both libnvme 1.x and 2.x versions.
>>>
>>> There will be a lot of API changes for 2.x to address all the silly
>>> mistakes. That's way it will be a major version change.
>>>
>>>> As we discussed during LSFMM, if we plan to implement an "nvme top" command,
>>>> we would need non-cached versions of these APIs even for nvme-cli.
>>>
>>> Yes, that is why I brought up this discussion. For such a command we
>>> would need non cached versions. And I realize that we would need this
>>> feature also for other commands. So it's not just the queue depth which
>>> changes. Maybe we should just not try to add this feature to 1.x and
>>> rather start the 2.x project.
>>>
>>>> So, using the same mechanism for both versions makes sense. Otherwise,
>>>> we’d also have to maintain different logic in nvme top depending on
>>>> the libnvme version, which adds unnecessary complexity.
>>>
>>> I don't see a big problem here. Either use the 1.x or 2.x.
>>
>> Why don't we make this option as non-cached by default?
>> In the end, there is limited usability in having it cached.
> 
> Sure, this is also fine. I suppose there will be some more conversion
> from cached to non-cached necessary for the 'nvme top' feature.

Makes sense. For the this patchset, I will spin a new series and send 
after incorporating comments. We shall address cached vs non-cached 
version of APIs in another series (probably when we implement nvme top). 

However, I like the idea of Hannes to only have non-cached APIs. May be, 
we should be able to convert existing cached APIs to non-cached APIs 
(or limit to only those APIs required for nvme top) without any side
effect. 

Thanks,
--Nilay



