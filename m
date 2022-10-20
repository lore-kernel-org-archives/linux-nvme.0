Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F413C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Oct 2022 12:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SD1SmgBy8yy81OdjQiEz8k7nIalu/meQTVoilBM0ZmE=; b=uoIqF/ok6jJ89kSsKs68gPYg2Y
	+o4LBHbToLjWISb1XtKvXcVU/5EccUXQAShNKR12Jtkd/5mNJqlZgNm4qhGSbkg0vwOT9QGtc3W33
	nKr0GL0AHPkNJpTiEuoKqpW+vwmcNHi59MRvkSSe58AoV51lF7UbEWm7+pXpdEpUyQFhx2ybpje4q
	hWnzphYV3XI8VV9qX2xxA+4Ei56NhyZnBadnYOqfztO7Wi7nnXwdwioeycb4ywP/o2XGQCYEp+Aco
	kQryQDoEZmK25w9Yd7JngFXxvdWKoUKz+lGh/gUAZak/+h4uvIjDmX/bu/r/MgN/TeAaf3fH7RkTe
	6sHc4HfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olV7e-00F8tg-Tb; Thu, 20 Oct 2022 12:58:06 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olUuf-00Ey8L-Hk
	for linux-nvme@lists.infradead.org; Thu, 20 Oct 2022 12:44:43 +0000
Received: by mail-pj1-x102e.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso2340819pjn.0
        for <linux-nvme@lists.infradead.org>; Thu, 20 Oct 2022 05:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SD1SmgBy8yy81OdjQiEz8k7nIalu/meQTVoilBM0ZmE=;
        b=ZGCXAu3f1sz3wGahRpQhqGQc5mdl07tJeVUiHYHWXzJK2WDjCudxEYGUbg3wvU/q70
         +mUFcE4t2zOxVvo351O4rlSq9gEqnOm3r5KBjyA6qoIvzo8Q6V+aL3pcPgT4IQ9EuN0d
         FAx4N0XVSurc6XMZg6Yi3o+svKmHkgT/Y8VaMbitaH4dvSnVdnAKQD4WqU9/nKppm9e6
         8l3nLXJfWzY4GzKq3Gce/p/JbMLqmxuEEtp0ime5KnbzBVAuDy353ipbxSbIcvouLq/5
         gIZjk5UNfqzLgzouxGme+JonP68Y6uHFb67ZEHWBphFm6BWFp/HkDEIgODe/WKCQM2ty
         yRuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SD1SmgBy8yy81OdjQiEz8k7nIalu/meQTVoilBM0ZmE=;
        b=zvzhtn7bHeB+rA3yN5ZJdwL7LTpojJoVTRcPfP8ZpE3gHv0uwORRNrck/JrwZy0G+f
         t9Q6wif4MeVbXDzJ7YAeMn/tldMfQxvPZnl/5xMDSETgGXfxiYXklVED2Ya2DrrlWZ1X
         LAKXZQS7RNy1rx2lR6iAiH8eV+eg69lT+U0V+CVzq8B7t1M/kZ1V/9UID7aVIn8txpDW
         cPHx6gOso/56r1jgn8iM2EauBUFvNIkfElQiEe925NDIZxo6vtf8EHNUVjZ+NeJqteXM
         A8WCZ5kINKvZ+ZEh9/9RrC4JMTz/rqeRGDnBPdkDebX3vm14YaYdx+611j+oJm2hn34r
         R/Og==
X-Gm-Message-State: ACrzQf1Y2iXbdxTqoLa+PB0Xs6QZA+UcnR+5/vt76tplJSLhyz/CUGT4
	uJRKZnuVbI4Tct8KzOjS5+lqxg==
X-Google-Smtp-Source: AMsMyM5Cr4DfPUctp2wz7vrf1Tij5yVA1d/FPQfZuTli2Oz5HcpDtR4Ep8Q/FKjYhaV9Wv+uOUSEpw==
X-Received: by 2002:a17:90a:bd87:b0:20b:1cb4:2c92 with SMTP id z7-20020a17090abd8700b0020b1cb42c92mr16264857pjr.210.1666269879296;
        Thu, 20 Oct 2022 05:44:39 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902ce8200b00179f370dbfasm12907953plg.26.2022.10.20.05.44.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 05:44:38 -0700 (PDT)
Message-ID: <3c07d444-7863-a658-8b7b-755654d390d3@kernel.dk>
Date: Thu, 20 Oct 2022 05:44:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [GIT PULL] nvme fixes for Linux 6.1
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <Y1ENi1X5gi7yU9VS@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y1ENi1X5gi7yU9VS@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221020_054441_840015_8162BE07 
X-CRM114-Status: UNSURE (   9.30  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/20/22 1:57 AM, Christoph Hellwig wrote:
> The following changes since commit e0539ae012ba5d618eb19665ff990b87b960c643:
> 
>   Documentation: document ublk user recovery feature (2022-10-18 05:12:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.1-2022-10-22

Pulled, thanks.

-- 
Jens Axboe



