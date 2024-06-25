Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF685C3064D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 06:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TCWZ9MBotSkbYl99ctuLh6W54nsSq/LaktbBC6/0bKE=; b=rQ7pMtgYRS2BUni9at34WSfDPB
	zvHkCHf7cjXS3IO7XUT1jlhlQtmdRESxLZMc9IVsQFUpY2oC7dGsvjl3vEW0PcA9K5XRid82TGNdT
	eJLTcbqJj5CLidZu6ZxV5Q/VLDAZaOCzLmpQjLr3rEdoRwrjQhI2xxMzJF3UbXTfS8h35SL67E0ux
	yCaSU4sIvetiktM0D7w18d0z2EifhNWwCHS4lWSfxaiKvcwvq+mD/B0x3qfXrAEZB9hAgjB1dOphP
	ciCrFimlk7WRzeuskZECsva98CW4uKTkuasbTcRUFeVxCejLyDsl/iopfVUB9J6RvPP0sEg4oRoJK
	pyRityag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLzck-00000001nQA-3vGF;
	Tue, 25 Jun 2024 06:25:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLzci-00000001nLo-18JK
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 06:25:49 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P5ueBL015310;
	Tue, 25 Jun 2024 06:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=T
	CWZ9MBotSkbYl99ctuLh6W54nsSq/LaktbBC6/0bKE=; b=slAMuYQ9VByKb4F72
	LHQ/F7ji7udLSiMVwShbqCXn+p6C96/2Bl/y7fpfbt8YeXBzU+0T40ICRBCBjJIs
	WS5twt78/bQnxXuX5DgadX8PjPWV0Vl+Ci6PTLKT5wWKSJZwT6x1LVzU6dXoAZgc
	zaCbGO2zKvP7zHkm8y22Xz+o5aqv/J1ncSviGhEeIoRe5wykhynwj30Vclc8jh/B
	+MUK/GvvltMVegfyvRvxml43BCaamwFKZS9DVmzyccKTSdDXe7PdzYNOUpRndLLL
	scrB1jNRmi5Gt/E4ua8Ra0FHV1eWiaBe2AXk6zflhBbUaYqUK6Ed99XKfri3kuL2
	0R37g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyqg8r4aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:25:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P5aamd000388;
	Tue, 25 Jun 2024 06:23:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxbn34grt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 06:23:25 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45P6NLce38011616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 06:23:23 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A9175805A;
	Tue, 25 Jun 2024 06:23:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCDC958051;
	Tue, 25 Jun 2024 06:23:18 +0000 (GMT)
Received: from [9.109.198.223] (unknown [9.109.198.223])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 06:23:18 +0000 (GMT)
Message-ID: <6795690a-4352-4f8d-abfd-e686bcd2fb4f@linux.ibm.com>
Date: Tue, 25 Jun 2024 11:53:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nvme-cli] nvme: warn about attaching a namespace to
 unknown controller
To: Keith Busch <kbusch@kernel.org>
Cc: dwagner@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
        sagi@grimberg.me, gjoyce@ibm.com, msmurthy@imap.linux.ibm.com,
        axboe@fb.com
References: <20240620125604.3017138-1-nilay@linux.ibm.com>
 <ZnWXc8wrNR_ijnTH@kbusch-mbp>
 <702e63dd-8fe6-4c23-89fd-7075573bb445@linux.ibm.com>
 <ZnnJyfZDg4xbxYDv@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZnnJyfZDg4xbxYDv@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9eqEyfJ-1YGeaXew7l7fa8gmyXMXTage
X-Proofpoint-GUID: 9eqEyfJ-1YGeaXew7l7fa8gmyXMXTage
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_03,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240624_232548_391742_A373E140 
X-CRM114-Status: GOOD (  33.89  )
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



On 6/25/24 01:02, Keith Busch wrote:
> On Sat, Jun 22, 2024 at 04:05:01PM +0530, Nilay Shroff wrote:
>>
>>
>> On 6/21/24 20:38, Keith Busch wrote:
>>> On Thu, Jun 20, 2024 at 06:25:45PM +0530, Nilay Shroff wrote:
>>>> Sometime it's possible for a multi-controller NVMe disk to have only
>>>> one of its controller discovered by the kernel. And if this happens
>>>> then it's also possible for a user to create and then attach a namespace
>>>> to a controller which has not been discovered by the kernel. In such a
>>>> case the attached namespace can't be used for IO because there's no path
>>>> to reach such namespace from the kernel.
>>>
>>> Isn't that a pretty normal thing to do, though? Like for an sriov
>>> situation, a primary controller attaches namespaces to secondaries, but
>>> not to itself.
>> Yes correct, but in case of sriov, AFAIK, the "nvme list-secondary ...." shall 
>> not list any secondary controller unless the secondary controller's corresponding 
>> VF is enabled (i.e. /sys/class/nvme/nvmeX/device/sriov_numvfs set to at least the 
>> secondary controller's VF number). 
>>
>> So it means that before attaching namespace to secondaries, user would first set 
>> sriov_numvfs. Setting numvfs would then enable the kernel to discover all secondary
>> controllers. 
> 
> You'd usually bind those to vfio, not nvme. So while the kernel knows
> those pci functions exist, the nvme driver doesn't necessarily know
> about these.
> 
> And that's not even an sriov exclusive thing. You can bind other PFs
> just the same, though they just don't have the resource provisioning
> features that VFs can do. But you can still attach and detach namespaces
> to/from them all the same.
>  
>> However, in the proposed patch we're trying to address a case where "nvme list-ctrl ..."
>> shows multiple controller entries however only one of those controllers is discovered
>> by kernel. All controllers shown in the output of "nvme list-ctrl ..." are physical
>> controllers on the nvme disk. In this case attaching a namespace to any of the 
>> undiscovered controller has a side effect due which the namespace rendered unusable.  
> 
> Unusable from the driver the admin ran the command from. Some other
> machine (real or virtual) may be able to use it, or maybe even the same
> machine that you handed some function to a user space driver, and that's
> not really an error.
> 
Ok got it... I didn't know this topology is also supported!

>> This patch tries to address this issue by showing a WARNING to the user and optionally
>> allowing user to cancel the attach operation. However if user still prefers to go 
>> ahead without cancelling the attach operation then nvme-cli would execute this command
>> as usual. 
> 
> Have you received bug reports of people mistakenly attaching namespaces
> to the wrong controller or something?
Not from customer but it was an internally found defect where someone (mistakenly!) 
attached a namespace to a controller which was not discovered by the kernel and that
caused the namespace remains hidden behind undiscovered controller... 

The "nvme list" command would not show up that hidden namespace, and also 
"nvme list-ns <dev>" wouldn't list that namespace. However later I found that 
the only way to list that hidden namespace was to use "nvme list <dev> -a" 
command.

I think, it might be difficult to gauge what's the intent here when user/admin runs 
a command to attach a namespace. If the intent is to attach namespace behind 
controller/VF which might be usable from other (real/virtual) machine then it's OK. 
However if the intent is to use the namespace on the same host machine and using the 
same kernel driver where the command is being executed then there could be an issue. 
Any comment...?

Thanks,
--Nilay 

