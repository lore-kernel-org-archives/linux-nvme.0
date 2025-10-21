Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5DECCD184
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1b69gDT8LvJVtiHS4ua5Tn6SRWH4Fsf1vL9xpsxKQeE=; b=N07fnHn3lgZA2xGGaYMGX61cO6
	QzKrOBPSx1WzMycjw4SwyZD07LkcvUV4V4iieVByNS3PH5F91xOTC1RxMIwuUhmPkwlecEfofNXab
	2KqcS8hJ1nnVpZTzPLRX6v9v3C0cp5GLRYDfwXgK45K1zm0IQgBOgN9TiJZ5xW70WP3afHrU1Nj3p
	gp4OELJPj/3VE93lu6fFaU4sL75Q5Oxy1cbmvii9k5jM1mjZs6n6kkWIzP3eVFBiHzB2fco66w1zR
	JUqWNrTNP21uN3Wm+rOAk+Tox4lrjx+fOrlK4fpTplAj6Vk7Hca4ReWd+Tp7NmB4uQFAGvx0ezy/h
	pFxV2jbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBDsr-0000000HQXV-0fb8;
	Tue, 21 Oct 2025 15:02:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBDsk-0000000HQWx-0wgg
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 15:02:39 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LBv7nT006824;
	Tue, 21 Oct 2025 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1b69gD
	T8LvJVtiHS4ua5Tn6SRWH4Fsf1vL9xpsxKQeE=; b=bCF/0Wa/KvKu6mQrXbsl9S
	IuI12RC4yilHAEQ8igAzzYa+6hR1osQ2yr76PsAHX3P22upm6LdX5AEibz+EsAc4
	lPjhFxAyp/n9PTO0X/8dAUWgOiq0uZm2AY6NL/nYzbyBBZdVrfnPhH6JOuaihVTM
	8YP4AWqBlnw3KWNb2wK1CASSxYokK8XFnkIejP3AjVt/itLGoqpCAqdAPiUas1Im
	xKuDNZZRybiL9zQ3MA9chXEP6DaTzSPO4jgBUpSJ53HQihGVkVuKg/5xMVRtgC03
	YIJszN5E+NsH2pBXcy0wKoFkKtRMRcX9nAn8MzPqsr8rQUohKLwQuegkzH/y8tvQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v326qp30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 15:02:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCAD24032099;
	Tue, 21 Oct 2025 15:02:29 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mua18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 15:02:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LF2SMN28705344
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 15:02:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0DBA58060;
	Tue, 21 Oct 2025 15:02:28 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF5CB58066;
	Tue, 21 Oct 2025 15:02:25 +0000 (GMT)
Received: from [9.61.103.108] (unknown [9.61.103.108])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Oct 2025 15:02:25 +0000 (GMT)
Message-ID: <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
Date: Tue, 21 Oct 2025 20:32:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: John Garry <john.g.garry@oracle.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EJELElZC c=1 sm=1 tr=0 ts=68f7a086 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=I5r0CxplrSDLCy34:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=TakWwMvn3hYBPWLwZwUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9kyN3yeIF1VP
 lFJJrlwUuBVhHNK3FogKnywjZqb3LY/SqgUeMZY0/GgT5hsULn2RVI8gcCUOSvEG3xhWKbRoh3B
 K8U1Yt/qSuiZhj8rOEJTnZMJfb5qZhzg/V/1nu9BRf/XsZhoXuiTTKmK9+UL/j82Y5AfwiDLmGV
 NXEKCcPmzxoY3H5ug/5yj8vlV+//ihBAt/9xxdHBNxCpPREdZA60JkhlkL57cRFLNkhNi6yVgaN
 1oRYgcIUdNf7YoZx1xFSVjdLQwodkslZAq7NkoIF3ytW8NN7IzPGwMS8X8gRQzeMLAG5hpJOBLN
 hlQSH0v1Qy7CCriubiqEqzFFJq6NIHZOEvyU9zkgA2IHg+Lx1IHHp4hTS3E5Vi36W/v1YGaSOT6
 iXAW1S5uqKurxre3Pgrcawa2ZK+J5g==
X-Proofpoint-GUID: xIWKchR_gvnhykSQPwUL9AvJTejebeoA
X-Proofpoint-ORIG-GUID: xIWKchR_gvnhykSQPwUL9AvJTejebeoA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_080238_373773_B55EA862 
X-CRM114-Status: GOOD (  19.01  )
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



On 10/20/25 7:12 PM, John Garry wrote:
> On 10/07/2025 06:07, Nilay Shroff wrote:
>>> Considering multi-controller subsystems, some controllers might have
>>> namespaces with only 512b formats attached, and other controllers might
>>> have some 4k mixed in, so then they can't all consistently report the
>>> desired AWUPF value. They'd have to just scale AWUPF based on the
>>> largest sector size supported. Which I guess is what the current wording
>>> is guiding toward, but that just suggests host drivers disregard the
>>> value and use NAWUPF instead. So still option III.
>> Yes, I agree — option III seems to be the best possible way forward.
>> However, does this mean we would disregard atomic write support for any
>> multi-controller NVMe vendor that consistently reports a valid AWUPF value
>> across all controllers and namespace formats, but sets NAWUPF to zero?
> 
> Hi Nilay,
> 
> Does the drive which you are using report NAWUPF as zero (as hinted)?
> 
> If so, have you tried the following https://lore.kernel.org/linux-nvme/20250820150220.1923826-1-john.g.garry@oracle.com/
> 
> We were considering changing the NVMe driver to not use AWUPF at all...

Yes, I just tested your patch with the latest upstream kernel on my drive, 
which reports a non-zero AWUPF but a zero NAWUPF.

And your opt-in change works well on my disk. So we may consider 
merging this change if everyone agrees.

Thanks,
--Nilay



 

