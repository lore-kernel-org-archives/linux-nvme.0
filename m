Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5B606A32C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bYUn2D0e;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CYgb/9c9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qMKgjwQHyamf95lJicC5RbMu4G1gYsYon8uWKC+/n5o=; b=bYUn2D0e4fIYMo
	ZT5dlz8WjdRhivgs2jrO7dOYhFx8PeV8CXpHtoKGPZ+PhzFkMwccZKBFEEvTsXEkfB8gCNYyspYGm
	bRmPnVb2DleUiHkHUEn/cbwrjrmGVaIntSEyEpovaU+znJmSQJz7sD98PwRM068VXOITZm4rwd25J
	IRzcW14CTMN/4EsMBnvdPjUPmhkvi/JAuRC1f59Kfwuu2sbAvs48FxMqFHnZW+nrhuAvpSyxuJQQ3
	ThvKQZi5pkWQLsbZjbK/U9X4/G5xUYVUqXQ2FADhJUkjQql0Z1iDPl6IddMkdwblYKWu6oWK9ir+s
	kQc9XUpoG5G7ypS4YsVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJs0-0000000CPhn-37z1;
	Fri, 06 Nov 2026 13:20:40 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJry-0000000CPh5-3bBx
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:20:39 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai7Lj2143114;
	Fri, 6 Nov 2026 13:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qMKgjw
	QHyamf95lJicC5RbMu4G1gYsYon8uWKC+/n5o=; b=CYgb/9c9IiT+B+PjguHTMM
	spYkDF+000iMzzFrVlGcJLL4lhYtC0GRtAnk8e0trbYDrnTiaTkhZv6lOjZLsHAW
	8Pr3UpquSkcQ17kUVWMvoEsGsqGbJUz3CQWxNi/NSIDjeFUfN3YLbrpv6pxHxDji
	P5rdDpAWZFMmAKMCTNTSqoG2KNyDNj34THG0wfJBpagfRGkpb1J5yrwYJgNGGVfD
	M32Zpr+nByptImGAJtj4cGzbUvRgGCgPpv5TMYLF2mAl/TULOCzHL0Z36Xhy8NHF
	ecXtxjz9g34MtldJ3GB7D9uE+aEs4xwkObpH1ZMKu0V4dCQ2OGgBFwjk5f7/99RA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r94beu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:20:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYxav3268955;
	Fri, 6 Nov 2026 13:20:32 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka7148r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:20:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DKV9M23003834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:20:31 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C08F58058;
	Fri,  6 Nov 2026 13:20:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E255558061;
	Fri,  6 Nov 2026 13:20:27 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:20:27 +0000 (GMT)
Message-ID: <c6ef8617-a48f-4376-95cb-63b6ff6c3c09@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:50:25 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/9] nvmet: passthru: remove unreachable break
 statements
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-9-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-9-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedd421 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=TJqm2GRHP8BU61Rg0goA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: x8IsJbx93ZSrWhlao9eaHanj7b079N0c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX+jl24UpT1zjr
 8QNHBBLJFFChbtU+4BzNeRCgT7YPoE26kQAK4W+yutKuztsyPtDYYwNa2jAUXr2OYGEQziNCAvx
 QbOb55M+vIBUG92SCZrx1bW1XnaaWkkrwZRjLZvhq399kSFm+BZVs02OCfGe7I1muxDmQveuD1Y
 xDmUF7sUOTZwpMRphJdCu+TVqUyN4svKauGD0XWJD1UCGFffkOiMUaBoLIYhDmyLvQtwxGEBBGA
 NLGOXbBvigsrolGeoqWUKmK/pGBGiT8AlIWE7/C8q2z8rXvsDGrfB1CEbPS/RmOkLUfay+Z/nVC
 YqHgZMRenrc4pIIVYyWfG3HFyCQw073hXoYB5txyw15ppt5OQ/IowtbK/QVp363ivFjyGNvTWRb
 cRcimYW0OO7vbkrWhc0l+VHDSzF/DwXKbALCuFiLNhdN+xufFJqusBEu+xzEFt9sgM/1e3Rsj9F
 Vhv1x2yRbXMYanzwggA==
X-Proofpoint-GUID: I2XNvLmpjQr32mRan9vLC30VePLJrrZV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX7cJRa5vlUb6k
 cahG/kvdLFAzqMvuUabNpUW1CtfSsLz61D7996VS1BXNX2qgUpo7rFBDgbT9+jUvQCzJPyRbc0d
 iVFPQtqAGImu693qQKm/t9iVkjSh4Fo=
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
X-CRM114-CacheID: sfid-20261106_052038_909953_468B3637 
X-CRM114-Status: GOOD (  11.28  )
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
> In the nvme_admin_set_features and nvme_admin_get_features handlers of
> nvmet_passthru_parse_cmd(), every path of the inner switch over the
> feature id returns, so the break statement following the switch can
> never be reached. Remove them.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


