Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146C6E98FD0
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0dEBKYkoDMME7nEkhgrR/yUhnHdtdm3xnurIwXVQyc=; b=05U/7/cx+NUV1Ldksdj4HQEBY2
	+wTUdxKilDWBRk68PXF/3Jdws+9V3ywGDIqykgPBYdb9yhzX2McQqp9Y54c52grxQZIC5NS6TFkXm
	qjsyWlPtZptvONn2ruxS4FKT7glWUAulcZlqWDP5tbBoV2IKQlh8/pSOtlhVTtqZ81rWduiepbvfe
	Qjlp0xKu1Yewefnn+ar/m93Q38dezXoNAfdChQ8R6G52mZoSTObtHOdeCyDXBw5hIdAhLb1TevHAp
	RtqBAA5nqNpp/Jz2dEF/MMmP5AX5+rifhDJydaMRvVa+6P4x0HuCp9e+h0iljW+1++EulsdzsG0gh
	cNkaTIFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAj1i-00000009mf0-1gh2;
	Thu, 09 Apr 2026 06:38:06 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAj1g-00000009mec-0AR2
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 06:38:05 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 638NFUrR665439;
	Thu, 9 Apr 2026 06:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b0dEBK
	YkoDMME7nEkhgrR/yUhnHdtdm3xnurIwXVQyc=; b=SrxVuGy3iXYZ8oSGCG9y5+
	cW+OqNWQbLcIW79IQm6DI5kiYc7gcOpWIIE/hBjGprg16b0OFfX4FBr2QwUOCv1q
	Hc+cf/2rfk7XJdUVwECyeCqbCHAkAA+xE+dyaMt1rzu1NNPCOPynMV4v1SmfNTWb
	N+W7dZtt22o7PYUxLouayC4XGm5WXqQS88HmRuuMlu1uizmGvumBo8TPO0YIsEMq
	Y6LfW/MUAcxDx51mLFEX8No4vAywfkrOiVAfRTiqtt4h0cw1tkQEOMTw+5Dm8Wm+
	ORErl1J6+RwrhM4VvorsRlw7uQE3vEc4P5Z4RkRmdgAOnmlnEu7+qIKTVKVGnZIw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ebmvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 06:37:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6392KXYu013824;
	Thu, 9 Apr 2026 06:37:50 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf4agb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Apr 2026 06:37:50 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6396bn1g31851160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Apr 2026 06:37:49 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F67A5805A;
	Thu,  9 Apr 2026 06:37:49 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0412D58052;
	Thu,  9 Apr 2026 06:37:44 +0000 (GMT)
Received: from [9.123.2.203] (unknown [9.123.2.203])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Apr 2026 06:37:43 +0000 (GMT)
Message-ID: <79725a83-3dc1-4398-ac86-c3e317e0e107@linux.ibm.com>
Date: Thu, 9 Apr 2026 12:07:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] libmultipath: Add delayed removal support
To: John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-8-john.g.garry@oracle.com>
 <bc006d17-22b6-49d5-9e04-02eab7dab729@linux.ibm.com>
 <74eb1f9b-265e-4264-9575-177de6c924a0@oracle.com>
 <6d7a4076-a4ad-4185-8e82-8e27d704d20e@suse.de>
 <c5334a6b-8089-4ee5-abd3-8340133db29a@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <c5334a6b-8089-4ee5-abd3-8340133db29a@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ryGWzV-kxtfoOaaEQla0XCXQw7DbbbdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDA1NCBTYWx0ZWRfX5XcfgdUgYwDD
 KkdwNvKclumlzdnlNHFpblTJb8dLXPGm773qOMgfkjCHTJKrOq+0harj3CiJH40ATmFzw7lNjG6
 V0W+Y/K5QLt+3nYWuHhQh+jqQMAsx2yQoo+5XinxIxmmxP2LMzJwPuKJXIrQMJ0xlxUREey6HSG
 rDMzHiKuRHJA7j6yn93sNlJ29f0Shih1NLSM3qY5IW3xMNDhzGZEH/+ekS2R0HN4UMXQWdL5I7c
 rzg/IXWZUYe9XGyfVV2UbjvOvtCI+xVtRuHqpOLPMQqIbBWIgvueGIC+I3OvXn/wmcDyqoZQgz7
 hS7aC+k/3HsM+GmjB0ZxjFsIsGUAInm3nsaSti4sWLGb0rAAgxTC2EKkT9JColBhvm+xME+vvXZ
 a54OJmHYfdrTjRvbS+U0uAghg3N+HGO6d2dD4aDVGIZx4aZjbtSa+fBk5me3hyOgj8xjrTPhUen
 ohNzoEVtbumSVvvhFJg==
X-Authority-Analysis: v=2.4 cv=Cfw4Irrl c=1 sm=1 tr=0 ts=69d7493f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=qGyuYsBrm1yEalbM7ekA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ryGWzV-kxtfoOaaEQla0XCXQw7DbbbdA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_01,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_233804_092185_128E2EF8 
X-CRM114-Status: GOOD (  16.60  )
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

On 4/8/26 9:58 PM, John Garry wrote:
> On 08/04/2026 16:41, Hannes Reinecke wrote:
>> On 4/8/26 13:28, John Garry wrote:
>>> On 02/03/2026 12:41, Nilay Shroff wrote:
>>>>> +
>>>>>   void mpath_add_sysfs_link(struct mpath_disk *mpath_disk)
>>>>>   {
>>>>>       struct mpath_head *mpath_head = mpath_disk->mpath_head;
>>>>> @@ -793,6 +868,8 @@ struct mpath_head *mpath_alloc_head(void)
>>>>>       mutex_init(&mpath_head->lock);
>>>>>       kref_init(&mpath_head->ref);
>>>>> +    mpath_head->delayed_removal_secs = 0;
>>>>> +
>>>>>       INIT_WORK(&mpath_head->requeue_work, mpath_requeue_work);
>>>>>       spin_lock_init(&mpath_head->requeue_lock);
>>>>>       bio_list_init(&mpath_head->requeue_list);
>>>>
>>>> I think we also need to initialize ->drv_module here.
>>>
>>> Hi Nilay,
>>>
>>> I am just coming back to this now. About NVMe multipath delayed disk removal, did you consider a blktests testcase to cover it? I might look at it if I have a chance (and it makes sense to do so).
>>>
>>
>> That look patently like the 'queue_if_no_path' feature from dm- multipath. Any chance of reconciling these two?
> 
> You mean a common blktests testcase, right?
> 
> For NVMe, that test would:
> a. try to remove NVMe ko when we have the delayed removal active
> b. ensure that we can queue for no path
> 
> I suppose that a common testcase could be possible (with dm mpath), but doesn't dm have its own testsuite?
> 
Yes, I'd add a blktest for 'queue_if_no_path' feature. But as we know we have
separate test suite for dm under blktests, I'd first target nvme testcase and
then later add another testcase for dm-multipath.
Thanks,
--Nilay

