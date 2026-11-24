Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A0B606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=r8V0iknt;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TMiL8+l5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nbEYOME3A2o2tsy2X3A5CJzZe8FVvaVXV58PWUvFnQM=; b=r8V0iknti1Pljs
	5m+ivXl2jensJshIf+rQc0Cw34WwsM4y7HYJCDw71bV6HXRsv8fBFwNeqFzT9vPAAh5v/nMFvYklt
	huixUbdSquPp/rc50xGZW0qbhVueyydmFy3zJG1cuO5h2XihFYFLOMdIe8I3OhMHr0tcyrS5gYjj7
	YtLEiaLwLuUyX03RN9XUmTtl823pHA+2fN37ikbVwyCrg5y1ZZiHmSjynWTIZHL7CWdFDjzNYgYVe
	ee0Ao2mNzGC6mpEUHc+YKLLQ+BUmYvoBkGgCP21D0G9vWidm8ELaP4nEVMi6BCShADrB6LN4IyXHW
	tfrFhL/eroG0Qozm6ICQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsO8-00000006snl-0zZD;
	Tue, 24 Nov 2026 15:24:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVsO5-00000006snN-07Mu
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 15:24:54 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOF4udn2795965;
	Tue, 24 Nov 2026 15:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nbEYOM
	E3A2o2tsy2X3A5CJzZe8FVvaVXV58PWUvFnQM=; b=TMiL8+l5XNR2fpJ+LNqBea
	PPkZ0NiLOXILUHt6GZXlt/Q9wgdAx4IiJJYGY+guT/QmAt1wEkLto3DO6QISVm87
	7Us8mRLBYK3ixuQ+6BVBeUnat5KB981mFnePa56jkrFxHZaHXvrMPRB1vOyoOtYk
	U4ampCmQ7iqLcUa/fILuoPUO9SEV3c2nib4xRCoRSHB7EBy+HSFbstKodVsT2wP7
	1py8DrHAW75IKQuph3dIEtDGXUXDio5JWaxqG19w3/XgSloHtGcc35tGznNiBq2b
	lp5Oy8ielGd4SRS9VbMfmOFbPSpshe2BGX0Ixuzjzl1HAEzGQjIIVteebt5ABabg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g17x4x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:24:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOFJQMw2467798;
	Tue, 24 Nov 2026 15:24:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j3quftua5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 15:24:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AOFOIZO54984994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Nov 2026 15:24:19 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D02AC5805C;
	Tue, 24 Nov 2026 15:24:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88D0958051;
	Tue, 24 Nov 2026 15:24:16 +0000 (GMT)
Received: from [9.61.113.35] (unknown [9.61.113.35])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Nov 2026 15:24:16 +0000 (GMT)
Message-ID: <75713e52-0a94-4671-b9e1-43ba51fca522@linux.ibm.com>
Date: Tue, 24 Nov 2026 20:54:15 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] nvme: define an event bit enum for
 nvme_ctrl::events
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261124120032.1824788-1-kanie@linux.alibaba.com>
 <20261124120032.1824788-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261124120032.1824788-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: WA5EO-FyhjKu2ec68Vl97W2pgJqcarg9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX6kIUkIMFYq6A
 YDTfuqimcIOxZJvGvAO+rSVM7Cc/DS0tcCl6nqF3EiYiEwIp37lOKwLrYAq7I0v3sAWyrCkH571
 3IxqLKwxiUumk85/QTxvZsWAzDOS5nY=
X-Proofpoint-GUID: 6Qu4ZPvqLs_x_5IzlYyxihT74suu8q8b
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b05ac24 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=2wTWctV0xbt1DyIdua4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA1OSBTYWx0ZWRfX+9Mv7TSkf9PT
 Kiyewl0HvYVU5ZMzbupjUgTTXFMp0pMpH+qT4wfvbZJJ2A8LHaFq8cMvtK21BWUeykZgfJJlmkn
 mqw6s3SwRRkvKm/tQp9dvYy1mhH5l5C47N8JabiTJE1/A267htFq/LMOetKT8veJjawLBeRGlf5
 0caWGRwxTIEsGSbYDJVBnPxDYRcJ18gdf6qTBCMjc56DWa4HVmXY9QG1PzE0N/VP4xAmmaq5nEb
 lL3ateuPm6L36vrWt43Df2oHQNkD2L/sfGMDIAoFURJo/OkaNFjedaznsMjePnhhUCKSO1WuIti
 7uHzCVaNbcb5ExX4Rfo7JkgZ97Q5ASUtCubEjedk1zQSJ6slhNK6vLL5Nm5/kYvmiKpmGwCTEx1
 aanV2KuFLMgfRkFYKHuCCtRqrj1iHImmsS96A/CCCdZEKrQMYThmUR58SWPhVpUODEzZKeBS593
 Clz1UlA8x4Zx0+UthAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_072453_185581_F428A8DD 
X-CRM114-Status: GOOD (  12.85  )
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

On 11/24/26 5:30 PM, Guixin Liu wrote:
> The only bit used in nvme_ctrl::events is indexed with
> NVME_AER_NOTICE_NS_CHANGED, an AER subtype value that doubles as the
> bit number.  The AER subtypes are numbered per event type and are not
> a bit namespace -- the notice and SMART values overlap -- so borrowing
> them as indices gets ambiguous as soon as more bits are needed.  Give
> the events field its own numbering.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

