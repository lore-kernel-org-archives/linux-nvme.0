Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB1D4C6FA90
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CK9TebHno8mIksOGMP5iM3H7Bl6eF54lPzCEEcDUT8A=; b=t5VtxsNXPW987d0GZJT4z8YlFE
	5s36AG2elrmelj4cEEA+jJd9aY8OTEUwIPueBr1VY1efNvlNnWnOQuZ+uCk64NLgbJ6ecduzjJLx7
	im7eHliSG6CecNcjCCgMlkP66C730uDA1tNTgoWoG9emfZE9KGaKSHilnwtL9X1Gy38B36hqQG2jO
	EhO7of/KBlf8jN4+m2XwIGmL8HOIHTZ1ImGXXxiak7VllVRL6BnsyCIwO5ZeWpzJV2vJiXB2cJJJM
	kpYe2WMBJVIuGUSSAo2awEySDcwlfl7uYCoos05QNC6IYWwV8ILcStQJaQfJ+h07cV9GGL4Bp8bJ+
	rLVtGm8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oadeY-004FTz-34; Tue, 20 Sep 2022 13:51:10 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oadeR-004FNS-JA
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 13:51:08 +0000
Received: by mail-io1-xd35.google.com with SMTP id n81so2280113iod.6
        for <linux-nvme@lists.infradead.org>; Tue, 20 Sep 2022 06:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=CK9TebHno8mIksOGMP5iM3H7Bl6eF54lPzCEEcDUT8A=;
        b=1pix+LOtxXtsEWvUmhnBjK3Gi+Nnb5nIznsQKF7piSBaXYJeoA+t+BzRXQud265iJj
         IoaThAE80xzywXLO4AXggmrZzoENkNb+RhP2jf7qx7b4hpSNhSWrj6Avdb0urPmwJTBr
         Hm8FSrU8cQRUgiZzngJhBpezxDAxEUqDdYpE5T1ZPuppXTiXk5uEBsgedRxlN2Z85lG7
         rlYwEgPLBJrJLrua5ZL2USGLNcOTnY8FRV8fEpPFS7ABnKRktyzzIxraJ2styn+HWl3X
         ijUCyEC1A/x8QOvGtZYd0wo/Ar7rx/A7UZaxiOarJBC0GHjtnBLMf+Nzn8HN1ej7vhnN
         3OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=CK9TebHno8mIksOGMP5iM3H7Bl6eF54lPzCEEcDUT8A=;
        b=hNCDBazFx/un8DC260W0GtZpP6X3ozdQc5sEj+VUVXQOlLav3K9sT6hdJ/yLCm8ApT
         tuclZBwRqFUWe4O2TvFCzil+4Br//SFrZFOghk5JyG4aBaefEmcH9H+bkNysL8e3eVuX
         2DlXPGk5lyW6t5ZZ/ejOItZ+v8oGQ38Tntcen3LUo7aRkS7IGUAdpy0wGTt3rOdN1bk3
         +GvkrDclPphZFyCk46o7V4fT4z2D+eYYH5K0ZxNgPbdOpt9V1QpwUuFcGNZ3V8z7GiXg
         HnBEPC/qdA2tKJktiOpbr055Rq25uFWgQ5PYBcED7jpHhwTTs0KSIsYmod7womrcIlq1
         y6PA==
X-Gm-Message-State: ACrzQf0wJteoQHx+vU83lmjsK4Xx+50FfVL/C+PH7AK1hUDSugwBotjV
	VJ4YHXxD0Exci+PinGmKFpoKZg==
X-Google-Smtp-Source: AMsMyM5/3U4XqLk26/Dwj3BYAtCy7LF4qawYFbJqiCdHYjNuc+YqIYw+7kE3g0JkUej/1M3hc9dQIQ==
X-Received: by 2002:a02:c4d4:0:b0:35a:a076:bb5e with SMTP id h20-20020a02c4d4000000b0035aa076bb5emr7927171jaj.300.1663681860310;
        Tue, 20 Sep 2022 06:51:00 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v8-20020a056e0213c800b002f1a7929d67sm65818ilj.72.2022.09.20.06.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 06:50:59 -0700 (PDT)
Message-ID: <c296189b-0a43-e682-d5c1-85cec7ce1f98@kernel.dk>
Date: Tue, 20 Sep 2022 07:50:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [GIT PULL] first round of nvme updates for Linux 6.1
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Yylz9ST3BJeXmQCU@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Yylz9ST3BJeXmQCU@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_065103_972367_D9ED95A9 
X-CRM114-Status: GOOD (  12.92  )
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

On 9/20/22 2:04 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> here is currently queue up nvme patches for 6.1, which are not a lot.
> There are a few more patches under discussion that will follow later.
> 
> The following changes since commit 91418cc4fd8f8e2e21b409eb8983d074359c8be6:
> 
>   block/drbd: remove unused w_start_resync declaration (2022-09-12 01:47:57 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-09-20

Pulled, thanks.

-- 
Jens Axboe



