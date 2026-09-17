Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524EFC88E72
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oajRSSPC0EOb90UdbfXf6HcgOxXwZmmUpvLczTgZZNk=; b=Njnfp6z3uEleQ0G9hnxyTbs/jx
	0r6FCxEZX50Oyw+PSDPaFEQfInzU4t10pv1qu8V4hgJvPbNrjgTU5To4H3iAwQ2DIN3+6loEvwXD0
	wYbGMg8UHbRD3s00rOGo7MedBFpfVgs2+swCOkMPrjXMUt20Ad1gBMv0CRIFW9ZP27uYOY+ZlMFFT
	mSZDn4xd1WeydGKJMn7TAnAIvlOvVyMGIuV7v49z0gsW9YxAI9ADxx+ey1GtbhErkKC84VWYkrlQs
	GnoG9hTFaPuw8soEddS0jvmo8vSfE2NNwLtA/jGdLoQALP9BCK2vdj+FUMiaSU1pNyUbeCx3uCD9n
	Xrp3Sugg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77u7-0000000Aw2P-3idf;
	Thu, 17 Sep 2026 08:55:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x77u5-0000000Aw1v-1loB
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 08:55:38 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68H61k8D1715675;
	Thu, 17 Sep 2026 08:55:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oajRSS
	PC0EOb90UdbfXf6HcgOxXwZmmUpvLczTgZZNk=; b=D5lRRaKPndvBqeTl/89JSQ
	f44K74/nYGXuWQYjH0408Sn1E42G804/mkikACzIVM5fjuxxPGGAveS73hs8sobD
	yQBRVVClUNo2npOvEtYLuLKsoJPJ4nJaBT0zInJIp4Rjb37zwluvPcnJO5+UmB3K
	a7GmlRapgXZ1Mgi9HJVVdLIpaGvM8HGxU7sXJtm2WCH1abNFxrv0Tva8xSGrQlXc
	jki5/e+sYDPSfzrwAOCOQPiOFHJQEKBL8jOMx/Eel1xcS992lsHIoFpEGbaEUcvu
	YEoYwXNOKmesqEXFKp5qAQGQjEDHRWOtYczT3h9Vkbajy1kpHkbxbyEstTlvUv/g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf59cer-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:55:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68H652Jn2723214;
	Thu, 17 Sep 2026 08:55:32 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yrnm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 08:55:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68H8tWKC3277312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 08:55:32 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37C3058063;
	Thu, 17 Sep 2026 08:55:32 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C89458043;
	Thu, 17 Sep 2026 08:55:29 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 08:55:28 +0000 (GMT)
Message-ID: <787b6816-2705-46b5-b24c-5bee2024e00c@linux.ibm.com>
Date: Thu, 17 Sep 2026 14:25:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: copy the hostid into the ctrl before creating PR
 pc_refs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260916114254.335277-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260916114254.335277-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: BZ5ZhJZoulNaRcC8zxn04ya2AnOyF1_G
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDExNiBTYWx0ZWRfXzf5slNPthkpn
 BYQ/6dBmx32mp35CxC7OgbgZFFtplZeBBpIrSX0dfWdDQz6LS4vHPdTc/7L/7fTZCvVe0idXV1C
 2+ey25ncr6gli3RKsznWfoiGiF5jQOQ=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aabab06 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=0pIMXCPmVxpyh1cQ97gA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 0_ykMhIIwGLCDl5shb4k8fwkITc3Jr3f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDExNiBTYWx0ZWRfX9YCwj+IlZ76Z
 uywQ7xJX2WT+UQBKTBpTH4C1Zxtzu3q72BIbixlQAlWd9Qvd+MMQxxX+/keXpDhncLSDBRxle3W
 opWhH7UG4rZXdL2bv8tBg7DZOjxp/9Q8WZgCwVDZ4KMAuLE3tF5WFQgSeCG+E0b0K46NvNayhZH
 NxzUP/jpKJejFr0yJRTsd1dqxxvD6yyyFW6kKdfc4Jh138eKkYqUvY6WgmXNy3m2qNLd7lplrfh
 rJWFkGAWxs7Z3IM9y4ud/luA8KCXrj2pZAfhEp0HOSoTPn/OE2YP5TjffoZoiddwzul9akal1Np
 TThZwosIDrc30X8hdEF1MUF6JE2JwyL6s4+iJpw/7dld0Ogv8szvOv+6J2cJ+XW71e1gjnKoGSi
 In0ryEeXT0ZfADKx7uhwjRoUuoiSEjUYc0NQKAAVafREpC6PQcq4gMpZWz6lQU60rO2Kdqe5wb+
 Og1k5mKeiAt2XGkU9qA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260917_015537_472485_75F5D903 
X-CRM114-Status: GOOD (  15.98  )
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

On 9/16/26 5:12 PM, Guixin Liu wrote:
> Commit 6202783184bf ("nvmet: Improve nvmet_alloc_ctrl() interface and
> implementation") added a second uuid_copy() of args->hostid near the end
> of nvmet_alloc_ctrl(), and commit 7b658153f1b8 ("nvmet: Remove duplicate
> uuid_copy") removed the original copy that sat before
> nvmet_ctrl_init_pr() instead of the new one.
> 
> Since then nvmet_ctrl_init_pr() snapshots ctrl->hostid into the
> per-controller per-namespace reservation refs while the uuid_copy()
> from the connect data runs later, after the controller is published.
> The ctrl is allocated with kzalloc(), so every pc_ref created on this
> path stores the nil UUID.
> 
> pc_ref->hostid has a single consumer: nvmet_pr_set_ctrl_to_abort()
> matches it against the preempted registrant's hostid to kill and drain
> the victim's in-flight I/O for Preempt and Abort.  The match can never
> hit with the nil UUID, so whenever a namespace with reservations
> enabled exists before a host connects, which includes every reconnect,
> Preempt and Abort silently degrades into a plain Preempt: the
> preempting host sees success while the victim's in-flight I/O is still
> in the air.
> 
> Copy the hostid where the rest of the connect data is consumed, before
> the controller is published and before nvmet_ctrl_init_pr() takes its
> snapshot.
> 
> Fixes: 7b658153f1b8 ("nvmet: Remove duplicate uuid_copy")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me.
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

