Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B246CC9833E
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 06:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eaWKjZvQSHbYYTyJEyOvBwvRlRtI699XA4i8EHQmOew=; b=aQIF1VuoTG66mzOkXKXDl9wddr
	oSsxV6NHyoAMMiTHPgxmMqCkV835MQTGajBjGcV7r5qrp9Y9uEZzRPee0kiRvopKTdpfb6G5dY2YR
	v4vShw9eBEu8TG/hBhZ0QiULJhPwRsIioQmG0csbdf98YGI0OAWBhkk4YXPATtk7WNi2LijS2BlyB
	gQbT8RyLfOlQoakK/SFiDzlJUMnn2kfs9FejwPvchZ90ZO3B+V1tsLooAPBFoug1HU+tl9PphTqA3
	t8Ce73WplriEAMPOjSGG6PCY2yuAOIjz7uhbET5JzdHCoGXqduZDtJFF0hgiJYphyBNsugJHBvqAm
	rlnoYS8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4xQ-0000000HSWN-2dfr;
	Mon, 28 Sep 2026 06:35:24 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xB4xO-0000000HSVx-3HWD
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 06:35:23 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RG03no263821;
	Mon, 28 Sep 2026 06:35:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eaWKjZ
	vQSHbYYTyJEyOvBwvRlRtI699XA4i8EHQmOew=; b=iP6LlPAhiBsbpLUc3DTVAR
	trupDnCCvpk4vQbkc66EO0JFL+0wR50Vna4IsHqGfjxM2hSMzqNZEDrcK/9Y2TFV
	vo6r/L8xLdxdi/PQwzY4fGrPKgjkh0QtpSyxHWhsnKA1f/XhpgK2FihKCcmcwWAp
	NFNtradAbJzzQBK0SWQmH2jrlaOvVKoSFNZBD47n6vbGJYL2VTpA3spadxFxb+zc
	lx9FR0TTN3EwTg2ABOKeRbzUcSAoCzsy5qoHPpRF42qxSr/qlCSY3Su3IDkbrXWp
	o8K8erNGnhnZzv6fxMewz59hGlfiedM/Ore5o4vTeDl46QW5qwUy6tkDm4qcEKGw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4yss9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:35:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S2OfKx2055547;
	Mon, 28 Sep 2026 06:35:14 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gxrcpm6jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 06:35:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S6ZDZI31785614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 06:35:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 358CD58056;
	Mon, 28 Sep 2026 06:35:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7CFF258052;
	Mon, 28 Sep 2026 06:35:11 +0000 (GMT)
Received: from [9.61.92.150] (unknown [9.61.92.150])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 06:35:11 +0000 (GMT)
Message-ID: <5d763307-ebd4-4d30-8a69-04f418a5cd0e@linux.ibm.com>
Date: Mon, 28 Sep 2026 12:05:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: introduce struct nvmet_passthru
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
        gjoyce@linux.ibm.com, chaitanyak@nvidia.com
References: <20260925112120.790530-1-nilay@linux.ibm.com>
 <20260925112120.790530-2-nilay@linux.ibm.com> <20260928051011.GA18753@lst.de>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260928051011.GA18753@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfXwVg6SIIfa9ox
 OTv+kRTrmVKf+i/Rq/+FlgJfdehfeXizTdPJqDXJkfVj/kVH02RkEW3TCgJFBfZs2J4bmDd3I7j
 eYQkHS1mtDRDeDcDlyvuhVou1I/eONY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyNiBTYWx0ZWRfX4uga8Gw/K/YY
 nhUUodcznC0K4zXhjoAhuQErmzkxGMt1GPonybx9MimtNyvgatb9Gajd7a4X0Eocxizcleb7s2m
 bauiYfh0TA5toOiGE87q7rbunlJnQS5Hzk2ui6tEE1nByKPd5NCWVhXWsbaV36oMAr792mMZ76r
 4WIturvqQdL6bAqw6PGCQPu0+eVJ+J0Cf95gTiC1ngjN5MmxRs+rn3eO4Fg4rPNvcBqxYrSRenU
 dsiKyioKj6V6VoCXPFrChwxEsKqmoU5wfMpBwsg/7yNQ2xhxfeYVlpnwXlcQlt1XFombQIPWcBq
 TGX1JrvxBsmu2FFiD9Ql+9zrmatYQaAmdoS8jDdf7QQpo0tduSrHliDVhIqCNVpeIr9FpsnuFMj
 VJ9gWnCXj1fvKVayS8y1E9w/VmWQxGpdROITEPwztIlZuIXk3dsvegaTNTJeeo597PLNxYtmI7U
 qCY3SUg0kS5vDuRSdzw==
X-Proofpoint-GUID: FvfKF4f9U_m2-r7_wB_zd_reT_eRC4lK
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6aba0aa2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=cuYsot4GVFTmo8XDYCsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FvfKF4f9U_m2-r7_wB_zd_reT_eRC4lK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260927_233522_838354_2CB892A6 
X-CRM114-Status: GOOD (  15.72  )
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

On 9/28/26 10:40 AM, Christoph Hellwig wrote:
> On Fri, Sep 25, 2026 at 04:51:09PM +0530, Nilay Shroff wrote:
>> Currently, passthru parameters are grouped under struct nvmet_subsys.
>> Since passthru can be configured through configfs and all passthru
>> parameters are exposed under a separate configfs subdirectory, group
>> these parameters under a new struct nvmet_passthru.
>>
>> Grouping passthru-specific parameters in a separate structure makes
>> the code easier to maintain and reason about.
>>
>> There are no functional changes intended.
> 
> If the fields are move out anyway, should they be a separate, dynamically
> allocated object so that non-passthrough users don't pay for the memory
> allocation?
> 
Yes makes sense. I'll change it to the dynamically allocated object in next
revision.

Thanks,
--Nilay

