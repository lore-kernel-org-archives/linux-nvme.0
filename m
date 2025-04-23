Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FF8C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 06:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4U00Um2A5WXJ4SbW7ZK/p6efa+xV1QJA1UoUNHItMu8=; b=Mdr7kFkbZuwflBFBBXyUDv2hOM
	9da06V8K9GE18EfGoeGdHujNTLA9iO4O0vu53qk4jd1KiuvSivMkK7LE1TimRl6n58EDl/EC5geQf
	Q4eQCHcMnMRLfBHBH4FZUGVt2QpOzN6yrMNPGFIgfgn5v62sqlDsL1GtMIIENVaw716hTBQLVnpDp
	yhKyOMEE9DJkKoNqnxoUPScAXgUegNpN8X0g4FiTl895kMwtCRmNU7k5uvOP/l9wY00Ov8lMltX29
	74v2L4e1ZWcgCdS3/v4SK/9Q8fXolsCdrjdZJvtaDVr2FLj3OlmS0nG3808+FbDv3vLfxo6GHJhDD
	KEgE6aJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7Tz6-00000009Ov8-0HbO;
	Wed, 23 Apr 2025 06:53:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7TN3-00000009JvS-00X5
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 06:14:10 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ML3JEI014707;
	Wed, 23 Apr 2025 06:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4U00Um
	2A5WXJ4SbW7ZK/p6efa+xV1QJA1UoUNHItMu8=; b=N78JBNyhUawJJ7Y76ZEcK4
	tUd9ZGz+GB8hngAXj2AARLnxmH8IEXLz5ihWWMRf+hg7xofFyQQbB7AI0bhOqG8r
	EDBEVvRm4ECOjGe8HkmjUzxSjciPX3FNIVhC22M1XXLZvVf41DSEb8XLEUjtIl0P
	K6ogqRmgeCLUgjYJSra1GKJXp7wKKW8+QZw7QVZGFPTj+5cCL/e/65EADUsP827Y
	C8l2KbVrC1eU0z4rlyUe0vU1os4QNSmGN6XGx9PlXL+weAk3E8DgT2oT6GX9nTVH
	r0QxkO/ozkw3FrZT7yjeQIxU82RW72PVmBrhqC3cDqCv45gT5zUv5PztOZi4i3tQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 466jpe1skm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:14:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53N1aD0T022271;
	Wed, 23 Apr 2025 06:13:59 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 466jfx9p9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 06:13:59 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53N6DwMx32768638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 06:13:59 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA0A58059;
	Wed, 23 Apr 2025 06:13:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4445F58058;
	Wed, 23 Apr 2025 06:13:56 +0000 (GMT)
Received: from [9.43.53.143] (unknown [9.43.53.143])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Apr 2025 06:13:55 +0000 (GMT)
Message-ID: <0b9d9fdc-6cf9-4140-a73d-01671de4b997@linux.ibm.com>
Date: Wed, 23 Apr 2025 11:43:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 2/4] tree: add queue-depth attribute for nvme path
 object
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
        hare@kernel.org, kbusch@kernel.org, gjoyce@ibm.com
References: <20250417135951.239447-1-nilay@linux.ibm.com>
 <20250417135951.239447-3-nilay@linux.ibm.com>
 <0e70314a-3c08-40ab-ac53-e9fb7e379f44@suse.de>
 <20e5b90b-3c2c-4be8-8119-b14fab733a5a@linux.ibm.com>
 <ad838a6d-6180-4c00-85b2-448393689478@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <ad838a6d-6180-4c00-85b2-448393689478@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cdS0FwCFctNV_W_oqjzrchguYT8H5blp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDAzOSBTYWx0ZWRfXz0V5dI8xhis9 pP+XuCoLMEwRILRKrrkFH67AlaMftYuRsuRZN+T6eZzJkhA8CXD6v9UlABeJu9IkxFr4NhAmUwM ulFJKc4f3Jm18WWEEj44AUMToCBN8gXuAhgVNkVAPA+vmX+R/ycTjDKEO3ZqXzTIWtfrCs2lEYj
 A7lin3w7MZCLRglgN84NapknXADpnPyPDtFgsCSwbHEhZzGjDLVIBKXna22G84kjRRGMjD8aBGZ JL/AI0K8i/6SG9dR4X2jhghmTZ/jdZh0XxPe7ejiyRiYj6wApPej5QMEiUNAAsMJKO9nLRvjhtV KNkBhey+Mpz369TOTAiPfYMQjMQX8zA8pYJnLGbuG5TraoP1jy5Ev3JUjNGeqluQd8nF0jz/FKg
 jEY9E2Ie9F7UNYV6JjVuEOGwPVRhS954Y5wbVucy1bwKXh9Dmo/EXYI3FrtTzvn8/Ca85a/b
X-Proofpoint-GUID: cdS0FwCFctNV_W_oqjzrchguYT8H5blp
X-Authority-Analysis: v=2.4 cv=IdWHWXqa c=1 sm=1 tr=0 ts=68088528 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=sxAane7pClyoPD3ogREA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_03,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=742
 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504230039
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_231409_177716_A1B69737 
X-CRM114-Status: GOOD (  14.64  )
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



On 4/22/25 10:53 PM, Daniel Wagner wrote:
> On Tue, Apr 22, 2025 at 08:02:49PM +0530, Nilay Shroff wrote:
>>> As discussed: saving the 'queue_depth' attribute is a bad idea, as it
>>> changes frequently.
>>> I'd rather read the attribute value from sysfs whenever
>>> 'nvme_path_get_queue_depth' is called, and use the tree structure only
>>> to hold the pathname.
>>>
>> Yes correct, but I thought we discussed about implementing non-cached
>> version of API in libnvme 2.x. So I implemented cached version of 
>> queue_depth API. Daniel can you confirm? 
> 
> I was under the impression that we agreed on the default being
> non-cached. As it doesn't really make sense to have a cached anyway.

Okay, my bad.. probably some misunderstanding on my part.
I will fix this in the next version of this patch.

Thanks,
--Nilay 

