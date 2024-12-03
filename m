Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5599AE6C61A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wLwkeAQsTltW20Wd8khMw6/91h1OsI6CRlSb99RAYZc=; b=bIO0Kq3e82ikDf+abNXEjLskZT
	mgEWNwr3hfPLhQ2Sf/rp88vDU5LhSpF3tH+5v7lWkDeA5uqadHGZTTJV/7a5XJ+2uBi/q1DaUr/qW
	f7Q8zkm0LjA1IPYjhvKnzLs8aLM0mT0FsMezsDSWnvrEq9BSK7a1rNFpk4TSHQvl888WNqYW8o3zw
	tLdGL3KichJ18CMl62Ns73hEZRrFomWbut9+UCK/8BhFpCv6543JU9nV5dkpSaZ7fQ4o+xol/urBy
	dJT0QOoRAu3A4eqZFv8H6CDTOxPyhg4pwo7/5ZK/FlGSzHRkuCehfMJ5NwsDnv7LegLY2oRIpZqU9
	DfKo8LQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOr0-00000008noa-1f6v;
	Tue, 03 Dec 2024 09:05:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIOqy-00000008nna-018t
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 09:05:57 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B32EhU0008361;
	Tue, 3 Dec 2024 09:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wLwkeA
	QsTltW20Wd8khMw6/91h1OsI6CRlSb99RAYZc=; b=KDT2BbA/6wx+C2EFV8OgCt
	IaaSyWxmnFNdO7+zc8z1fSIX/oslA9Qbm46McUtHDseajNJMAojZ6jteHpHmpBtE
	SWgIHJGEZ+g3EodvVfUuUHI9D9Fd/jvpApBw8xh48vKobrFAMrxo1xH7XU7LhqQz
	15rdmxQ1WyWPDwhL2D9yvQwIlCU+Bl5frObcLYQG9QfxrWGd+XYxtcho2n2e0Jqw
	a8hdqslSwDScboXapI1aRBWgJcqcNqmk03jGbA6z52BKIezKOUDo43BTptBFYS3I
	TEmLZwPuX/zJORc4amnYcVT47lIpvMTCAZrQ+fDFR86eeN6lgUtuXImxDCHXWV5A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 438kfghtfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:05:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2J53ib005273;
	Tue, 3 Dec 2024 09:05:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 438fr1bp8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 09:05:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B395f234981448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 09:05:41 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E79305805A;
	Tue,  3 Dec 2024 09:05:40 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BB7C58056;
	Tue,  3 Dec 2024 09:05:38 +0000 (GMT)
Received: from [9.109.198.241] (unknown [9.109.198.241])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 09:05:38 +0000 (GMT)
Message-ID: <95a64c51-2a3a-41e3-9c9d-454ec2c04e9d@linux.ibm.com>
Date: Tue, 3 Dec 2024 14:35:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>,
        "gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>,
        "jirong.feng@easystack.cn" <jirong.feng@easystack.cn>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
 <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
 <htfujjbga5xvlmlkv46lncbutqr5b63kvylveewoiqmsern4qz@m7ulmfr3tjp3>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <htfujjbga5xvlmlkv46lncbutqr5b63kvylveewoiqmsern4qz@m7ulmfr3tjp3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kg1GA_quBGmRpRo-zz4VtJta0wzkm7Jt
X-Proofpoint-GUID: kg1GA_quBGmRpRo-zz4VtJta0wzkm7Jt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_010556_061706_16A73941 
X-CRM114-Status: GOOD (  27.19  )
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



On 12/3/24 13:56, Shinichiro Kawasaki wrote:
> CC: Jirong,
> 
> On Dec 03, 2024 / 11:08, Nilay Shroff wrote:
>>
>>
>> On 11/30/24 14:40, Shinichiro Kawasaki wrote:
>>> On Nov 29, 2024 / 13:31, Nilay Shroff wrote:
>>>> Hi,
>>>>
>>>> There're two patches in this series. The first patch is a preparation patch 
>>>> for reusing a common function nvmf_wait_for_ns from multiple nvme test scripts. 
>>>> The second patch adds a new nvme regression[1] test for commit 505363957fad 
>>>> ("nvmet: fix nvme status code when namespace is disabled").
>>>
>>> Hi Nilay, thank your very much for the fix actions. Much appreciated.
>>>
>>> I tried these blktests patches with the kernel just before the commit
>>> 505363957fad, at the git hash 6825bdde4434. I expected the new test case fails,
>>> but it passes. I increased the number of iterations from 10 to 100, but it still
>>> passes. Do you observe the test case failure on your test systems?
>> If you ran blktests at git hash 6825bdde4434 then that doesn't include ns changes 
>> which uses mutex_lock. So it's expected that the test wouldn't fail. Did you try
>> running test using latest upstream kernel or checking out tree at commit 
>> 505363957fad ("nvmet: fix nvme status code when namespace is disabled")?
> 
> Yes, I see the test case creates "BUG: sleeping function called from invalid
> context". Now I see that you added this new test case nvme/055 to recreate the
> BUG. However, I observed the BUG at the first place with nvme/052, which can be
> used to confirm the BUG fixed. So it does not look so meaningful to add the new
> test case.
> 
> I think my report "blktests failures with v6.12 kernel [X]" confused you. I
> wrote "It is desired to have a better fix and the test case to confirm it.", but
> I should have wrote "It is desired to have a better fix and the test case to
> confirm that the fix does not break the intent of the trigger commit
> 505363957fad." Please find the discussion about how to test the fix patch [Y].
> The question was: how to "confirm that the commit 505363957fad achieves its
> purpose" ?.
> 
> [X] https://lore.kernel.org/linux-block/6crydkodszx5vq4ieox3jjpwkxtu7mhbohypy24awlo5w7f4k6@to3dcng24rd4/
> [Y] https://lore.kernel.org/linux-nvme/20241023052042.GB1341@lst.de/
> 
Yeah I read that explanation and I also saw in another discussion[Z] you mentioned, 
it's udev daemon manifesting this kernel BUG. So my initial thought was that relying
on udev to recreate a bug may not be good idea because udev rules could change without 
out control and those rules could be different from one distro to another.. 

Hence I thought about writing a test case so that we could reliably recreate this BUG
without any external dependency...

[Z] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/
> 
> Jirong,
> 
> I found your Tested-by tag for the commit 505363957fad. Could you share how did
> you test the commit? It will help for us to have more confidence on Nilay's
> patch.

Thanks,
--Nilay

