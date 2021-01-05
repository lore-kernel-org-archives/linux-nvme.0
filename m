Return-Path: <SRS0=mRFX=GI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71288C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 12:43:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F139F229C5
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jan 2021 12:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F139F229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JK6TSS9N+uGERyO+vP0EFd1dizDmC6WiorbQCyK370E=; b=zf6YHNCkxC/lXveis1bWZEVVY
	zNGbCcL9NpS2OKiljj/Hhun8KB9m1fVDXEXfsPTnNEs6aryjqilM+hD/9tyTIl5duXTwy8R/BLWhP
	DMSmwhqfPG9eXRIYti4Ycxr1CtqhMJn4AONNTdjwTdN2xrjQHMDxLicUvnwiVAva00lAs593QPFeo
	nn01sGXavZjNeR13gp3NuS1qph73lJ8tnklhqRwgPweksy+QMqIvPDCO1KFRLekbWBMyonpk6mnUG
	00RjY5G3rI0Mlm51N4GHEVVAsHBQdy+ldXXg+eQFeF4gFGPHWbNzJa96/KUeP7Kl2wx3HjZtMhevJ
	+krGxmc8A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwlg6-00067J-Hf; Tue, 05 Jan 2021 12:43:10 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwlg4-00066P-Hz
 for linux-nvme@lists.infradead.org; Tue, 05 Jan 2021 12:43:09 +0000
Received: by mail-pg1-x52d.google.com with SMTP id n7so21218902pgg.2
 for <linux-nvme@lists.infradead.org>; Tue, 05 Jan 2021 04:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=pBAkou0Oab/E0zysaAeTM0vAap7Jv+dikzt7m9rXce4=;
 b=ICH5YSTBR+QA1T9kpPzXgCPbIbXXEaDq9ppOh7S+mWrLfKJKyBaiBYYxgnaApJZ3iQ
 M+G2Rfbjxwgc6wMnjqT2C72tRWSH5LNSEY2dEG3FkoEhtaVq/Z0IksKVIBI5OsdPxWWf
 kVZJACaSVDqAbvckhFfUw+XIiG+/a3hDW3+Viup5Kf8gRJVhzscPUPu8lgJQtdyTRZQP
 Wp8ceBnPStF/zhsLFbLnb89e4vsnCxPWUW5FWCdOqcZ+gVVlKN6ByAdqVGjryQolWYmO
 dIUaYLwtWFYd4zgfjrSo4DFQufhalqSbgP6jZXyv5loTx+Y7a/5YFJp/iL4XQFLhF9mn
 J/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pBAkou0Oab/E0zysaAeTM0vAap7Jv+dikzt7m9rXce4=;
 b=dCeVEWqyW9NSf63T+69uv9pBBOjK14gWb0Fu1lw/Cfq6KwsE1O7KTJARVLd1UMBSok
 e13WO3SJtKa6SCQGcBRq7Vj5SGQKZKiPv2T1PHDNmrZ9dMn0k4XSM1cVQJX0M/AskHkp
 pcM7mAYZBSPMgquqq50Hk6pWhLzoszKC3sMT021/nfFE4ZB92rnCbVAbGRoeEbcVNABy
 3Q3+i4e2zU9Sr0Wb8Jc5RpEvHE0Nv3hfF3HEKHmuHOZXgDgzxn8jLAHZkXSOimVR5uT7
 ATjO95hQbfWGgb4qWC/t3LNMBnH7Aj8J0dupf3YNgv5VnzIn9avCBdY21FRl+1HRMKp9
 mICA==
X-Gm-Message-State: AOAM533TEEtMViBZCrc/e/67WGAqi5FGYKj8Rl+ui8w8mLp0P8OEjIwJ
 Lz56KEYMp7uGqLXfvXpPe0s=
X-Google-Smtp-Source: ABdhPJwRKBmBOmtBsKnSyBk7tnw/T0Ya4ESbLLlIRQzxYX7eJSGumMDdmIs9TlEtLQ7yE/w/AsmpiA==
X-Received: by 2002:a63:cf56:: with SMTP id b22mr76187706pgj.16.1609850586209; 
 Tue, 05 Jan 2021 04:43:06 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id m3sm57053247pfa.134.2021.01.05.04.43.05
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Jan 2021 04:43:05 -0800 (PST)
Date: Tue, 5 Jan 2021 21:43:03 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 1/1] nvme: remove the unused status argument from
 nvme_trace_bio_complete
Message-ID: <20210105124303.GA13655@localhost.localdomain>
References: <20210105103402.3121-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210105103402.3121-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210105_074308_668127_C692857D 
X-CRM114-Status: UNSURE (   9.80  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: sagi@grimberg.me, israelr@nvidia.com, linux-nvme@lists.infradead.org,
 oren@nvidia.com, nitzanc@nvidia.com, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

Looks good to me.

On 21-01-05 10:34:02, Max Gurtovoy wrote:
> The only used argument in this function is the "req".
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
