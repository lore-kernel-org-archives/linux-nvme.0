Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A220606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EtCsS8wT;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hmNTg4Kq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=20swoZT0GodyJu76+EEiyU0yuzcVFkqKt0LYXMdEXw4=; b=EtCsS8wT9yJGe0
	ZzP54H2YLSBtfGbOIUA0mKJErTB45CPFbOkXd0yKt+dB7XcKn6cnRx+L4maxCvYSUoL+Zfoy12W1i
	mK4e8D7AyUKhRVmMzn7bWhGYzBedTLahukGHjIgEU4yi/ZTaQ3A51SuOxw9GGKOgl0AUwU4blzO5S
	KZi06F6/V2ObslMcQcLmwKX4gwzQl1hfiek5XsIWyi0oNVtFzCOFhu4ODBn+MO9jRRjbTELyMLST0
	8cBOJm/nd6+Cp1KVLxCnBNhnuhtWvgOM/Ul1gRwfTNg+QMs+8SpvLpj286E4e437Kicf6IqF00nFN
	ZZ8iIQEh2cU9K5nogPHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM54e-00000007Grd-36YW;
	Wed, 28 Oct 2026 14:56:20 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM54c-00000007Gr9-2Y8v
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:56:19 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBirtf1136346;
	Wed, 28 Oct 2026 14:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=20swoZ
	T0GodyJu76+EEiyU0yuzcVFkqKt0LYXMdEXw4=; b=hmNTg4KqWwoxnTi02E6zJR
	gTubbfcdy5/VeJfPhCJ4WXyblrXRZFWP/PQNeMaD1VgKNj7QaYYvUIJI+iUG+aW7
	Ykb8BO66fpsgZg90GKpvEKwFg+13BELpavDmR/Ckl1Krvl5+IWIPJrfrJT8OyDZk
	LHyVe417zjIPDIeFS4qd5LHY7NpNw8jXt+yAvzuCUU2OKZy802z3u+2q3eDWwEEW
	pBTzTOHJvGIVhifmV/hku7yKcyQ8Qc+oRNI3XisQKtW0C5zVJtevCltncuIJP2Ng
	ekVcsrceDk9FQjpBx0Uzhjlqn8dj7IDM0FyFC9KvRfoiF8dMnGxBgvii4wxe+0sg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd75bcu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 14:56:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBnt8A1441984;
	Wed, 28 Oct 2026 14:56:08 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnndfmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 14:56:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SEu8jM64487698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 14:56:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09DA358043;
	Wed, 28 Oct 2026 14:56:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE6805805D;
	Wed, 28 Oct 2026 14:56:03 +0000 (GMT)
Received: from [9.61.174.203] (unknown [9.61.174.203])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 14:56:03 +0000 (GMT)
Message-ID: <7ff677a8-185c-487f-a51e-750cdde045af@linux.ibm.com>
Date: Wed, 28 Oct 2026 20:26:01 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: Finish the blk plug when integrity allocation
 fails
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261028064436.550665-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261028064436.550665-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae20d0a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8 a=NcyRit3GLvo1xQcR6fcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX2HDynMoI+qVI
 S9AIJYyI2fpX2V8eSmIuFCXSq9lfz/Nyp9NNH2znLByCyiQM7Im8zzx6FIoUTzD1JDnXWHGuPpQ
 fiouwzuTQi8HKcZNO8faF8y8Q2wnIeebvat7AxuytC7+bCCWPLzoKL/0qbCQZNL//xxGNpOAZYk
 KoXSrzMgsUoOTZ2AGgb8U49bVXhvCe3RVwp+3vFD9sc9zcFOUiC7+4esdcHl9EdBv4Q3O3nvzkj
 XIvHoNtcmS+g3YofSpeosrzrOloshans/Is1sHtxe4xblr/qNzOFm837YrDLzsrQDaXr6fAhuPv
 AzXvDt7wpLyubE4F8WUZb5QTPO649k2hWDaIeFoX1pwJXaBU1hQpyPttBh8dkZFqesfWhQqZr1b
 gC/N5jKdCJFyZpNib05u5wodk/UEYO0tFqhQcRZOmHJq1lNIVY5YODKYLQwej48nxeXzaio6ciZ
 lytg1Rm8Dko6Q9Pgcxw==
X-Proofpoint-GUID: Wa4MTwvFTmepjN6RX74P6Z-VV7CNpAF3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX9/XX7Wuoe7Ph
 Sb7gRayRhQTIO4gMaigd6vkKG4ryD1+R1E9lpLwgofW07opxdQtDbs3JZRq+XxjLE1DhYAr5+UM
 KR5M6Oq2rxtawdz4QNedj1N/unnTd3I=
X-Proofpoint-ORIG-GUID: vOciLw4qrcn8e8c7Xo5Gg2wj1jjTsgad
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075618_658944_70D3EB9E 
X-CRM114-Status: GOOD (  12.16  )
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

On 10/28/26 12:14 PM, Guixin Liu wrote:
> nvmet_bdev_execute_rw() starts a plug before building the bios, but
> the two error exits taken when nvmet_bdev_alloc_bip() fails return
> without calling blk_finish_plug().  current->plug is left pointing
> at the stack frame of the returned function, so the next
> blk_flush_plug() walks a stale list.
> 
> Route both failures through a common exit that finishes the plug.
> 
> Fixes: c6e3f13398123 ("nvmet: add metadata support for block devices")
> Cc:stable@vger.kernel.org
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

