Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13275C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 14:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TLErDbMKW6pOWGcde3ixJ4kJ5agf9bISsQskSM/It1Q=; b=fx3N6HQnRDsXYE35F/iRzxEFaN
	gha/7Bsl3cUHkylNivVfuosHsEl5+rmz6QRVznossFgQNYKELYah3O4S/Ik21ion4aXI0QlLNodUL
	H+oPkYXwQMPQXLuAU9arh4E6PfDJBWCPA5h/xsLDFgHCSD6+5T5C4jN4k9acp8kyGLdme5kIjJa+4
	AdP+ebKa0DW7m6qFw/FZuZI8srn/7/RSf0NPeSGaREc4K0MlkZm6I1Dwrs3xRytjrvUZDNbg4hklT
	OuSBRCc7oYLim2Kk130hnGXYlaQsNk9Psqt5/EoVNAmg/Ir144IDMXkytPL7SBymRyfd/41DaF9hQ
	SnMUSR9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbKRT-0000000Epur-212i;
	Fri, 24 Jan 2025 14:13:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbKRQ-0000000EpuR-2ZRX
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 14:13:49 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50O8f0aI008368;
	Fri, 24 Jan 2025 14:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TLErDb
	MKW6pOWGcde3ixJ4kJ5agf9bISsQskSM/It1Q=; b=MWdTyEjo2iQY/RmmAfCRjY
	Jl138penrlfDkRV18Gm2cZRJVEcm9brlKJb6lkA9OEFTeY2/QuZKiSyxiX2mPCSa
	yF9jozXfgCnQkwzXBRrXFainQX7dwLhhcxOP5vLPh1CvUfrOClKbVQki2ckDwu7Y
	IWveSBT3/S112NUiuH7GsswviBOL/lg528vbLPG2tc7EuSHQkrKJnt7Qa4BcazFg
	QduagceQ5r/soa+bssDyemx+hc6Pt+H2vfMv06ebFPLdzLRM3zVe352BLQXYY8MW
	9+4OMfydba2eXLBqaEn52OVbYLAa1lp0FnOuEtqCXOywVai+5r0MY+caTtrJcM0A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c1pyuvwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 14:13:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OBdXfZ019266;
	Fri, 24 Jan 2025 14:13:39 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsuwjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 14:13:39 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OEDcOD20382418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 14:13:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4DB85805A;
	Fri, 24 Jan 2025 14:13:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B15D58063;
	Fri, 24 Jan 2025 14:13:37 +0000 (GMT)
Received: from [9.171.53.174] (unknown [9.171.53.174])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 14:13:36 +0000 (GMT)
Message-ID: <b66b1987-c2de-4862-8bc9-c3b38477d01f@linux.ibm.com>
Date: Fri, 24 Jan 2025 19:43:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix a memory leak in controller identify
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20250124110033.391731-1-sagi@grimberg.me>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20250124110033.391731-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OEcPwcwhtoEmNdw3Qk1LRBSFIRaoPr6w
X-Proofpoint-GUID: OEcPwcwhtoEmNdw3Qk1LRBSFIRaoPr6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_05,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240099
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_061348_779232_FC60BBCD 
X-CRM114-Status: GOOD (  18.13  )
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



On 1/24/25 4:30 PM, Sagi Grimberg wrote:
> Simply free an allocated buffer once we copied its content
> to the request sgl.
> 
> kmemleak complaint:
> unreferenced object 0xffff8cd40c388000 (size 4096):
>   comm "kworker/2:2H", pid 14739, jiffies 4401313113
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     [<ffffffff9e01087a>] kmemleak_alloc+0x4a/0x90
>     [<ffffffff9d30324a>] __kmalloc_cache_noprof+0x35a/0x420
>     [<ffffffffc180b0e2>] nvmet_execute_identify+0x912/0x9f0 [nvmet]
>     [<ffffffffc181a72c>] nvmet_tcp_try_recv_pdu+0x84c/0xc90 [nvmet_tcp]
>     [<ffffffffc181ac02>] nvmet_tcp_io_work+0x82/0x8b0 [nvmet_tcp]
>     [<ffffffff9cfa7158>] process_one_work+0x178/0x3e0
>     [<ffffffff9cfa8e9c>] worker_thread+0x2ec/0x420
>     [<ffffffff9cfb2140>] kthread+0xf0/0x120
>     [<ffffffff9cee36a4>] ret_from_fork+0x44/0x70
>     [<ffffffff9ce7fdda>] ret_from_fork_asm+0x1a/0x30
> 
> Fixes: 84909f7decbd ("nvmet: use kzalloc instead of ZERO_PAGE in
> nvme_execute_identify_ns_nvm()")
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/target/admin-cmd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index e670dc185a96..acc138bbf8f2 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -1068,6 +1068,7 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
>  		goto out;
>  	}
>  	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
> +	kfree(id);
>  out:
>  	nvmet_req_complete(req, status);
>  }

Looks good to me.

Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>



