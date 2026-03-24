Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2552EF54AAE
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Mar 2026 13:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8GHuN93tDhbCRL0iblTAW2y6mIXI+4EnjdA31iUXV44=; b=sXdkMR389JdliQowEP48+4naki
	c1ae7GIhGwP85HlbcatPIff8ICBein5sctIIt7GYRJ0w7cYEu8eQM5yWcFUmFTWEH6Lp+3PA9HQcu
	5T6SJ5tg8euhx97W3Q4oMGxCa578zOakpGRSphIspVqBEFrVZB9/1b3zUY8s9DHkSOXQRkQp3May8
	63ACggZe6WdZdOEAiNDLIxRNQg/Sc5hSM1LvvK2FpxxAn1E8BW0xev09ktT3CaMuoXVkeToKmLW1t
	8kMDZei7WJNDX8EWZvndIgeJaIi7tfMBL4GORD5lrxsTn0H/KHjLkWgC2qeTYK1tszPxpqYUZv7/v
	4ZcXI3gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w51ZB-00000001VhW-1VnK;
	Tue, 24 Mar 2026 13:13:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w51Z3-00000001Vco-2Y7q
	for linux-nvme@lists.infradead.org;
	Tue, 24 Mar 2026 13:12:58 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62O18Smg3681168;
	Tue, 24 Mar 2026 13:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8GHuN9
	3tDhbCRL0iblTAW2y6mIXI+4EnjdA31iUXV44=; b=sVoL2QNxO+qc5x+TuW1Vm1
	y5fHn8ACi/prA3a985NujSI+4ocpypPl7JbA68rswWFWImddzu1k3toAO+5ipUJb
	LUl/n/l44kbdVJrhs8bkRan5zirqYGwAyK61Vs2m+cLb4NvlJU0inryiQoG+VbWp
	ChfuzpZwqERHLRAJRtkjDYFinHWxLfOR5ZBhY+vl17T+OFKpRQtfcbFdFwinhZl9
	OIJ9BTHHsA12m4LQwcHi6HuxAH+JzNjz+KiTxIxAok0kJ8tZ66fMuvInSz4IlpVL
	pWEdhTTLrV25Hp5NQFna6kSWUjsJ4kmKX4rIljzoRVyDH8DtkiAEzjUKz1OisBrw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9ujy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:12:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OCIQeh009126;
	Tue, 24 Mar 2026 13:12:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnj0as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 13:12:54 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ODCSat27132490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 13:12:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 647DA58064;
	Tue, 24 Mar 2026 13:12:52 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3A8D5805A;
	Tue, 24 Mar 2026 13:12:49 +0000 (GMT)
Received: from [9.39.27.13] (unknown [9.39.27.13])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 13:12:49 +0000 (GMT)
Message-ID: <91f4a9f9-8645-4372-a622-cbd5dae46d2d@linux.ibm.com>
Date: Tue, 24 Mar 2026 18:42:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] libnvme: add support for retrieving namespace gendisk
 I/O statistics
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, hare@suse.com, kbusch@kernel.org,
        hch@lst.de, gjoyce@ibm.com, wenxiong@linux.ibm.com
References: <20260321152823.3197870-1-nilay@linux.ibm.com>
 <20260321152823.3197870-6-nilay@linux.ibm.com>
 <3c8a6da5-31ef-44f0-a9c8-d675d810ea03@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <3c8a6da5-31ef-44f0-a9c8-d675d810ea03@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QrhhFQb1pRaDM-ACeF8Rj-Omoz9fXUjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwMSBTYWx0ZWRfX4+sOc2qLtq5a
 OjQdK2TfXzm4OpmsYa+zepAng4CHdAnsBmss7oOjvWe+atzSf7q8i7+XiH6OhHO77cxMmhD1AoJ
 SnH9urwU7oKUapzq7+R25Dx6nmwPqAuDHvY/US6rafr1tHxfMUNUpQlSelR2CulEGK1YHg6xzK1
 xUPOeVJiBoeLoXubEkpTqMybG+i+oM2QiJBQFQQzvHgJ8tGOb51fRhBVKJvMZQ8xxusI7hfbYUF
 F54PUxexAd+KWo7AHQo0OFiAFKD2awQ3roxzw5PQ0sf8B6Uf/i8aooXdqqIKZPch9961X8ixgaD
 2DQSsDn1IkMyztCqsuozWzFmLX0gRxEwVXthQlOxfi4SPK70Iz+buHDc4J0+gfAEgE7FRCN85IQ
 a097NYRxEgfUkYrnFMLKCgsHDd+Yi0wKmjWs5RcD4VCS0ruklCRmqOpV9SMcWui9MFAZrHweHje
 w7n641lnMh/XYWQSr8g==
X-Proofpoint-GUID: QrhhFQb1pRaDM-ACeF8Rj-Omoz9fXUjN
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c28dd7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=MUBKE89p4hToOFseiiAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260324_061257_677745_8B8B267C 
X-CRM114-Status: GOOD (  16.27  )
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

On 3/24/26 2:36 PM, Daniel Wagner wrote:
> On Sat, Mar 21, 2026 at 08:58:04PM +0530, Nilay Shroff wrote:
>> Gendisk I/O statistics provide useful insight into disk activity,
>> including read/write/discard/flush operations, as well as information
>> about in-flight I/Os and I/O timing.
>>
>> Parsing these statistics allows users to determine the number of I/Os
>> processed, time spent servicing I/O, number of sectors accessed, and
>> the count of in-flight requests.
>>
>> Add support for retrieving namespace gendisk I/O statistics. Also add
>> support for computing deltas of these statistics between samples, such
>> as I/O ticks, number of sectors, and number of serviced I/Os.
>>
>> These metrics can be used by tools such as nvme-top to display real-time
>> disk activity.
> 
> Same comments as in the previous patch.
>    - error codes
>    - is it necessary to expose 'cur', 'this' via the API?

Yeah will use proper error codes.

The same rationale as in the previous patch applies here for exposing cur/this.
The only difference is that the earlier patch handled nvme_path_t statistics,
while this one operates on nvme_ns_t statistics.

Thanks,
--Nilay

