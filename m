Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA13C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 20:20:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D0760E76
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 20:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69D0760E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hSyDWcos8voK0laV9iiR6rLcJYcA/zGVhRMe3KflZbY=; b=Fnn30+Jq9zGLNl
	c0S3xTwX2q5zj+XWRXy9t198ut5yTSrPyL/nXSX5lRH2bTkKNOsRJA5YYJReOdNkpPXXYGfJa0oh+
	gXB7KEcrjqYNJl/cYbKIt6kHbC+Gb8aoAbwwRjbf0MxcFqPyKs1AthKFMjN4nzOmb+ZkJDZVlMesv
	naU6pt/y9ib8B3tKn/MA1Zild9PoCcPYgz4SJfzlxtskGCaDFJFZdzSIgKECKtL+2fCZQiIeRfWmP
	88ZScMvxQaddGvlitzeLAkPxpZ1WIv1vipjBBijjGLnI/GMfJXny9RZEyX3z3jnvoXlt2GpLqeFQj
	akkXTfvnGKdS81NP6IGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPsQg-003AZv-0Y; Mon, 13 Sep 2021 20:19:50 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPsQd-003AYr-0O
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 20:19:48 +0000
Received: by mail-wr1-x433.google.com with SMTP id t8so11525313wrq.4
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 13:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Bz6FvGGU07KPK+agys9SwAMl1hDlSOpUcqq9bmZVgr0=;
 b=n6LgbsNvb0G+smQjZONYALt7AmZ9kxNBmDB2x7hfCYP/pHvh7eQTF+Ucm2Tm4hy7aj
 ZyJicZUz2i8w6Sv5KaF8nPemK1e7t/0NxWBA7CA7Kp+/2s/ET3iZKvRAlEPHPfEeN+X0
 YSn/tMtK5nQZSTXHbpvTZMBobhqqN/GGXBo26owaRtOb7GFCox1mNzm0MPuYhVkahcuO
 S/eSR+VVDhj2mqMKnAMRZZzjXtnUIRdSFTRYqsOeoBdZniNXoN8dpelBP/0krEIJixB5
 RF9foj6sVmy/AvJ2YcACzu68ndiW/ESPbb4TCmwN24FCUmuHvKwhaZRcNM5jLmDEXlcZ
 fvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Bz6FvGGU07KPK+agys9SwAMl1hDlSOpUcqq9bmZVgr0=;
 b=eYgPoGuWBFxx2aGrKhW2PO3I9mM8QoKoC88nDRevEwmyGEFP7u+WfSLWBoRqHSiGKu
 gde7Zi54TCfrM83D1PbPxW60nM8qksLKE3QOqPFeqlC1BbkTlYy7blILFApy996lrW2s
 +AkGzg92zUpdNP5glKAwzfes2oJgbyWClugLaYHnJvxHK3M+nI98YqWuTjcKV1ivjGLc
 qnBSAI0To6NumDaGhxp/ouQIXfoZNLsWhTUNh+uFDCNx5rRYAtycKJ62uGDZoLVZME95
 AN0tfBBSRhP531zMp9Gii0Pm4tjLqN90Zye7+y97Vbur2NWk4ipl4hFBDkgBWdSgIPKS
 r2uQ==
X-Gm-Message-State: AOAM5318tmu2XRj6imfBN5/32bAZXf1h5sI9hQ1QJSJ2CP3XC79I4TAp
 pnbLeEScdCrvez5jDGYV1Kc=
X-Google-Smtp-Source: ABdhPJyhgeGhk8wEizAHq3mqIsw/QaHHsTXRModpsQeQBufT3CECdNdIpkNu0aUhADxGtlbMZVgKDg==
X-Received: by 2002:a5d:4b0b:: with SMTP id v11mr15072200wrq.359.1631564380718; 
 Mon, 13 Sep 2021 13:19:40 -0700 (PDT)
Received: from anton-latitude (c-76-23-2-87.hsd1.ut.comcast.net. [76.23.2.87])
 by smtp.gmail.com with ESMTPSA id
 j14sm8433188wrp.21.2021.09.13.13.19.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 13:19:40 -0700 (PDT)
Date: Mon, 13 Sep 2021 14:19:35 -0600
From: Anton Eidelman <anton.eidelman@gmail.com>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Subject: Re: [PATCH v2 2/3] nvme/multipath: cosmetic: keep ns nsid locally
Message-ID: <20210913201935.GA83181@anton-latitude>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-3-anton@lightbitslabs.com>
 <20210913160220.GB6442@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913160220.GB6442@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_131947_096626_B67F361E 
X-CRM114-Status: GOOD (  13.88  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 13, 2021 at 06:02:20PM +0200, Christoph Hellwig wrote:
> On Mon, Sep 13, 2021 at 09:30:22AM -0600, Anton Eidelman wrote:
> > Keep the nsid of the current namespace in a local variable.
> > Change the type to unsigned int to make checkpatch happy.
> > 
> > Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
> 
> I can't really see any improvement here.  Also checkpath as so often
> these days is fundamentally wrong here.

Do we you prefer to scrap this commit?

I just wanted to get rid of multiple occurances of "ns->head->ns_id",
and just use a local variable that only changes
once in the for_each iteration.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
