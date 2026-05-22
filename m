Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10285CD4F5B
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 06:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kaNJkhCBBY9x/rbdWbxLu/3hGPYuNuIgwIB25ZOkDXM=; b=g76vzLJILxaFi+zUu1JnnpQgIP
	Jw6JsP9AsIJwtDRmiV3XBYYuUt0n16RMM3a1zenxXGu1NdXPNRkyKgFA5lS2TgtBmWJEVSu8dLMe6
	NPjdw7NKAI9VotjN4izt/vlhzh777aY/1DrZVWdDMRIpY2vECF/zrJPIjgzI9YrPIpTaQ0OiEciXD
	vA5k42aUmwqVZMpp7O1phMs7cdmOJlInirSCMdeAPvI4SKxE+jwGWUuULz2kwGQsNQUwTLVF+MMbx
	8k5Qn2eYMyCrcKzbtxUsa9ObTbPW7HlvUvzjREXMm/qzMpmshvDu5AzFzbSSDF5JEK1vnY21EO9dN
	7xARqeig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQJE2-00000009wrz-3gpY;
	Fri, 22 May 2026 06:19:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQJDx-00000009wra-0oIR
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 06:19:10 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64LITtHT733638;
	Fri, 22 May 2026 06:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kaNJkh
	CBBY9x/rbdWbxLu/3hGPYuNuIgwIB25ZOkDXM=; b=bt0CVHr7XmJSVqCEJTZVS5
	BYf+mhWgMeiTj4OsCpRm6hVTCEwO/w3RXrKfJc0hmdV6ujOqVtOieGN1br0lWKl0
	Ovu1U6iiA09llIhgsgajqSOkWo+ooP6k8Ejb5qEBwJVcR+5YUmM+S4NQRm90OakH
	YQY49ZRTnl0ihWCY8UUxS65wpnztmqRq7Fw1sZlBxm11cL9v3YOFUcgM6Hhxdt0p
	V+KGf4FSo1eR83j/v2X3H3WrDmw1bIevTMdnNaH6DPtyW+cvDEKzy4GEKHqsZcg+
	0eGcO7okyFo6d8z+mQ0qOQ/Cj9+VVUz9Z9wFthDHlatck0QwsdYYXHmZaK4AOV0Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8s4f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 06:18:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M698q7004320;
	Fri, 22 May 2026 06:18:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wkfpgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 06:18:51 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M6Ioa624248834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 06:18:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAC685804E;
	Fri, 22 May 2026 06:18:50 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC3385803F;
	Fri, 22 May 2026 06:18:46 +0000 (GMT)
Received: from [9.61.145.118] (unknown [9.61.145.118])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 06:18:46 +0000 (GMT)
Message-ID: <c0d1d025-0c34-4df0-a123-1324e2a99389@linux.ibm.com>
Date: Fri, 22 May 2026 11:48:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 1/8] block: expose
 blk_stat_{enable,disable}_accounting() to drivers
To: John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260520182112.863076-1-nilay@linux.ibm.com>
 <20260520182112.863076-2-nilay@linux.ibm.com>
 <e9b2c9a7-b9d5-48f3-8a79-cf925b99b7e1@oracle.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <e9b2c9a7-b9d5-48f3-8a79-cf925b99b7e1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA1OSBTYWx0ZWRfXyqwaHQUqriwp
 ODhgBn7c9taOJmOuNNV37na4cmCSwbbXKcjzw8xerbeCrwRsR1lu9Rda5qLT/MIJFbePzdqMhin
 hV/XjTmg7inimR9IkAX6Mq6Ae/AnXkQuR0pN9ukko7lfLOE5oepTPbrVdnXzSC/qyc3vJTSoOFx
 GUy1VG54lknAtwcQRZL57xcL/2LKaxqraXnYwIVl3ffT8qjkE3H5Are07kkqhmYF6wAyq5U1MtU
 3M3vXfknwRQ2u6SC8KTKLEkJVSJWa5zLDefJm9h6A6vc8YYH1SNmRecfPe4EXsbHpxfJqynKkjZ
 Hf0Sa0ne3xPBA41ZM1nyvHafzr8uZYYD33jUYhs+ZFO9vB3Eb4Ugt/RWX/m5hTOdQBsfWjIkFz5
 BznIPXRVNcAqsHfykxF7jhypxTHaHAmMbwmnPkyOm/OrCBm3dy1ZjC2N9wTbT9xJW6eSGlnhumT
 7ppFs5O+Sy8L0lh0YAw==
X-Proofpoint-GUID: y7uT8GjPeCULGJ99xLzf9Euyj_hapsoZ
X-Proofpoint-ORIG-GUID: RwoXYEUiRtcpvJxL9WfFzAa1ot9W0TCi
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0ff54c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=7t_g6Ztwec8PCX0n7VcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_231909_362084_B1E1C95A 
X-CRM114-Status: GOOD (  12.30  )
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

On 5/21/26 5:36 PM, John Garry wrote:
> On 20/05/2026 19:20, Nilay Shroff wrote:
>> The functions blk_stat_enable_accounting() and
>> blk_stat_disable_accounting() are currently exported, but their
>> prototypes are only defined in a private header. Move these prototypes
>> into a common header so that block drivers can directly use these APIs.
>>
>> Reviewed-by: Hannes Reinecke<hare@suse.de>
>> Reviewed-by: Sagi Grimberg<sagi@grimberg.me>
>> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>
>> ---
>>   block/blk-stat.h       | 4 ----
>>   include/linux/blk-mq.h | 4 ++++
> 
> struct request_queue comes from blkdev.h, so maybe that would be a more appropriate place to locate the prototype.
> 
yes both blk-mq.h and blkdev.h should work well. We do also have few
prototypes defined in linux/blk-mq.h which uses request_queue. Personally
I don't have anything against using blkdev.h. So I will move it under
blkdev.h.

Thanks,
--Nilay

