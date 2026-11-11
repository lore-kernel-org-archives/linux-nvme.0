Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD46606A321
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DkmEr+3u;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=XV5tSlvG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AjMEIi7lv07LvTskR3i0Su3EOrQGDfx9N4dCUycSW4I=; b=DkmEr+3ut1qgog
	WyrkYEbLa1B4LWQGbTh10ZDmsyq9zXSGr00zGJidKWx5CIWlSEN7tFjZPjLZi0atMi+b26HYPeO1G
	UPUedChZk4FZNnOZvN5bqv+4cgmm1NTKzFOtw/TnT36PkC9N0fPr8hn50HdKFVzpABARThbME6CTi
	cHT9gbjvWjjyBteafXor41Vca7HRRkTXOaX9B8UF8dmQSgI5p7tc6FRHMWZpxWExlcpcG+VhrPEGR
	qDToq7bKAn9UyowDijcH62bdV/pn4FocZfgKob+Coi+BFVtTxhXkHIswvUV53U4E5szM8Wj66gMFi
	qMoexML/5l531emxDNKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3zr-000000064wg-3Jbr;
	Wed, 11 Nov 2026 08:47:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xR3zo-000000064wF-2cXh
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 08:47:57 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5iKdi286217;
	Wed, 11 Nov 2026 08:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AjMEIi
	7lv07LvTskR3i0Su3EOrQGDfx9N4dCUycSW4I=; b=XV5tSlvG5bAKoEQW1GF70n
	ULi6FNjoEDnmsKO+pwyQDMrK3IHv2Dr99hLD7ItcVG6NuPbma9r+HJ7TL4AxvXkk
	RRO4LWcLt8D5geh/Wd3OgHMSQOtHpLFInbqp1cqVCfuR5KBoO4inBqukYi9h52VN
	4BpXZ8OYokENJh4LuwmNy751C6jkzJurU78JaQgcQMCHXmeRPwc19OM84SaZ1LCW
	nz1QNQv488nyxitu50T7NMdALIPOQStVP+QsG5BGA8zmubMvd/e7X8eVSXPHVVSu
	tjn6obGGMhSkrSue4EITX1qTzNpuxaXf8V7rAft/fCTubGE3MNTSqqz3L+EW7CAQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumv0ejb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:47:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AB5Jvtp1747835;
	Wed, 11 Nov 2026 08:47:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hvd51sdc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Nov 2026 08:47:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AB8lnbb32047692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Nov 2026 08:47:49 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C910158058;
	Wed, 11 Nov 2026 08:47:49 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9818858057;
	Wed, 11 Nov 2026 08:47:45 +0000 (GMT)
Received: from [9.123.7.57] (unknown [9.123.7.57])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 11 Nov 2026 08:47:45 +0000 (GMT)
Message-ID: <5ac651df-2140-4e56-a8d1-857f599a8046@linux.ibm.com>
Date: Wed, 11 Nov 2026 14:17:44 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] nvme/081: test the per-queue io_cpu sysfs
 attribute
To: Saravanan D <saravanand@crusoe.ai>, linux-block@vger.kernel.org
Cc: shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org,
        dwagner@suse.de, hare@suse.de, sagi@grimberg.me, kbusch@kernel.org,
        iyamahata@crusoe.ai, kiyer@crusoe.ai, ganbalagane@crusoe.ai,
        sjpark@crusoe.ai, bchen@crusoe.ai
References: <cover.1794015622.git.saravanand@crusoe.ai>
 <20261107095350.98072-1-saravanand@crusoe.ai>
 <7a2bcf1c-990f-46fa-badd-dc1b14dfa96f@linux.ibm.com>
 <20261110115005.47367-1-saravanand@crusoe.ai>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20261110115005.47367-1-saravanand@crusoe.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX2MTSknSqIWSp
 GN0m3MgOiaXy1eDY9LUj34ZBm7u5GF8hCKzj4EgvbkDYnysQuwMqi6y80dvIjowTjhWLIqZZXUW
 3ly4vTjnKCMK5PPKQNhyRgIcf2/px9c=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af42bb6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sfnruoiRsdzNOXGBZVQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nlwaUSIBITl4O8vqNmsCiAdciW3MJZSz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAzNCBTYWx0ZWRfX6hbFs4hVUgg4
 X2MpZccTxuXAtXlrxvLIJiY+fEvy8+WP0B/oRkJmV4tMbe+las+NfADI73s+DxEltqFZjH6gKjs
 oCRu7tZpeD3I8ft1I52YlSbSd+NsXRb9BgTnuXcSb6xYbIxiscR0hBcogcXsI1fx3s6qq8NYT2z
 YKnYpuAfjZhmEbRNGPJYD2uvT/lzlXMKia4V3Ll+/kMc5CKaSkl8CFASFgxxP7mJlzv8nMW8wW4
 ReU0Fs2Ipg1W8PrOsMQqOnrmCUS2H4vs2tiVZq2DiX7LIraN30c/f0I5bTVD6NxmBOje/S2dCgO
 inLLpA8ArIM9Mt23vjJctvDBnmW/v5hOBnyBNWoOnuwXdRPWOB/iB71mxMrKvfv8zAwF+pbKNnW
 +UtLT4luD7Wxzv7V0Pk4aZNjaIbRVrrBn7ubxosuux2FCR5NEgaDsSJ6XNSb3VvMCJQTiuzrjIG
 NQ2dtl+6+GtIaAMpktg==
X-Proofpoint-ORIG-GUID: nlwaUSIBITl4O8vqNmsCiAdciW3MJZSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110034
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261111_004756_794213_DBAFB5CF 
X-CRM114-Status: GOOD (  14.31  )
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

On 11/10/26 5:20 PM, Saravanan D wrote:
> nvme-tcp exposes/sys/class/nvme/nvmeX/queues/<qid>/io_cpu and managed,
> so a control plane can choose the CPU that runs each I/O queue's socket
> work [1]. Test that
> 
>    - io_cpu reads back a written CPU and rejects invalid values
>    - managed is read only and turns 0 once io_cpu is written
>    - an assignment and the queue directories survive a controller reset
>    - the queue directories follow the queue count as attr_qid_max
>      shrinks and grows it
>    - removing the controller while io_cpu is written completes
> 
> The test skips when the kernel does not have the queues/ directory or
> the io_cpu attribute.
> 
> [1]https://lore.kernel.org/linux-nvme/cover.1794015622.git.saravanand@crusoe.ai/
> 
> Assisted-by: Claude:claude-opus-5-5 [Claude Code]
> Signed-off-by: Saravanan D<saravanand@crusoe.ai>

Looks good to me:

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>

