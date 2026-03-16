Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77548F506C7
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 12:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p4kW6iuHHd3Onpl6qYFTf5sjgCfYgSoSxftPODJkfWU=; b=sRTKpRpi11GB8YEfZxi2SIQuJx
	Rw/Ejn0XspjhOyIzOlRYRplDU1bp857QAzizLvswJq379bygOVosX/UoUaEtCzoppl6waiSUghbC9
	6FWqVna27ZHpfOCjOLQQvGYDmoP+M1DcJfzWq6dz1YqZyAR2V9ggoagS6bw5T5DflNGLHNY0U6UAM
	1PPf1delovYebg/X7nG4qxcpBhjTM4aYH887dOt8f2fz2jj76dtnQHUiSAyBz5C+PA+fes86e/VgW
	UTaEc0VpbDndr2Lxc9M9HJs1yctOVGtozD9QcM+z0w6y4oGBx9JTHMrca2MsGmol03OpQz6ebnxU0
	auRW4wBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27VD-00000003zC9-3H83;
	Mon, 16 Mar 2026 12:56:59 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w27VB-00000003zBN-1bOr
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 12:56:58 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMj9Td940706;
	Mon, 16 Mar 2026 12:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=p4kW6i
	uHHd3Onpl6qYFTf5sjgCfYgSoSxftPODJkfWU=; b=h1uJGKv4osO6s6QXSEomGv
	iRph+yCDra90KY98nyvdjBvsYFFH2/3Tq6uENlZeJLITa0+D+6XC+mmnP3D+vxuV
	G4KruSpjtmSeFTLMlUfckqoLkUCfRKtYzTcbH8w0Ao9s2fwew1VxnZLtQ3VVQnfY
	4ov4ks2uXknM0dm94NecFNe6didsPk178R6z1UY0on8jd6fTlJSBqzPJNOVe1Yub
	Q8Ked5Vg7TgC/tqucng1Xhur7g+9MHvSr+aw+urAqQn3I88ssAKN5SnzuZbOp5GJ
	i1gp7aITuyIuv0xJ6s6Z2y2+fxSzTVYzwadv9Jj4HeFCfn6EnsvkaPWIx5queVRg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybryvks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:56:39 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GA0VuV014113;
	Mon, 16 Mar 2026 12:56:38 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcxvx45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:56:38 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GCubFO62390660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 12:56:37 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29DF058065;
	Mon, 16 Mar 2026 12:56:37 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1820758056;
	Mon, 16 Mar 2026 12:56:34 +0000 (GMT)
Received: from [9.123.5.177] (unknown [9.123.5.177])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 12:56:33 +0000 (GMT)
Message-ID: <0832f4dd-0ab6-4e11-a404-fdb18ca699b2@linux.ibm.com>
Date: Mon, 16 Mar 2026 18:26:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 0/7] nvme: export additional diagnostic counters via
 sysfs
From: Nilay Shroff <nilay@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
        sagi@grimberg.me, hare@suse.de, dwagner@suse.de,
        wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260220175024.292898-1-nilay@linux.ibm.com>
 <92f27319-649b-4957-9de7-619d76faa1ce@linux.ibm.com>
 <aar6j8S1O-mjqqxN@kbusch-mbp>
 <a1acd62e-3e22-42eb-b634-3e9ab18bc39a@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a1acd62e-3e22-42eb-b634-3e9ab18bc39a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b7fe07 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=oEqMEXgzuMGmv0uDYDIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Xq2NqVKtFp6xD9scGmjgHacF89P5TGfP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfX1UvaiOdk1mU5
 8PftLpFGVzrVjRvNMkz5ed2yhApmu3bZXBCujnk6E8F7VlKQi9lKHXrI7JV55yaq7GwdpvJipMx
 ZNtXN0oYAyts3KxarmRhd8XkpKA+mR8fTo0Og6iHBfPk3TMZfnFUrchmqCF5OEYbK2ezkNW2vIn
 vhdMRXTgE6t8hhTtTfmikhujubWv0aZ3JeIKp+Zx2E4NghJdz7w5cCAbN1AN6JRRxAjRXSrd+Ed
 9IQUvRXkGXR3epBG/V8abrtJF4lt7nalpPInx4hratDf9wtj+cDd70M1qRM+dyP2H25zvauWpKY
 LbsW/Y3CFjl7NZLmHnh7P7RSrg1D7CxENPMvCmLx+dBBXd7IylYwtU31ED0C2KVqJOhJfedRbfE
 IGYoIMRnCETQ/jFjF0yMXaXzSwWTtXrrIjGI+JR20C5S37akDneGgcu1om4rzI1VAIhI/smVYy4
 vpLUQLdAnHaO4BvxY8Q==
X-Proofpoint-GUID: Xq2NqVKtFp6xD9scGmjgHacF89P5TGfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_055657_428939_BB3A892F 
X-CRM114-Status: GOOD (  38.37  )
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

On 3/9/26 12:25 AM, Nilay Shroff wrote:
> On 3/6/26 9:32 PM, Keith Busch wrote:
>> On Wed, Mar 04, 2026 at 08:03:02PM +0530, Nilay Shroff wrote:
>>> Hi Keith,
>>>
>>> A gentle ping on this. I´ve incorporated the review comments,
>>> and the series has already received Reviewed-by and Tested-by tags.
>>>
>>> Could you please consider pulling it? Also, please let me know if
>>> you have any further comments or if additional changes are needed.
>>
>> Thanks, I was hoping free time would show up to let me look closer at
>> this, but that doesn't appear to be happening, so looks like I have to
>> force the time :)
>>
> Thanks for your time and review!
> 
>> We always need to be a bit cautious on adding user visible attributes,
>> so just throwing out some thoughts on this feature.
>>
>> The event counters are not atomic. I know these are informational, so
>> maybe it's not important to be 100% accurate in the reporting, but I
>> don't know. Maybe you do want accuracy in which case using atomic_long_t
>> might be the right type. I think that should be okay to use since none
>> of these counters are in the normal fast path.
> 
> Currently the counters are implemented using size_t and updated through
> the size_add() helper to avoid overflow (as you suggested earlier in the
> review). Since these counters are not updated in performance critical
> paths, switching them to atomic_long_t should be fine. I'll  update the
> implementation to use atomic counters.
> 
>>
>> The names of the attributes are a bit inconsistent. Some have a "_count"
>> suffix, some have "_events" suffix, and some have no suffix at all.
>>
> Yes, I originally chose names that I felt were descriptive while trying
> to keep them concise. However I agree that consistent naming is more
> important. I'd update all attributes to use a uniform "_count" suffix.
> 
>> In order to keep sysfs a bit cleaner, should we consider moving these
>> attributes under a sub-directory specifically for reporting event
>> counters?
>>
> The counters are currently exported from different objects depending on
> what they represent. Some are per-namespace path, some per-controller,
> and others are associated with the namespace head. Because of this
> separation, placing all counters under a single sub-directory would
> not be feasible.
> 
> If the concern is reducing clutter in existing directories, we could
> instead introduce a dedicated sub-directory under each object and export
> the counters there. For example, we could create a "diag" directory under
> the per-ns path, controller, and ns-head directories and then export the
> respective counters under "diag". What do you suggest?
> 
>> Last thought, as you are probably aware, John Garry is proposing to
>> lift the nvme multipath into a generic library, which suggests many of
>> these events would also need to be generic. Should some of these, like
>> error and retry counts, be appended to the generic disk stats instead?
> 
> Yes I am aware about libmultipath work.
> I agree that retry and error counters might conceptually fit into
> generic disk statistics. However the intent of these diagnostic counters
> is to capture all relevant events, including passthrough commands.
> 
> Passthrough requests are typically not accounted for in generic disk
> statistics, which makes that interface unsuitable for these counters.
> Additionally some counters are reported at the controller level, and
> controllers do not have an associated gendisk or block device.
> 
> For these reasons exporting them through the dedicated sysfs interfaces
> appears to be the most appropriate approach.
> 

Based on the points you raised earlier in the thread, I propose the
following updates to the series:

1. Convert the stat/event counters to atomic_long_t to ensure correctness.
2. Make the attribute naming consistent by using a uniform _count suffix
    for all counters.
3. Export the counters under a dedicated sysfs sub-directory. Since the
    counters are exposed from different kobjects (per-ns path, controller,
    and ns-head), I would add a diag sub-directory under each of those
    objects and place the respective counters there.
4. Keep these counters out of the generic gendisk statistics, as some of the
    counters include passthrough requests, which are typically not accounted
    for in the generic disk stats interface.

Please let me know if this approach looks reasonable.

Thanks,
--Nilay



