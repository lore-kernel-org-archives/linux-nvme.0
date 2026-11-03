Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E41606A32C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=NgvJ3wWM;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BX3TVsMo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zfjMXj/on1hRFEi4xnxNbqdpXZSo9zSdL1cCc2kqngk=; b=NgvJ3wWMbkzklx
	QoJEG9/SwxzSALqnnQjF5goWD/NSVNYmHdUtjbtTFob25OjD9LZGbchTRR0+7NuFM54qRo7AeiNLL
	AF6y0F3aJxtBxybtrwIH8FnF4BuZoXYHhlj3PhCBIVXDujV+BtJDdMYpI4jhaHJ/gym4RvtZ3r2Bw
	DIfwgnnPbao8jU8GLjoBuRFQh6l2+AqSQiiryshL69fbrjqH4omW2G8XBUDn+oLYKMugpd4utrYz5
	FhOpXdjcxyKyMV99cvudoh2J1YFZNYMxji6nt7mqNfwzQDKPNCn38F4IA9VLvAd+0oh/U23a16rSA
	rQH3XlCWeQounBvJwtJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9RZ-00000001SyJ-1eXz;
	Tue, 03 Nov 2026 08:00:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9RU-00000001Sx7-2xIs
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 08:00:30 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31jJlR308009;
	Tue, 3 Nov 2026 08:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zfjMXj
	/on1hRFEi4xnxNbqdpXZSo9zSdL1cCc2kqngk=; b=BX3TVsMoCcbgjxEk5HTluq
	jdLAq9Qst9EV55MseYlhaXqZouf4LLwH7z4LFK1sAN3e+4sr895VKJ4eZ8fpoKoc
	Zz3elBOGeh0xAYWd8MXCOauYoapdx+hIZa3hjZjAhug+WVhrkkMUmDBKRoYLdOAo
	ThEzTsNH4DpH88HEFTqSLD0PhPWFEN4Ba9D4zLrH3MmY+bRLh8SGkrxVLxPfuNVL
	C/YKXXHoccBvqIE/WLo6cB2izjtLvn5SPXm216PgV7myM2pL5dH/wmV/4ySRikIg
	UDfX3uPO8MXLRPbXfay9bZzAYE5d6gu6rh3jPsyaSAwnps/867ISt5HU7PQ6EHJA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrv8v3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 08:00:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37V25r1870698;
	Tue, 3 Nov 2026 08:00:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5gs9th-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 08:00:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A380JOl9568878
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 08:00:20 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A9558059;
	Tue,  3 Nov 2026 08:00:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2EA0458057;
	Tue,  3 Nov 2026 08:00:16 +0000 (GMT)
Received: from [9.61.129.51] (unknown [9.61.129.51])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 08:00:15 +0000 (GMT)
Message-ID: <eb05ce61-d6a2-4cc5-915e-40cd21c48bf1@linux.ibm.com>
Date: Tue, 3 Nov 2026 13:30:14 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-rdma: remove dead allocated field in nvmet_rdma_rsp
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
        Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261103073307.2588945-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261103073307.2588945-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae99495 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=SRrdq9N9AAAA:8
 a=VnNF1IyMAAAA:8 a=qf__Td2_-8ewvJj1OEQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfX9GFd4imkjU1r
 MjyO2VDq5LpxDtRZwxhH2ABxKtV1XKw9+vKV8biqIj06DISXFQZzWKA8Jgwl2GK/UUp1VjmYL/D
 qqB8bE+HdDlRfhTrmRxEKiQ3MihnF6E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzMCBTYWx0ZWRfXyCsNrZo/p+59
 BO8Fac1zXQcfYJYSJz4pjESFUD2C6N8Dza/oMpSCtRp5xow/lwwdaJHU1qiZZgHON2LkbTtlDil
 Kh06ciIO4DeBnlaRP85IO7WtganQ2DtzUpbjlfwZDxmzimeoJJSnufweQrrzekwfu/DDnqGreAy
 RWBPRLMrvW+8tF1ORCH1NIgWk43DlOmhOuJrpqL7KPOQxseFDpAdAj/iG284/atU2bzyp+3Ysk2
 bw8fWX0mHitdckxUorfycxJTBlw+CPsW/5+F70tVsXeH18sAalYruaJf/cdidzhZT+dve+nQQc3
 t9Gk+fjQUM9J5pecRI5Jz/8vhrOk/Dv5n2++7P37Az28rELDO0R5MM9M3sgV+XkelbXEYSVx6Gx
 P2Ag2kA0yVLup1NdTJyYcuba1fAzeHCukxG1ms2e1rg3tEX7X9VBLMPtYxiGu1jECb8HI71o2/E
 i05Ecudxps2yax0H7qg==
X-Proofpoint-GUID: ow_0wRF2OWVNelRvYSO6vaqBNslltfwj
X-Proofpoint-ORIG-GUID: 8OBQNrOMfcF10dZnTKEkFKOHOzJLTozk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_000028_863905_EB882EAE 
X-CRM114-Status: GOOD (  11.77  )
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

On 11/3/26 1:03 PM, Guixin Liu wrote:
> Commit 40f0e5dc2f3c ("nvmet-rdma: use sbitmap to replace rsp free
> list") replaced the ->allocated flag with the discrete tag value
> NVMET_RDMA_DISCRETE_RSP_TAG, but left the field behind. Nothing
> references it anymore, so drop it.
> 
> Signed-off-by: Guixin Liu<kanie@linux.alibaba.com>

Looks good to me:
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

