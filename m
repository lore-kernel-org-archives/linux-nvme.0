Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846EFC28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 15:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSN6klQU3Lfa89SnGqZVCjQNXAaPadcQkryGW51WD28=; b=Ne9cJTcDIMXSlrv89/jJAc8ho5
	h0rjoKouGSFWbvcK3RTbeU3A6LwW3ezlN8hu6lOL3lfD31nuQ44zOktO3htfmRB928SryVblABQQt
	2M2hvXuBrEqeYaZHfFTooGBfrYUPcOHYSEh3BrRexFKSQPKHaU7YMr+Yi3l8z0d/qoFSmm+XR8wzM
	fm/fm9do3ZXG0OwCXKOGrCUs3IaPZtrmReeqo0x+Om0+04iHrmuGXYHuA3ejOi4dmjH7dsJLmMr7E
	ErNvjKk8Wa1NLmz5eftOzPVm9ZSkSxXDzFigG3cmvlGSKSIwrp/kRlPj8aRsnQYBH4lgoV2YVGESk
	HXUkNPxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNzI-00000008roG-3UtY;
	Wed, 12 Mar 2025 15:27:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tsNzG-00000008rnp-3z7A
	for linux-nvme@lists.infradead.org;
	Wed, 12 Mar 2025 15:27:16 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCdpoA002855;
	Wed, 12 Mar 2025 15:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SSN6kl
	QU3Lfa89SnGqZVCjQNXAaPadcQkryGW51WD28=; b=LNPHEaG9CCLUyol0cYsSf1
	Vjd7HHc1x/ZgFemjUnLqhwEw69ieadVX1w7tSxO84w1KLnjMGc1Wb7Po1cAtZ9mG
	+33hdKrPrBbQp+tiZjIfzbgYssyCzkILHE8Ye2KCTpJqoekGYF6ExEIOc7A3ueX2
	GZ1AH5OOWvzMfFwPicLqbAH1J1KPUju/wvwL56ogm/CcTQsOAk7feTAoak71/Iqa
	QgBbRy3dF9c0QfGbh4KDz8ZZ/LaOFwZ99JdDkZ8/+uRHz5Y5FRlpGoRMv4k/cmmX
	OYQTT7hmogguE/3oQBh0CA6FwpZN7ipeV7Ta2ZiG5OXQ3WJL/R+17DWcXcW2Wj5A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45avbpmps7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:27:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52CDfCRY026099;
	Wed, 12 Mar 2025 15:27:05 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspct10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 15:27:05 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52CFR4QO57868552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 15:27:04 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3244458052;
	Wed, 12 Mar 2025 15:27:04 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 738675805A;
	Wed, 12 Mar 2025 15:27:00 +0000 (GMT)
Received: from [9.61.69.177] (unknown [9.61.69.177])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 15:27:00 +0000 (GMT)
Message-ID: <d7d284ac-a8d1-4f9d-901c-424dccc5a1b1@linux.ibm.com>
Date: Wed, 12 Mar 2025 20:56:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: remove multipath module parameter
To: John Meneghini <jmeneghi@redhat.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>, bmarzins@redhat.com,
        Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
        axboe@kernel.dk, Randy Jennings <randyj@purestorage.com>
References: <Z8hrJ5JVqi7TgFCn@kbusch-mbp> <20250305235119.GB896@lst.de>
 <Z8jk-D3EjEdyBIU5@kbusch-mbp> <20250306000348.GA1233@lst.de>
 <1ffebf60-5672-4cd0-bb5a-934376c16694@suse.de>
 <20250306141837.GA21353@lst.de> <Z8m4vzE36UHWjwep@kbusch-mbp>
 <20250306151654.GA22810@lst.de> <Z8pB9jQALxMN6WaA@kbusch-mbp>
 <b2c9df64-0afc-46cd-9e8d-6a3f41a4f1c7@linux.ibm.com>
 <Z8sUB2bbbMsurZmu@kbusch-mbp>
 <69cdaf9d-2fb4-4ee0-9c32-cc946405a23a@linux.ibm.com>
 <01d799d1-fc93-4285-aa8f-89ac2d01478b@redhat.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <01d799d1-fc93-4285-aa8f-89ac2d01478b@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r6vJbcw2bvB4WlR3SZtMe9f1qxIekOde
X-Proofpoint-GUID: r6vJbcw2bvB4WlR3SZtMe9f1qxIekOde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_082715_115183_CEDC32E6 
X-CRM114-Status: GOOD (  23.69  )
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



On 3/12/25 9:17 AM, John Meneghini wrote:
> On 3/9/25 1:23 PM, Nilay Shroff wrote:
>>> It honestly has potential to solve some real problems, like
>>> re-enumeration triggered by a link reset on an in-use drive. You'd
>>> currently need to close the old handle and open a new on, even though
>>> it's the same device. It may not even be possible to do that if that
>>> device contains your root partition, and then you can only power cycle.
>>>
>>> The downside is we wouldn't get the short cut to blk_mq_submit_bio. We'd
>>> instead stack that atop an indirect call, so it's not free.
>>>
>> Yes agreed however it seems advantages of using an indirect call outweighs
>> using the short cut to blk_mq_submit_bio. Moreover it seems the cost of
>> indirect call is trivial because we already cache the nexthop.
>>
>> I integrated your proposed patch (with few trivial additional changes on top)
>> and I see that it's coming out nicely. I ran few tests and confirmed it's
>> working well. However, in the proposed patch we*always* delay (~10 sec) the
> Have you tested this with a NVMe-oF controller... yet?
Not on real target. But tested it against blktests which has few NVMeOF 
test cases though it uses loopback interface.
> 
> Where did the number 10 seconds come from?
That was probably used as hard coded value for POC. However, we shall be able to
configure that.
> 
>> removal of multipath head node. That means that even while removing the
>> nvme module (rmmod nvme) or if user delete/detache the namespace, we delay
>> the removal of head node but that may not be what we want. So I'd suggest
>> instead, delayed removal of multipath head not shall be configurable using a
>> sysfs attribute. With this attribute then we shall let user opt for pinning
>> the head node (with optional delayed time as well?). And it's only when user
> 
> So be aware the TP-4129 is adding a CQT parameter which does almost exactly this.
> 
>> shows the intent to pin the node we should delay its removal. This is what
>> exactly (pinning of head node) Christoph's proposed patch implements. So I'd
>> suggest a bit of amalgamation of yours as well as Christoph patch to implement
>> this change.
> 
> Please cc: me on your patches Nilay, I'd like to test them with my NVMe-oF testbed.
> 
Sure, I will keep you in Cc when I send the patch. 

Thanks,
--Nilay


