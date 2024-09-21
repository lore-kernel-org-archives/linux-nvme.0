Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB4CCF9C6B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Sep 2024 07:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzCbM6Et1vbKkuAVFJTmxsZwHleNuE0LrFdB24Im824=; b=kQeGPkqvuSfc3LMfAjJk/9z7nU
	PD8Z/4Dbm0cHLuMz4JejPuSAOhHJndB9c5kOtDLTiJ6m/p37QfhzkC9tpdptVrrewyOi3lNNFCqWX
	DTxyr1EBXlD1nQX2FZ6xdOHmqVLdyMqX2RTIdMCRvsc504m7qcAI4lZ3525WggGax0hhSQBl8h4M3
	8t7NdN7ohacSj6sJ0Z/2v0GlWg8puQMtnyLRg+SoTApg313fOsHpoZ16kbeEg+4zvsRojSP45pD47
	pZ8DPixUR3tmj0KQiRpmwNvedBQUDdTZ3TRKMq526ZBNxzgbFUb6+nyghwRiW1bR86sE712n7/Y7B
	ywZDTjvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sruC9-0000000DOd0-3InZ;
	Sat, 21 Sep 2024 07:06:17 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sruC7-0000000DOcY-2oph
	for linux-nvme@lists.infradead.org;
	Sat, 21 Sep 2024 07:06:16 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48L3ZSlv016705;
	Sat, 21 Sep 2024 07:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=n
	zCbM6Et1vbKkuAVFJTmxsZwHleNuE0LrFdB24Im824=; b=nmrZeiqmJEi78qmlK
	6AxVY3kGf0SEnYZAf0w8ersEwvZlawB/xxzk4kOfYwj8i+ZBFByZIUcfb57ccT1G
	mY3zyh8SScXClxASU/GicsofkvLQd2PnFm1jd1+BVwvwJPe9Ls59Xk9bOSs3GKkY
	etv7PUxqbX07X3DMwii/06pXZ4NTZfXb/1NA5QBPeQ3d/dX+G+NhqZOGOC3Ken9k
	Ao23JQmeLVX0pkicJWMsRqpK4xmqciF8uTj5oW8rXm7wQohwZk6EhVtOH0j7JiHK
	xcNQLWPRR3DzAHpefERD1RWrDwph3JFqA7uxE6NaxQm9fjpQyFSGTKRE6RlNmzA1
	VUzLQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvagmch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Sep 2024 07:06:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48L6RKMM000765;
	Sat, 21 Sep 2024 07:06:03 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41nntqubtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 21 Sep 2024 07:06:03 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48L762DS48431766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 21 Sep 2024 07:06:02 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C7CB58051;
	Sat, 21 Sep 2024 07:06:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 438785805A;
	Sat, 21 Sep 2024 07:06:00 +0000 (GMT)
Received: from [9.171.13.135] (unknown [9.171.13.135])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 21 Sep 2024 07:05:59 +0000 (GMT)
Message-ID: <96531d69-172d-4116-be76-db79085f7fb4@linux.ibm.com>
Date: Sat, 21 Sep 2024 12:35:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-passthru: allow nvme ns-id descriptor list to clear
 EUID/NGUID/UUID
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        kch@nvidia.com, axboe@fb.com, gjoyce@linux.ibm.com
References: <20240917085112.155173-1-nilay@linux.ibm.com>
 <Zu2nslMqpfPR9j6f@kbusch-mbp>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <Zu2nslMqpfPR9j6f@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VpTRs-deG_YC9u0H_1SJMO_aoSHMiFUc
X-Proofpoint-GUID: VpTRs-deG_YC9u0H_1SJMO_aoSHMiFUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-21_02,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=630 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409210051
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240921_000615_756823_B189B4EB 
X-CRM114-Status: GOOD (  12.14  )
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



On 9/20/24 22:19, Keith Busch wrote:
> On Tue, Sep 17, 2024 at 02:21:04PM +0530, Nilay Shroff wrote:
>> @@ -547,7 +543,11 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
>>  				return NVME_SC_SUCCESS;
>>  			}
>>  			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
>> +		case NVME_ID_CNS_CTRL:
>> +			fallthrough;
>>  		case NVME_ID_CNS_NS:
>> +			fallthrough;
>> +		case NVME_ID_CNS_NS_DESC_LIST:
> 
> I'm pretty sure you only need the "fallthrough" statement when you other
> statements inbetween the cases.
> 
Alright, I think you prefer combining all three cases together without any
fallthrough in-between them and yes I believe that would also work. I will 
send the next patch including yours as well Christoph review comment addressed.

Thank,
--Nilay

