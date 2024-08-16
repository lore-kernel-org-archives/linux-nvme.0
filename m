Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9512C531DC
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Aug 2024 07:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1+5+lAVAMOr3HHDuETi+ZAuBXY8dps6db3zVxzD0Vw=; b=DjX6FqkUM/MLIrz4/9QS6aK24k
	H4SzsHa2wPZjLv5+9eCqN/HjW/p/Gv97+AqMiHBz3bl/bsuvkg+QNHCMuWewxcYPbHpD4Y2Vom/02
	+DfF3jTHohtAPHBijM35dkcCg+32EczXxRhbiVjKiT1RxlTEE3augKS4it4mbB/if6PCm0GDqaqh8
	zm1tSg5m6hG5Xpu00/mWtlx5XCnxbmQHmUEG86IgeMY8AOW5F8GluZdi+Nyil2529ykUZY9cKgWqa
	Inea8R+tpHVa6MRKHRadZI4atrUz343J26hlved8yCO8mjLn7X5EbW85jT0ujzTZ3xIFdkuxevgZr
	B0oaIrrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seqxT-0000000C0eq-3Gs6;
	Fri, 16 Aug 2024 07:01:11 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seqxP-0000000C0eO-2puX
	for linux-nvme@lists.infradead.org;
	Fri, 16 Aug 2024 07:01:09 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FMsI6T005704;
	Fri, 16 Aug 2024 07:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=E
	1+5+lAVAMOr3HHDuETi+ZAuBXY8dps6db3zVxzD0Vw=; b=M/K2rU4l5xFv5dUr9
	iqj0xASwbz2C3WsrqLOXr8R+84PXuVqC9HTxK+Q6vdIY2NcSeN3jNZcXVh/QrLFx
	HxFHxOf1fLgPvRvEzyQpCDYvsQAncGwPFluW4gJN19ONRwdYszWC21PYu2hhKrbW
	Y37zbr6ymSjFfYrf/NmCY6Qd3mFacDENcZyOWi2RzaOv+fnrnpqbH/oTC14dkpf8
	DuAHfGU0xaw8Vijx3bvsN3Fhd0F1WhxlhwxYW/XmXMcc592Z+ttmrrGnB0nrwAgs
	waq0dsMvZLFlSGdcdcJOSQFjpuuNS4k4m3x+AH9L3XfkubKFyZhFLickbHQ7NLO7
	PgHCw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6f3gd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:00:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47G5bYNH010055;
	Fri, 16 Aug 2024 07:00:54 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx12mn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:00:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47G70pJB14942504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 07:00:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FE3258063;
	Fri, 16 Aug 2024 07:00:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F8235805A;
	Fri, 16 Aug 2024 07:00:47 +0000 (GMT)
Received: from [9.171.14.70] (unknown [9.171.14.70])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 07:00:47 +0000 (GMT)
Message-ID: <16c5ec69-da33-49ef-9032-ef0cb9ac09f7@linux.ibm.com>
Date: Fri, 16 Aug 2024 12:30:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Remove unused parameter
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, gjoyce@linux.ibm.com
References: <20240814135702.99402-1-nilay@linux.ibm.com>
 <20240816054111.GA29113@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240816054111.GA29113@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kVv-ajVZA-kLfTI325lbh8SaCfHL00qs
X-Proofpoint-GUID: kVv-ajVZA-kLfTI325lbh8SaCfHL00qs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_18,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 mlxlogscore=799 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408160046
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240816_000108_090157_3F040E3D 
X-CRM114-Status: GOOD (  14.83  )
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

Hi Christoph,

On 8/16/24 11:11, Christoph Hellwig wrote:
> On Wed, Aug 14, 2024 at 07:26:50PM +0530, Nilay Shroff wrote:
>> The "name" field in struct nvme_ctrl is unsued so removing it.
>> This would help save 12 bytes of space for each nvme_ctrl instance
>> created.
> 
> name is a structure member, not a parameter.
> 
> The code change itself look fine, though.
> 
> 
Yeah ok, if you prefer, shall I update the patch subject line and 
resend the patch?

Thanks,
--Nilay

