Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12E3C25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 07:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nlTdOmS4rQMLGgRZ50uca11B1YS6oRrap8tdbZiD04c=; b=1J0rbUpnXqCGua3qs7wEiUrMcA
	bc2zq4llfX5teTEpJVIEvSSOMcGBskQQrW6JjUzxwn8H+sJKElD5P9OuiVaRnTs8d1sz5MdAAqhLS
	f9Www9gmg4XMQsL6GUe81XjgMXM1SzPjfMS3/5qWWflfasdonBZfrmg/jEAfTZKOEwl004qd4pxzx
	ATzJ5vm8qrgBv/j9lfYx03xOsrRV6+4zUmCvNgc8vw++JDZYFCyD+OGguEYT97vDjj8ZbkkY4GNKh
	DEgekTX9JMkgK1HlLWNQmz8V5GU0SswR4hvU3WHOnIL3i61N9BWeJXptggtg3m+hLyQN2iEG04jYp
	eAMxlZuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2S3-00000005HCe-2uCg;
	Thu, 23 May 2024 07:01:23 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA2Rz-00000005HBp-4Bpc
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 07:01:21 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44N6ZA9q027473;
	Thu, 23 May 2024 07:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=nlTdOmS4rQMLGgRZ50uca11B1YS6oRrap8tdbZiD04c=;
 b=DMGbfVFsrZbE/PtvMWTzzPcsVbZD8Q0glm1auLM7O4bjHxv8ufYE3g6BpFhDVEoBp+74
 IfzRudMIH0GHoYsrddlzjkZPr/uEe2/7SYubylObgZBu1yQ4BQqMnRnaaUY5xAcHy1Yb
 dOTMKGSCkCsRbyAmZTQ0z9tmB6Sj2fy6RoNlqaxrvZW3Rrba36lhhiEYUsxLQ3BRWG2O
 h8E8vmfAKWtkUXE+ItlWcE7YGuM2+nNSr6RChhp/pKBWY0duYpLJS3GaRkHeHp3CDUcd
 QxuOBUZBuSboGTC3wZYvv/JKqh6RvMIBMmN/otH1r7ZgxRPNR4T+iclX/5ENZo/HgyNf oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya0n8r1tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 07:01:03 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44N712oM031862;
	Thu, 23 May 2024 07:01:02 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ya0n8r1tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 07:01:02 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44N6h4Xe000967;
	Thu, 23 May 2024 07:01:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y7720grax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 May 2024 07:01:01 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44N70x8n20513490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 07:01:01 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4830D58052;
	Thu, 23 May 2024 07:00:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1853058067;
	Thu, 23 May 2024 07:00:57 +0000 (GMT)
Received: from [9.109.198.166] (unknown [9.109.198.166])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 May 2024 07:00:56 +0000 (GMT)
Message-ID: <89dee2dd-bf3a-4f65-aa44-f8360dd597f0@linux.ibm.com>
Date: Thu, 23 May 2024 12:30:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix io accounting on failover
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, jmeneghi@redhat.com
References: <20240521180712.2423165-1-kbusch@meta.com>
 <6e01032f-c90e-4f7e-9339-d2782fd60e3f@linux.ibm.com>
 <Zk3-okfn-8WIf2I8@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zk3-okfn-8WIf2I8@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DBuxE2Wb_taHHJyoPpO_lZ82BWn6aktX
X-Proofpoint-ORIG-GUID: Xr3mq_uUcnYJyb6fqwcLKEmnxzJcGaVR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_03,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxlogscore=914 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_000120_203330_EECB755B 
X-CRM114-Status: GOOD (  18.51  )
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



On 5/22/24 19:48, Keith Busch wrote:
> On Wed, May 22, 2024 at 06:32:11PM +0530, Nilay Shroff wrote:
>>
>>
>> On 5/21/24 23:37, Keith Busch wrote:
>>> From: Keith Busch <kbusch@kernel.org>
>>>
>>> There are io stats accounting that needs to be handled, so don't call
>>> blk_mq_end_request() directly. Use the existing nvme_end_req() helper
>>> that already handles everything.
>>>
>> The changes look good however I have a question about why do we retry an IO
>> when that IO is cancelled? For instance, when a multipath IO request is cancelled 
>> (from nvme_cancel_request()) we re-queue the bio in nvme_failover_req().
>> Similarly, for non-multipath request, we do retry request in nvme_retry_req()
>> until retries for a request are maxed out by nvme_max_retries. So wouldn't it be 
>> appropriate to drop the cancelled request instead of retrying? 
>>
>> However, I do understand retrying a request on a different path when we got the 
>> request completion status specifying the path related error.
> 
> A cancelled request just means the host thinks the target failed to
> produce a response. It doesn't mean the host stopped caring about the
> command; the host still wants it to succeed, but determined corrective
> action is needed to reclaim and resubmit the command.
> 
Thank Keith, got it!

--Nilay

