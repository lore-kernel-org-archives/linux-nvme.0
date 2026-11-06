Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A82606A336
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 13:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wQV0hm7X;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fcUP3YgY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=rCjDsFSoM/fdDI1KYgvfVCEFpnlqU97IrK9aw2LXfOg=; b=wQV0hm7Xw+k1Iv
	CWYdB2cO/5jFuBEdPi8mtKe3/6mV+kjaye0ire8+3SxOuhqIsgKpgiytZl0ftsPPAjv1yr//SZNrw
	vThwGEolstfPABYceSdXIL1WBwbuxo51WGSfNOsHZPpB4SHlcvGSF8dFooTNWc+E2N5/UJmfZjtVH
	yc85EiN6NTdwuhvIHGhASOJGeTMPwghelyhJly1fH5d8wmjiPHVT7qfv7YV0uMTjhXQaS+IbJW5Ay
	Wh4ldVXl1OGWVfB0FwrRVqNA1C419P5bMFms13Bl5kFBeN0fOUSuwBQq/6SW884+QV9Cn5PIMfGUr
	QrUwVwWALSZdps/d+cQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJpZ-0000000CPKY-3Upe;
	Fri, 06 Nov 2026 13:18:09 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xPJpX-0000000CPJu-0WTq
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 13:18:08 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Ai4Ad2143103;
	Fri, 6 Nov 2026 13:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rCjDsF
	SoM/fdDI1KYgvfVCEFpnlqU97IrK9aw2LXfOg=; b=fcUP3YgYXBdpK65XpLoLMV
	2SiINBd8iqVhhoPOaagjSVNXo8eBOmJ6s8JhzcxW4bShRBZJREzJxvCaGaw1Eamz
	KpFdNBmynLVbUdomgdqMDuLjR1BCtmuuCuHeDvRKd0ssbq8rI4YyqYP+SDgapAqH
	O2BRZUdkzYOkG1uA/8iBO16JeVTS15btwdmuNGYaHellRk6JssH7pnnSXk2ps0p8
	HEL+TBgRAqZyE7VWcQfPx/zHkuO3WmEYclFzQASm/57VkIzX/MfKjQH5V6Brtbj2
	fD8SjBmKMn9pFIeovbrziKep2QW1B4I/XGFLfw6q13Dybdx72prZJJBJqiO7tCVA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r94b28-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:17:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6AYtup3159692;
	Fri, 6 Nov 2026 13:17:54 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrerrns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 13:17:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6DHsAk13173364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 13:17:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AE6858061;
	Fri,  6 Nov 2026 13:17:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1DAF58059;
	Fri,  6 Nov 2026 13:17:49 +0000 (GMT)
Received: from [9.61.101.130] (unknown [9.61.101.130])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 13:17:49 +0000 (GMT)
Message-ID: <df3e09e6-1e9f-4ece-a17b-92c1006bb4c3@linux.ibm.com>
Date: Fri, 6 Nov 2026 18:47:48 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] nvmet-fc: remove dead fields in nvmet_fc_ls_iod
 and nvmet_fc_tgt_queue
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261106022736.3582824-1-kanie@linux.alibaba.com>
 <20261106022736.3582824-7-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261106022736.3582824-7-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedd384 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=hBQzd1ffT8NXKSxI3VUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: c-REkJ5YTgvNaTkgm_Ov-rG-G_QdN0dw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX8U0jjOLaji1V
 IOnQehdoUwpyEDvglXJYAclEjnH9ktsOoDeoGhB/4GtlfsrI9WVB1La1EZfskvQz8OM9fjRxx9g
 etYeSZSlhi/2FRmEjO2Uq3mo7+Qz7K+I0ZISov8f1x/iZOawkVM5hRfb+02FSThKTjp/ph617xR
 6STtCMqhHyCo+GZuIDokkuvM6jvYWOEMqKyCFjSaoXa+emLz2eLoFaQzAwtBVd9tHIr6PZyzXna
 6uruUu9eG8wnu8778usqNKXtCzVrsQzvo/2TmPpfvFeXwLFchBA+36Nr3VJYv+T7H0ZDfmUTtkD
 XgEXw8qQ7m6rF95rMIRUMe8Lre1YKehwJtwLxFynHcQl2bm4PKZP3S9kTsdh0Y4BIvQioDvFfF0
 dtqv/XnvAg7T6mOaDRqrzzNF8CQ/1jebmQfQ8HMrShqHpjRVrUH7ClLe0W5GieO8jat089sqqrr
 l7hoE9KeE5/FdYVzVxQ==
X-Proofpoint-GUID: kgtopx-pMxIp6SCsGJWg1svx6wTbQGK7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1MiBTYWx0ZWRfX/PlsVdchTUK/
 C3uHITeOCnjixiDYE8tojaGseZL9LN86ukJBRK+Mhv6RFk2l5l4M7eUep1VIaoIVCC15aEpMtI3
 Nk7hJX6DJ5CYkIkVzJ5Uso6XTkNE74E=
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
X-CRM114-CacheID: sfid-20261106_051807_257279_A9DBC60B 
X-CRM114-Status: GOOD (  11.52  )
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
> The fcpreq field of struct nvmet_fc_ls_iod is only ever assigned NULL
> and never read, and the ninetypercent field of struct nvmet_fc_tgt_queue
> is never referenced as the 90% queue state is recomputed on demand.
> Drop both.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>


