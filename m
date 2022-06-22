Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF94C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Ygnmr3VzBkMOqarnDRQ0l10afrspm3Z7ECFxSWL1VE=; b=mqq7NRL6vCCZiIPaXboxEc7eUI
	gnOvBvHV+66glWV6JrVStSZEnUtp0ieoh0XOf6jr0FH/JFe8+6KO/Wgw3JNjsuU/MYOTz3wAKqB7h
	j1r8XuSFko5u7UvkXvBxMw4pLwxguM3eUKq4hr5GMK5UoGVetofP+U+HhI+PfaEOIGnz3jiiGzwNg
	zhZ0Wpz1eVR8PdVbcgpJoHOt9xeXc3DTT2rLc7B/ei9xMk9fQ3BwUrky3sqS8B4m7XjcwEA2vrvhQ
	/NyFkOaX0XDVJJo2WbmKSNtYCUiuAWq61M/oCzqAr+uLWyT5vvbpICjw1oAUDB+wiyLZibdpf2eQX
	Xq/yoluA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o44OI-00BjuV-48; Wed, 22 Jun 2022 17:43:46 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o44OC-00Bjqe-Ks
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 17:43:45 +0000
Received: by mail-wr1-f44.google.com with SMTP id v14so24462419wra.5
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 10:43:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9Ygnmr3VzBkMOqarnDRQ0l10afrspm3Z7ECFxSWL1VE=;
        b=IZwRD44nBvmHH8lcRj1OeL1iHjY2NqRsPv11YmVkRiyrlXGbPH5FKcbNiysFdWdlrN
         +pHcJBCEeRmV2TG3Uu0KdCMzusC2OFlAWfQFe370qdZk0R3WrQrEIreV+C/rOLIIIguO
         ABST4cNIszVi2L/GwG5xJ+DfmAosm2MQ1LfsB3rf87i/mXuJx5g8BwUQ846qTrVLPx83
         5iAxmEjXag77plvLUz5LrtS/0E3Fo95X3briVVdE7lnISqc1NU/+e5QHTAlnMTd3P8Me
         7lF+bNxaYnxld8wJi1LM5lUTN5VWbAOiKZ6WYjU9si1BXSCMLz48/qZ0Qd95YWEmLOvq
         +LnQ==
X-Gm-Message-State: AJIora+BposHGBEakk8wtgV5T7iBmLZcaoqaTnEghIoTJeOo/3SRUFT/
	Um9jMVCujH7XgQ3DOV9O0Ro=
X-Google-Smtp-Source: AGRyM1s0qWkwTIx3iBoiSJu5xrQJUubim+Nxx/1DIIStJ2IZ+m4St61x7SmU0qL0M9W6W/FayxjnAA==
X-Received: by 2002:a05:6000:1ac8:b0:21b:9236:6207 with SMTP id i8-20020a0560001ac800b0021b92366207mr4303087wry.123.1655919809243;
        Wed, 22 Jun 2022 10:43:29 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id l12-20020a056000022c00b0021a3daef45esm21475591wrz.63.2022.06.22.10.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:43:28 -0700 (PDT)
Message-ID: <b7415f78-99f7-87be-85b3-deb3e2118660@grimberg.me>
Date: Wed, 22 Jun 2022 20:43:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 06/11] nvme: Implement In-Band authentication
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621172414.82847-1-hare@suse.de>
 <20220621172414.82847-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220621172414.82847-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_104340_729214_092D7FB0 
X-CRM114-Status: GOOD (  11.75  )
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


> @@ -552,6 +586,8 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
> +	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
> +	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
>   	{ NVMF_OPT_ERR,			NULL			}
>   };
>   
> @@ -833,6 +869,34 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> +		case NVMF_OPT_DHCHAP_SECRET:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> +				pr_err("Invalid DH-CHAP secret %s\n", p);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			kfree(opts->dhchap_secret);
> +			opts->dhchap_secret = p;
> +			break;
> +		case NVMF_OPT_DHCHAP_CTRL_SECRET:
> +			p = match_strdup(args);
> +			if (!p) {
> +				ret = -ENOMEM;
> +				goto out;
> +			}
> +			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
> +				pr_err("Invalid DH-CHAP secret %s\n", p);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			kfree(opts->dhchap_ctrl_secret);
> +			opts->dhchap_ctrl_secret = p;
> +			break;
>   		default:
>   			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
>   				p);
> @@ -951,6 +1015,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   	kfree(opts->subsysnqn);
>   	kfree(opts->host_traddr);
>   	kfree(opts->host_iface);
> +	kfree(opts->dhchap_secret);

I think you need to free ctrl_dhchap_secret as well.

I see kmemleak complaits:
--
unreferenced object 0xffff9797b529f140 (size 64):
   comm "nvme", pid 7070, jiffies 4362827766 (age 27851.164s)
   hex dump (first 32 bytes):
     44 48 48 43 2d 31 3a 30 30 3a 6a 63 2f 4d 79 31  DHHC-1:00:jc/My1
     6f 30 71 74 4c 43 57 52 70 2b 73 48 68 41 56 4e  o0qtLCWRp+sHhAVN
   backtrace:
     [<00000000a8aa18e4>] kmemdup_nul+0x22/0x50
     [<000000009798b50f>] nvmf_parse_options+0x208/0x790 [nvme_fabrics]
     [<0000000049fd6c0a>] nvmf_create_ctrl+0x3e/0x230 [nvme_fabrics]
     [<000000000a5ab7b3>] nvmf_dev_write+0x7d/0xe0 [nvme_fabrics]
     [<000000006c0feca3>] vfs_write+0xb5/0x290
     [<00000000868859e4>] ksys_write+0x5f/0xe0
     [<00000000d670ec58>] do_syscall_64+0x3b/0x90
     [<00000000a2feb9a4>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
--

