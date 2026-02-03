Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748EEE87822
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 12:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZwwmEa03CUZyywUHHwzuYS7UjNPzpgozHSrzQre094I=; b=I8Xj1V+xD+DIVvfJjGGB9rW3+V
	ablmqYwglxmEkBUTp8aurc+LRahGa7dkuzB5+Z1xjTD9ly6TFXIYrK2fnUlcx/JjeZ/0blK4R3DlU
	7UuP8PM0vaZr+cPQu/g/qae4y/DEBpD5rysPIYoPz6qkEBa1x+ddz7vLOHiC4Wzfv45wRvBGTU3qS
	TIShMO7V9di+bPGuvIxQ3RHpYyGCEqLnZOHlc6OfcXLqKC62vBoSC2+blAFiIookxwIkwm5nnDtOn
	yThSsjxIn5BOldBjPhy8yorgmTwR7yI3K8ZS6gGZF3cU/8oTxGCK/Tq4pCq9dcReEW8Vxz1RfxgGN
	pJvmWZMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnFNN-00000006aaN-02Pm;
	Tue, 03 Feb 2026 12:19:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnFNK-00000006aa1-1FF3
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 12:19:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6130GcMJ028582;
	Tue, 3 Feb 2026 12:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZwwmEa
	03CUZyywUHHwzuYS7UjNPzpgozHSrzQre094I=; b=eKgp6HpIb2pdd3vVGSkOx6
	VBfQV6uH8q5Q7bHwHYhAA1UrT5NLt0aGEwvqSKEVkWT//BCj53bNgI+o4SouNlp6
	i1oCcLq8QsAVpwYJw4hVKOQXEcT5uC4IQlVkeOLYzGJRDO2F4/Adr7w8N1JRpewT
	7cXOGJFQe1I6TVlKmglr4snKUnujzf6ZwVjcXp+BeJiH2xVCIzNjCvIqcv0k+k0x
	xGPSi3phu9ejo6C8Kc0Vt5x2j/Kni9Vq4jZa7cQPX4O0kWYCHSik3fxGKrukALaS
	TrAEXgzkdVe7MiSpzsLgB1J6C1FMH4fTov33JC4nZR/ApX8DOAKe5fCQa5KYfQqg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c1986d96p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 12:19:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 613AvOri025700;
	Tue, 3 Feb 2026 12:19:17 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2ms21p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 12:19:17 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 613CJH3N23921352
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 12:19:17 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35DBD58059;
	Tue,  3 Feb 2026 12:19:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDBAA58058;
	Tue,  3 Feb 2026 12:19:14 +0000 (GMT)
Received: from [9.111.10.240] (unknown [9.111.10.240])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 12:19:14 +0000 (GMT)
Message-ID: <10428c95-2023-466b-ad1a-4b190bc402a1@linux.ibm.com>
Date: Tue, 3 Feb 2026 17:49:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM?BFP TOPIC] Block-layer device resets
To: Hannes Reinecke <hare@suse.de>, Damien Le Moal <dlemoal@kernel.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <50ee77fa-0c44-422e-9ee2-eece60b189e1@suse.de>
 <7ec5f552-197f-48be-9898-9cc4233783fc@kernel.org>
 <2594023b-b1a5-4752-bb4b-73a4fce4ef5d@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <2594023b-b1a5-4752-bb4b-73a4fce4ef5d@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA5NCBTYWx0ZWRfX71UBOaHoifbW
 vfdaLIgcfUOORBRbZSlJPxulUZMhl13Cjgl7NyR9exfIkbn6/kRy5Rbdn420T65/I/F5rwhJMUx
 WCuB7jneWGAOBC66TppwQFavI+oT7bhjLN/olT21WhlvkXNydk+3Gsz5tuDJtnsjGXU1A2S+54l
 OvpyFl7XeMKX200TN1gF5TQWtz+oBvVw4JzLi4nA/k/oO93b4Gr/GKKR0r1vweoNmebrQ9p1T1N
 gAUgcdDAHUxlM31nPa/1FWksyRq3g7aRtl+EaDZDnEiSukeld8g6N0kfb7EzO00J2LclHxiFCpV
 Voe9ZUMApNjyJXVsetHpxVOGJHPjHhhdAg5lOocvlkFk4O4lfZxOENh1OatRwdfwvwLmaqW1xok
 cVODxkXwZ5LpMWPc78y1HVsPSTRk11NpEZ+Eb18LJetm7mdlSeXQOxRk6qHhLNjGXYQcGgMjuWx
 oovXTo+8XXYxKZHPIsw==
X-Proofpoint-GUID: gF4zFd5UD7hys2SEoJ3-aS50wHX9ZvkV
X-Authority-Analysis: v=2.4 cv=DbAaa/tW c=1 sm=1 tr=0 ts=6981e7c7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=hV3ytQWAjLcP9wIvwFgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gF4zFd5UD7hys2SEoJ3-aS50wHX9ZvkV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260203_041922_371118_43FCBD8B 
X-CRM114-Status: GOOD (  22.35  )
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



On 2/3/26 4:34 AM, Hannes Reinecke wrote:
> On 2/2/26 02:46, Damien Le Moal wrote:
>> On 2/2/26 02:06, Hannes Reinecke wrote:
>>> Hi all,
>>>
>>> We are currently working on implementing cross-controller resets for
>>> NVMe, which requires to send a command to the target which then should
>>> terminate all commands on a given controller.
>>> While we could easily terminate the controller, the specification
>>> also requires us to terminate all outstanding commands.
>>> Which then recurses into my all-time favourite topic on how to
>>> abort outstanding commands from the fs/bio layer.
>>>
>>> However, here we don't have to dissect/match to individual commands,
>>> but rather have to abort everything, which seems rather easier.s
>>>
>>> So I would like to fathom whether such a thing is feasible/reasonable
>>> (I think so, obviously, and can think of several other use-cases, too,
>>> qemu springs to mind here ...) and discuss possible implementations
>>> (set 'req->deadline' to zero for all pending commands?).
>>> Or maybe we can do such a thing already and I'm just not aware of it...
>>
>> Hmmm... Command timeouts ? E.g. if a controller is slow to respond (send
>> completions), the block layer timeout timer may trigger, which will call into
>> the low level device driver to force a reset. But before the reset actually
>> happens, completions may actually come back, and we do handle that race
>> correctly, well at least for scsi/ata.
>>
>> Your scenario sound very similar to this: once you reset the controller,
>> whatever was pending will be silent and can be aborted or retried. So it does
>> sound like that should not be too difficult, no ? Generalize the timeout
>> processing or do something similar ?
>>
> The good thing is we don't even need to generalize anything. It should
> should be sufficient to walk the inflight requests and set
> 'rq->deadline' to 'jiffies'. General idea here is to just _initiate_
> command termination with this, one then still has to wait for all
> commands to complete, but at least now there is a reasonable chance
> that this will happen quickly.
Well if the request which is being terminated this way happens to be admin
command then it may cause the controller reset. The issue with this approach
is that we're artificially inducing the timeout (instead of actually issuing
abort) and NVMe driver timeout handler assumes the admin command timeout is
fatal and it resets the controller. 

IMO, conceptually, the goal here is not to force a timeout but to explicitly
abort all outstanding commands as required by the NVMe cross-controller reset
semantics. So combining these two (timeout and abort) mechanisms makes the intent
unclear and coupling abort semantics to timeout handling makes it fragile. 

So from this perspective, it would be cleaner to have an explicit blk-mq callback
for aborting all outstanding requests. The block layer would invoke this callback,
and each driver could implement the abort logic according to its own requirements
and specification constraints. For NVMe, this shall allow us to abort in-flight
commands without overloading the timeout path or triggering unintended controller
resets, any thoughts?

Thanks,
--Nilay


