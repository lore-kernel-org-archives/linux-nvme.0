Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05003C55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L7PyaQGMoExvW+n3/+GALrV4+I4wpAG5f3iEgm9W3vY=; b=aSPhb5TIMAu1q+cteJ4dOwEwVH
	ks+C2Guxx/xbTG5w4BNT79LS3I3U7NQn5Z10Q6XwTTtfEe+5JV++hWGUBcr2ohNJSAZeVreigeGsJ
	P6Pma2jUkB3SGdgDBPIkIHb1pYFqP/Q/L0pGntaYBRItdOsopcMWuBJpigvEYkt2rTWBaoCZItwd5
	Ie2KYbAHde/LY0IfRSknHlOO6DWwOqc5wL544LQOiV3wsCVsmIQ5tUcJSUKxp6+imnluXC/5wI55O
	lV9Cd82tbWWBT8dtVkLh681QqZdxi//feUVco3DQ/Dw5mc7WmshogIbHqin4bgyemfaTiTx/lYCYm
	nEZ9xZPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpjvM-0000000CF4M-1S0Y;
	Fri, 31 Jul 2026 09:53:04 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpjvK-0000000CF3E-0GND
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 09:53:03 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8HfB61230360;
	Fri, 31 Jul 2026 09:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=L7PyaQ
	GMoExvW+n3/+GALrV4+I4wpAG5f3iEgm9W3vY=; b=ceaxp/7U7YhFh5fglxL8h0
	3HVWCok3u62ArBB4WijrD5qOLrwVYnMQ2zhC3IR3CJmDgjWkztKgIttC6J/PF9cV
	DLsuIgUz/yxaDqWkU6hewXeK2SJKLkDjye9btw9PDz0NFsHwY2Nr2ibTmyf5iK9e
	D73/aNeeW0zlN1WHkgAK0jbDJ4IehxDjwZXi8zp46SowGxEHTZlA8j6miAYPj3IM
	Soid6+pug6FVuXOwvcFXfFGxzP8+iyypC8ahRHD+5/AfL5ZcoL0gmObKwpf+rDDk
	QqELR7W4gWiTiZNzGTiO1zjC8Zix/Ee1oCyqLgE+1l4jFCNVEdmIW9/OtBEetIuw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p3cbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 09:52:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V9fN5L000929;
	Fri, 31 Jul 2026 09:52:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgq7h1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 09:52:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V9qoKL33096384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 09:52:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E5CD5803F;
	Fri, 31 Jul 2026 09:52:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBC565805A;
	Fri, 31 Jul 2026 09:52:46 +0000 (GMT)
Received: from [9.43.118.67] (unknown [9.43.118.67])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 09:52:46 +0000 (GMT)
Message-ID: <7fb7cb5e-397a-4cf1-a3f7-e75309784e3d@linux.ibm.com>
Date: Fri, 31 Jul 2026 15:22:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv5 2/7] nvme-multipath: add support for adaptive I/O
 policy
To: Guixin Liu <kanie@linux.alibaba.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
References: <20251105103347.86059-1-nilay@linux.ibm.com>
 <20251105103347.86059-3-nilay@linux.ibm.com>
 <61fb25bf-3ee1-4400-8b65-ea6cfe27b9a2@linux.alibaba.com>
 <83701c38-ba9e-4134-85f0-e11e1129375d@linux.ibm.com>
 <879797f7-ce3e-494d-be11-fe96790fa03e@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <879797f7-ce3e-494d-be11-fe96790fa03e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3MiBTYWx0ZWRfX11Oj3dl18ZEf
 vDhdAW4OTYEIyY3aXioOA1gH5WuL72fnFsv6/vPOPlvUVoNdbPMPbmOc0bZRdr56atkrQInfSrI
 ePBj9aS7HXlFYFcsszSupIJ35L8L03E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3MiBTYWx0ZWRfX0erh6lQ6mBKf
 uTjASLLw8yO6wvvUWWxDqk20Vku6vMm34syqyDXMDk/XPweWu9CHKRNysZ8Dh8rU1AAcTk0xcDE
 +pwGGxdlNuz4PIVt3JmyP/Zjz7bm5U4VEb8UYN88AknbiLULhVRa/s/WIhKETpYNyvywFzz+2ij
 FEwn7/aZSzOCBeCv5mnqjvZo/fa9Xeb+LmC2IFjUhImy+sWTOuVdXnS4GNPDHzlVOVXSC5g6UrP
 a8WyiBf/fmOIkspPAPD1jm1amiXi2WQVyAnPElZjfeTTHe12LP/57Iwr/8/G7ihhT2Ytkdc4UVO
 uzNYyZKtmp9RRLVECtIb5zVDZ63+e43jNJAwE/UbXy8L2ORPUiLWMQYgIz6yloSkfe7AL9/StsR
 J51aMUUTXG07Yp6N79rpj8NyaD/jGCyyy/7c58vP3V72oAO8cvAZdt4+dYPPUP0FeSAj4DkGxYl
 5MmqkKrnIxGqEGY9qIQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c7073 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=zF3b4vWIHgU45-1fILkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Q40VPwKpPJnn_BUiRIdbwVU-e1-OCwwj
X-Proofpoint-ORIG-GUID: Ayw9Qz16NMmS2SIZRtl2I0jbb4DtF23E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310072
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_025302_222565_F02091C7 
X-CRM114-Status: GOOD (  16.12  )
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

On 7/31/26 8:18 AM, Guixin Liu wrote:
> 
> 
> 在 2026/7/30 20:01, Nilay Shroff 写道:
>> On 7/29/26 1:25 PM, Guixin Liu wrote:
>>> Hi,
>>>    Raise some comments to see if we can keep moving this
>>> feature forward.
>>>    Once this feature is merged, I'll be able to build the
>>> service-time I/O policy on top of it.
>>>
>> Thanks for the review! BTW we alreday have patch revision v6
>> upstream now. You may find it here (in case you missed it):
>> https://lore.kernel.org/all/20260520182112.863076-1-nilay@linux.ibm.com/
>>
> Sorry, I miss that.
>>>
>>> +static bool nvme_mpath_enable_adaptive_path_policy(struct nvme_ns *ns)
>>> +{
>>> +    struct nvme_ns_head *head = ns->head;
>>> +
>>> +    if (!head->disk || head->subsys->iopolicy != NVME_IOPOLICY_ADAPTIVE)
>>> +        return false;
>>> +
>>> +    if (test_and_set_bit(NVME_NS_PATH_STAT, &ns->flags))
>>> +        return false;
>>> +
>>> +    blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, ns->queue);
>>> +    blk_stat_enable_accounting(ns->queue);
>>> +    return true;
>>> +}
>>> +
>>> +static bool nvme_mpath_disable_adaptive_path_policy(struct nvme_ns *ns)
>>> +{
>>> +
>>> +    if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
>>> +        return false;
>>> +
>>> +    blk_stat_disable_accounting(ns->queue);
>>> +    blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
>>> +    nvme_mpath_reset_adaptive_path_stat(ns);
>>> The adp_path still hold the ns's pointer, should clear too,
>>> otherwise, we will access a freed ns.
> Is this correct?
> 
Yes correct but this has been already addressed in the latest
revision. Please review nvme_disable_ns_latency_sampling().

Thanks,
--Nilay

