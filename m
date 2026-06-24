Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99709CDB479
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 13:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GobjcLGSertG6yMu3cUuLzhgTApiHOOZIMJSDpCPNG0=; b=ujBZNbjLxWSVuS6+kGiyLAt66N
	zL/n8aJ6iMsfdd5ZvZJGl8Td2hiareSCzQEgwZqjdHgMuJLmRCSRqcmv3y4FDsst+UpvEfEEAHnn2
	x+c81S5IoURnD5pfMm4H8gO+sf+OIvEIl0hz8aZniCbVubSxP8KdSuFr+iSXw6mkhYAexn6F0nq8K
	rRtPKyPfcvFH7fvYNewkk+RxKhjZh9ISLsnTWwKs1mtDSGN6lqA+OtEOIi9cVgvkj2JAIVuLkPlZo
	2Ztafl0x/UiOlUGC2NEJyXxg1Ug4EcJS0Qo4zm7MiYMW4OIw883HHKYpuCOQnhNSTLye5wgknDRT6
	7J4gDkcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNXg-00000007oYT-2Qhq;
	Wed, 24 Jun 2026 13:21:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcNXd-00000007oY4-3CXR
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 13:21:23 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmYcL596046;
	Wed, 24 Jun 2026 13:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GobjcL
	GSertG6yMu3cUuLzhgTApiHOOZIMJSDpCPNG0=; b=NB7L3Lt5aWj3Jb48Q+0fFE
	9IBsAYb7TcpuZegl1MQIr5idW9a7WJc1vO/h3BgztwC5k0DhRSYOHOTiYANl1D92
	pO44AbMHzZH1rXmxU2F7yDz28XrOCcWufelJ2t5U/7+drJQiM6LGHMkduVqu5U6E
	GNiriX1Gp11vW+unw26g7ndRlpDxPg2cP4MI4whS8nteS00wjeDyzUd28d87fjGM
	S7qZ96K+1uTgQQ3Q5Sq6FX8XVkMNSZ/+cy5KU6C+B8J79ecyF9TcYtJlea6EGjUn
	tsCRqmk2xzKbZeLn+TnsNUeDduhzNwpIknpbGCvVIuBh7szh4pdVVkEz5J47Li5g
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hvdt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 13:21:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ODJjC3027605;
	Wed, 24 Jun 2026 13:21:05 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phgmp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 13:21:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ODL4ir48103744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 13:21:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C204C58069;
	Wed, 24 Jun 2026 13:21:04 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0205A5805D;
	Wed, 24 Jun 2026 13:21:02 +0000 (GMT)
Received: from [9.43.75.139] (unknown [9.43.75.139])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 13:21:01 +0000 (GMT)
Message-ID: <7da38928-fcb6-4ae4-891a-a71516b2977c@linux.ibm.com>
Date: Wed, 24 Jun 2026 18:51:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-multipath: expose path_state via sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <20260624054843.1132083-1-kanie@linux.alibaba.com>
 <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
 <c9b1d8fd-7012-44a0-a975-947fc0e16fac@flourine.local>
 <315b3fcf-a4ba-4f81-aa16-0d2f61a47b5f@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <315b3fcf-a4ba-4f81-aa16-0d2f61a47b5f@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 73coPMhPdKF99gI8nJNAVjKg08YnWHMw
X-Proofpoint-GUID: D64rvRU2HxgQbjJauUD7zOGJl_RlhqSK
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3bd9c2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=lFQayydI-qiYcSBUv4AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX+03dKdSyAdJY
 nLA0ZF5BdJlpm3w4zpi0FcWAABxJo4unFAQWRFEzMOgVp41q0rrN7rCdCRxQoKneF56QMFJJnz5
 Z682WHxiZCoaNdPdTERyXseyNYQd40CHtavRz6hAG9l+XtaM2sKVx6imVriuYeFqFMAwSMcUYbA
 FJJK9VHYyV961/dim4oJFyq/Kz+vpdAy//fknQDoAzAKZYl+yHdaFDDJsxm54JdjhtkD7NUbn4x
 mhdYiUuRoygrzSUdjkJ9hOp5K0kidoOUwEy/ZWEHKHxqwb8UTxKBpfd0i/XVKdVp+0JkGl66Tsd
 SZ5N5x20CIi/QLc9YRIruk30cLdLdVIQy92dyUgXAgOQ7GHb6p93cMqdUYfu6iR8OJsQ3Hikog5
 Z8/z3WQ2CcD3RP5Qra+AqL070gzt68BkIQU4jePWZ+ih+HpfRnnvpIq3Ze4b2088XdmrumBw6O2
 csIO1xRQOR3lA7zKkdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExMCBTYWx0ZWRfX3FrLIZnUTm15
 kPwHxCzlaayntucdNDlW624EgEulqglT421g4yKG0zBN08c6qJ99ibMf84qIoL1HOYvB1HJZ8nG
 JLEeQRmLVSnLw2bbfx7AKJyYoE/qE7k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_062121_989695_D3AB49A2 
X-CRM114-Status: GOOD (  17.28  )
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

On 6/24/26 5:22 PM, Guixin Liu wrote:
> 
> 
> 在 2026/6/24 17:55, Daniel Wagner 写道:
>> On Wed, Jun 24, 2026 at 08:36:44AM +0100, John Garry wrote:
>>> On 24/06/2026 06:48, Guixin Liu wrote:
>>>> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
>>>> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
>>>> current path state, including whether the path is enabled or disabled
>>>> with a specific reason.
>>>>
>>>> Factor the path disable checks from nvme_path_is_disabled() into a new
>>>> nvme_path_get_state() helper that returns an enum nvme_path_state. This
>>>> keeps the path selection logic and sysfs reporting in sync, so any future
>>>> updates to the path disable criteria are automatically reflected in the
>>>> sysfs output.
>>>>
>>>> Possible values:
>>>>     - "enabled (optimized)"     : ANA state is optimized
>>>>     - "enabled (non-optimized)" : ANA state is not optimized
>>>>     - "disabled (ctrl_down)"    : controller is not live
>>>>     - "disabled (ana_pending)"  : ANA state change pending
>>>>     - "disabled (ns_not_ready)" : namespace is not ready
>> I'd prefer to have a single string here instead of something we might need
>> to parse again. The sysfs docs says
>>
>>    Mixing types, expressing multiple lines of data, and doing fancy
>>    formatting of data is heavily frowned upon. Doing these things may get
>>    you publicly humiliated and your code rewritten without notice.
>>
>> Something like
>>
>>    - optimized
>>    - non-optimized
>>    - ctrl-down
>>    - ana-pending
>>    - ns-no-ready
> Would this be redundant with ana_state?
> 
> Is this OK?
>      - enabled
>      - ctrl-down
>      - ana-pending
>      - ns-not-ready
> 
> 
> CC Keith, John, Nilay, what do you think?

I tend to agree with Daniel about both mixing types and
reporting ana state values here as ana state is also reported
separately.

The purpose of path_state is really to expose whether the path
is currently eligible for path selection and, if not, why.

IMO, a simpler set of values which you suggested above
should be sufficient. But lets wait if Keith has any
other suggestion.

Thanks
--Nilay



