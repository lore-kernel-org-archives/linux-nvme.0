Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ADC6CA0EDC
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 12:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RLrlyJFVqbp/Dt5k3svqAxSyaPQX866KxjUKzdPqOBA=; b=Kpew3Vb11nVry51yQN69Ckz37w
	uXDFrYInaxd5AnowTHbpUg84Ffi9xgj9UmB0WbIGdJZ61a7nXT6M2JSkj7cVoYyN6LuYyIG67+SPg
	Erk0zvxI6UqYzgWirxnfEfjffPlLWYzmOvbKDPUFBmusgvP2VgZb95+cT8UaOqFDxOfgoUZ57o0x4
	82obHqs8u8gfxiVPLzcfkB3bU0XBngafNG2FJvG1zundg701TuVZIlJZ0+8j1xgM0ULsKSvlybG9h
	LrzC121o6RZaY2SlCZXjp8WAoPNww8C8VBBksQuK/y+RpwZbue/ijrl+C/shcBk3mxavBfSNF6jiS
	sqKzsNVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uohUh-0000000DUw3-138t;
	Wed, 20 Aug 2025 12:00:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uohTO-0000000DUPx-0dXy
	for linux-nvme@lists.infradead.org;
	Wed, 20 Aug 2025 11:59:23 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57JNmVsq002165;
	Wed, 20 Aug 2025 11:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RLrlyJ
	FVqbp/Dt5k3svqAxSyaPQX866KxjUKzdPqOBA=; b=mlUFZcDjvYXjZbh6zOl1QN
	KNMLCdVe10cptZOMTH8cCGEfN5c5uegmz1J8XZiRScTZcEVqDXcfH/8T9SMrgQI5
	LfAvfhohqYRbAh/0RKONoOxsRgqtaw+16BBw/5kYwlZMrIHd8iT7sWY38ydW4SUk
	rvffEhd6dS5yQO8OozQurmfPtD4HSIcXbFObPTa5Cm8veIBna8rfXm/VDn9lpRcg
	rdhqthctedMKBtUC2ssWhX4gPMaBNbp9VtHwmsQCyoARjF6pnQOP2JPUIOOk68cU
	pscuWsT4UErRJUdG9C1YfHhbf9HLr2XC2VXy0fOrWkUxgU/brBm/QjRTgMFPUd1A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38w2kqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 11:59:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57K9cXnL027192;
	Wed, 20 Aug 2025 11:59:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my4w34dp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 11:59:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57KBxFFk63373674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 11:59:15 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA34558053;
	Wed, 20 Aug 2025 11:59:15 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD20558043;
	Wed, 20 Aug 2025 11:59:13 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 Aug 2025 11:59:13 +0000 (GMT)
Message-ID: <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
Date: Wed, 20 Aug 2025 17:29:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
 <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfX2iaDZrfKEgQI
 GP7Q9ZdPH9/K9LPpvcP5HmrSlv5J4phRZdKcA6QzNxBOiiPP6gCFGslmhn+IDh4YafDHqo31piu
 7Y/8v3ppBBbYKhI9Pv5sP0M38ahRr2QqY94qPu1HMSOaOk+31UhIMb3Qi83T9uk5x98EJys55mb
 Xr3OJ9FsgR7RC+k8U16Fn84Br+Afc1e/kENGRFAOfViupsDdS0AV4tTwy94OPLzmCjA/iRPrhow
 Bw8bmHZMi2+oH5IywmRqMnDuUVeg4on2ozu6hAWGProlck1lZf0kf2Tgh4IMlwg86pYGnhXIP4c
 LYA1m1yDKf7UoUaWs4j2fHMFUn99vGvd+RKRvoQHNcyWw330GgYFIAuPasuQR5hsqOsqyO+mVp9
 PRVuZyEB31mKHvvZrhzySX5yqjz1YA==
X-Authority-Analysis: v=2.4 cv=H62CA+Yi c=1 sm=1 tr=0 ts=68a5b894 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=i_-IQU-Y-YdxHXwAEK4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6enLnWcQmt97YRlOd2etGL9Abhsb5f8j
X-Proofpoint-GUID: 6enLnWcQmt97YRlOd2etGL9Abhsb5f8j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250820_045922_306984_3EBB357F 
X-CRM114-Status: GOOD (  24.19  )
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



On 8/20/25 2:00 PM, Hannes Reinecke wrote:
> On 8/20/25 10:17, Daniel Wagner wrote:
>> On Tue, Aug 19, 2025 at 08:15:09AM +0200, Hannes Reinecke wrote:
>>>> Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
>>>> is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
>>>> And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
>>>> I'll update this in the next patch.
>>>>
>>> Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
>>> the number of fields will be different (and making parsing harder).
>>
>> What type of parser do you mean, a carbon based one or a computer? I
>> strongly recommend to use the JSON output for the later.
>>
>> I would really prefer that the default stdout is easy for a human to
>> read not screen scrappers.
>>
> That was my intention, too. And my prime objection was to have a
> sequence of raw numbers, and requiring the user to figure out what
> these numbers are for.
> 
Yes, you are right — those sequences of raw numbers did look confusing,
and that’s why Daniel suggested adding annotations. However, I found it
difficult to annotate the numbers in the tree-style output of show-topology.
To address this, we decided to also support printing topology in a tabular
format, which is much easier for humans to interpret.

As you can see in the last patch of this series (4/4), we now support showing
the topology in a tabular format (when the user selects it). For reference:

# ./nvme show-topology -o tabular 
nvme-subsys1 - NQN=nvmet_subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:779c3f46-2bb7-4e82-8f46-2b3e795e54f6
               iopolicy=numa

NSHead  NSID NSPath    ANAState  Nodes Qdepth Controller TrType Address                                          State 
------- ---- --------- --------- ----- ------ ---------- ------ ------------------------------------------------ ----- 
nvme1n1  1   nvme1c1n1 optimized  0,1     0    nvme1      tcp    traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live  
  -->    1   nvme1c2n1 optimized  2,3     0    nvme2      tcp    traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live  

So as you could see above, this format is much clearer and human-friendly.
(Please note that above table is printed using new table APIs introduced
in patch 3/3).

> But really, I'm not sure if we should print out values from the various
> I/O policies. For NUMA it probably makes sense, but for round-robin and
> queue-depths the values are extremely volatile, so I wonder what benefit
> for the user is here.
> 

I think the qdepth output could still be useful. For example, if I/Os are
queuing up on one path (perhaps because that path is slower), then the Qdepth
value might help indicate something unusual or explain why one path is being
chosen over another.

That said, if we all agree that tools or scripts should ideally rely on JSON
output for parsing, then the tabular output could be simplified further:

- For numa iopolicy: print <Nodes> and exclude <Qdepth>.
- For queue-depth iopolicy: print <Qdepth> and exclude <Nodes>.
- For round-robin iopolicy: exclude both <Nodes> and <Qdepth>.

Does this sound reasonable? Or do we still want to avoid printing 
<Qdepth> even for queue-depth iopolicy?

Thanks,
--Nilay

