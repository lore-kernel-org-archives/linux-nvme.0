Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B238C4321E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wbhd+Z2+Aih/sGy1KHtTn/ZBXAB3S7OAmdwgL/cp8Rc=; b=Z/W8rsTMfcxbgmECGrpOVUCDOD
	FGFkPy97YPVXAdJDj3Wbt4n+SGYgDWV/Km4bdhbSuTm+KvNRyJ/Ea/iOIaPB6qmIk8AYx4ts//zr0
	xmnvzMRGnUn8NRhl006VhxVHnHtOjWwLBckDEaPudTtE/iTP+z6yktcxqQKtBoLjGk7ViIvl+chsU
	NnY6hJWQ0D0b+xmjVWHNtL9du17j6Un8NGXHIKR83who1+PLNSP6+8oWDe8WT3UZhlbkBbvCoZMwd
	u+M2IIDWtJrOd/YY5/cSDdd45TzLro1bvd679TPC7R9/IVkN8Raq3pQQ2sqooNi6NJI4e/a/d2GEW
	OOkmGPVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p18cg-00HN0E-NM; Fri, 02 Dec 2022 16:10:46 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p18bW-00HMPm-Ay
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 16:09:35 +0000
Received: by mail-pj1-x102e.google.com with SMTP id o12so5334130pjo.4
        for <linux-nvme@lists.infradead.org>; Fri, 02 Dec 2022 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wbhd+Z2+Aih/sGy1KHtTn/ZBXAB3S7OAmdwgL/cp8Rc=;
        b=PW337XFnXEKFH3MvwKo63QpjCMtNRbkmcgQf9AgRsCgEUn8YkiZK4ziuv0Tbpi2Mhz
         O6upUniuVr6yYzFZGID0QEGpzM0F+NYIshOMoTH88zZ4w3pcBIpWc3QLZGUcd622FdJ7
         z+MQmntSrHylM8uXfUX/iCt6maHcbKgBkuZawbZfUFoR1Ylpng1/dK1x6LBDVh4xmeys
         6FV23NqXRpmx0nzh7949tIIMKekpGuYsMgcut0abvZ+aR1UamwF0lSBEmICQ3KfdkkQv
         ufY91oXbww53QCaAbN5D4Pkd92XTwAWjRNlXiwGV56dhF/Mhr8arHfe0yBx366qbW2nD
         LzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbhd+Z2+Aih/sGy1KHtTn/ZBXAB3S7OAmdwgL/cp8Rc=;
        b=ACtdZAl+1pfHMj68zDOUacr0hlCOQMaT+IF9n0Ke8Gdz7BQOWDew2lWIhc9d9Ry5fe
         bfBhUwP8RVnyyZmF/ypwc571IH8j/B3Z55p6fBlxbjn0VNofyw3mjsqMFtRXiS3m+FNR
         PIY13+O6nX0UnvR/TpMCsQGCQSNdtIU9yx7w5MVHVkSdJ+EhYLoNiXXpu7Eb1Mfo+xy5
         rCabOh6vPjH2RW6TvvDgWk1BNr0bebfhn5P5x6XopI4TAN4dBT4ZMVAFquDx8y3s5ClQ
         GLekvJoIUteFwclOaGPX7KqLNvfsgk5lZ6eW9M5H7wcR50h83twPuHDj7dDXmxCELNYp
         1koA==
X-Gm-Message-State: ANoB5pkrot4/2pV5+e+EYGPnbzBM4cfbbC/T4zB21t3Dhcypv7UqJerd
	FGOo/CNSrsx4AgYl+Fsb1IE=
X-Google-Smtp-Source: AA0mqf7GrwLu8LM4f2YAy2IA7LJSrPc+HJbKkiukntwg7SRZCr7qiKIUcaLzZsBuATUNS2Ump3fnnQ==
X-Received: by 2002:a17:90b:2686:b0:218:bb0a:e295 with SMTP id pl6-20020a17090b268600b00218bb0ae295mr59966778pjb.80.1669997371144;
        Fri, 02 Dec 2022 08:09:31 -0800 (PST)
Received: from [192.168.50.208] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id md22-20020a17090b23d600b00218fa115f83sm6860402pjb.57.2022.12.02.08.09.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 08:09:30 -0800 (PST)
Message-ID: <f1f9041d-90d4-c483-84cb-d2c48e544c82@gmail.com>
Date: Fri, 2 Dec 2022 08:09:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] nvme-fc: move common code into helper
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20221130213341.9625-1-kch@nvidia.com>
 <20221130213341.9625-2-kch@nvidia.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221130213341.9625-2-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_080934_423046_753D9E91 
X-CRM114-Status: GOOD (  14.61  )
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

On 11/30/2022 1:33 PM, Chaitanya Kulkarni wrote:
> Add a helper to move the duplicate code for error message
> from nvme_fc_rcv_ls_req() to nvme_fc_rcv_ls_req_err_msg().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/fc.c | 19 +++++++++++--------
>   1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 06bae7150087..42fa450187f8 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1701,6 +1701,15 @@ nvme_fc_handle_ls_rqst_work(struct work_struct *work)
>   	spin_unlock_irqrestore(&rport->lock, flags);
>   }
>   
> +static
> +void nvme_fc_rcv_ls_req_err_msg(struct nvme_fc_lport *lport,
> +				struct fcnvme_ls_rqst_w0 *w0)
> +{
> +	dev_info(lport->dev, "RCV %s LS failed: No memory\n",
> +		(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
> +			nvmefc_ls_names[w0->ls_cmd] : "");
> +}
> +
>   /**
>    * nvme_fc_rcv_ls_req - transport entry point called by an LLDD
>    *                       upon the reception of a NVME LS request.
> @@ -1755,10 +1764,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   
>   	lsop = kzalloc(sizeof(*lsop), GFP_KERNEL);
>   	if (!lsop) {
> -		dev_info(lport->dev,
> -			"RCV %s LS failed: No memory\n",
> -			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
> -				nvmefc_ls_names[w0->ls_cmd] : "");
> +		nvme_fc_rcv_ls_req_err_msg(lport, w0);
>   		ret = -ENOMEM;
>   		goto out_put;
>   	}
> @@ -1766,10 +1772,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   	lsop->rqstbuf = kzalloc(sizeof(*lsop->rqstbuf), GFP_KERNEL);
>   	lsop->rspbuf = kzalloc(sizeof(*lsop->rspbuf), GFP_KERNEL);
>   	if (!lsop->rqstbuf || !lsop->rspbuf) {
> -		dev_info(lport->dev,
> -			"RCV %s LS failed: No memory\n",
> -			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
> -				nvmefc_ls_names[w0->ls_cmd] : "");
> +		nvme_fc_rcv_ls_req_err_msg(lport, w0);
>   		ret = -ENOMEM;
>   		goto out_free;
>   	}

OK

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



