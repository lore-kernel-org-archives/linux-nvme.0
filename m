Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37D6CA0EEB
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Aug 2025 12:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NdULgqhVJPdRjGwSvVjV1gKCL1cdDGPqIbuwfH7v4uk=; b=yGV6RIWyq+mSaa1s1ieiyIS6zH
	eEdGSdB/r560PpATfd/VX8sU5j06BDRQG6pm1cNFSX2lV7iZ254fNlgC4eOeBVR26LKCjbgs1a3wh
	RoCy9xeSCzFGop48Oeq7CgXTe1vKAT7Gn50C8FeL8PF5iz3xjbo5rjZOOFn5Y+Hb4lvMIg+lkxAAa
	9/LbOXfA4tPC0ReBYaBvcJKrAdySzPy6IhWaVecrBJyMcOpxJNx+0EWSuDFnSbZNF+1sQCbR7l9kB
	+E3flxFOndA4SFyitRIGIORlk/bVeJxBtIiLysScKehTlb92am0pTLnX1MrHRQw+pBiKCAnmWp1QD
	2JR9kcOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoLXg-0000000ARw8-1uvz;
	Tue, 19 Aug 2025 12:34:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoJce-0000000A8XO-0TCw
	for linux-nvme@lists.infradead.org;
	Tue, 19 Aug 2025 10:31:21 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57J9NIA3008013;
	Tue, 19 Aug 2025 10:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=NdULgq
	hVJPdRjGwSvVjV1gKCL1cdDGPqIbuwfH7v4uk=; b=JKIdG4FKvFZJ8m3We/+OHY
	FTCUQZ7iBg9690np5pkdW+GPA049oRgoijnmw7wBA2AO8V+Gm71wyqp94CExvZIS
	svPGDFJRRS12b6tI11pcrhlZGDVhezLjRR4H8p4F3lEijTalEUyHwy3Az20lks2T
	J8+zLXnkpk3Fnw3gGxRTptPcGiS28IOI9RqYTKvPKYiPdxtX3KB3aIE2VCYsIX9I
	eLr8u2CKqRDvYaJAwikuQGgVY2Q/lZTT22NwwdKCw42b67jyLJymGt4/s8pU2din
	Stpx6pY99cUc9UXDKWYMOzUIQSvizPCUJyXv4Ax4pC9LDhIV/CStHMuDUljbL3pA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48jfdrx4ka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 10:31:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57JAUEMM003190;
	Tue, 19 Aug 2025 10:31:15 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48k6hm9kjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Aug 2025 10:31:15 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57JAVEoh17695156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Aug 2025 10:31:14 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367FE5805F;
	Tue, 19 Aug 2025 10:31:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 429895805A;
	Tue, 19 Aug 2025 10:31:12 +0000 (GMT)
Received: from [9.61.13.229] (unknown [9.61.13.229])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 19 Aug 2025 10:31:11 +0000 (GMT)
Message-ID: <a1132d3c-ac1b-4807-82f9-a1f195cef0f5@linux.ibm.com>
Date: Tue, 19 Aug 2025 16:01:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: dwagner@suse.de, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: als-rx60piRYbXd2yuIlRdm2pHuxioxl
X-Proofpoint-GUID: als-rx60piRYbXd2yuIlRdm2pHuxioxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAwMSBTYWx0ZWRfX/Gdhpqh9esyZ
 pLasRLDcf4FVIQvKYsFyus/RLCugYPkkRWzdVst54zZweLJpDD1afpu9O33ZXKyPj3PvxFvOUaO
 M2mi7pnRz4/Rj8e5hDGcjwi8ajBlNd0hAy6Ro7GvQWZEZPSbYhJ0VtedTYkDYP24IgNd+IU2S2t
 hI5VYPp6ctV/G/PxwiD4620bentGHF5s1wALkttEK1ttCYOvM3153lXDd3pPVCRAGjDwiBK5eMY
 99QZtYKA3C3VvHiz08Sh/ks4kVxgb8HNgN7Vt8QH44M3azNU46pHl1PJSQII9clTnl/Ee+AiHyD
 yijyBqBmNU8o3HrL8XInpSIo/5/fx6oG1lxnz/yXXoHyKwq8PbH+l3k62np4DTUsj3qWMj3E1DA
 9ePknX78
X-Authority-Analysis: v=2.4 cv=GotC+l1C c=1 sm=1 tr=0 ts=68a45273 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=2J7IuT7wAAAA:8 a=IgbNSRTGSoO6iWomlKUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250819_033120_270734_9C8059D4 
X-CRM114-Status: GOOD (  19.79  )
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



On 8/19/25 11:45 AM, Hannes Reinecke wrote:
> On 8/19/25 06:49, Nilay Shroff wrote:
>>
>>
>> On 8/18/25 12:52 PM, Hannes Reinecke wrote:
>>> On 8/12/25 14:56, Nilay Shroff wrote:
>>>> This commit enhances the show-topology command by adding support for
>>>> NVMe multipath. With this change, users can now list all paths to a
>>>> namespace from its corresponding head node device. Each NVMe path
>>>> entry then also includes additional details such as ANA state, NUMA
>>>> node, and queue depth, improving visibility into multipath configs.
>>>> This information can be particularly helpful for debugging and
>>>> analyzing NVMe multipath setups.
>>>>
>>>> To support this functionality, the "--ranking" option of the nvme
>>>> show-topology command has been extended with a new sub-option:
>>>> "multipath".
>>>>
>>>> Since this enhancement is specific to NVMe multipath, the iopolicy
>>>> configured under each subsystem is now always displayed. Previously,
>>>> iopolicy was shown only with nvme show-topology verbose output, but
>>>> it is now included by default to improve usability and provide better
>>>> context when reviewing multipath configurations via show-topology.
>>>>
>>>> With this update, users can view the multipath topology of a multi
>>>> controller/port NVMe disk using:
>>>>
>>>> $ nvme show-topology -r multipath
>>>>
>>>> nvme-subsys2 - NQN=nvmet_subsystem
>>>>                  hostnqn=nqn.2014-08.org.nvmexpress:uuid:12b49f6e-0276-4746-b10c-56815b7e6dc2
>>>>                  iopolicy=numa
>>>>
>>>>             _ _ _<head-node>
>>>>            /              _ _ _ <ana-state>
>>>>           /              /      _ _ _ <numa-node-list>
>>>>          /              /      /  _ _ _<queue-depth>
>>>>         |              /      /  /
>>>>    +- nvme2n1 (ns 1)  /      /  /
>>>>    \                 |      |  |
>>>>     +- nvme2c2n1 optimized 1,2 0 nvme2 tcp traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live
>>>>     +- nvme2c3n1 optimized 3,4 0 nvme3 tcp traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live
>>>>
>>>> Please note that the annotations shown above (e.g., <numa-node-list>,
>>>> <ana-state>, <hed-node>, and <queue-depth>) are included for clarity
>>>> only and are not part of the actual output.
>>>>
>>>
>>> Hmm. Why do we have the values for 'numa-node-list' and 'queue-depth'
>>> both in here? They are tied to the selected IO policy, and pretty
>>> meaningless if that IO policy is not selected.
>>> Please include only the values relevant for the selected IO policy;
>>> this will increase readability of the resulting status string.
>>>
>> Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
>> is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
>> And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
>> I'll update this in the next patch.
>>
> Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
> the number of fields will be different (and making parsing harder).
> 
Okay so then how about printing <numa-node> for round-robin policy as well?

I looked at the NVMe path selection code for the round-robin iopolicy, and it
appears the kernel uses the NUMA node ID of the I/O submitting CPU as the
reference for path selection.
For example, on a system with two NUMA nodes (0 and 1) and two NVMe paths
(PA and PB):
- If an I/O from node 0 selects PA, that choice is cached.
- Next time when kernel receives the I/O from the node 0, it'd retrieve
  the cached path value and find the last path chosen was PA. So now it
  will choose next available path which is PB to forward this IO.

This way kernel alternates between PA and PB in round-robin fashion.
So the selection is still tied to the submitting NUMA node, just with path
rotation layered on top. Given that, I think it makes sense to also print
<numa-node> for round-robin iopolicy, to keep field consistency and still
provide meaningful context. Agreed?

Thanks,
--Nilay

