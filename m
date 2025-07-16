Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C85CAC83F27
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jul 2025 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I61YsxkMcSL5KjNUzEumFFJQqgMjHFGv+4NaJWpDZr8=; b=YCvB5/d4YOY6JLZzQ7ypRn7Yn9
	i8H84ZH2Nb5y/ii+O0fKwvh0kIVD9o7zZ7pDNOBvlsfLLMGsPS9v6/fytWAqMKAjPz9OZG8UDcEpQ
	ip1f9M3+08Q2p0+7bNnH75nCsJMohI0gjSmMAzYbFVTdJMP5Gm33Txx5CdI6nJBw63Zf0uX5+1vvy
	2DubIkhgSdhDd2J+HdwWCWIpxUc5Qy3jgFUpg5uvI482pfgQtsw+dPOldnekYc+TL3BdDMZ9J34SF
	bvjtMcyuojuKB6ytqzDEEWCF1mgPQ6tBWSs8Uoe3FMrU0poZr6fblhYPuKjP6Foo7NWZTtWfj0D0P
	8DOXZEVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubvEC-00000006q2d-2lQG;
	Wed, 16 Jul 2025 06:02:52 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubv2U-00000006p25-3y5P
	for linux-nvme@lists.infradead.org;
	Wed, 16 Jul 2025 05:50:48 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G0000D016701;
	Wed, 16 Jul 2025 05:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I61Ysx
	kMcSL5KjNUzEumFFJQqgMjHFGv+4NaJWpDZr8=; b=fUNDB1iKwFs0OcnDzCF/Yy
	9ASv4zz65kon90zS0PZAHGl+8pjhfgieuWXfYEptqN/3wDXx16xrLxhLhyTB1mDC
	n0VKZWGBolvfg8Cj3T4Qb1m6B95JVZeIB5eCAoz5kV05q2AvKUGci6Cl89BTyGK3
	EmunL0yrCQUPUa4+HTnGDzIXZwrruB4X9i4CHQ7WN/YuoAyF/IgsGWxRwZJLzoBS
	AQvw6WqJ6yoicauTyXWMaWUu7LYSI7BmMxOWXOBk67vTll1E2KUPOjsM66E71yLO
	6Onfx3usWkMxyYiCzomtY5XqL7xMxNjXY1yiM9QxM1Nw5tJJDFxIjZtue09DJkqA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamtxhc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 05:50:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G23WIW008988;
	Wed, 16 Jul 2025 05:50:41 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v3hmntef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 05:50:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56G5oeWT32244368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 05:50:41 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A214658059;
	Wed, 16 Jul 2025 05:50:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 126A158058;
	Wed, 16 Jul 2025 05:50:37 +0000 (GMT)
Received: from [9.43.110.2] (unknown [9.43.110.2])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 05:50:36 +0000 (GMT)
Message-ID: <a1bd4aed-a1c3-4546-bf99-4e427c45ab46@linux.ibm.com>
Date: Wed, 16 Jul 2025 11:20:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: John Garry <john.g.garry@oracle.com>,
        "Darrick J. Wong"
 <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20250714131713.GA8742@lst.de> <aHbAZBf12kiEdXfH@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <aHbAZBf12kiEdXfH@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ngaxYKAAVLqcHHt3SW9M3GdVR8WR3_En
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA1MCBTYWx0ZWRfX1XIyTzkq4ss9 uJbvVN3xdufRl9u6Qe5SPy7HSWVIj1TPTxg/WSTXb1C7BdWbbtK9Qsl2QXsjWJTc4QHMnQENLbI ZgfIg9JlLVEpSUo8iimqFFOizBlNw4qKu55wtu5ZB5OZT542QuoZbuOhJ+t7l4mOQu4eOvHBF/C
 +6NcdCFScCOno1V8EvPhEcEcJ6YTMFC0NKLiWQcZDsX1MbUvEeeId2kXrO18m4UrMIhUuxhBkaS uMrj+sM3GZrBAIb3XYbpl7LkpJl6PLRi4m7i/zhG3+rsrggJnOUEByTZ/xangBpJYQS0zSHV4XW ZuKdJUZjQMY0YSNuKRdJlNjaoPZNMjPgr4sQ0pR1gfhFfnLvLW9aCBNrO58tm+TbGQC/OYVBbKn
 +YRa/0j7ACGhW5kUV/7BJvhxTS3e/bQFWcSqWWnIL1dcFKsjPAd3+iYetMh0cx1gC1vvMvjP
X-Proofpoint-ORIG-GUID: ngaxYKAAVLqcHHt3SW9M3GdVR8WR3_En
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68773db2 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=kLWA3gBXtu5QbDPQ:21 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Cdajwa0swSnkgbHL8UIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=895 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_225047_461784_21851786 
X-CRM114-Status: GOOD (  19.78  )
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



On 7/16/25 2:26 AM, Keith Busch wrote:
> On Mon, Jul 14, 2025 at 03:17:13PM +0200, Christoph Hellwig wrote:
>> Is is just me, or would it be a good idea to require an explicit
>> opt-in to user hardware atomics?
> 
> IMO, if the block device's limits reports atomic capabilities, it's fair
> game for any in kernel use. These are used outside of filesystems too,
> like through raw block fops.
> 
> We've already settled on discarding problematic nvme attributes from
> consideration. Is there something beyond that you've really found? If
> so, maybe we should continue down the path of splitting more queue
> limits into "hardware" and "user" values, and make filesystems subscribe
> to the udev value where it defaults to "unsupported" for untrusted
> devices.
> 
If we're going down the path of disregarding atomic write support for 
NVMe devices that don't report NAWUPF, then we likely need an opt-in
mechanism for users who trust their device to have a sane AWUPF value.

For example, consider an NVMe disk that does not support NAWUPF, but 
does consistently support AWUPF across all namespaces and for different
LBA sizes. In such cases, I would still want to enable atomic writes on
this disk, even if the kernel driver marks it as "unsupported" due to
missing NAWUPF.

Having an explicit user opt-in mechanism in such scenarios would be very
useful, allowing advanced users to take advantage of hardware capabilities
they trust, despite conservative kernel defaults. 

Thanks,
--Nilay

