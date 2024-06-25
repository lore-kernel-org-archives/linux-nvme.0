Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7749C2BBCA
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jun 2024 10:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mQ7L7rRBN6X4YzC0LClbkr0J0xi6q0fsdKXuChcwY7c=; b=beTiIXF/y3qY17y5CApOcKBg+H
	d+VQPEf2Ofv5PIUmW9qK1/49aljq/3Velu1fx+Oyf0ZvXkAR7oeqwq7ozffFvpXUPA4TgfxM6T/H8
	obmWbGpidCRqaG2vfyLnSGbe026OeCb3LgxKOZukLHFB1Knnw2t3fj1kLxxL/kq53Z3/CTfOkTCfq
	WD7ZVBivyVg/OAWJ88oMTmQvT88wconX28JKBvKL9As7f9/VPecR6682ubsStct3UUMRTEh4vDJWH
	5M+FiPyuLjgYAa35ZxAoDF+3irWG0BOjcAVuwL/DDYgdk6heFL2LiVoAVbwU1vFcQWzOnJ+Ug2/Gd
	jPWoLtQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM31G-00000002Ld9-1dwG;
	Tue, 25 Jun 2024 10:03:22 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sM31D-00000002LcX-0fep
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jun 2024 10:03:20 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P9U8KQ011911;
	Tue, 25 Jun 2024 10:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=m
	Q7L7rRBN6X4YzC0LClbkr0J0xi6q0fsdKXuChcwY7c=; b=f0YAdK43LFSB3NufA
	xVQgTDjTTpSGFDuf9IU0WS1YeSXEHZOf8H2WOnRk4uP5WZXKaipRGXRwUqkFAvCQ
	CJPIDAMLp2j74flJ7qP8YiFUg2TpKNFUb6znH8aMxTUUkEzKDrxw8eNrHzN+vM9c
	rtlMOSdTnFrmpweELPjdu1DYcxDzdi/Fe/5xp0GjDQnPuyjYPEFeFE+JBqBobXSa
	9/qZq3NBKcKJ3SntCNC7QXAM6BBhBlMs9Fsc2rG5O8HGqHEUSwq9rd6XpcNT/2rx
	KNwzp5BbT57tEVMswrCZnxmZ+LEnWhkgNMY11VyB9K5oJFFP+Sv69otfz8dBzwID
	2bLqA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yyua702m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:03:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45P8YbP4020058;
	Tue, 25 Jun 2024 10:03:06 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yxb5mdfh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 10:03:06 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45PA338Q43320028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 10:03:05 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F015D5805C;
	Tue, 25 Jun 2024 10:03:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D59358051;
	Tue, 25 Jun 2024 10:03:01 +0000 (GMT)
Received: from [9.109.198.223] (unknown [9.109.198.223])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Jun 2024 10:03:00 +0000 (GMT)
Message-ID: <e4eb3d7c-e9d9-41fa-81cf-e3f248d3e0a8@linux.ibm.com>
Date: Tue, 25 Jun 2024 15:32:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme-pci: do not directly handle subsys reset fallout
To: Keith Busch <kbusch@meta.com>, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Gregory Joyce <gjoyce@ibm.com>
References: <20240624172649.2268634-1-kbusch@meta.com>
Content-Language: en-US
From: Nilay Shroff <nilay@linux.ibm.com>
In-Reply-To: <20240624172649.2268634-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pg-cHkvJyHtX_x0Ukoyycsk3Nq9aVCMp
X-Proofpoint-ORIG-GUID: pg-cHkvJyHtX_x0Ukoyycsk3Nq9aVCMp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_06,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250068
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240625_030319_351497_D4FDAC3D 
X-CRM114-Status: GOOD (  34.96  )
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

Hi Keith,

On 6/24/24 22:56, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Scheduling reset_work after a nvme subsystem reset is expected to fail
> on pcie, but this also prevents potential handling from the platform's
> pcie services may provide that may successfully recovering the link
> without re-enumeration. Such examples include AER, DPC, and power's EEH.
> 
> Provide a pci specific operation that safely initiates a subsystem
> reset, and instead of scheduling reset work, read back the status
> register to trigger a pcie read error.
> 
> Since this only affects pci, the other fabrics drivers subscribe to a
> generic nvmf subsystem reset that is exactly the same as before. The
> loop fabric doesn't use it because nvmet doesn't support setting that
> property anyway.
> 
> And since we're using the magic NSSR value in two places now, provide a
> symbolic define for it.
> 
> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> Changes from v1, applied comments from Christoph:
> 
>   Split out and require new ctrl subsystem reset op
> 
>   Comments updated for correctness and clarity
> 
>   Use a symbolic name for the special reset value
> 
>  drivers/nvme/host/fabrics.c | 15 +++++++++++++++
>  drivers/nvme/host/fabrics.h |  1 +
>  drivers/nvme/host/fc.c      |  1 +
>  drivers/nvme/host/nvme.h    | 14 +++-----------
>  drivers/nvme/host/pci.c     | 35 +++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/rdma.c    |  1 +
>  drivers/nvme/host/tcp.c     |  1 +
>  include/linux/nvme.h        |  3 +++
>  8 files changed, 60 insertions(+), 11 deletions(-)
> 
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 102a9fb0c65ff..6cb7acef05576 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1143,6 +1143,40 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
>  	spin_unlock(&nvmeq->sq_lock);
>  }
>  
> +static int nvme_pci_subsystem_reset(struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_dev *dev = to_nvme_dev(ctrl);
> +	int ret = 0;
> +
> +	/*
> +	 * Taking the shutdown_lock ensures the BAR mapping is not being
> +	 * altered by reset_work. Holding this lock before the RESETTING state
> +	 * change, if successful, also ensures nvme_remove won't be able to
> +	 * proceed to iounmap until we're done.
> +	 */
> +	mutex_lock(&dev->shutdown_lock);
> +	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
> +		ret = -EBUSY;
> +		goto unlock;
> +	}
> +
> +	if (!dev->bar_mapped_size) {
> +		ret = -ENODEV;
> +		goto unlock;
> +	}
> +
> +	writel(NVME_SUBSYS_RESET, dev->bar + NVME_REG_NSSR);
> +
> +	/*
> +	 * Read controller status to flush the previous write and trigger a
> +	 * pcie read error.
> +	 */
> +	readl(dev->bar + NVME_REG_CSTS);
> +unlock:
> +	mutex_unlock(&dev->shutdown_lock);
> +	return ret;
> +}
I noticed that in your earlier proposal we were changing the NVMe controller 
state from RESETTING to LIVE just after write to NVME_REG_NSSR. In this patch,
you removed that code and due to it now pci error recovery code (nvme_error_detected()) 
couldn't change the state of controller to RESETTING and that causes the pci error 
recovery to immediately bail out without recovering the NVMe adapter. 

I think we need to change state of controller to LIVE after write to NVME_REG_NSSR.
So was there any specific reason you removed that code or was it missed out by mistake?

Thanks,
--Nilay

