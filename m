Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67198C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Aug 2024 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cg/bndupk50rnRSsxm4uXdUIHZrNSZ5AzvafipUGmz8=; b=tSFbPNxVfA9/Ly3eyZafFHixd1
	VGk9NyLoOp2bUIWJLWGz0OjXMicteRFfW2Rr1I3e63/kLlCJRi/NPRk2fQwmYj9k42NDrU0hSC+vY
	Z2Xt6BEInLSL6NkF8jz1Bfj9b+YZyAzLA9uX7TsFuiSzfCV4NRNvkWRwzDnPoRj6Vx0o9tXKmXyWe
	avPcGw2Lc45IGMii6/xkaA6y+GU2aKpo7rNsAh0oiaKZ0xRNrj44iMPOGD3LtN6opdD9a2a41zWk7
	HAqpB49/dwe9HvczC0iFLHIuDgZsVEbdFkKpjdy0RL8tHGE3st4jSbN0yx0MzsM8PWHWocA8CC/hM
	bWpSh5eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZvTW-00000009WKw-2BGJ;
	Fri, 02 Aug 2024 16:49:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZvTI-00000009WI9-1V66
	for linux-nvme@lists.infradead.org;
	Fri, 02 Aug 2024 16:49:43 +0000
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 472FTBA7011799;
	Fri, 2 Aug 2024 16:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	cg/bndupk50rnRSsxm4uXdUIHZrNSZ5AzvafipUGmz8=; b=nbwlj3xPgqLjq4hn
	BiMRfwpOq2AnIqP8YUvW+A7E9apEy/G92t3teOEmJ7tok9sCwLwRLaEY8mxlknSA
	PeWIEjCoKgyx8L2LizMomvysWqlDZbIyz2Cb7nXIYIdeoCJLJJfT/3lqnMQmu1fh
	4KGUTtA71ymfWwgSFLExdrDtrQJbxcpBLptN/JIkHUt4Mft0NqwGZkDZfVTQCJJS
	nWbR1nuBIGYB27uucrrRlap9wiHjgs/pP66WoJYUBuZOg/eanxLxijXrUpItt7nK
	/dtdR1GBDuUx4zXimMChvduXm42l5AyGY3rTrd/Auaqtjq19uDIxOK2fl6t+kxEo
	8gZN/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s1pf07d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 16:49:37 +0000 (GMT)
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 472Gnbuk018859;
	Fri, 2 Aug 2024 16:49:37 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40s1pf07d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 16:49:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 472DmSUY029103;
	Fri, 2 Aug 2024 16:49:36 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm18a24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Aug 2024 16:49:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 472GnYmA16974424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Aug 2024 16:49:36 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 255C758043;
	Fri,  2 Aug 2024 16:49:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D97758053;
	Fri,  2 Aug 2024 16:49:31 +0000 (GMT)
Received: from [9.171.33.192] (unknown [9.171.33.192])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Aug 2024 16:49:31 +0000 (GMT)
Message-ID: <79a7ec0d-c22d-44cf-a832-13da05a1fcbd@linux.ibm.com>
Date: Fri, 2 Aug 2024 22:19:29 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.11-rc1 kernel
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Yi Zhang <yi.zhang@redhat.com>
References: <5yal5unzvisrvfhhvsqrsqgu4tfbjp2fsrnbuyxioaxjgbojsi@o2arvhebzes3>
 <ab363932-ab3d-49b1-853d-7313f02cce9e@linux.ibm.com>
 <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ljqlgkvhkojsmehqddmeo4dng6l3yaav6le2uslsumfxivluwu@m7lkx3j4mkkw>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tkuW1usVc4_L-ZsXnVMafpq53k4_2E6j
X-Proofpoint-GUID: a115jAe8d2xS4aK9ey4Ffkuh_ApZccBy
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_12,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408020114
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240802_094940_701660_F579D5ED 
X-CRM114-Status: GOOD (  18.35  )
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



On 8/2/24 18:04, Shinichiro Kawasaki wrote:
> CC+: Yi Zhang,
> 
> On Aug 02, 2024 / 17:46, Nilay Shroff wrote:
>>
>>
>> On 8/2/24 14:39, Shinichiro Kawasaki wrote:
>>>
>>> #3: nvme/052 (CKI failure)
>>>
>>>    The CKI project reported that nvme/052 fails occasionally [4].
>>>    This needs further debug effort.
>>>
>>>   nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
>>>       runtime    ...  22.209s
>>>       --- tests/nvme/052.out	2024-07-30 18:38:29.041716566 -0400
>>>       +++ /mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-tests-production.zip/storage/blktests/nvme/nvme-loop/blktests/results/nodev_tr_loop/nvme/052.out.bad	2024-07-30 18:45:35.438067452 -0400
>>>       @@ -1,2 +1,4 @@
>>>        Running nvme/052
>>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>       +cat: /sys/block/nvme1n2/uuid: No such file or directory
>>>        Test complete
>>>
>>>    [4] https://datawarehouse.cki-project.org/kcidb/tests/13669275
>>
>> I just checked the console logs of the nvme/052 and from the logs it's 
>> apparent that all namespaces were created successfully and so it's strange
>> to see that the test couldn't access "/sys/block/nvme1n2/uuid".
> 
> I agree that it's strange. I think the "No such file or directory" error
> happened in _find_nvme_ns(), and it checks existence of the uuid file before
> the cat command. I have no idea why the error happens.
> 
Yes exactly, and these two operations (checking the existence of uuid
and cat command) are not atomic. So the only plausible theory I have at this 
time is "if namespace is deleted after checking the existence of uuid but 
before cat command is executed" then this issue may potentially manifests. 
Furthermore, as you mentioned, this issue is seen on the test machine 
occasionally, so I asked if there's a possibility of simultaneous blktest 
or some other tests running on this system.

Thanks,
--Nilay

