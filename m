Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953A1C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 08:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ZPWYq6IIw/TNPJawbvNCwvL0fazf7/37lr/OzsY8wQ=; b=eRyTc3He3owg4ed6yyey+U7D9j
	NtgdIUh2NqN7Y432b0gHlE9maz2xoAPNbOo/URVlwiUqHStIBJl7alotXwHuR5zL/Y0OF5groCbGK
	mX3qusE+MpC3XKbarhH++/Y7z4fZ1xixHhlKQZd8yyoRut9e9DOP5tBSEHo6Xc37xRdTEy8W+iqT6
	OEF7z/SrpN6RpDCA40GcekHhrXEQkkgc7lb6GEMLUKx09aby5nyEx+LVDY/t7B/7IHwcavtXVTlMW
	G4jEqtztmuINL01D4rw1gQrBOrTKdeWAvDBRelCkCQWIisCCicSB6INcapKE1UvaiGxxpq8cyhvDE
	tJON0Tkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3uj-0000000Fc9E-2CQ1;
	Wed, 12 Aug 2026 08:02:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu3ue-0000000Fc8t-38Kz
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 08:02:15 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62cZ8808427;
	Wed, 12 Aug 2026 08:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6ZPWYq
	6IIw/TNPJawbvNCwvL0fazf7/37lr/OzsY8wQ=; b=Dfnubfp9DyxmtFyhfTq3t9
	sJFfs12rLNkFpBlv0VCWQHKkXvWE3E5bCJLPq4wkYXPB5QEHzAr8bfqdYHRuUDfV
	aaQqfkiLCBeut0oh10g4Gc6A2WrNDQO6ypGPt5yv74Y23T7foO2+6pOFaNNvF9Uf
	RH3bcop/b3NgCmtEttGFEWBjjCZ1bQETXpIbiW5hHU2bergjrdaLEd/B9M+ApEbG
	/9Dnsp6mc+CzNd+MPkp+1JcJ22ErKZPcmsXNYcShLso36kkl2vEgRpNkEVemQjhE
	Dmy650aCKKOZ8yl7aU4ug0RNAFtCIuCwna75tsPiPyZnNgX15hfIEXTIg3iMn6OA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk01dtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:01:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7uL2T020019;
	Wed, 12 Aug 2026 08:01:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w57gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:01:57 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C81uHh23921348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 08:01:56 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCA0158062;
	Wed, 12 Aug 2026 08:01:56 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD66B5805E;
	Wed, 12 Aug 2026 08:01:52 +0000 (GMT)
Received: from [9.61.0.237] (unknown [9.61.0.237])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 08:01:52 +0000 (GMT)
Message-ID: <c4ed646b-b6a4-4312-8a1e-797cd336901d@linux.ibm.com>
Date: Wed, 12 Aug 2026 13:31:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-5-nilay@linux.ibm.com>
 <2d0163f0-ecf3-4f59-9121-587f98eeb54c@oracle.com>
 <4e157ebe-7afd-45b9-9d35-f866b6f92097@linux.ibm.com>
 <a9d2c427-4360-402b-bdc7-136f85fd4d9f@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a9d2c427-4360-402b-bdc7-136f85fd4d9f@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX2NLY8B0gHB+F
 7HXR3iZPQfck/avRJvK91Z0J7kgj80UuY1dcXCa62RMC2f3ZtbYe7JBFWZeWioYGFSLI2ro+nzV
 nqkwTfhi0wPaJ6vNiKPHQeEaiOxSwX0MFvB709jwIQkkZTTT1ZcbEuHGD5j1TWNWFOJtBdb/Jd2
 ykMYitfBFMEI4sBbx2dTzvoFvXYX0xyGm0dDEPDjA5U6jBas/fEjC4Dvfyan53jZ7rQOJ2BJgo6
 bMmZgRHFC7LYtS3c+BsRLqNdXyqDL6+HbWaUgh/c0myga7ctRx5KYHCjKrjf/kmJFPO3Jt/uxac
 PhpRgt6ajEHyeKSMGbUQMsrJKc4MoDafKnwkeL9DHU024WniJ/hiTXK1rXMm7Gn+LHW/qSA04gs
 NDK97upSr57VUkbxYiorJeWzhik1pfKSRzNBrSiFr8+lcJUUoIlVEtP25MViFU3YF4JyInL3rhL
 y/V0dKIwxiSANqDIkmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MyBTYWx0ZWRfX7MNZJklrFP8a
 5KgxCUJn9RbHqTllo+iiVc8V+jzpbTCMw3FM4YaWrXMbbBTFrkML/E1eH48uOcGzssdIxfsLgTl
 BaD/P901o2YUyM0WcXJa7rwRJ1X4DFw=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7c2877 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=wLyl8CQKQOLkDyj1Q1AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: LQ__rjaPgoZVw0rKH7D__9aZGEUYAl-F
X-Proofpoint-ORIG-GUID: Xn0IiFpd3P-pwgQX24MSEdLHvrpwnuZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_010212_880323_7F03A965 
X-CRM114-Status: GOOD (  14.41  )
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

On 8/11/26 3:56 PM, John Garry wrote:
> On 10/08/2026 18:25, Nilay Shroff wrote:
>>>
>>> iops: (groupid=0, jobs=10): err= 0: pid=821: Mon Aug 10 08:08:28 2026
>>>     read: IOPS=9239, BW=36.1MiB/s (37.8MB/s)(1434MiB/39744msec)
>>>       slat (usec): min=25, max=110836, avg=129.22, stdev=537.18
>>>
>>> Note that I do have many heavy kernel debug options enabled, like kasan and kmemleak, which may influence this.
>>>
>>
>> Thanks for testing. Given that you're running with KASAN, kmemleak, and other
>> heavy debug options enabled, I think this is expected. Those configurations
>> can significantly increase I/O completion latency, causing some samples to
>> exceed the 1-second threshold. The warning is also rate-limited to avoid
>> flooding the log. That said, still if it's causing a lot of noise in the logs
>> then we could change it to dev_dbg_ratelimited() from dev_warn_ratelimited().
> 
> Note they these warnings go away when I turn off those debug options, as expected.
> 
> The max latency I was seeing was ~1.2 seconds. Maybe you can just increase this limit for ignoring the sample. Or make it a dev_warn_once(). Or control the warn print rate with DEFINE_RATELIMIT_STATE.

I think we could make it dev_warn_once() as we also increment the stat
counter nr_ignored when we hit this case. So user could always interrogate
the stat counter to find num of samples those were ignored.

Thanks,
--Nilay

