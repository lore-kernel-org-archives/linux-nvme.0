Return-Path: <SRS0=DfP6=K5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB767C47082
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:20:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A926C600D3
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jun 2021 17:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A926C600D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=IfPB1kSJ+mbALF4P23IaAK/MpHDavhOIbTKH77QOoiI=; b=Y7Mpovg7Tmm8zw
	4hgu+uxAGFGJL0NBCpUR27de+fUy7xR4R6MwJH10VB0gWM3MqHDcxe5PRpo0yg7gWRL+mZkbzMCEf
	ICuv2+yP3EkOxwSjwxXuyatk3FzvBlTqay/2reoNsYuYDUNlPXhOo7kTcrby4CmJZDFr/rN5XVEgt
	uEn9K0YtYXBzDo1z7zjIBeQiz9MpFLBzJi89yv6EHt82sIk2PijKLosqeicmucdbm8osDqMFu6jLi
	+dRQmodPlH+aOGKkXmjKJSAqbzCTYKL4F6BbHIN5diasuyU2LGmHCi8hqqsD4scL+v7u/j1F4gaGr
	c2SfsttQiTzRXdDONI4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lor0q-009pDM-PW; Thu, 03 Jun 2021 17:20:08 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loqwT-009nZz-01
 for linux-nvme@lists.infradead.org; Thu, 03 Jun 2021 17:15:38 +0000
Received: by mail-qt1-x835.google.com with SMTP id a15so4960597qta.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Jun 2021 10:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=w0exjtZ15/jxZ5appQWYmEfz/5/RSw8ZiyvtjDQDYXo=;
 b=Ukb4v1ha4SLkwCDpxPfZJx7IzOAC2os3Hte+6pTnbHFTHaZIoduzTVnSHvJ3C/8j28
 FwaMNxlAtxen75T/MAl8jz5/RvKNphj8Ul0idJtgnxFZTWrX5QSF4b6Wy9sc34wlQ0Gk
 eYZeaFBuN0CkOwrKbt9HTAktTb+GZjSCbgROnUvGCyMd3bXtCzDZiOHhS/BC1+Af0OT1
 I6oP1kNnbl/RVay52vQP8RUvl4SCvlwznmjx+pALToPP5MMDD3gp8/f36W89GodqVGz0
 HTz9iZcPVuik0CUoSeI2VK44O6D6is/Zj/7ugUkVp1yWiff3bMSOM03tKvW24SZgAKMT
 7HUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=w0exjtZ15/jxZ5appQWYmEfz/5/RSw8ZiyvtjDQDYXo=;
 b=FOOBhAe2a0+/lvdd8eqZr/W/8JEyxuGqCQGF+BfVV/xtpC/YT2LkUXUAdeXmFxSLMC
 mQN2Go4TWnZ7SGlnORVcX3YQ2P3P41rwz3LFjaAtO44j06O/Lvgy5uwb/hIS0CdAeIQd
 4oaOFci5ZBDEONQ983GTUQApUm7Sj6dVpjEovyMCgguebJQNvDoO3woDJg5AKJ4yjZ+A
 n/tI/3Uaftj/2tQ1QTUPCPaejB+qW6zKFHKSnLNeDW60XrV7KS/qRj40DJwF/j/VhM1F
 klNaijSLfw3uvx/viadIjBEh19YFiZq1ReKJrDxPxxG7aUv84XuQrmA8MqfNMswoadxU
 V13w==
X-Gm-Message-State: AOAM532BhCcDQGi32UYPYHOhy0CUMDGKRj4fLl+fNdaZ/RlaibkRxS5g
 pgPqm1Bn6DHzt464LqHv+jk=
X-Google-Smtp-Source: ABdhPJzJlJJs0A63qDpwwMabAHWI5tlTd2iZpCNLj0CRyeDrkiQDV+LQGLgYlDXXdThf4pzCcwmgiA==
X-Received: by 2002:a05:622a:309:: with SMTP id
 q9mr497487qtw.320.1622740535479; 
 Thu, 03 Jun 2021 10:15:35 -0700 (PDT)
Received: from localhost ([199.192.137.73])
 by smtp.gmail.com with ESMTPSA id o143sm2322483qke.16.2021.06.03.10.15.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Jun 2021 10:15:35 -0700 (PDT)
Date: Thu, 3 Jun 2021 13:15:34 -0400
From: Tejun Heo <tj@kernel.org>
To: Muneendra <muneendra.kumar@broadcom.com>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de, jsmart2021@gmail.com,
 emilne@redhat.com, mkumar@redhat.com
Subject: Re: [PATCH v10 02/13] blkcg: Added a app identifier support for blkcg
Message-ID: <YLkONg69icwTD+bD@slm.duckdns.org>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
 <1619562897-14062-3-git-send-email-muneendra.kumar@broadcom.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1619562897-14062-3-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210603_101537_085888_A1AD21C9 
X-CRM114-Status: GOOD (  10.35  )
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

Hello,

On Wed, Apr 28, 2021 at 04:04:46AM +0530, Muneendra wrote:
...
> +static inline int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len)
> +{
...
> +	strlcpy(blkcg->fc_app_id, app_id, app_id_len);
> +}
...
> +static inline char *blkcg_get_fc_appid(struct bio *bio)
> +{
> +	if (bio && bio->bi_blkg &&
> +		(bio->bi_blkg->blkcg->fc_app_id[0] != '\0'))
> +		return bio->bi_blkg->blkcg->fc_app_id;
> +	return NULL;
> +}

So, there's reader-writer race here but if that's okay for the use case,
please note that with a comment. Otherwise:

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
