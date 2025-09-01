Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4823CA0FFD
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Sep 2025 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VWY9Ep3AemUxgOmyA9Z3FA3cymUK7UD7MwsnUhn/Eq0=; b=weLwZaVRAG3vyCsNCn3NPQIHGb
	7QyQTs5ywvOALpeuicAEnYUZq3MwkB5etoV9AavgKWWwpBbFtZFYe0N5V/Ud8X7e6h2wEJr5vD3bj
	mfg3YLcyDQl+D//blhWYJjWC61BcXrxRVVHvbah3lNSB27qV1tx62sPMXRi3vBXMG+aAohf7iPEWL
	I6ZBYjYU03rPTfpc0JJ6DC4RLR/pRVHwooitApvZNJTBP0BKr0MSQ3HXwYng50uVpxM/QcR7GADdw
	7VRA8LGG3M/iZnh/6u2YMMqVGGfPHEl2w3TwfcpTAJMtKCWPhSZNCRRLqETdoZ1/WLZGx9l00DMHG
	iTXTolEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut1mQ-0000000BuPm-42tL;
	Mon, 01 Sep 2025 10:28:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ut0j6-0000000BjbS-2F8o
	for linux-nvme@lists.infradead.org;
	Mon, 01 Sep 2025 09:21:25 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5819IqOi028398;
	Mon, 1 Sep 2025 09:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VWY9Ep
	3AemUxgOmyA9Z3FA3cymUK7UD7MwsnUhn/Eq0=; b=IaCrNJ3qJsfRsgLykZvt2K
	zPlNAwaf/JLE4S3BbpiJt9pKALnoriyXWRE7Gax63Ebeb5OXOwDUKEnx2pfj9fAI
	9FFCrzbSrnQd9f4RirunDM2ldQSWdsCsRugInFjNjVkTEh8Wfe/7ZmPRbs+Jm+eQ
	YB/pmiDZz2qTOlBbMBsi+ZPOhLc/AHV1tU9pBZINi52FwnKYz83Aey336aYlh1mA
	Z9qlI6jznIo3oN1Ct3lPvxcCXibvOpOTVzDUHnMJ1YjmzRbtnZnDwV7hc8zX+2ht
	RKEXw0SKBWPOzGDU0nZBIrD1TPdOke3iaPT1J7dzg6hrHfP1JnSB+/n94LpaqF0w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usu9qydd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 09:21:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5818eWWE019926;
	Mon, 1 Sep 2025 09:21:14 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmtwe62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Sep 2025 09:21:14 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5819LDLW26608266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Sep 2025 09:21:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 99C7F5805E;
	Mon,  1 Sep 2025 09:21:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B09D15805C;
	Mon,  1 Sep 2025 09:21:11 +0000 (GMT)
Received: from [9.109.198.214] (unknown [9.109.198.214])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Sep 2025 09:21:11 +0000 (GMT)
Message-ID: <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
Date: Mon, 1 Sep 2025 14:51:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] nvme: extend show-topology command to add support
 for multipath
From: Nilay Shroff <nilay@linux.ibm.com>
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250812125614.164445-1-nilay@linux.ibm.com>
 <20250812125614.164445-3-nilay@linux.ibm.com>
 <93be5b21-8897-44d3-a590-42ba8f1b6abb@suse.de>
 <a06660fb-821f-447e-9ea6-ef0f3372a844@linux.ibm.com>
 <ecd33303-830d-4e26-b49a-14a558725e67@suse.de>
 <4f504c94-e6da-4a33-aa12-9dcb447e7021@flourine.local>
 <4e20561b-8b51-45c5-ad83-24b3d7ae092d@suse.de>
 <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Y8ELy93ux4GzBRKF5-A9lXz9OIQ5tF-c
X-Authority-Analysis: v=2.4 cv=U6uSDfru c=1 sm=1 tr=0 ts=68b5658b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=2J7IuT7wAAAA:8 a=df6Uu-Y5KN19nuECXEYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=RtgRkGnnZwJf8nmJIBi8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX+zqdfZWRp1Zw
 6mr7b74ynHnXBoeoAzpWCjlZDZTr2nvSlDAO5zfN0BMvsL0Lf6IP/IwApH1Cllnck0I3Mk7gq4u
 t5fCyyiym8xydKAYPPDHtWt3Ro5xysOkEcEjl3lT+gcP9TMh9nLD+idwKB9jt0bYZQWpJ3AIV1l
 lY55UViDo9ntwed6Vbi9b/kDF2IBq6faadPte07o7dx/gMY0ItPh2O7wb64v7MBFKdjfnf8RZVY
 1By3qkoUAhEwXCGoNq2LfXPrX+Kkh5snJhcILS0gaP/k9DZorGRHWqg0IzbqbhyREuX9JZNIWCP
 4jJaXwZNXdBfR2VLztPl+uZj7AT8GbKt2uZnMmrWFCRZz8QUL8w2qo09qkx6FEN63oIBcDen2P4
 2zmmzArC
X-Proofpoint-ORIG-GUID: Y8ELy93ux4GzBRKF5-A9lXz9OIQ5tF-c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_022124_691714_23A82083 
X-CRM114-Status: GOOD (  32.49  )
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

Hi Daniel and Hannes,

Just a gentle ping on this one...

Do you agree with the reasoning I suggested for filtering
columns based on iopolicy? If we all have agreement then
I'd send out the next patchset with appropriate change.

Thanks,
--Nilay

On 8/20/25 5:29 PM, Nilay Shroff wrote:
> 
> 
> On 8/20/25 2:00 PM, Hannes Reinecke wrote:
>> On 8/20/25 10:17, Daniel Wagner wrote:
>>> On Tue, Aug 19, 2025 at 08:15:09AM +0200, Hannes Reinecke wrote:
>>>>> Okay makes sense, so we'd print <numa-node> and exclude <queue-depth> if iopolicy
>>>>> is numa. For 'queue-depth' iopolicy, we'd print <queue-depth> and exclude <numa-node>.
>>>>> And for 'round-robin' iopolicy, we'd neither print <numa-node> nor <queue-depth>.
>>>>> I'll update this in the next patch.
>>>>>
>>>> Hmm. I'd rather have _some_ value for 'round-robin', too, as otherwise
>>>> the number of fields will be different (and making parsing harder).
>>>
>>> What type of parser do you mean, a carbon based one or a computer? I
>>> strongly recommend to use the JSON output for the later.
>>>
>>> I would really prefer that the default stdout is easy for a human to
>>> read not screen scrappers.
>>>
>> That was my intention, too. And my prime objection was to have a
>> sequence of raw numbers, and requiring the user to figure out what
>> these numbers are for.
>>
> Yes, you are right — those sequences of raw numbers did look confusing,
> and that’s why Daniel suggested adding annotations. However, I found it
> difficult to annotate the numbers in the tree-style output of show-topology.
> To address this, we decided to also support printing topology in a tabular
> format, which is much easier for humans to interpret.
> 
> As you can see in the last patch of this series (4/4), we now support showing
> the topology in a tabular format (when the user selects it). For reference:
> 
> # ./nvme show-topology -o tabular 
> nvme-subsys1 - NQN=nvmet_subsystem
>                hostnqn=nqn.2014-08.org.nvmexpress:uuid:779c3f46-2bb7-4e82-8f46-2b3e795e54f6
>                iopolicy=numa
> 
> NSHead  NSID NSPath    ANAState  Nodes Qdepth Controller TrType Address                                          State 
> ------- ---- --------- --------- ----- ------ ---------- ------ ------------------------------------------------ ----- 
> nvme1n1  1   nvme1c1n1 optimized  0,1     0    nvme1      tcp    traddr=127.0.0.2,trsvcid=4460,src_addr=127.0.0.1 live  
>   -->    1   nvme1c2n1 optimized  2,3     0    nvme2      tcp    traddr=127.0.0.3,trsvcid=4460,src_addr=127.0.0.1 live  
> 
> So as you could see above, this format is much clearer and human-friendly.
> (Please note that above table is printed using new table APIs introduced
> in patch 3/3).
> 
>> But really, I'm not sure if we should print out values from the various
>> I/O policies. For NUMA it probably makes sense, but for round-robin and
>> queue-depths the values are extremely volatile, so I wonder what benefit
>> for the user is here.
>>
> 
> I think the qdepth output could still be useful. For example, if I/Os are
> queuing up on one path (perhaps because that path is slower), then the Qdepth
> value might help indicate something unusual or explain why one path is being
> chosen over another.
> 
> That said, if we all agree that tools or scripts should ideally rely on JSON
> output for parsing, then the tabular output could be simplified further:
> 
> - For numa iopolicy: print <Nodes> and exclude <Qdepth>.
> - For queue-depth iopolicy: print <Qdepth> and exclude <Nodes>.
> - For round-robin iopolicy: exclude both <Nodes> and <Qdepth>.
> 
> Does this sound reasonable? Or do we still want to avoid printing 
> <Qdepth> even for queue-depth iopolicy?
> 
> Thanks,
> --Nilay


