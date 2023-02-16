Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A18DC636CC
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Feb 2023 03:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mRrk+huqvLsREB4fXPHKW0WRe3uiCIWHsOsh8pv/9a4=; b=B07lycyaYbji8ste0L4Y+bB6Xf
	wPQgrUwVCUf+Q8ZPgXn2PRFSmMlh7KoNz6SEHHBqf/Id+d2bqPF/OEbjHsvSyeG2eBeYMcFviqa+K
	E331hdRt1cuOT+GB9pqn7aaYgJpCKLI1Q3VkGMCkBhfVDAZoLVgUXdakTSd7XuUfqYEjOs2bYZG8i
	L4R6MQQbGyd8yVh+wyHT20RnkWMQw5pjIlEjE97TX27p6alcGIERFLAyZNcHMHWfFmEKKiRE5f96G
	Usl3KhI3I93BUTVMasc1hPUpolB9JETGRq4KSZ9w+J0wU2ax9Z6z3P1RckfXKkR/rkaHJhmGLQjaw
	Q2LWL7fg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSUu7-008OSG-5p; Thu, 16 Feb 2023 03:25:51 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSUu4-008ORM-Ei
	for linux-nvme@lists.infradead.org; Thu, 16 Feb 2023 03:25:49 +0000
Received: by mail-pg1-x536.google.com with SMTP id b22so454605pgw.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Feb 2023 19:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRrk+huqvLsREB4fXPHKW0WRe3uiCIWHsOsh8pv/9a4=;
        b=XTY7W7y3/FP0g25KTBnE6zZ5SpKVS70UtpSkBFbfZ/iBFaBf8bn+NhQ+Y3jjBZS8Qj
         zaIll7sroEo6SZBI+OasIkdd2Rvz5/zuz03DLEy6yreDLbJ/09+he64yieO18bBffvJX
         YxYOUJrBH6P/SkojlujxtRkdNgIIyOcGp6t0ntW/s41Hdy2s6XSAMQ1LKS+QkLNVAUqH
         KeqKuPlXKJBL1JvFs4T1RmscL4bNpMkiiBKXEi5UXdq6WhmMQWGkcmR20YXmwniM8wN0
         Wd2PUrfgQ+oapHwkiEyZ2LJRPpCBNiXRO5FpAWlU9ENK9dM4lLUJ8RikeZoH41ZwJs/A
         iH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRrk+huqvLsREB4fXPHKW0WRe3uiCIWHsOsh8pv/9a4=;
        b=lMM4o5HwsEsWZWfsQ2hvTo4xer9zbPA941BLic9vx7hfKbGJWy00vMTrw5nHlaqHtr
         ZeV4WKE8LQLKYBUvVYozdF/YK7VlYo6H+UOHRAw/pcgRMbpT/J1VLObyAgi/K8IELMVg
         X1ukktWIgKU/iWfXdFB4tjUfjPkJXyqlrGnQgcmaX2d/j9HRASunya5jLK+XFF8HFE0A
         zn8T/F07grMcfGR0PWU25jZQREDmWEKnnv0WHCa5rTT6FhVz8suLwK+LyXEYAx3Qc852
         p1rUqiUMqQ0DPHSLno2D22zsLw35icrWFubEN4SmQmx9keZz5m+ssjZAYwZdENRNc44r
         qN0w==
X-Gm-Message-State: AO0yUKU40+dY8nKer2pXYVHbrzTHCQKjmSWPwVV7SfCrm2fNA8hY+yjy
	wD2xdPK/Z/6upVOq4PD7GeVSJg==
X-Google-Smtp-Source: AK7set9xQgpAoiffZypZuNUXQrvgcty21gEMPpnubTu+FZKm+RPYKyijBEDBbIObbqucc6tRvtqHMg==
X-Received: by 2002:a62:dbc2:0:b0:5a8:bc61:d6e9 with SMTP id f185-20020a62dbc2000000b005a8bc61d6e9mr3479436pfg.2.1676517944672;
        Wed, 15 Feb 2023 19:25:44 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v15-20020a62a50f000000b005a9051241b0sm91787pfm.129.2023.02.15.19.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 19:25:44 -0800 (PST)
Message-ID: <4c2ddb31-b384-2d39-e49e-2f6683062f01@kernel.dk>
Date: Wed, 15 Feb 2023 20:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y+0hG6t1gTse7yfo@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y+0hG6t1gTse7yfo@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_192548_499414_EAE3D5A5 
X-CRM114-Status: GOOD (  11.87  )
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

On 2/15/23 11:14 AM, Christoph Hellwig wrote:
> The following changes since commit 38c33ece232019c5b18b4d5ec0254807cac06b7c:
> 
>   Merge tag 'nvme-6.2-2023-02-09' of git://git.infradead.org/nvme into block-6.2 (2023-02-09 08:12:06 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2023-02-15
> 
> for you to fetch changes up to dc785d69d753a3894c93afc23b91404652382ead:
> 
>   nvme-pci: always return an ERR_PTR from nvme_pci_alloc_dev (2023-02-14 06:39:02 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.2
> 
>  - always return an ERR_PTR from nvme_pci_alloc_dev (Irvin Cote)
>  - add bogus ID quirk for ADATA SX6000PNP (Daniel Wagner)
>  - set the DMA mask earlier (Christoph Hellwig)

Pulled, thanks.

-- 
Jens Axboe



