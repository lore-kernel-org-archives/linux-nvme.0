Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7091FC54734
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pgclxmzqd3oTDyB+3skSsbxX5e8+XGqsFoQD3A2GBc0=; b=iml0wjjSGUe8jKZiqjvi1B4u8y
	Irhp5VGpBNay7qwlrVm5CjHm6kUdIC2YzfVPbe52/oKepqjA9XtiShWEp8sn3okHMrhLmgJHGceFJ
	qk996qm4MezH1ZMSnBjWd5bDL0dNxrLNHgdysEIUk+Icj7H7kHs+cipMHVgXKoQ+CyyVDYAcE93zi
	gOdpiemxPEPYwNpGz1mucmPx4UtsB+rP30tSDUDbtCCj7THEr05Cn8WojoQ0yVIJKR1A3KdqvNOQk
	1BNCs0NlxX5XeAVazv4ceLME7XXyZutf5Z2L80GwHsoLilf37cFpxurch2ZVGiDAwQ3y3qDe5ljIb
	9Oq8Bzpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwFS-0000000BSrL-0AOA;
	Tue, 27 Aug 2024 13:28:38 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1siwEp-0000000BSfq-0uEk
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 13:28:36 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47R1tKSJ014329;
	Tue, 27 Aug 2024 13:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=p
	gclxmzqd3oTDyB+3skSsbxX5e8+XGqsFoQD3A2GBc0=; b=eW/L3uPX0xdD8M9iy
	EiHbro6mq6KWrkivntpSx0mALX2P+ajxpJDnB0yUU2j7EcQlp4rvhgVTF5z+N7f9
	EuJoxJ7DCXUDoo3JNntkFLaQnIt65f4Pg8rpnu7GbCSu0HfffO/SfqRSG832uAQK
	FL8mLaZ7scl/wYe8T9ZM32Lk7fj1TfAPobexN/9L0NVLNBZRRyTJhhbJPNbdEITO
	e1kqtvQcuDft2+blzLa4j9qOwND0CkvEjYZmioenESz/j9NbZZTOiBoxgH4/kSkm
	i9Tg5uEzBUGhRMwP04drtUlSsh0j10mm3q5WT2wkUI/fydXt9sJsFSgufy7/860B
	NH5Dw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417h66kpkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 13:27:44 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47RDRihl022275;
	Tue, 27 Aug 2024 13:27:44 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 417h66kpkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 13:27:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47R90axx024622;
	Tue, 27 Aug 2024 13:27:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 417vj3ak4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 13:27:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47RDRhCL25297424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Aug 2024 13:27:43 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326C558059;
	Tue, 27 Aug 2024 13:27:43 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB0AF58043;
	Tue, 27 Aug 2024 13:27:40 +0000 (GMT)
Received: from [9.179.13.33] (unknown [9.179.13.33])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Aug 2024 13:27:40 +0000 (GMT)
Message-ID: <f6091325-3df6-4de5-8c0c-ecc42d9124fc@linux.ibm.com>
Date: Tue, 27 Aug 2024 18:57:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: get rid of a high-order allocation
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        Hannes Reinecke <hare@suse.de>
References: <20240826120333.529128-1-sagi@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240826120333.529128-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _syZM_VpKfrDy3kmpEaGB0pPv8bHxZBh
X-Proofpoint-ORIG-GUID: Rtv_iuxR73PTUa4DCf9W-apHlU3ZlFqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_06,2024-08-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408270096
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_062759_298391_2C27620F 
X-CRM114-Status: GOOD (  23.92  )
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



On 8/26/24 17:33, Sagi Grimberg wrote:
> Allocating the queue commands array leads to a high order
> allocation.
> 
> The current size of nvmet_tcp_cmd is 704 bytes. Allocating
> 128 of those (default queue depth) means that we are allocating
> an array of 90K bytes. There is no reason why this will be
> a single contiguous allocation. Change the allocation to be
> kvcalloc instead.

Though the description suggests using kvcalloc, the implementation 
uses vcalloc. Maybe a typo here or you want to use kvcalloc instead
of vcalloc? In fact, either of them (kvcalloc or vcalloc) would work
in this case. 
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Hannes, I did not test tls (I wish there were blktests for it)
> Can you please double check that nothing breaks? Given that now
> cmd->recv_cbuf is coming from a virtually contiguous allocation
> (which shouldn't be a problem as far as I can tell...)
> 
>  drivers/nvme/target/tcp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 5bff0d5464d1..ba50474c8afc 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -1516,7 +1516,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
>  	struct nvmet_tcp_cmd *cmds;
>  	int i, ret = -EINVAL, nr_cmds = queue->nr_cmds;
>  
> -	cmds = kcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd), GFP_KERNEL);
> +	cmds = vcalloc(nr_cmds, sizeof(struct nvmet_tcp_cmd));
>  	if (!cmds)
>  		goto out;
>  
> @@ -1532,7 +1532,7 @@ static int nvmet_tcp_alloc_cmds(struct nvmet_tcp_queue *queue)
>  out_free:
>  	while (--i >= 0)
>  		nvmet_tcp_free_cmd(cmds + i);
> -	kfree(cmds);
> +	vfree(cmds);
>  out:
>  	return ret;
>  }
> @@ -1546,7 +1546,7 @@ static void nvmet_tcp_free_cmds(struct nvmet_tcp_queue *queue)
>  		nvmet_tcp_free_cmd(cmds + i);
>  
>  	nvmet_tcp_free_cmd(&queue->connect);
> -	kfree(cmds);
> +	vfree(cmds);
>  }
>  
>  static void nvmet_tcp_restore_socket_callbacks(struct nvmet_tcp_queue *queue)

Thanks,
--Nilay

