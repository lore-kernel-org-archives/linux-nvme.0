Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF85CA1007
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Sep 2025 04:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQU6ctnCNbUfR9na/8DSINvS0jXpc/LKAzEOiCtx+/I=; b=2L1n/Ug/ad7hZiDhJF41AkpSkI
	zwl7I2pfsJC63Vz7ACK7S9kH70jPfYpFkV2rxcDGjTGqzHl4CZ10soWe87W1FGa36CEs5X1fOil0D
	6BphI5iWtvxJ5u8bSNuPplLPtx7pMfeN2SDjPhYGQ55CdmUQhCPPjCe0V3a1t0CoLDQfgWZH+glaf
	eZ/8LMJ2E4ulu93zUV/Czi3h70o1YdOZkJLiI7BVkAuM+3eHKAhMP/ST17vNkRiOtQA4DJcG2dY79
	EXF5jgPbHd87q8fx8LBrwHKxVw/EaYahIr7Hnvgcl3hVdMvTQHdf36X7k/OZbNrU0uuzAti/iyBGf
	CCvshGGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utf2Q-00000003pP4-2Xvg;
	Wed, 03 Sep 2025 04:24:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utf0o-00000003oqq-2eQF
	for linux-nvme@lists.infradead.org;
	Wed, 03 Sep 2025 04:22:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582JQCHb019646;
	Wed, 3 Sep 2025 04:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GQU6ct
	nCNbUfR9na/8DSINvS0jXpc/LKAzEOiCtx+/I=; b=SuSmgGqAC7rw4auyQH4xPM
	s0w7ruYhhaJEeuBbwXbjNXHXDK2quMxaeN9tGj711fC1dhWinbOb3VQ/w5WVUXFr
	pQoBhxSLMYLFxHQrrZm7CofqrHYioevGC7WE7K/ynrcCzClyJpEyxhlgMlddrX57
	AcbdsJnCPh7OXB6jxGUp2p+qXc6w24HMZNlaSEMI4ilarHfPlwHqM5396oOV8Oq8
	AoQcylvWrOf6SauNsrtplunDZXtr7lfrkFOmaFkd/XMu1Nyva2rI1c72nv9DKC4v
	ZCLTzubcLW15SYr1xNX6TlkzIosyNWORSGlj9tRBxPeaVgd2lMMvgh4aT38WzVQQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usv3235d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:22:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5831Rwop021202;
	Wed, 3 Sep 2025 04:22:17 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpnqd1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Sep 2025 04:22:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5834MHPW29819512
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Sep 2025 04:22:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E38D058061;
	Wed,  3 Sep 2025 04:22:16 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC41058057;
	Wed,  3 Sep 2025 04:22:14 +0000 (GMT)
Received: from [9.43.126.99] (unknown [9.43.126.99])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Sep 2025 04:22:14 +0000 (GMT)
Message-ID: <d904e2bf-1b59-4511-998d-f53249137428@linux.ibm.com>
Date: Wed, 3 Sep 2025 09:52:13 +0530
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
 <180fd47e-ffe6-4ef1-986e-5885afc34c01@linux.ibm.com>
 <8de91a15-3d89-4801-911a-00e45bb6a2f1@linux.ibm.com>
 <2eeba3ca-293c-429b-8afa-c5ba401c67b6@flourine.local>
 <ee0d329a-334b-429c-a916-f03c64bbb323@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ee0d329a-334b-429c-a916-f03c64bbb323@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y_mAHaQHHmk5_pINpVuLEQ7w4zwFSSeV
X-Authority-Analysis: v=2.4 cv=FPMbx/os c=1 sm=1 tr=0 ts=68b7c27a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=NEAV23lmAAAA:8 a=DME0puPfNGmfh3VUhp4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y_mAHaQHHmk5_pINpVuLEQ7w4zwFSSeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX6tFHlj1QmVUw
 3RinFF7vO5HB95EmtN6zZfGpTHzKLX0WnSFWwoj/3skKbKAo2Uw9Umm8xDzkMFrayTI3TBDldyL
 5Q1ftcbmbcxkaMtVg1S1MczLOaKR+TIg4NGKRoW/Hdn0oUh90oB+7TfFK8+AWKPOCc1gWKQeXrw
 Aw2CTuEgPc0HzHVyU6X129aCF9pMiAp/SR/GtH6J5VjlusY97N6cSyt8ggS7Q6Av8IOMxJoap4s
 h9kkaITP2NssJsLVyi5uAdID/GKNlCXvZhYvPsTr/JJun3juvko8lmaoHA1WJTp/ry73pVOVjOV
 Ac3B2VDzAGgyOslKC78/oclGhwz4qZXHRu6jXBIzc8VyhTzfBnlwPYyzJH/JtDIB0NKnTwIZVgt
 Ah6ves58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_212222_693852_AE878F80 
X-CRM114-Status: GOOD (  31.30  )
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



On 9/2/25 11:56 AM, Hannes Reinecke wrote:
> On 9/1/25 18:36, Daniel Wagner wrote:
>> Hi Nilay,
>>
>> On Mon, Sep 01, 2025 at 02:51:09PM +0530, Nilay Shroff wrote:
>>> Hi Daniel and Hannes,
>>>
>>> Just a gentle ping on this one...
>>>
>>> Do you agree with the reasoning I suggested for filtering
>>> columns based on iopolicy? If we all have agreement then
>>> I'd send out the next patchset with appropriate change.
>>
>> I was waiting for Hannes input here as he was in discussion.
>>
> Yeah, and he is fine with the latest changes. Probably should've been
> a bit more vocal about it :-)
> 
>>>>> But really, I'm not sure if we should print out values from the various
>>>>> I/O policies. For NUMA it probably makes sense, but for round-robin and
>>>>> queue-depths the values are extremely volatile, so I wonder what benefit
>>>>> for the user is here.
>>>>>
>>>>
>>>> I think the qdepth output could still be useful. For example, if I/Os are
>>>> queuing up on one path (perhaps because that path is slower), then the Qdepth
>>>> value might help indicate something unusual or explain why one path is being
>>>> chosen over another.
>>>>
>>>> That said, if we all agree that tools or scripts should ideally rely on JSON
>>>> output for parsing, then the tabular output could be simplified further:
>>>>
>>>> - For numa iopolicy: print <Nodes> and exclude <Qdepth>.
>>>> - For queue-depth iopolicy: print <Qdepth> and exclude <Nodes>.
>>>> - For round-robin iopolicy: exclude both <Nodes> and <Qdepth>.
>>
>> Looks reasonable to me.
>>
> Yep, that's fine.
> 
>>>> Does this sound reasonable? Or do we still want to avoid printing
>>>> <Qdepth> even for queue-depth iopolicy?
>>
>> I am fine with printing the qdepth value as long it is documented what it
>> means. IIRC there are other tools which just show a snapshot for some
>> statistics.
>>
>> BTW, some discussion on github regarding something like a
>> 'monitor' feature: https://github.com/linux-nvme/nvme-cli/issues/2189
>> Might be something to which could be considered here as well.
>> Well, that might be tricky. The current 'tree' structure is build
> once when the program starts up. Any changes to that structure after
> that are not tracked, and there (currently) are no hooks for updating
> it. So having a 'monitor' function will get tricky.
> 
> To do that we would either need a udev event receiver (using uevents
> to update the tree structure) or looking into fanotify()/inotify().
> Then the tree structure would always be up-to-date and things like
> 'monitor' will be possible.
> Will be hell for the python bindings, mind :-(
> 
Thanks, that explanation helps. I see the difference — today nvme-cli
just builds the tree once and prints a snapshot, so volatile values like
Qdepth are inherently a “point in time” view. A monitor-style feature would
instead keep the tree live and update it as ANA state, path health, or qdepth
change (probably similar to how iostat or top refresh continuously). That
definitely makes sense for those kinds of fields, though as you say it would
require new hooks (udev/inotify) and rework of the in-memory tree handling.

For this patchset, I’d prefer to keep the scope limited and just filter the
tabular output based on iopolicy (NUMA -> Nodes, qdepth -> Qdepth, RR -> none).
That way the snapshot view stays useful. 

Having said that, the “monitor” idea seems worth pursuing separately as a
longer-term feature. For users who want a live view today, they can already
run something like "watch -n1 nvme show-topology ..." to refresh the snapshot
every second. A built-in --monitor feature would be nicer and more efficient,
but I think that’s orthogonal and can be discussed separately. And I believe
"minitor" feature shall be useful as well for implementing nvme-top command
(as I recall we (me and Daniel) discussed it during LSFM-2025). 

Thanks,
--Nilay

