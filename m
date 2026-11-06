Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34E0606D80C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pHDfliC3;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KP2fab2O
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=o3zlzOTQ1E3ScmCN0W4KBonIlkl/taKVgsQbI9pnt78=; b=pHDfliC34R4sLj
	9Kd86lkqs/Wp223fC3qbn6FxabAmMxJ7UVeaZ5TuVDmL31MwqGsZRzgWe39/bprtoojDMTML/sQNz
	ULclLVzqSMRAoFWSQyJlvFUwON1l9wYbV6+A7BUGLd5ChXP5RyNzoxpe1qc/p0Osg3qIfjBYfSvW7
	9gygJrc/MTPWoaoNJMpF6eY717nFFfSBXH8tn7goA78W+3DHgU6t9/DWENMxkrboF7Leq3HOyxF4E
	bV1/xXOe8iDl+vJlTC6bkhZN4K2dxmH3QTua9jsH0fRYi96RzVVCtWSmeLHixLGn3mxtxb0ZVbqWU
	VTyTbWGEeWrdo6ZtOCwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJrS-0000000CPab-1Ki7;
	Fri, 06 Nov 2026 13:20:06 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJrQ-0000000CPa9-0www
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:20:05 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AiDaQ976740;
	Fri, 6 Nov 2026 13:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o3zlzO
	TQ1E3ScmCN0W4KBonIlkl/taKVgsQbI9pnt78=; b=KP2fab2Ox0u3bVj0nY30Gq
	1+RXqG9L64FHBUs37yLwykDBsMtQbTu9g3EaKPY9/Khu+Yz17NkankPnl8RqX4yq
	fSt3Hsx7GWlzEXMj6WuKz5/C0+TyNGDjsV8+VV3zIpKDrrTWcn6Kme+QQc4QQ69a
	jrJPfDqmq3uBrCcCf4rrXVgYP9f1qIwmwwZjpaP+Ri63Az8bWCIVe9zmDAteucCH
	R4Yjra0of3SPhLWfUNlXEmmrqhbtERPGSp0/2yaAS+sOpVKT7NKYBEWlQcPm68jC
	ZPsf0Ir0DMUNskeEb87xma8TjkuMc74B8WKIjEcUPqnxrOyJ58WPG3s4QSrGX4MA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbva2q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:19:57 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYxHn3159704;
	Fri, 6 Nov 2026 13:19:57 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrerrw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:19:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DJuPS4588296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:19:56 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 725E658061;
	Fri,  6 Nov 2026 13:19:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86A4558059;
	Fri,  6 Nov 2026 13:19:52 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:19:52 +0000 (GMT)
Message-ID: <d97a00bb-a089-4a00-8427-eb5e44cb9a78@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:49:51 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] nvmet: remove unreachable "pcie" entry from the
 address family map
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-8-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-8-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: rZz-b-TRsVdvagINeLrUR4omQxmFrxzy
X-Proofpoint-GUID: mKkUSW65NNdeoUhYDAO3AwSLr4dyWJCN
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedd3fe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=cazXS1QCPFhO809RKzYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX3X8jaimASrtN
 vJXThnFSJh4+0dkaHL0wrB3C/PCwyY8Mm5OiYsBW4j++4DwKME0vcwFQTyDAlH4tD5EARc1rCn+
 VZoEJf3fuhMZy2uWTteESi7DwgimkxA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX98IImzwYeeJq
 pscmMFY31VtbEDRFl0QyIFP0UrXRQ8r5By87NCV7S88TX4DfV996TVWotYQuA0fx5ihqqif+374
 vlJCJmVkI2Kx8jN2hs20jXMBm2EwtzReAqB9s7b4ZAVY1J9RIrwDkRdaFOZX0DAWaXIEGju27LU
 IeGaarkgzo1mucpryLCwQN4+DaYbpyv/KKGVo/EEmfp8qEC1CXHMRQ2npFAveQBbYJ9LebgOK4X
 ZJos1D+jSj07j5Ly0NY8xPv5rI9+kxh5Fby4FX2XKcqhkB3KkZ3KvM8bb4lGVD2D85zEkoIJhpw
 vI8Jcd+zJjK0X59FmzrK7rfkJgrl1oRrbxxQ66WOyMdjHvpZMawrUzpFuQirzjK5zroHu1k6BSd
 ARp7+ihfXOL/Pk30EXYoc3m9/qU/dfVNPvtz73Eq4mZ4nz3KC5VgQuIzFYWsIRh8UpK9o2IDQpX
 vP86dOuOn+MYLVrH/Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261106_052004_390771_91925138 
X-CRM114-Status: GOOD (  14.00  )
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
> The first entry of nvmet_addr_family[] is never matched: both the
> adrfam show and store handlers skip index 0, and the
> NVMF_ADDR_FAMILY_PCI type is matched by the "pci" entry further down
> the array. Drop the entry and start the iteration at index 0 so the
> map no longer needs an explanation for the skipped element.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Wonder why does at first place, we added the duplicate
entries for NVMF_ADDR_FAMILY_PCI in nvmet_addr_family[].
May be some history which I don't know...

Anyways, Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


