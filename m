Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC2C02180
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jan 2025 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RmJE4EZ9fW8WW2XojuAPnvQ0nQLilxR/W3eIlxyXkUg=; b=n24s3LWwPQ+lKIC5J855yajW0P
	BEQW3TQtnoeX3fpOCjq5ujUVanWtvaXRDpmJBQVl9zWRXVzsP0ALyQgAEKFjbjv6kUQKQXyuWaFAd
	HX7vzvWQ2pNJHBJh1PDbzLbB0i9Roa4M3bzS8wwLJPRPJ01Ewe/n1pxgvAhKgqBtYGRPRCdDz9Vfb
	2+k8jgIaH1YEd0G9tI3/L98G1hzNnvaKLYDLirp9VhicW2sbYhIPn3IOoMj2wNTfCYcGk/FGxucMg
	CJJHG05jqu3XrtKEco3Smz8pKOqD2ovY2PN1Zqa1tsVYdjbOXf6B8XkvB8psJLUcm54kdsj4BVtTS
	6mmQdSXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXLBO-00000005MoC-1G97;
	Mon, 13 Jan 2025 14:12:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXLBL-00000005Mmt-3k1c
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jan 2025 14:12:45 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DDhFBh006251;
	Mon, 13 Jan 2025 14:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RmJE4E
	Z9fW8WW2XojuAPnvQ0nQLilxR/W3eIlxyXkUg=; b=SDZDQy8u0/2itkDn4Ldkfg
	diANuY62uNIFssZJUvpZ3+2MSZPXO2Wpxe/f3uUceXA8yFW9W/527U5BEfi0P7M/
	8aS+EN5u/DXHBnXJPcnZl/IiWkc1J/oS47rV8oL+FuXF5wcTCdxf5sVNBTL2zZ0T
	c5R381js02qN1Q/opzhDN9zPjYHJhrF5Dwd4pBM00iC4HVUFpiyFKRMPO6dTaFC4
	PoPG6AUwua7eeV3OrbFMNwCobwpbUpWJlPDMB/NlqE+mh992Jm6p+8xqZfTjZ9V1
	rRdcKkqF+CbsByeGV4Menn7rlpk+bNJuZiLkaAUar1yWvbTQPnovRo1qD/Gu471Q
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 444qjajwmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:12:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50DCuVCh016994;
	Mon, 13 Jan 2025 14:12:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fjxegg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jan 2025 14:12:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50DECRhS1573376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jan 2025 14:12:27 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BD4F5805A;
	Mon, 13 Jan 2025 14:12:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A95DD58051;
	Mon, 13 Jan 2025 14:12:25 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jan 2025 14:12:25 +0000 (GMT)
Message-ID: <c0f49aed-2f93-4b31-b768-e9e354c98d42@linux.ibm.com>
Date: Mon, 13 Jan 2025 19:42:24 +0530
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
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <f71a0a75-1a79-4d0f-803f-5eb8835252ef@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F6-dExRJNGt-xnfND8EaH_JGdwc1HWxT
X-Proofpoint-ORIG-GUID: F6-dExRJNGt-xnfND8EaH_JGdwc1HWxT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_061244_051753_6C8F2AB3 
X-CRM114-Status: GOOD (  38.20  )
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



On 1/13/25 1:13 PM, Hannes Reinecke wrote:
> On 1/11/25 15:01, Nilay Shroff wrote:
>>
>>
>> On 12/6/24 6:11 PM, Hannes Reinecke wrote:
>>> On 12/5/24 17:15, Keith Busch wrote:
>>>> On Thu, Dec 05, 2024 at 01:30:39PM +0100, Hannes Reinecke wrote:
>>>>> On 12/4/24 17:39, Keith Busch wrote:
>>>>>>> 1) AEN triggers a rescan
>>>>>>> 2) List of active namespace is retrieved
>>>>>>> -> NSID A gets unmapped (or moved to another node in the cluster)
>>>>>>> 3) Scan of NSID A returns an error with DNR set.
>>>>>>> Without this patch we keep the namespace around, so eventually we'll
>>>>>>> trip over the 'non-matching UUID' check once the NSID is reused.
>>>>>>
>>>>>> I'm still not sure that makes sense. The target shouldn't attach the new
>>>>>> namespace until the host acknowledges the removal of the older NSID via
>>>>>> the Namespace Change List log. Until the log is read, the inventory for
>>>>>> removed namespaces should be latched. Otherwise, timing might remove+add
>>>>>> a specific NSID before the host requests the NS Descriptor for the
>>>>>> racing removal, then it would just get the "non-matching UUID" issue
>>>>>> anyway.
>>>>>
>>>>> But we read the Namespace Change List log in step 2)
>>>>> (Not that we're doing anything with it, but that's another story...)
>>>>> Hmm?
>>>>
>>>> Indeed. So maybe we should just move the log page retrevial *after* we
>>>> scan the identify active namespace list processing?
>>>
>>> Not sure how that would help. We are getting an 'ANA inaccessible' with DNR set status when retrieving the NS descriptor list for the namespace.
>>> And this has to happen after we read the list of active namespace.
>>> Perfectly legit, but doesn't tell us anything if the namespace is present at all.
>>> All we know is that we cannot get information about that, and my argument is that we should treat this as equivalent to a namespace
>>> not present.
>>>
>> I think when a nsid is in "ANA inaccessible" state sending any command which
>> has that nsid described in it would be aborted by the controller.
>> Per the NVMe 2.0  spec (quoting a snippet from section 8.1.3.3 ANA
>> Inaccessible state):
>>
>> "A controller shall abort commands, other than those described in section 8.1.4, with a status code of
>> Asymmetric Access Inaccessible if those commands are submitted while the relationship between the
>> namespace specified by the command and the controller processing the command is in this state.
>>
>> While ANA Inaccessible state is reported by a controller for the namespace, the host should retry the
>> command on a different controller that is reporting ANA Optimized state or ANA Non-Optimized state. If no
>> controllers are reporting ANA Optimized state or ANA Non-Optimized state, then a transition may be
>> occurring such that a controller reporting the Inaccessible state may become accessible and the host should
>> retry the command on the controller reporting Inaccessible state for at least ANATT seconds (refer to Figure
>> 275). Refer to section 8.10.2."
>>
>> So as we can see above, removing nsid immediately just because ns-descriptor-list command
>> failed with status "ANA inaccessible and DNR set" may not be correct. Because it's possible
>> that ANA state may transition back to optimized/non-optimized state, So instead of removing
>> ns from host, we may retry that command on another controller which is reporting ANA optimized/
>> non-optimized state if that nsid is attached to more than one controller. If nsid is private
>> (means attached only to one controller) then we may not have any option but to skip this nsid
>> during scan and wait until either ANATT timer expires or nsid transition back from ANA
>> inaccessible to ANA optimized/non-optimized state.
>>
> I would agree with you for any other command. But the 'identify ns desc' command is the very first command send to the namespace, and it's required by our implementation to correctly attach the namespace to the corresponding ns_head structure.
> We simply _cannot_ retry that command on another path, as that other path might (and, actually, is expected to) yield different information.
> 
>> Yes it might be possible that while nsid is in ANA inaccessible state, it might be un-mapped
>> from the target controller. But in that case target should send namespace change notice to the
>> host and that shall trigger ns scan. And as Keith proposed, we probably want to move the changed
>> log ns retrieval just after we get active list of ns.
>>
> That is precisely the scenario which I ran into.
> We _do_ get the AEN changed event, but by the time when we start the ns scan the NSID has already been reassigned to a namespace with a different UUID.
> 
> When nvme_scan_ns() is called,  nvme_find_get_ns() would return 'true'
> (as we still have the stale namespace in our lists), but the subsequent
> nvme_validate_ns() would fail (as the UUID is different).
> So the old namespace will be removed, but the new namespace will never be rescanned.
> 
> So my argument is that in this specific case the 'ANA inaccessible' nvme
> state should _not_ be retried, but should be treated as identical to
> 'invalid namespace' errors.
> 
I think I got what you're trying to propose. So when this issue manifests, on host, if we 
could possibly differentiate between nvme_identify_ns_descs() failed reasons : is it failed
because the nsid has been removed/un-mapped on the target or is it failed due to "ANA inaccessible" 
state? IMO, for "ANA inaccessible" status, we may not want to immediately remove the ns from
the host (due to reason I mentioned earlier per NVMe spec section 8.1.3.3), however for the
other error case we may remove the ns from the host. 
I think issuing ns descriptor list command to target for a nsid which doesn't exist on the 
target would return buffer filled with all zeros. So that might be an indication that ns has 
been removed from the target.
 
Thanks,
--Nilay

