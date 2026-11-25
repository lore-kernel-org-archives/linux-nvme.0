Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D1606A326
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=t3wRQlY0;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M700tM+b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OTyB8eiqReKuBSdc39NOktHn8e82ttBGdsJxwLkDypg=; b=t3wRQlY0q3vybS
	Nnm5sgbVADQNsqOIeTRLrEOdJmYX8fs1CoJ+ic1XR2oOMbfec0SCiS0qGTsNZuLlIK54jaRCaDU9R
	r6vVty8q5iJvArK4Hm/ccoQYEURIk4/tOVN9mbDl6pmPGkkSdXTSIiBce/jQdC128kwwa4igMdTqQ
	UfCzblTm+h70iXGHJc9rSbap8Yz/j+p+81HcJIReFd2WE3MKzYRA0CDs/aAsWeMxjvIOBlq2qq4ai
	wkZPXSs6Al9cx3Og8iDvZkTMoyPsWCjlIn6o/g3mBj57I3OFMYlQ/21Tco6x2xoGaLPph5Z8+ugbe
	MEIMsDzapFPynDVP/e1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWAMN-00000009ToE-0QDx;
	Wed, 25 Nov 2026 10:36:19 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWAMH-00000009Tjm-2UR0
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 10:36:17 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4d6h973428;
	Wed, 25 Nov 2026 10:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OTyB8e
	iqReKuBSdc39NOktHn8e82ttBGdsJxwLkDypg=; b=M700tM+bwkJoDQekvgfYG/
	dOJh5NJv47ya9lWd2+7/DrfYmSteojxK7yN2NIaVhs1S6aldAH9i8hjzN5Im/j/n
	QXFYoYvOXlVRnIJpqcnan12MTskdy6liUcvXO6ATBVUBqNnTceLcJoMw/MyvPft7
	j045EGJ3WXvdOMPN4pVJ/nId+OaheQAD6Ij528c22UY6TB8rMi9MtY5RD+NhXf4u
	PeZ1N8ychfJIO3SWz+URZ4jAcq+lydWZYKvG6TfPdu8jL18qhPOdRXU+hwVvDoPH
	CdlUWnRW2nQ8gfu/eM5IotGnLL1tLD03xF1acKBa33orTP2HGguGrwuFTcfRn/bg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34gvbgdn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:35:54 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nM4p2002805;
	Wed, 25 Nov 2026 10:35:53 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j5a413pu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:35:53 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APAZqgj28705306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 10:35:53 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E213558051;
	Wed, 25 Nov 2026 10:35:52 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 334905805E;
	Wed, 25 Nov 2026 10:35:50 +0000 (GMT)
Received: from [9.61.9.230] (unknown [9.61.9.230])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Nov 2026 10:35:49 +0000 (GMT)
Message-ID: <ebfa8b20-b160-4dc4-939f-4fc8d84d7c36@linux.ibm.com>
Date: Wed, 25 Nov 2026 16:05:48 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: document the per-subsystem iopolicy sysfs
 attributes
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261116114208.2226472-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261116114208.2226472-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=CYCdd7rl c=1 sm=1 tr=0 ts=6b06ba0a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=54us63YHYWHqKNPbwcYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfXyyOVJvQemX7f
 8HqOzq6ZUOFpvXYLSTPfPuj5MJ8XLw6l8c0Usx1vFc5s8vQ7TgHU6LqtFa8DRqtzoJWnZEQVjCd
 OpM0Xi8w7Jkq3/s+oLR2unxEkKkvxCY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX8jehIu9IqJPq
 CfWHutHhRUuX+MvIVK8g3SdYGnKLr0GD4/5Fe18HEj1QKLHaui8Hd9Zft3mtk38wfAzGicuOqOf
 nWshHq6I1zf5Nu7wL/ftWM0+or/rv0lgE68rY1gcr1dDO23mKwzixXQjrmIS2meBjuVdw/WVHvP
 L5/BDjLfWmmXzUT/583+EiAEEI1m1IKVJEGOSX5Dtx75YZUbUdAU/dPS9X4M+KuDhW+uTG1WyT+
 89kcMNCggQt8FlBKZf/QI1vCJW4Zh54NG0c3sh0BBDB+XKEtgJovp+7Ixvo1bTGRE9HIa51whaJ
 R1ocUd6D/oYH+EisEdSUhDaKDUcTE3bEKvICuobehHVU8BI2OMy9h059gY6r7aYJ68H4oVx53bp
 UW64ETzTkUqDUxmde/98VLAALzZxzDt2MtukkEPPD2gXoMRR+/3q+pySaOcJOvy6rLSQkg7OrF1
 LyLf/9LbXzSG8PWYy2w==
X-Proofpoint-ORIG-GUID: SzVKPjNJmavpvskl0mEnPSkHMP2fgvcT
X-Proofpoint-GUID: ZAKimiNJ-tzilneHp27xF967XgWh90U4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250042
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_023613_784398_ABB214C7 
X-CRM114-Status: GOOD (  13.66  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 5:12 PM, Guixin Liu wrote:
> nvme-multipath.rst only mentions the global nvme_core.iopolicy module
> parameter. That value is only picked up when a subsystem is created;
> changing it does not affect subsystems that already exist. The runtime
> interface is the per-subsystem iopolicy attribute, which applies the
> new policy to a single subsystem immediately, plus the read-only
> iopolicies attribute listing the supported policies. Document both,
> and note that discovery subsystems report "none" and reject writes.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

