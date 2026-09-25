Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D328C9830D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2026 11:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xKoiiojkT/32RNOr9G/qkfVAXI3D15CAhsxdo9/YIbs=; b=Pykn07RL4LxGoDSNc3FAkNkR2G
	6eZDUhQZe5KvGsi05bIzwl0qsPugpn6TBjLCsiMojHGas3IDmsiO/5pm8P2W/3j6j+ok7PLaFzJE8
	PVQg56URIvrdiN1QEPNkYRO9gF6sTUT6o1qwYYC0/oC3k7SSZniMWzjT2Bi2UscAI0EMfolwboBpw
	v4+GY4Fv1JbyCJAkQfgOtPUipPX/5GRlI9zBfAgwwhXKbo/VhMZ2WH2oTxESRX6JIJuETN8TD0V8z
	eAAKvS3pJiqSRY07Qlboun8pmOvBmToqlXyv7CyWav1DOxAGxBjfsO3oDhFx0R28UDIiNWvCz8222
	zXmZVDqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA42l-0000000DBm2-2bLU;
	Fri, 25 Sep 2026 11:24:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xA42j-0000000DBlV-2Mrg
	for linux-nvme@lists.infradead.org;
	Fri, 25 Sep 2026 11:24:42 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4Zoiq074217;
	Fri, 25 Sep 2026 11:24:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xKoiio
	jkT/32RNOr9G/qkfVAXI3D15CAhsxdo9/YIbs=; b=tUrsZK0xf2V2sx+bxoDNor
	o7p7YgZx2woNYySMvbMLiKlVJCh6iq+eTZgPz9JZTHQcBrVU0Q/dYKf7nA8N2Dq6
	s2JL6Iz3atzmzyVUJu1zfNyaKAA1evFVU+6qM9xaVr7BFft0obb5JSEEq5CRI/qg
	38Ozxf7ERixof7OfDHfZauY85l/k2M9SAvfUd8ag50j8U63YlRXdFykmHDViqkue
	V74Ep8wuiFshtVwvB6W9ZznroQAljj9KJpNTaYwuUEmy3DVavuq4Ijp35RnHqxtT
	PjoPC80ca3tMVaRTX4rpXhbLZ1V8fhlCdGpkZB2Pm/RoamG7f8lgq2rNBBilh7cQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2xuac-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:24:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P9vCEm3288818;
	Fri, 25 Sep 2026 11:24:34 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe227fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 11:24:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PBOXkA32309940
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 11:24:33 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0854E5805B;
	Fri, 25 Sep 2026 11:24:33 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7B9D58059;
	Fri, 25 Sep 2026 11:24:29 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 11:24:29 +0000 (GMT)
Message-ID: <00f6b963-bb60-448c-ab42-fcca052074a5@linux.ibm.com>
Date: Fri, 25 Sep 2026 16:54:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvmet: return Invalid Field for invalid NSIDs in
 Set Features 82h
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        John Garry <john.g.garry@oracle.com>, Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260920033500.3209138-1-kanie@linux.alibaba.com>
 <20260920033500.3209138-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20260920033500.3209138-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: uwLMHY7wkcMVWWKR3rVfRC_Mcu7EtLEj
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab659f3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=Wb38n0UyosfG_voPj4AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXyIru+PczSjLj
 nyFMKAMZHo9e6e5hD/Uw6G9T8KnAtMNBe2CSNNLv35Q0G8UHXiFYSAHqClIFQ94Jx3qvVCrwpqj
 IuKXPX4XL/WyKCCl/hQw56To1DlqtOHNVJWNHpRTLg7WzDsDFxcOaTZCHcDgOwrZr3C2ZzXL3JN
 9q8plvdXE5R3CdyupGs2EAfgt6esUklQCXfRJcs6eigpSZgl7VfWBSbkO6tp/DFfCIBwGvi9JwO
 o5NQnLmWk1qtuFK5/OR1UPSlStVTqPZHj611MontLBCULYL4bAovvCwaiiIfVGWfgEKgT1zHeWr
 Kt10K6diwwOUwjFzdeoTYne98v6J6fW+o3n6kNngJ95/ca5a/fNPVkDnI8tLMgldD/BwgtjfQOK
 iwecVWIdl0l0g0p4UJ33oa3M6eLFpgCWhNGucLylbzfpatHf5h0InjpNmpbAV28EL1bpJTTTvgk
 JcVujc77KP0byYpKU5Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA0NCBTYWx0ZWRfXyxPgLKnFV7so
 iXN8772yxYov9/v/HyQJdd7KnPchd197/E0JAHIX1RxZUhSoNXkvcHwjkoGVXlcAf3aQWby5dAh
 S3vTTajc/si5aszS/nkGc5BqAvyvT1Q=
X-Proofpoint-GUID: dZwu2U0QYbqYodyFKHDzR8jOBU54xAR6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250044
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260925_042441_622710_6A7156D0 
X-CRM114-Status: GOOD (  16.36  )
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

On 9/20/26 9:04 AM, Guixin Liu wrote:
> The Reservation Notification Mask feature (FID 82h) defines its own
> status code for namespaces that do not support reservations:
> 
>    "If a Set Features command or a Get Features command attempts to
>    access the Reservation Notification Mask on a namespace that does
>    not support reservations or is invalid, then that command is
>    aborted with status code of Invalid Field in Command."
> 
>    -- NVMe Base Specification, section 5.2.26.1.33
> 
> The Set Features handler routes the namespace lookup through
> nvmet_req_find_ns(), which returns Invalid Namespace or Format for an
> unknown NSID.  That is the correct status for the generic
> namespace-scoped admin commands, but not for this feature: a Set
> Features 82h naming a nonexistent NSID is aborted with Invalid
> Namespace or Format instead of Invalid Field in Command.
> 
> Translate the lookup failure to Invalid Field in Command.  The
> broadcast NSID, the namespace-without-reservations case and everything
> else keep their current behavior.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

