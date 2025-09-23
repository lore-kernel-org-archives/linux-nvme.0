Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A902FCAC5A5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UK9ReJFkKo6PuwiZi/CrtGzBNFCLjBDxaDxdQyWpm8Q=; b=tDCFkBJF7ElVhjxutXjuN61qwD
	mzeoKX1E1MdW+lG+X0I5B4oKJ4suowmRj6LCQSzQuEKk/1VPNbAV2mvWUUQFnaPgkwJOglB8vU6RL
	c8QHXhVyj+zxqS21I9ngdHheS2czUeRuZTvgqh3bVWWoh4Ae1vWO4i3bY8ZJBdTIQpoHZE3MagcRp
	UCysM4S3evwFGo4Ksj8l7ngAS7XldNEHboELmddmvL/cBAxCc+Low6kSv96LE3MEjCitR3rT4gefD
	7vcXVXRviAoJVmKjGeM2X9OP7bzgPGvaYdHvLoxWC1mrwNsAzV5D+sD8PmtX0VrKtypqqn8MCWRqY
	M5Szosfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17Ho-0000000EUXx-18rk;
	Tue, 23 Sep 2025 17:58:44 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v17Hj-0000000EUXN-39hn
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 17:58:41 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58NGcxUG010177;
	Tue, 23 Sep 2025 17:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UK9ReJ
	FkKo6PuwiZi/CrtGzBNFCLjBDxaDxdQyWpm8Q=; b=qrLQwi8W4qWagL7wq4tp92
	D6Nd85ri7ZhBsboOLpo7jl62RNMj+Q5N6DrAs2fvWrIrbrkt7F/cbie4nnEiyAtL
	B0d3QH47jre8AdXiH8OHvtUhHtQRCwl4LFHRO+MOjPdI2wV0CiVDueO7ax/k5nn7
	2nI08mRJ2yqz4wzK20g0Rn43n3Zf7iiuiMRvmVmGZL6mGNpawaEa08aLYrLHhySd
	Z3DTwLAhPuJHWtEbZZ7UI8IY3ZRCWhxnvNFwdKvPhA6j3erlFxw/11rc0XVDaGVR
	mLUR0MOCkRc0lA6svSEnSny8/drk8rFO0fDtLYGjb7iAvbkzsB6WRujlN/px8D+A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499ksbu13t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 17:58:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58NHYJ4P030336;
	Tue, 23 Sep 2025 17:58:25 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a14fpm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Sep 2025 17:58:25 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58NHwP1m27984438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 17:58:25 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335FC5804B;
	Tue, 23 Sep 2025 17:58:25 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E513F58055;
	Tue, 23 Sep 2025 17:58:21 +0000 (GMT)
Received: from [9.43.49.218] (unknown [9.43.49.218])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Sep 2025 17:58:21 +0000 (GMT)
Message-ID: <4fc12b57-3c37-493a-bd46-3ad9b8951fff@linux.ibm.com>
Date: Tue, 23 Sep 2025 23:28:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] nvmf-tcp: add support for retrieving adapter link
 speed
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-5-nilay@linux.ibm.com>
 <bacb5186-b3f6-45fe-967c-0472df746b4f@suse.de>
 <67abba19-5b81-48bf-a279-fd4c520f2d29@linux.ibm.com>
 <7021edf0-b459-4f0c-a309-3948ef588c71@suse.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <7021edf0-b459-4f0c-a309-3948ef588c71@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: I3p3cflUSJxthf5ViwoGuF9h0Su43iT2
X-Proofpoint-GUID: I3p3cflUSJxthf5ViwoGuF9h0Su43iT2
X-Authority-Analysis: v=2.4 cv=SdH3duRu c=1 sm=1 tr=0 ts=68d2dfc2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=kWRrMHtDIdHLOLkhEswA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMCBTYWx0ZWRfXxtjVEEt+1qWd
 P0yQOkr9OLZSHo+GL0bSOkLfHWY6voFz14LVfQ1/ZpEtXWtgZvx7YUXKAxZPJTXj75pq3schIyK
 a+MwFcXR4tQdDRj7CX4esCnbydLzhA6BD5AfhrWDva1dClEDwgS2CWS7vtb1k+sdgyW82s2UrvC
 JubYTglSHhu6MhinxuLZQf2MXCkrKejzcnRyXFACP3erUzFjgIu3TiexCcFqcX7OjVEOEreONjP
 0Bj/v+Aj1aejnvzeLp2K6H+JQ8LbjxzuIq3kHKo3T45Qx4IvBPXMguKhYN7KRDla30DYd6D/ANi
 Xl2p70g0K2Xp+lpCP8NKETr7dkNaHF+J2nR4nUz5mW67Uw+Ldks8l9DVIvV1pW5C0b38SouOpqL
 aQ6eBnJa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200020
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_105839_972483_041A57CF 
X-CRM114-Status: GOOD (  29.42  )
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



On 9/23/25 3:57 PM, Hannes Reinecke wrote:
> On 9/23/25 11:33, Nilay Shroff wrote:
>>
>>
>> On 9/22/25 1:08 PM, Hannes Reinecke wrote:
>>> On 9/21/25 13:12, Nilay Shroff wrote:
>>>> Add support for retrieving the negotiated NIC link speed (in Mbps).
>>>> This value can be factored into path scoring for the adaptive I/O
>>>> policy. For visibility and debugging, a new sysfs attribute "speed"
>>>> is also added under the NVMe path block device.
>>>>
>>>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
>>>> ---
>>>>    drivers/nvme/host/multipath.c | 11 ++++++
>>>>    drivers/nvme/host/nvme.h      |  3 ++
>>>>    drivers/nvme/host/sysfs.c     |  5 +++
>>>>    drivers/nvme/host/tcp.c       | 66 +++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 85 insertions(+)
>>>>
>>> Why not for FC? We can easily extract the link speed from there, too ...
>>>
>> Yes it's easy to get the speed for FC. I just wanted to get feedback from
>> the community about this idea and so didn't include it. But I will do that
>> in the future patchset.
>>  
>>> But why do we need to do that? We already calculated the weighted
>>> average, so we _know_ the latency of each path. And then it's
>>> pretty much immaterial if a path runs with a given speed; if the
>>> latency is lower, that path is being preferred.
>>> Irrespective of the speed, which might be deceptive anyway as
>>> you'll only ever be able to retrieve the speed of the local
>>> link, not of the entire path.
>>>
>> Consider a scenario with two paths: one over a high-capacity link
>> (e.g. 1000 Mbps) and another over a much smaller link (e.g. 10 Mbps).
>> If both paths report the same latency, the current formula would
>> assign them identical weights. But in reality, the higher-capacity
>> path can sustain a larger number of I/Os compared to the lower-
>> capacity one.
>>
> That would be correct if the transfer speed is assumed to be negligible.
> But I would assume that we do transfer mainly in units of PAGE_SIZE,
> so with 4k PAGE_SIZE we'll spend 400 ms on a 10Mbps link, but 4ms on a
> 1000Mbps link. That actually is one of the issues we're facing with
> measuring latency: we only have access to the combined latency
> (submission/data transfer/completion), so it's really hard to separate
> them out.
> 
>> In such cases, factoring in link speed allows us to assign proportionally
>> higher weight to the higher-capacity path. At the same time, if that same
>> path exhibits higher latency, it will be penalized accordingly, ensuring
>> the final score balances both latency and bandwidth.
>>
> See above. If we could measure them separately, yes. But we can't.
> 
>> So, including link speed in the weight calculation helps capture both
>> dimensions—latency sensitivity and throughput capacity—leading to a more
>> accurate and proportional I/O distribution.
>>
> Would be true if we could measure it properly. But we can only get thespeed on the local link; everything behind that is anyone's guess, and
> it would skew measurements even more if we assume the same link speed
> for the entire path.
> 
Yes you brought a very good point and I agree that we can’t reliably
determine the end-to-end path capacity. Assuming the same link speed
beyond the first hop may not always be correct and could easily skew
the measurement.
Given that limitation, I agree it would be better to exclude link speed
from the path scoring formula. Without a way to accurately capture the 
full path capacity, incorporating only the local link speed risks making
the scoring misleading rather than more accurate.

Thanks,
--Nilay

