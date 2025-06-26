Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ABBC7EE32
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 09:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dgJ8LezffNghIZ65PQ36N1TvbmnAeClbcssTPpcJleE=; b=vOoz7pzAeEU7ffbp/nQt30RPWE
	Gu+RIkNsJrcV3H3wKWggg+aUUGQzw3REJCr1mZjI+aChZVaVMqzPy2pEltBLR21L4UKC0PRiJweSH
	W8Yh2AMoYDM08gsmOCBja3LQXdWJ2B1/CnCaU9Vf0cOgpivN8zVxcyAm2RPqQTbBVmKHvHeowsXqu
	kL3Hgd1XATNlASCQuWY4WuBGgpyEPiW/XL+uppaw+a/xMbRZNCWlGnHBipOoTeoX79I6K0q6iei0F
	P/SPN88UNIu5yFoI9nOjmB7gxCbyClTOmR0WrdDNw7IcKV9jxygidZOb60IKuliB5hzM9VWXgZxF9
	gZPYzW2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUiTe-0000000B4b9-1gKn;
	Thu, 26 Jun 2025 09:01:02 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUhzF-0000000AyGH-2a36
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 08:29:39 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q4AZM9015765;
	Thu, 26 Jun 2025 08:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dgJ8Le
	zffNghIZ65PQ36N1TvbmnAeClbcssTPpcJleE=; b=h685EGdDOAUDJuygOBblhR
	e/p2hBIbpplthbf7ueFaiPGKiGdzjN9ZKnslSeiNspJXppOJPL3Zni4pF2t4z1FF
	7eVbYEM28dpTEN7ZvE4jRx7DjfWmsZ9yzFZ7rjEHLNf+Yl29kQEHCyehR4NdtYgX
	hgkf7nQtCzrGZOitgqAVKfB50/6WLfxMjSrR5EeqYp/SbiRUev+I9npI0HhgtZWi
	kmMBSky0ittMdAn4gtxjqALIIflE+T+T7ZFuaYXJWjUIGBs/rw2i9cK9kE+Xtx7u
	DJebZIovhVx4fr0de4hpiTndsd9PS4qtRxUUoTkp2yWC63WqKLJwtHAAs41zORBQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jn61p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 08:29:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q6L40j014710;
	Thu, 26 Jun 2025 08:29:28 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e9s2nkts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Jun 2025 08:29:28 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55Q8TRIM27853506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 08:29:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80ED958059;
	Thu, 26 Jun 2025 08:29:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF0F58043;
	Thu, 26 Jun 2025 08:29:24 +0000 (GMT)
Received: from [9.109.198.209] (unknown [9.109.198.209])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Jun 2025 08:29:23 +0000 (GMT)
Message-ID: <45316d0a-97fd-4f0c-aabd-30015be94059@linux.ibm.com>
Date: Thu, 26 Jun 2025 13:59:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3] nvme: correctly account for namespace head reference
 counter
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, yi.zhang@redhat.com, hch@lst.de,
        kbusch@kernel.org, sagi@grimberg.me, hare@suse.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
References: <20250626051935.801205-1-nilay@linux.ibm.com>
 <c2233513-6736-4c2c-a757-96f205286f18@flourine.local>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <c2233513-6736-4c2c-a757-96f205286f18@flourine.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA2OCBTYWx0ZWRfX/1evmsq7EDaK IdsLHSuFVNnoSuqW2SgDJe2Tk4IEY5aAkzPR1pPWwHIogx+pJKLiH23uMq+iNl74jakN3Zrv+v5 RaeYIoEZ6on2HXDgDd0zoOGV+TBeqyW3f67HllgTGniPy4a1JE79XMQSiYicekDq2BllqcGZNUP
 adxc28AZzyPPOnUXehPi96V6p6GaIztunXe5oweetwIIFbKXEO4Ly/O4CsxPknUV1PRm3OGujgP 1vn2wl1B2/MOUyO6bNboPtlyeiNeT2UBGvD4RfxIP1/o3psouqAbnBHZKmvcySzszJOBec0MWM5 ZGQcAkkVQNQvE+re6RrFLrNSkbo3/BdBcTT7Khtu8j1qfp+igVey5mM+JzsvWUlAZD7WOJDJ3r9
 L8yv0hImepN9F2001acSn0pW2i3Kj8O2cil5LfXwKSxt4Sd/h3PobVRXR6iNHSLD22rgpRfN
X-Proofpoint-GUID: -j4nB0iu8yAl1l9E89Y6b4niyajqO4a0
X-Proofpoint-ORIG-GUID: -j4nB0iu8yAl1l9E89Y6b4niyajqO4a0
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685d04e9 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8
 a=__RwD4hcay5KO24_EnoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=872 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506260068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_012937_827840_E983C0E9 
X-CRM114-Status: GOOD (  17.16  )
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



On 6/26/25 1:18 PM, Daniel Wagner wrote:
> On Thu, Jun 26, 2025 at 10:49:19AM +0530, Nilay Shroff wrote:
>> This change prevents stale kobject entries from lingering in sysfs and
>> eliminates the module reload failures observed just after running
>> nvme/058.
>>
>> [1] https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
>>
>> Reported-by: yi.zhang@redhat.com
>> Closes: https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
>> Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the multipath head node")
>> Tested-by: yi.zhang@redhat.com
>> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> 
>>  		list_del_init(&ns->head->entry);
>> +		/*
>> +		 * If multipath is not configured, we still create a namespace
>> +		 * head (nshead), but head->disk is not initialized in that case.
>> +		 * As a result, only a single reference to nshead is held (via
>> +		 * kref_init()) when it is created. Therefore, ensure that we
>> +		 * do not release the reference to nshead twice if head->disk
>> +		 * is not present.
>> +		 */
>> +		if (ns->head->disk)
>> +			last_path = true;
> 
> just nitpicking: what about renaming the variable to something like
> 'multipath' which matches more with the comment.

The variable @last_path is meant to indicate that we're releasing/removing the last
remaining path to the namespace, which is relevant only when NVMe multipath is enabled
(i.e., ns->head->disk is set). So if we rename @last_path to @multipath, it could
become less intuitive, as the name wouldn't reflect the actual logic — that we're
conditionally releasing the nshead reference only when the last path to the namespace 
is being removed. Hence, in this context, IMO, @last_path is more semantically accurate
and self-explanatory.

Moreover, in nvme_ns_remove() as well we use @last_path in the same context as
mentioned above. 

Thanks,
--Nilay

