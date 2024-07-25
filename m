Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC16C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jul 2024 06:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AlYLJ8kbGtYo778cIdEsPA500tzKj2/cnzKJ7StpWG4=; b=ANe8YJSl6SomznDo2/TEiBHhfc
	ENsIgc8ji/zgQDN0ZFZc0bsChetohO5QoixH4dlkL8OMA3bNR9qPDyQV04pGUzKHZeWhvEd5MVEQ3
	eg5KeZuMDhoBIYMQEhuNpKXXAMdajsDhEEnUIFIKLfrj/d0rn765alA7mvPR4yiHK/rTc8d3J8us8
	6yF61mOOM0L2J2LkoBmdnPxlOAWrE2yDDJTBfICfcBDEdNLN6nUdLv5gC3CBJigzyCFFfHpvjoGC2
	HYhVxxp/8s9RdMcIvu90X3bxg2pgiCHD9VYbCteEuDln9x1L5V433Pdo8460egPmgI9FqA9/iSFwg
	Cx1rquag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWrqR-0000000Hagj-0ECB;
	Thu, 25 Jul 2024 06:20:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWrqN-0000000HafF-3YIm
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jul 2024 06:20:53 +0000
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P5Pk9G013644;
	Thu, 25 Jul 2024 06:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=A
	lYLJ8kbGtYo778cIdEsPA500tzKj2/cnzKJ7StpWG4=; b=bBNnhoahBZeAKvhH6
	Z9HZZ29nCmCt5cncbKrq1oQxDIpLrHfOWihSJ+DbiApcAW/QA+7ulqlTCrmyHEho
	vQMVrPTyvO13Kbx0JeY1pBkUpdwnxr3FD1M9XmKbJd7U9bixP1js3pQwDzwUrdUF
	Hqo07nISEvmTJQIp6NYupLO9Mpn2g7/pZqVR6q8H42C6cWxCvA7McvAX5XSFVDRH
	eoIPuz/JM4p8cmg8gAeLHPqmP9wgKyVsJzZ65aFr1dfnbqDGllEm6T46iW36N1D3
	Bw0SVskNjV+JHmlm9+0ooOqgEU70c6PxBvznzH2hoB1XiKEPYABCp6kTslrphSdw
	DB2WA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40kg5f04x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 06:20:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46P64dR5006741;
	Thu, 25 Jul 2024 06:20:40 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40gxn7m8wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jul 2024 06:20:40 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46P6Kb9c34210360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 06:20:39 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6336758058;
	Thu, 25 Jul 2024 06:20:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5673358065;
	Thu, 25 Jul 2024 06:20:35 +0000 (GMT)
Received: from [9.109.198.186] (unknown [9.109.198.186])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Jul 2024 06:20:35 +0000 (GMT)
Message-ID: <ee820e6d-8667-4ba5-b8b2-b936a29f1a18@linux.ibm.com>
Date: Thu, 25 Jul 2024 11:50:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/1] Add visibility for native NVMe miltipath using
 debugfs
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        gjoyce@linux.ibm.com
References: <20240722093124.42581-1-nilay@linux.ibm.com>
 <ZqERmEICdLEvQ6aQ@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ZqERmEICdLEvQ6aQ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WHkw3SjfLLpzzcGS5zfCSvszqbsWbxNk
X-Proofpoint-GUID: WHkw3SjfLLpzzcGS5zfCSvszqbsWbxNk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_05,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=857
 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407250037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240724_232051_931606_03B54E87 
X-CRM114-Status: GOOD (  18.52  )
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



On 7/24/24 20:07, Keith Busch wrote:
> On Mon, Jul 22, 2024 at 03:01:08PM +0530, Nilay Shroff wrote:
>> # cat /sys/kernel/debug/block/nvme1n1/multipath
>> io-policy: queue-depth
>> io-path:
>> --------
>> node  path          ctrl    qdepth      ana-state
>> 2     nvme1c1n1     nvme1   1328        optimized
>> 2     nvme1c3n1     nvme3   1324        optimized
>> 3     nvme1c1n1     nvme1   1328        optimized
>> 3     nvme1c3n1     nvme3   1324        optimized
>>
>> The above output was captured while I/O was running and accessing 
>> namespace nvme1n1. From the above output, we see that iopolicy is set to 
>> "queue-depth". When we have I/O workload running on numa node 2, accessing
>> namespace "nvme1n1", the I/O path nvme1c1n1/nvme1 has queue depth of 1328 
>> and another I/O path nvme1c3n1/nvme3 has queue depth of 1324. Both paths 
>> are optimized and seems that both paths are equally utilized for 
>> forwarding I/O.
> 
> You can get the outstanding queue-depth from iostats too, and that
> doesn't rely on queue-depth io policy. It does, however, require stats
> are enabled, but that's probably a more reasonable given than an io
> policy.
> 
Yes correct, user could use iostat to find the queue-depth in real-time 
when I/O workload is running.

>> The same could be said for workload running on numa 
>> node 3.
> 
> The output for all numa nodes will be the same regardless of which node
> a workload is running on (the accounting isn't per-node), so I'm not
> sure outputting qdepth again for each node is useful.
Agreed, so in that case we may only show the available I/O paths for 
head disk node when I/O policy is set to "queue-depth". In this case,
we don't need to show paths per numa node as you suggested. And then 
for each I/O path we can show the "qdepth" once. 

IMO, though it's possible to find the queue-depth monitoring the iostat
output, it'd be convenient to have it readily available under one place
where we would add further visibility of multipathing.

Thanks,
--Nilay

