Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D4B2C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 09:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cUcJoLtY+nDexHMnGYoZp3U7wjuUH4CdIXmbB/RLu4c=; b=ZiyF0Zs69iwvyZ7XSBZk5yWFUc
	aDR61hjeQVH8t+8SQiGLN1qRmvs578HkJx6kq1pr3bFVeLmoNfcc7GcFDKN/iie4PPbyOpQ7D+ulk
	/lGgzF9R8WbJKZx1Qaw0wupLOQPXnCkpU1+U6KIZeQIMzcdQSUqd7773DW5T+24C4uGv4YhbN0kpq
	SuPemWnACt46tBb1LaqdiLedVP9TqW2yBkL+p6ciwkWY32VJxmeb3l/5esMCVvqg/zbV/hhADZg3p
	XyninSzB4VdC8Hs7L3bWdA1okWrQ/77IsQT31VCmGpr8jXTp8E8C9WpyDrGLZQfehV/0poF4j6fIe
	ltCDBC4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBlz-0000000CPab-3icc;
	Wed, 14 Feb 2024 09:41:47 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raBjI-0000000CNQH-25aF
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 09:39:01 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41E9Wmfh018847;
	Wed, 14 Feb 2024 09:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=cUcJoLtY+nDexHMnGYoZp3U7wjuUH4CdIXmbB/RLu4c=;
 b=DoXGmsP4K81+9XjLJWWthfIK5HcFnGRXVnTNhQYKLpE4UNiWNdYWzWhdVKjraBl8JpJO
 alqg64zxAP4okpf2tHNQAyQp6Tayak6XgScxJmec1e5bo3LoqxQpwt4XOwaF/YFDcdXh
 72vYSUxrkb2O9p8AoigIZHgAnmdE3Wb2wr24BR1CecBCic4R5g2TYDnX0ib+lIhMvlrP
 gjoFxH356Ua64DRJuOjc4gEt2A+BTmDPK5eu5q0XdZ84K386dVI0yh949B4ZlkP1DlUO
 cxyAaAEtLli14uzMpXVurlO3pT87em81jCiBWtk/jp3KDvhYrEufewqHBTV3oJNPxkm3 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8tyrr4f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:38:48 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41E9X0Ub019301;
	Wed, 14 Feb 2024 09:38:47 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8tyrr4et-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:38:47 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41E8xTQw032553;
	Wed, 14 Feb 2024 09:38:46 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kftna01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 09:38:46 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41E9chpo14877390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Feb 2024 09:38:45 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C22C5806A;
	Wed, 14 Feb 2024 09:38:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26BC05805C;
	Wed, 14 Feb 2024 09:38:36 +0000 (GMT)
Received: from [9.109.198.187] (unknown [9.109.198.187])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Feb 2024 09:38:35 +0000 (GMT)
Message-ID: <c130133f-7c4c-4875-a850-1a8ac9ad4845@linux.ibm.com>
Date: Wed, 14 Feb 2024 15:08:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/15] block: Add fops atomic write support
Content-Language: en-US
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, bvanassche@acm.org,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de, jack@suse.cz,
        jbongio@google.com, jejb@linux.ibm.com, kbusch@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
        martin.petersen@oracle.com, ming.lei@redhat.com, ojaswin@linux.ibm.com,
        sagi@grimberg.me, tytso@mit.edu, viro@zeniv.linux.org.uk
References: <20240124113841.31824-11-john.g.garry@oracle.com>
 <20240213093619.106770-1-nilay@linux.ibm.com>
 <9ffc3102-2936-4f83-b69d-bbf64793b9ca@oracle.com>
 <e99cf4ef-40ec-4e66-956f-c9e2aebb4621@linux.ibm.com>
 <30909525-73e4-42cb-a695-672b8e5a6235@oracle.com>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <30909525-73e4-42cb-a695-672b8e5a6235@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: p7_p2wy0T2tbh-50wJFh1wKiPX3doLPk
X-Proofpoint-ORIG-GUID: DUfNKTmlVXqE-eL32_o5hvhwgMYyPpUV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402140074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_013900_570739_692C62E4 
X-CRM114-Status: GOOD (  22.71  )
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



On 2/13/24 17:22, John Garry wrote:
> On 13/02/2024 11:08, Nilay Shroff wrote:
>>> It's relied that atomic_write_unit_max is <= atomic_write_boundary and both are a power-of-2. Please see the NVMe patch, which this is checked. Indeed, it would not make sense if atomic_write_unit_max > atomic_write_boundary (when non-zero).
>>>
>>> So if the write is naturally aligned and its size is <= atomic_write_unit_max, then it cannot be straddling a boundary.
>> Ok fine but in case the device doesn't support namespace atomic boundary size (i.e. NABSPF is zero) then still do we need
>> to restrict IO which crosses the atomic boundary?
> 
> Is there a boundary if NABSPF is zero?
If NABSPF is zero then there's no boundary and so we may not need to worry about IO crossing boundary.

Even though, the atomic boundary is not defined, this function doesn't allow atomic write crossing atomic_write_unit_max_bytes.
For instance, if AWUPF is 63 and an IO starts atomic write from logical block #32 and the number of logical blocks to be written
in this IO equals to #64 then it's not allowed. However if this same IO starts from logical block #0 then it's allowed.
So my point here's that can this restriction be avoided when atomic boundary is zero (or not defined)? 

Also, it seems that the restriction implemented for atomic write to succeed are very strict. For example, atomic-write can't
succeed if an IO starts from logical block #8 and the number of logical blocks to be written in this IO equals to #16. 
In this particular case, IO is well within atomic-boundary (if it's defined) and atomic-size-limit, so why do we NOT want to 
allow it? Is it intentional? I think, the spec doesn't mention about such limitation.

> 
>>
>> I am quoting this from NVMe spec (Command Set Specification, revision 1.0a, Section 2.1.4.3) :
>> "To ensure backwards compatibility, the values reported for AWUN, AWUPF, and ACWU shall be set such that
>> they  are  supported  even  if  a  write  crosses  an  atomic  boundary.  If  a  controller  does  not
>> guarantee atomicity across atomic boundaries, the controller shall set AWUN, AWUPF, and ACWU to 0h (1 LBA)."
> 
> How about respond to the NVMe patch in this series, asking this question?
> 
Yes I will send this query to the NVMe patch in this series.

Thanks,
--Nilay

