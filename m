Return-Path: <SRS0=MITl=OJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EFFC433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 10:03:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BD2611F0
	for <linux-nvme@archiver.kernel.org>; Sun, 19 Sep 2021 10:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69BD2611F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AW1NHZnSTRPBQtoot4bFRgZMBFvV/+ZYLs6gKVy+Nc=; b=2CnhA1VmNLk+aL/mCRDIbRCjF4
	24guSCr47YUQslfYhYKPFZoBXAxJ2uwoLCGm62bfEPVliKXoadd6Mw2H+fIYCJ9Sx/59QrbEcYpdf
	9+3xe61v8nWmODKvdSgzqBXEgs2vOZ0cFCOfQoaozqdi1TOc5IsbNESJfZh3A7lSr4dtG7OAMuDOv
	GMnN8IOCAV0Hj+8cONTLI3bcj4kd/6wvy/I+nnH75yIOkivU6togna97gKH40bsqxYi8JM41vT0C3
	AtxHQQqlNqvZTdMXCuyy/mbKmbuZDy4RSMvAVwC0UidF3mb7CGLTz0DolV76qXAuOiAb/t9GAPexL
	RZOuaqjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mRtfG-00H4ib-FP; Sun, 19 Sep 2021 10:03:14 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mRtfE-00H4i5-8j
 for linux-nvme@lists.infradead.org; Sun, 19 Sep 2021 10:03:13 +0000
Received: by mail-wm1-f54.google.com with SMTP id z2so1731594wmc.3
 for <linux-nvme@lists.infradead.org>; Sun, 19 Sep 2021 03:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/1EDq0b0IYgdxz24scGGUpQ1criuLNGHPIuEN1CR16Q=;
 b=cxV2Y1nic9UAC7LJfi1VxIWBHQGeiohPDC99Ev2TgRFf8Wt7+0JvuWKDJg4zR2jM13
 DZHKui8P89TnSEJHChySrtLInBJCcjEAtEB3ysJwHRcMHFTPUZFPa8/H+iwUGjGIGSgg
 Rbmo31IdNKzsHZm9RoPPu4a7s+o/rnWY8MD2OSGHAGy8SbNxSNlOPKSTDp5zAttOCz3X
 E1ItT5bgHsNkh9FiL6JhcWtLYaFMT23GL3FGxdwZ7tIZLpcnZ95wlXzFCdR2OlgCKPL3
 FXuil7MnEbufMDEp3VCMka7rbjXy/HBpyCVwf46qohDkiIZoBrS/xJxDmF9p330+PmCL
 pfnQ==
X-Gm-Message-State: AOAM531/RyygT10NfeiXfvYRBjXzDfbnTJbMH1sF2b3XIYTtDKhCUUp4
 zd67W2qyyhfBmbubgqpsnlkXeihxg+o=
X-Google-Smtp-Source: ABdhPJx8rAd4vV3pG9bFzMGnigA6wJ600ImX264LyRuvnNBlny/+6ia2+AqCKi6uwv82jvCimGEzWg==
X-Received: by 2002:a1c:4d01:: with SMTP id o1mr19080344wmh.61.1632045789718; 
 Sun, 19 Sep 2021 03:03:09 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id k4sm11723636wmj.30.2021.09.19.03.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Sep 2021 03:03:09 -0700 (PDT)
Subject: Re: [PATCH] nvme: keep ctrl->namespaces ordered
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: anton.eidelman@gmail.com, linux-nvme@lists.infradead.org
References: <20210915153751.1457173-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f56a9541-2f6f-c8fd-85b9-4fc652852d8b@grimberg.me>
Date: Sun, 19 Sep 2021 13:03:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210915153751.1457173-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210919_030312_360132_8D0E8956 
X-CRM114-Status: UNSURE (   8.63  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
