Return-Path: <SRS0=p1db=LY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A519AC11F66
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 18:50:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A4F61494
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jun 2021 18:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A4F61494
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=00KSb2Qpv06ceW3fsRw4cbh4hBTSJ/RIGOvF1hLqOSs=; b=IG253PCJvJk7fB82taLP2JXy+f
	QS3NagjM/XQGOZjU6S2bHmQniW5svqRnGBHWiGnlvNM6Fy33oPDH46oS4SId0gSVYbS8E5ElLbo+u
	wUQSy7ZjapA3KWkQ8LzPnZdbAAG/Z9zIcRZFk1w0pofS+55LCsxZ/sE9AtF8bSG5FOK/Cadv0Wdvd
	DtymNAUlo9NhpWCzjfbyUSFfpdhObkwlFdBwJiYYPIG5eu9P/wX2BXjBl5IwMn07I5f6TJ2gYVcVT
	5WnWBeYQhCAFUXMalY6snQWe3ezt+4ebJoPU/t3bDse3LNRWhZyr+k1TmVcu7cfawgZcPhn5d+Nal
	ZiEj0JxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyfHp-00F2lK-MG; Wed, 30 Jun 2021 18:50:13 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyfHn-00F2k0-1P
 for linux-nvme@lists.infradead.org; Wed, 30 Jun 2021 18:50:12 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 g24-20020a17090ace98b029017225d0c013so3700444pju.1
 for <linux-nvme@lists.infradead.org>; Wed, 30 Jun 2021 11:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eNw8dBI5PhxQLFB8+rMgyGNEk5rA3kFMUjTuuttIqu8=;
 b=UQZs2AG8UW8Q6Z27Io8JiQn2ND9/HYYYOsQv2qJrE94yNFY8t+qHwCn0wcY6T2wJwG
 y5NEsDOvH+MXAdpdNdPF2Nf44rYiDuonNvcDCi0VjKsmo3G3jxUe4uAhEI9miPV64TxS
 D+Yr1Sm+NRcOhzUoTOCEJ7J/hODSa9JrnUHGmRP1bgOzROTKLRsitK7xO07g5l1rte8b
 uHuTz7Mj6vt+2tm3lcw7M8kv38yOwixFsTdD0VBKidcn6Jx7jSTf87aC7SnWyBwR8Zos
 gyJThrYwoTSPXDO6+q1zxod5hLuYNG/hAlRWCCsGOMN2UGxsE57Mii63sufUieI51epo
 00Jg==
X-Gm-Message-State: AOAM530xeiulCp4TfgjA8jUDon8UwaUZ3ry7IpgWkvvY61d1im5H9dAg
 fHWTNJ5JRmAbR3/R74bsadZmrKWg4NQ=
X-Google-Smtp-Source: ABdhPJwx4P/U4JWYRhsLO+xaPgfqyNlAWmpYBzRe8Zwn5hS24Yw2wlgwssDSzEBIewZOA91EAMZcNg==
X-Received: by 2002:a17:902:8504:b029:128:c36f:2b7d with SMTP id
 bj4-20020a1709028504b0290128c36f2b7dmr20678224plb.32.1625079008713; 
 Wed, 30 Jun 2021 11:50:08 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8e5:b428:30c3:f97b?
 ([2601:647:4802:9070:8e5:b428:30c3:f97b])
 by smtp.gmail.com with ESMTPSA id v69sm24846682pfc.18.2021.06.30.11.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Jun 2021 11:50:07 -0700 (PDT)
Subject: Re: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes
 set
To: ran.anner@dell.com, hch@lst.de, linux-nvme@lists.infradead.org
References: <20210502153106.18970-1-ran.anner@dell.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <a1767b33-561d-3c9f-cdd0-b338f2967f6e@grimberg.me>
Date: Wed, 30 Jun 2021 11:50:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210502153106.18970-1-ran.anner@dell.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210630_115011_138941_56B925E5 
X-CRM114-Status: GOOD (  22.38  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> From: Ran Anner <Ran.Anner@dell.com>
> 
> According to the spec we should fail creation of IO queues
> if iosqes or iocqes properties are not set

Would be good to add the specific section in the spec.

  but does not mention
> preventing from changing ctrl status to ready.
> We have seen host implementation which sets the property to 0x1
> and waits endlessly until ctrl status changes to ready.
> 
> Signed-off-by: Ran Anner <Ran.Anner@dell.com>
> ---
>   drivers/nvme/target/core.c        | 39 +------------------------------
>   drivers/nvme/target/fabrics-cmd.c |  9 +++++++
>   drivers/nvme/target/nvmet.h       | 34 +++++++++++++++++++++++++++
>   3 files changed, 44 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index adbede9ab7f3..559dc7354adb 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1078,48 +1078,11 @@ void nvmet_req_free_sgls(struct nvmet_req *req)
>   }
>   EXPORT_SYMBOL_GPL(nvmet_req_free_sgls);
>   
> -static inline bool nvmet_cc_en(u32 cc)
> -{
> -	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
> -}
> -
> -static inline u8 nvmet_cc_css(u32 cc)
> -{
> -	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
> -}
> -
> -static inline u8 nvmet_cc_mps(u32 cc)
> -{
> -	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
> -}
> -
> -static inline u8 nvmet_cc_ams(u32 cc)
> -{
> -	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
> -}
> -
> -static inline u8 nvmet_cc_shn(u32 cc)
> -{
> -	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
> -}
> -
> -static inline u8 nvmet_cc_iosqes(u32 cc)
> -{
> -	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
> -}
> -
> -static inline u8 nvmet_cc_iocqes(u32 cc)
> -{
> -	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
> -}
> -
>   static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
>   {
>   	lockdep_assert_held(&ctrl->lock);
>   
> -	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> -	    nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES ||
> -	    nvmet_cc_mps(ctrl->cc) != 0 ||
> +	if (nvmet_cc_mps(ctrl->cc) != 0 ||
>   	    nvmet_cc_ams(ctrl->cc) != 0 ||
>   	    nvmet_cc_css(ctrl->cc) != 0) {
>   		ctrl->csts = NVME_CSTS_CFS;
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index 1420a8e3e0b1..421ab564ed5c 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -259,6 +259,15 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
>   		goto out_ctrl_put;
>   	}
>   
> +	if (nvmet_cc_iosqes(ctrl->cc) != NVME_NVM_IOSQES ||
> +			nvmet_cc_iocqes(ctrl->cc) != NVME_NVM_IOCQES) {

Can you indent to the start of the parenthesis?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
