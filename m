Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE7E606A326
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3N5tOKeF;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CHP7JV4B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gk7G8sy5FovrVYE1D/byr5lXhFpO4UtNL7B0oSuicxs=; b=3N5tOKeFPHgqcK
	lJ76pPuUh5v5Ir+nSqp1i8W2ekWu00+i7EdcUh6D09R1E5yRL5R/EIHNPuSrktxdS61Y/b/pffN3C
	DL/kzQXSFe9xj22S+Br+D/DC+1S3aSxDvmf2o86xiRl2tz8THLlPajNmhNL6S/kbI6wdXnwgKpKrV
	OVwta6REolI3QH99BX3+Pax6+inPHdPiyzfNl2sis29WF6IQjjRA1uXFW6+zVxKJxz7eeOpHNfpYF
	RrvHEW/3ktOWDZAQhnfNyrdt9kGjSChTbKQzMEfouxD0P9aZ5jsU4PJvDFJooS+2QukSIww0gAwWL
	8qoFh4tekBlid39TExUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJsS-0000000CPqp-3kLp;
	Fri, 06 Nov 2026 13:21:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJsQ-0000000CPqA-0Vkp
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:21:07 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiRTG2143838;
	Fri, 6 Nov 2026 13:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gk7G8s
	y5FovrVYE1D/byr5lXhFpO4UtNL7B0oSuicxs=; b=CHP7JV4BoacnY0bm8uqzF0
	fMlc+2CyT/iwufSaeG7ZhNY8D21rseTosaiHVMt3plgLzXRyE53ygpNcrwsYgFG1
	yOKGLW8V+azo7QjW9eDBiJbmiavdFWBqVT+5ebp9NobHqb8HLrsxoOjhsLy6ar+/
	OWyCV63zgEvqdG5ls/u6Oul0FN/10VmbHy95vXsJb1WUPlLBcsDyKid6rYspxzcP
	FXZSBfQtd7XWXpPFTX2+i/zn/JWMEFCZz0xo93oHFml3JQSmg+TX7FSTNJxbrjIx
	jqNW0CV9Nek/vI/CjJAmjXz7EOtmKmJHkVWv3GXDxY6yJc2npc1Q0OgYe+MFIkjA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r94bhs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:20:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYu6u3268909;
	Fri, 6 Nov 2026 13:20:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka714c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:20:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DKuUP328264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:20:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FE1258058;
	Fri,  6 Nov 2026 13:20:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368175805D;
	Fri,  6 Nov 2026 13:20:51 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:20:50 +0000 (GMT)
Message-ID: <688388c4-125d-4004-b4fa-855558139d63@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:50:49 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] nvmet-pci-epf: don't drain the never-populated SQ
 list
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-10-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-10-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedd43a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=JIftLcS-lHwQtHbSY-IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: dt7uI4eXFrW3MGl6YbO4iB7Kj5ZmlnXO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX24cb31O4PNf2
 BsJrRBani+HQVgD+BAYX1FnFg55uz/l0Ekvd/a/KkcGtU7xB/TAlQp/EtV0eOtzBQoiUxTq1Nti
 gVUBbsWeKzAG1esaWpvT4dOgEdeT5pXxxFAg48oocK4F6Xu3uQI9iDzZdxC7w/1Sw8E3YzjymsK
 hOzjWrvvfoMUe/L7cxidISC7C6550PtrrER+GKV7Zo5+yfjbLCT4AncMMVTsAUuqH2X7EMcQlIb
 8u6iFvwr/YutSPDvBiHJX2T0uutPLnLSojrqC0lGMiyWQUJEjySvexjK4QBB7eGdh0vw2XKzPBa
 o7HkX63ncBbnLwtCUVchvt/CHegFjjcqyDadPsMm2u17+gCDV7wKnQaqwc17zl128gFkrpZLFqG
 WrJtgzqHphBTqIT+cEuACBIO6ewDL2YKfxQ+QnVNPxhZmSXwdHyrOrHuvQkb3XQAjNLhW5/ywZR
 gVsKvbG+Q1LLdViEtdw==
X-Proofpoint-GUID: dDxH82cX8CkEibmIxRE4hT9Ovx5tG4Cl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX4pbl4KhNHkNz
 8cDHQhjO12PMCpOCatLOIHqRMCqM8C3miru+T2yFXSzMjwez2DZdmkLihuWQOH5DjHXBXchVncK
 gIvs4Rx4fdoibEpKtjS7m9q6ZeCDxz0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_052106_171794_B856AF2B 
X-CRM114-Status: GOOD (  12.27  )
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

On 11/6/26 7:57 AM, Guixin Liu wrote:
> nvmet_pci_epf_delete_sq() calls nvmet_pci_epf_drain_queue() on the
> submission queue, but IOD links are only ever added to the completion
> queue list, so the SQ list is always empty and the call is a no-op.
> Remove it.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


