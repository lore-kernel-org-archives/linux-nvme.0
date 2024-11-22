Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A33E65D35
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 08:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RnX/jzGR8VWUUEEtqi5AuW3OzgaQNYWHtQJaSQZxswo=; b=e2pS4ii3yIrsZg1NIsIrsvstgs
	qOOJ1DaCiEdsRoloygffEQxgPrBzwCVD6KAkUWD+XXhH+Q1PK7c5TiTUlh7sddWK8jdOA7rZsPNUX
	/TV6KSzySR0DfStZYZPyylauOweAcWG8ja5YmtcAmwnNEy7sOGnxHzjnJuKAaA7qvioQ/fFAwYqie
	VlXhg2LfEuu31pSiStdmYpClI2hWnbFmZvwspoAS6l+arm3rtnewV23nYJ1snfVOU/nRfNT5dlnvi
	OYua5YcmyXlXu5WuU3Vs0NCPl7M/fFRmJCMSDklk+9bglIDCpkte9ihweDdm4oNCYPb35zCEq/NrR
	wuUCvQWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPUJ-00000001zs9-2k1n;
	Fri, 22 Nov 2024 08:58:03 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEPUG-00000001zrd-2UPM
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 08:58:01 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM1qkcY019256;
	Fri, 22 Nov 2024 08:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=RnX/jz
	GR8VWUUEEtqi5AuW3OzgaQNYWHtQJaSQZxswo=; b=Z1jAI6qABqoYKOXqaHa9uO
	zkP1bnE8jNapRmD4nXZlwqHedPfGF9RFk8kGj83K+KY8ZRDBHOKwFFfnY+LJFoqI
	3tPT9W6ULXPP/obTvkUlRgAYbxYdUH349sqNn8XxJy0DvrMQfVY1DnJm+IkiZxrH
	NiyBtb5nLMwrTixat5iN0cf5eNqvgVuURi3ljm/jzLRyFZ+FlNSj2lNYmHo5yfQY
	gChtNIMlJyCmr8VIrCqUYFyMXgMsxlCT2nluukDUqcTE2/qTAHPJfVeHTCq/5ld4
	t9lMS/lCt2XqEqNqUesn1qB1tGNyey1vvK3APYmA/Yh/YF4TqFGvLgzkjhnygHyw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xk21fhyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:57:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM0CdYB021833;
	Fri, 22 Nov 2024 08:57:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42y6qn2n0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 08:57:53 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AM8vq6138798068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 08:57:53 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E06AE58054;
	Fri, 22 Nov 2024 08:57:52 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D0075805C;
	Fri, 22 Nov 2024 08:57:49 +0000 (GMT)
Received: from [9.109.198.240] (unknown [9.109.198.240])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Nov 2024 08:57:48 +0000 (GMT)
Message-ID: <539b2e5e-6314-472f-9b61-439a304a07cd@linux.ibm.com>
Date: Fri, 22 Nov 2024 14:27:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix the use of ZERO_PAGE in
 nvme_execute_identify_ns_nvm()
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, yi.zhang@redhat.com,
        shinichiro.kawasaki@wdc.com, mlombard@redhat.com, gjoyce@linux.ibm.com
References: <20241122085113.2487839-1-nilay@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20241122085113.2487839-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KVdi9kiwY78Md46gsA6fFfI8bBOZ70Q3
X-Proofpoint-GUID: KVdi9kiwY78Md46gsA6fFfI8bBOZ70Q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_005800_757576_A4F1A749 
X-CRM114-Status: GOOD (  24.41  )
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

Sorry but I forgot to add the reported-by tag.

Reported-by: Yi Zhang <yi.zhang@redhat.com>

On 11/22/24 14:20, Nilay Shroff wrote:
> The nvme_execute_identify_ns_nvm function uses ZERO_PAGE
> for copying SG list with all zeros. As ZERO_PAGE would not
> necessarily return the virtual-address of the zero page, we
> need to first convert the page address to kernel virtual-
> address and then use it as source address for copying the
> data to SG list with all zeros.
> 
> Using return address of ZERO_PAGE(0) as source address for
> copying data to SG list would fill the target buffer with
> random value and causes the undesired side effect. This patch
> implements the fix ensuring that we use virtual-address of the
> zero page for copying all zeros to the SG list buffers.
> 
> Link: https://lore.kernel.org/all/CAHj4cs8OVyxmn4XTvA=y4uQ3qWpdw-x3M3FSUYr-KpE-nhaFEA@mail.gmail.com/
> Fixes: 64a51080eaba ("nvmet: implement id ns for nvm command set")
> [nilay: Use page_to_virt() for converting ZERO_PAGE address to
>         virtual-address as suggested by Maurizio Lombardi]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>  drivers/nvme/target/admin-cmd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 934b401fbc2f..a2b0444f28ab 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -901,12 +901,14 @@ static void nvmet_execute_identify_ctrl_nvm(struct nvmet_req *req)
>  static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  {
>  	u16 status;
> +	void *zero_buf;
>  
>  	status = nvmet_req_find_ns(req);
>  	if (status)
>  		goto out;
>  
> -	status = nvmet_copy_to_sgl(req, 0, ZERO_PAGE(0),
> +	zero_buf = page_to_virt(ZERO_PAGE(0));
> +	status = nvmet_copy_to_sgl(req, 0, zero_buf,
>  				   NVME_IDENTIFY_DATA_SIZE);
>  out:
>  	nvmet_req_complete(req, status);

