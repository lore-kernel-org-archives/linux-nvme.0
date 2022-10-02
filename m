Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A046C433F5
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Oct 2022 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/mpr1D/Cf3GeGpEFQtpc5ZgpgZceqs0dyEsitRKt+I=; b=qwy1ea5FHD/qv/USeefFrzbhXw
	Q50R3Ma7bw+n6+TUx7+UpsUbx0R1AqLG0/Yt7GPGQC1yj/WXd9w06l/Y3mx3xj1Pl6DiU0+z1e62h
	Qy9gTeBDXelNbX0x0o/z8QBSA/uEHb1n5Z28LIhh5cHDL4fnWClZljTa2wNfHe2zsgs7hzYuBlhSv
	PI0HU/y7895/QgSzZh024HpPXExA9Cx/RVZOBCB8Y74B5xFRx9UYMNF94Iqxz0QSIY2ip3kHoBXoQ
	zGUcgLHeVIoHHR6rxxiM4R7iHMR2M7rsLNHYoYlYhRaXNkgPDlG7zyBD9ccum8b9gj2FnieVvshuJ
	yEXqFHFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1of2Vt-001t2A-7Q; Sun, 02 Oct 2022 17:12:25 +0000
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1of2Vq-001t1G-GS
	for linux-nvme@lists.infradead.org; Sun, 02 Oct 2022 17:12:23 +0000
Received: by mail-qt1-x82b.google.com with SMTP id a20so5295194qtw.10
        for <linux-nvme@lists.infradead.org>; Sun, 02 Oct 2022 10:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=B/mpr1D/Cf3GeGpEFQtpc5ZgpgZceqs0dyEsitRKt+I=;
        b=hOXO3xdxbkJiV4wc688W9IZv7efI+O+BeU+g8BDPXWgCyi5d7AV1QVvcl2W8/+Max8
         AWrX2tTmgRXXc1DzdSCO2JvqgA15o1qPhcdT34TPLE8v8CGYyeHG0rt5sPHKLaDqMDTQ
         nugwHPSJYjigTMomz5JillqUVCDclZJz/hIzlLPInjHhYYO4ZBjX9DbcqO77mR9L9GY0
         P1DqKdMYTKF/0wGxBrROj+ZMJfFqSBGnwaU1JoP/eea5+l9Nf0n2k6gfAQ9CK5u46gML
         lG0y1uGcunrPXx2p4VXQY9Mgb3yprAqXFdz96YI2karTsl0rXVoKwwkERiv3o/6LR7mO
         4g0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=B/mpr1D/Cf3GeGpEFQtpc5ZgpgZceqs0dyEsitRKt+I=;
        b=kSgg0XFd+FHbdlgTdkruirL2fpI05IJWSoyfT5hg14zmsXwOiCrSzGxj7cU2EKXzQy
         74Gwu7/C/27QXYBHMm8uB5Ww9usnxFhMTAhkAdZy4vOKxZBP3bQoli2xqY+iST2yrBlG
         NuC44mCxf+Ldq37wi0R6KNHFPqAF9ufFDl5gWotBv9gTxqEkDoB6rhCm2Mgav0QKYyn5
         HWXZ0wMv8gDiyeOnWBL9kni9/i7giF3Hw348sNkTN0rQFzcfEnMSntqUeB185g4WCZpN
         5yWGhEsJZoLZ8uYafME9ZzNpN+kWtb8q5O65iPNihYKndz7pUR9B57RlHLlQWC12rCBU
         BqKA==
X-Gm-Message-State: ACrzQf3tGjWBuPbUW8DnIiTaO30DpN9INwCoesZM6ZF2kIgp/eUe7oP4
	TZmWdjgvyuEI1fZvRg9pa/0=
X-Google-Smtp-Source: AMsMyM6ZT8UAIGZf1J/tY3BediOLwcIjnusNk+DV09LpJREyb/czMI4tS03iJFb7dUZLZ26cFw2wnQ==
X-Received: by 2002:a05:622a:1052:b0:35b:b6cb:48f6 with SMTP id f18-20020a05622a105200b0035bb6cb48f6mr13185374qte.190.1664730737873;
        Sun, 02 Oct 2022 10:12:17 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id q19-20020a37f713000000b006bba46e5eeasm8376870qkj.37.2022.10.02.10.12.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 10:12:17 -0700 (PDT)
Message-ID: <305fbf18-6759-9b00-6fc0-93a4a2e40be2@gmail.com>
Date: Sun, 2 Oct 2022 10:12:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] nvme-fc: fix sleep-in-atomic-context bug caused by
 nvme_fc_rcv_ls_req
Content-Language: en-US
To: Duoming Zhou <duoming@zju.edu.cn>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, james.smart@broadcom.com,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
References: <20221002001909.20070-1-duoming@zju.edu.cn>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20221002001909.20070-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221002_101222_591770_908DA1DD 
X-CRM114-Status: GOOD (  17.62  )
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

On 10/1/2022 5:19 PM, Duoming Zhou wrote:
> The function lpfc_poll_timeout() is a timer handler that runs in an
> atomic context, but it calls "kzalloc(.., GFP_KERNEL)" that may sleep.
> As a result, the sleep-in-atomic-context bug will happen. The processes
> is shown below:
> 
> lpfc_poll_timeout()
>   lpfc_sli_handle_fast_ring_event()
>    lpfc_sli_process_unsol_iocb()
>     lpfc_complete_unsol_iocb()
>      lpfc_nvme_unsol_ls_handler()
>       lpfc_nvme_handle_lsreq()
>        nvme_fc_rcv_ls_req()
>         kzalloc(sizeof(.., GFP_KERNEL) //may sleep
> 
> This patch changes the gfp_t parameter of kzalloc() from GFP_KERNEL to
> GFP_ATOMIC in order to mitigate the bug.
> 
> Fixes: 14fd1e98afaf ("nvme-fc: Add Disconnect Association Rcv support")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
>   drivers/nvme/host/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 127abaf9ba5..36698dfc8b3 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1754,7 +1754,7 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
>   	lsop = kzalloc(sizeof(*lsop) +
>   			sizeof(union nvmefc_ls_requests) +
>   			sizeof(union nvmefc_ls_responses),
> -			GFP_KERNEL);
> +			GFP_ATOMIC);
>   	if (!lsop) {
>   		dev_info(lport->dev,
>   			"RCV %s LS failed: No memory\n",

I would prefer this was fixed within lpfc rather than introducing atomic 
allocations (1st in either host or target transport).  It was introduced 
by lpfc change in irq handling style.

-- james


-- james


