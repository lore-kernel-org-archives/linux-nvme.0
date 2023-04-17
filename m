Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E41E4C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sy7wQsGi6Nyz8v43nQvutVpWGG1vp+oDxTzBNGMPHN8=; b=4O5IW0Ykcmnjqrye3SAGn8a644
	GoAMqh1B52Z8x/X1Wo7HxqRLpSGZdFC2LpqKuJ86TX1/IuWrxBTGwdiJWJHe5JqQVwUZLJ5cBfQfp
	Od52OaKYZXoTMlYXYdp67zx0K9uVOzf+Egs8ZQQS8LZPhQ6fV9UbQE2FjDeVhSnRjznvtPkJGaXsO
	e75AX04xpyVewNSVOVuhpLJzwmZ0LijvcsA5k8sY3fRyph20znpjVeVRXKf3HiiJ7h5cy4CbERfk0
	/S1Ns5N6V0rXfSMQhCGbV3Jz7e//HxJdlEgUOD5XM3zPAT3JSiEgF4yL1MHklrIjobsuaFFVKsZbB
	vGM2n18A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poPAt-00GS8R-1e;
	Mon, 17 Apr 2023 13:45:43 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poPAr-00GS7C-0U
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:45:42 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-3f05f61adbeso7193545e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Apr 2023 06:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681739140; x=1684331140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sy7wQsGi6Nyz8v43nQvutVpWGG1vp+oDxTzBNGMPHN8=;
        b=KKPI+CpWOXPIAWgj/bMlIBJ7mFpJqqHZBF869UR2ZOXl6B/JLtFAjAlhsijH4ll+Oc
         yEVg0iEDtjhkl2vJ12I+elHckYnGBj16cqbL+fK+jzAy2OwWu8ri6KKutQPIKIvOFJZN
         a46wHGbW0GUo8TVT0Lybcx3qjB11YUmfB3SzS1eUbV+e/gyW2Xi9IhVhGc6LMhqse/mp
         6qTGVR1QX/NEF4HH+dGLfL3z8K7ww5s/XXio+A3yB2Gc8K2hNpp2neA8QnoJCaeU3K0G
         tQg1HvsY5vjkstX0GY8wca8ecUTnrL6bUzwgrYwz2sFVDKATHK1RDcdjj9mwpAjBh+Sf
         1BZw==
X-Gm-Message-State: AAQBX9dcAHNz8W2ozb5sYGQSF0jW7iGbXS8dlU0QxIczCtuydqyHcSzV
	zibNODsr9d1trAHBbSiku8I=
X-Google-Smtp-Source: AKy350YBfbjvfjeQ0sD799bOScyuPO276lIbLuDkqHFHL2HlShdNtg9EsNM1V+hrzVVo4DsgmCrraw==
X-Received: by 2002:a05:600c:1c93:b0:3f0:b1c9:b676 with SMTP id k19-20020a05600c1c9300b003f0b1c9b676mr7756064wms.2.1681739139515;
        Mon, 17 Apr 2023 06:45:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p6-20020a1c7406000000b003ed2c0a0f37sm11966478wmc.35.2023.04.17.06.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:45:38 -0700 (PDT)
Message-ID: <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
Date: Mon, 17 Apr 2023 16:45:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
Content-Language: en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: lifeng1519@gmail.com
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230413063317.2455680-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_064541_186996_3F4FD7CE 
X-CRM114-Status: GOOD (  19.01  )
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

Hey Li,

> The default worker affinity policy is using all online cpus, e.g. from 0
> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp will
> have a bad performance.
> 
> This patch adds a module parameter to set the cpu affinity for the nvme-tcp
> socket worker threads.  The parameter is a comma separated list of CPU
> numbers.  The list is parsed and the resulting cpumask is used to set the
> affinity of the socket worker threads.  If the list is empty or the
> parsing fails, the default affinity is used.

I can see how this may benefit a specific set of workloads, but I have a
few issues with this.

- This is exposing a user interface for something that is really
internal to the driver.

- This is something that can be misleading and could be tricky to get
right, my concern is that this would only benefit a very niche case.

- If the setting should exist, it should not be global.

- I prefer not to introduce new modparams.

- I'd prefer to find a way to support your use-case without introducing
a config knob for it.

- It is not backed by performance improvements, but more importantly
does not cover any potential regressions in key metrics (bw/iops/lat)
or lack there of.

