Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48510CD6E74
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jun 2026 11:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JBU7Y6VrqdwWgdBQP6jhPfg8zfLJGuoMc1/B0LUwQGw=; b=k1DQyfDNdjcS65WgPM/UeG8mrk
	cn5fATaXxZNoKEPNmwtULch7kqXvTKGWaObwEyM3JHRIMV/yhj5mdQtHpfdafhhoH3SWvji5yuSzY
	6vBnOQDbuu67QTkl60GBvk4wKIsWoaNuXNqVx4SxZ5tFN93UFg4TZyGjEjr49URdUV4kiv9IJDf1i
	+1GjLQIkIH0+oZj39i1Lr1AW4Erd9Ryl2qXfowOFFIOV+CrRkRdtDIjql2+4AfzEnbLYzQTuhF+YN
	e2mbz2nI+0Fk/ZMyGVyfp3P5AWEZvaFgFQGy+jWUFfDewixorXM5B6z18DKD+HTv0p1VVTIqVAX21
	Ba3fzAGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVSaL-00000000WsD-3IiU;
	Fri, 05 Jun 2026 11:19:33 +0000
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVSaI-00000000Wrs-2PTn
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jun 2026 11:19:32 +0000
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-7e6e9408e30so1268084a34.2
        for <linux-nvme@lists.infradead.org>; Fri, 05 Jun 2026 04:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1780658369; x=1781263169; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBU7Y6VrqdwWgdBQP6jhPfg8zfLJGuoMc1/B0LUwQGw=;
        b=rZm6FHgYWMamtoIzIChtwJ70RKDrX57qbE6+H3U/Ur4jCEzZ2Setv/XVdBefk4ZdVu
         Uq1XH6eWndqKZ9zLqjm+x+XB5vrrIbScIofqW4cnyDV2i49WvQay6McLLEu4jIJoLKAc
         j8LRtKf80GAF7i3sXybzraYB75ti7bmrM94kSlGKFG3u6SrB716reUuICTU6jo6Ybypg
         Lm/q/fOn0T52nErvTjx9YQQVIpUfvbzdF+uIvIAt0qWANHA8T5dFpgN/L3d0cwNI9rre
         iAGzNVGSZyOT73RPPuQ8uNGaEUw/0oUaeKsZdnaNBmsQ0SlKv3YS2EODOHhQBC4vJ97M
         YKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658369; x=1781263169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBU7Y6VrqdwWgdBQP6jhPfg8zfLJGuoMc1/B0LUwQGw=;
        b=ruBxNy63LU9PXZFxk9GmbvmqZPQ9fEedQLva9hLWeihEA4fkEeaTy52yuelw39XZY9
         iH5mVoJ7HCKPS7cLKF8EYqaMcSvQYh6OwV1Q4a+I+vYVBnh4qtZ2+2qEUH6o7fkwGy3X
         vYopSK/K74KaiEObX675MaqRK4QOX3w1rzQ+5uBdE50PnuIRoLsw5ZoOYi5kgHOUoCKS
         T2qxiGXZnDEFHzfpVQYPBVV5ca4apOj4nl24U3IJBI6CJ15h5DCBp5MXSJ5sGhEHaZrh
         aCeuGJqNh43putGxTYROPZsZUN/Idi3SwmDt3wIOCf1Ws5GJ/IfNOU9EOxeL8SziXNZN
         fkRQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mWsa0Se9uyV7dY36zJhrdq1IxnCvFG4v570Kei7emnMLQ9VdVMxLKfqBTxBRPlDvtydSG6XKYGbJQ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+aF8GwzseTxvVvnkd2E6+XG42HgylKi+d0vSHho3Y5d+tdIfM
	qrd2ct2Yu55mtoCJBb60wZHHKEwj1KKydRlqJFeVxU54NaEeHHrDWNgZTYeIZxNKTkk=
X-Gm-Gg: Acq92OHa8hhgOQjCGlRN8GjhWEaS//A+G0DaMIUzVdSex/8W7t1RLnfQUCRSXfx5Chp
	L7VTpDqyNqYK7/r6cZVyqRzs5ZDlG94PpZAbp9J3jmGaznFEIQ6us28c0swLd+/9hlgX2NbMXwh
	XzvISDAtxM2t4xkLN/ST2Fq5F1EGOr8nNzeeAeh1r0wW+AQq8OHktaefzncqG3BLRSH9h9rQZ/n
	2AuK9sKAdYqHvySgdecNySiUnT/6r9Kta92nUAcO/v9D8UnWYjqetcfFb3JqAceLkVkB5DIoPRK
	UWyZeJxFx8+Accf+uH1/P2HMt6vV2TDk57ED0gGkIxMAUjH+L5SGIE6CXpT9p2H5SABvaPH4WdN
	ASoDg3MUHA7sYNBZBBd4nA5ySuOl6brQFESPZSBR8fS/HImOaerEmRI4UCnnxnLV4E/XlE9NO2C
	4eEtSC7jeR9zFAMefNNt4eg7epuo/OvVchMIsZY5n4BGhxEJJAExggLpFApQUDs7+egVVBmnQsx
	kE8ZREOSJ94FlM8/us++omeXgIJP2U=
X-Received: by 2002:a05:6830:3c8b:b0:7e6:50c0:87a6 with SMTP id 46e09a7af769-7e70c6c4d66mr1652404a34.8.1780658368926;
        Fri, 05 Jun 2026 04:19:28 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e78e14acsm6008206a34.14.2026.06.05.04.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 04:19:28 -0700 (PDT)
Message-ID: <2cda1272-8391-4005-b877-0d91cecacd70@kernel.dk>
Date: Fri, 5 Jun 2026 05:19:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.2
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
References: <aiFY0kfy2Xt-nPQO@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aiFY0kfy2Xt-nPQO@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260605_041930_887361_02720696 
X-CRM114-Status: UNSURE (   9.19  )
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

On 6/4/26 4:52 AM, Keith Busch wrote:
> The following changes since commit be34ec59ef061a1cc435a3e066ad71ca675c7fcd:
> 
>   block: unexport bio_{set,check}_pages_dirty (2026-05-15 08:46:45 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-7.2-2026-06-04
> 
> for you to fetch changes up to 3c8c284dfcdfce81a02fe3c911196d9876468ae4:
> 
>   nvme: export controller reconnect event count via sysfs (2026-06-04 01:57:40 -0700)
> 
> ----------------------------------------------------------------
> nvme updates for Linux 7.2
> 
>   - Per-controller timeouts
>   - Multipath telemetry
>   - Namespace format validation
>   - Various other fixes

Pulled, thanks.

-- 
Jens Axboe


