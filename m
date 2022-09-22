Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B97ECAAD8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 22:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6VKP159SxBjr/BcNk98E/nSSkaOftTs1quW71VgGw0=; b=I6xcKNONi5QV/7U3mJKZ6fvNPo
	HULB1LbAFzqGE1qlSsmIm1t4IvqoJHM7ze/aUt7MiMNfauxD8S1pzoJ3M3vRnDhg0xILzLK83fY+8
	DUBw/FTNJ+NWo67/6g42BS2axmv4ECIC+aq0xz55RyxGg+buaLM2dEL4375poc5Nts1U2g3E2vDt5
	DAkIuq7tW+pH8wSaWYV+QgD8TOtuADRETlF0cIKB4KbTgx274BPOZXfoaQbaOrIZJ2ZafJHZ4RrNU
	su5QVhJT9deh4nSty5iurY3RXc+W8+Aex0GbZ2/E124DzkdFZggHfApqsHDmXGMT13brLDQ0meXNK
	BUZMimog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obV29-000WAH-Gh; Thu, 22 Sep 2022 22:51:05 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obV27-000W9I-GM
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 22:51:04 +0000
Received: by mail-qt1-x835.google.com with SMTP id w2so7376547qtv.9
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 15:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=c6VKP159SxBjr/BcNk98E/nSSkaOftTs1quW71VgGw0=;
        b=grp3rBO+ii9cBXKQmFamAb6F3ZTeIeb7JWVlNoYg02WGTlKDJIf9lkO/Zw21dYD8Y/
         hxLBCY0enY282POBC8rBK40AKYXCKXY8QKJeZUmWl7cRfwYE0sdbny8j5NB/XRnDf3VV
         VfDvADz/Vkkgw13YsOuYmzyde/LFTu5Waeh95TLzZXBkFujwhbl4aKbuySQm9lW6wOVe
         SQ6m6mzhWVTJbsalhYELALk5BWGtRKmSSsj3rL4LeHzWf92rUY19tE155x1DupbKif+i
         TfDHUFi9Ijgdx/33chVT63gSlROT+LS7S169boCw19zUju2nUi7yZp5t34lrBSkri7V4
         vDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=c6VKP159SxBjr/BcNk98E/nSSkaOftTs1quW71VgGw0=;
        b=tszr8s80wKEEFdd/BbJBHfkmd7wlkTA1z7GxZHE59/TUGtevx0a3on+a1DkHF8NOR3
         qea+4TdG6eJvLFlmS2mMvvSCyjjelX62rL+MaQ1xgN3JroKDS05Qgs9tyUonjN6mDMQT
         iRjz+WcNhXvMwkXdGhLZXuadc7X1Radh8LrDxuGLPpC0Mqrxf795Ua5Ae2nfqhlZtAIZ
         g4rp0j+OdZj538VtTeniAfyjjg2k6ZAbSl4ABC1SZWtMl3g3J99I3TqhpXbrvXyY1fc9
         6S6GilYABGhEr8rVjQnp6D/SOpBKlY5R7Vw3rWFIp2m+jmqztbBZUDzkPaGBOLlGhGqO
         tkBA==
X-Gm-Message-State: ACrzQf2F2ZFzMuKZ32MyIWcM0dAZ1E4q5cGj2KGER3l8wrQvgQQS/w7s
	2W7xrgAhnRMVPooAlv0aBxs=
X-Google-Smtp-Source: AMsMyM6e3Gt9RBXANm0WjM3K9ME8lxX4TbC4Kh27rjoY7DYHSDpTunXEmKmlnQQE/OIbuchyHQgKXg==
X-Received: by 2002:ac8:5889:0:b0:35c:cb1e:68cc with SMTP id t9-20020ac85889000000b0035ccb1e68ccmr5082613qta.406.1663887061587;
        Thu, 22 Sep 2022 15:51:01 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t15-20020a37aa0f000000b006cbc6e1478csm4427048qke.57.2022.09.22.15.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:51:01 -0700 (PDT)
Message-ID: <851034ac-46ac-6928-d616-25c70de76ccd@gmail.com>
Date: Thu, 22 Sep 2022 15:51:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 08/13] nvme-fc: store the generic nvme_ctrl in
 set->driver_data
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Cc: linux-nvme@lists.infradead.org
References: <20220920171611.1289361-1-hch@lst.de>
 <20220920171611.1289361-9-hch@lst.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220920171611.1289361-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_155103_580030_7480D7EC 
X-CRM114-Status: GOOD (  11.13  )
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

On 9/20/2022 10:16 AM, Christoph Hellwig wrote:
> Point the private data to the generic controller structure in preparation
> of using the common tagset init/exit code and use the chance the cleanup
> the init_hctx methods a bit.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/fc.c | 32 ++++++++++++--------------------
>   1 file changed, 12 insertions(+), 20 deletions(-)
> 

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james




