Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E163C05023
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 07:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M5nXvryQ/dvux+xOLk2Dh/OUTqHhgPkj5JQmGV3w3TE=; b=OlFXlHLln1j9HiJbToIiKXwplC
	C2PyZzCZnZo/Tr3Ap+EQnIVJ6MIuaudUe0TPaRl+peQz8Vr7Cfm2dSos2imx0gi0ALVIysUzz21kJ
	jFfPvamDxUYDpOEn2GL1g5af1R3uJ8D1+6I/I9B9Q6UCtgfLZDLajezlOxa73nhqBkCy7pjQBPqgt
	Bo+M3rWCKSXYYyOyg37XVEGtaghjw2MXsu79yTMzyjwNfA5aJuoukhG+4XaHW5G0YzC0vfU2hj+Hu
	1ugTunIyuW2arxrYSSYUuyayv9ut2Hzsk4n4rIpisO4+Gyr83CRGPP4OFOAjaSfCASsYAhmqd1cz5
	0CvDYFtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHC9-00000007QKm-2a9H;
	Mon, 15 Apr 2024 07:56:05 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwHBB-00000007PhS-3HlT
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 07:55:10 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43F72SfK017796;
	Mon, 15 Apr 2024 07:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=M5nXvryQ/dvux+xOLk2Dh/OUTqHhgPkj5JQmGV3w3TE=;
 b=MIOEOkma9+FzY6GqWsuEWQcEdPvQWGFVHzrEYB+axp5w3r8U4iRxr4vb7cs+Y7eIE8jU
 MoEQszFxXdbfJtwlTAawRze6CSP5xgnWgJ+DdrnIglcd4LzG1Vo0BuQIYYxMv9u8QpPP
 SUV6m3PHQkCYRn9x1uT2xkLNiFQPuA3IDsvp4xzkHsETXgEmsTrY2i0xswZ11sirnkb2
 0czWcdv35xiPkGnob55Vj5mJ5P0VQz4p94RC3cUDp4IlrGOl4JdMwbf4ZNBQcNtud1tt
 IcpBEaAOMDx9RNWIheXMusXUeYQ2wPYPGOGuVkRqUsYbQr8w1W2pK9kVNsIP/tEtfyVb cQ== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xgyg983cf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 07:54:55 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43F6CW8X015862;
	Mon, 15 Apr 2024 07:54:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xg5vkxg53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Apr 2024 07:54:54 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43F7spP021103140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 07:54:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C19158064;
	Mon, 15 Apr 2024 07:54:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47BC558069;
	Mon, 15 Apr 2024 07:54:49 +0000 (GMT)
Received: from [9.109.198.231] (unknown [9.109.198.231])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Apr 2024 07:54:48 +0000 (GMT)
Message-ID: <d1ae6dc4-1898-4afc-bd2c-974ad6702a43@linux.ibm.com>
Date: Mon, 15 Apr 2024 13:24:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: find numa distance only if controller has valid
 numa id
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        gjoyce@linux.ibm.com, axboe@fb.com
References: <20240413090614.678353-1-nilay@linux.ibm.com>
 <20240415072530.GA31958@lst.de>
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240415072530.GA31958@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4TYTBOwBhgsFIYq___HB0RHdiAgXMe8k
X-Proofpoint-GUID: 4TYTBOwBhgsFIYq___HB0RHdiAgXMe8k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-15_07,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 spamscore=0 mlxlogscore=636
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404150051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_005506_448941_02054268 
X-CRM114-Status: GOOD (  18.14  )
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



On 4/15/24 12:55, Christoph Hellwig wrote:
> On Sat, Apr 13, 2024 at 02:34:36PM +0530, Nilay Shroff wrote:
>>  			continue;
>>  
>> -		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
>> -			distance = node_distance(node, ns->ctrl->numa_node);
>> -		else
>> -			distance = LOCAL_DISTANCE;
>> +		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA) {
>> +			if (ns->ctrl->numa_node != NUMA_NO_NODE)
>> +				distance = node_distance(node, ns->ctrl->numa_node);
>> +		}
> 
> Please avoid the overly long line.  This could be easily done by keeping
> the old code structure, which IMHO is more readable anyway:
> 
> 		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
> 		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
> 			distance = node_distance(node, ns->ctrl->numa_node);
> 		else
> 			distance = LOCAL_DISTANCE;
> 
> 
Sure. I will incorporate the above comment in the next version of the patch.

Thanks,
--Nilay

