Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41861C04A95
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 06:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IvgvCrZohqeVTcYpOdAI6h3yXM5eV5w6Fdvzm+yi1pg=; b=bV6C914EOSmoQwckpVN4u6Gf1V
	KOHXPpOsCwjUxI0S9iiOp5VbZeewjQB19iB4qUWsTe4emCUNKnfjqN/UakPZncLIs1IgaHTegei9Z
	s2ZQixHZXigcPg40i6E5huF0k6r5Qtap9lRnLMkVi7vc7pqhB/31dR+kynCEAU++Q6vQQdmkVgn1e
	VSvZvIoyRrWLqdcMopTypA++ryUW+N8uImypb1UkVxdtMw+lH93oXu7wovzGm3Db9cwcgqc25Xy0K
	fobSROheERtLkQ5+Vp07wgVWdQdL7Z22+ltjJ6TGrLpxmqOoZtjNeplSA8CaUFhSFV6P5nO5wpw3Z
	ojEfQnFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQyU-00EMpf-NU; Wed, 28 Sep 2022 06:55:18 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odQyR-00EMo9-Qx
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 06:55:17 +0000
Received: by mail-wr1-f51.google.com with SMTP id l18so6237606wrw.9
        for <linux-nvme@lists.infradead.org>; Tue, 27 Sep 2022 23:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IvgvCrZohqeVTcYpOdAI6h3yXM5eV5w6Fdvzm+yi1pg=;
        b=AHEjIEQ/HJ5IxJWyMj+tMASzl4xNAQeCF8MwFm8NBRvUSKS1qgG8ty2UrTvBVKynfJ
         2O5YZc+s8Mpahf/Ga/PAvzg03iFsWz2YwtSWzXynA02fnA90dGqYYT8mFpSHC5Ohf2Mk
         MpsoNLmEdA6ZJCBqYiJasF1T9Kt4ToRkFGSU+5vVaShuB4qhstdzITvi/z4Er48fdMpm
         b1kqVZ3TLYHHbVkL3rZZOgGukpAgcTShIGxstqpv+L47MKNrdnutIUR6cQiPNyjPON2v
         TEM3d742/a5ftGQMMO1FKWG5QeFVENzNeiT1QzGJSxH4Mr4+NfixGPYwePbGFApdYTTT
         KQzw==
X-Gm-Message-State: ACrzQf3X/qXqFRRVVKV7Npg0JD9LyG3MJ5w9kRM7ri0SEYdC1L8khr7P
	R0yi2CZrcUvcmFtw52TDKeA=
X-Google-Smtp-Source: AMsMyM7ly8PHCXwqHj7p/qgkmSw78j6jf7zjAT1Y/tgMHPF8WhP9iizXeXXJDQR9BzbnTqu37qip9Q==
X-Received: by 2002:a05:6000:1566:b0:228:b754:186e with SMTP id 6-20020a056000156600b00228b754186emr19265730wrz.226.1664348114489;
        Tue, 27 Sep 2022 23:55:14 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c2dd000b003b47e8a5d22sm881662wmh.23.2022.09.27.23.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 23:55:13 -0700 (PDT)
Message-ID: <d151b0c1-d28e-faeb-03d4-ed28b9768ee2@grimberg.me>
Date: Wed, 28 Sep 2022 09:55:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20220927143157.3659-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220927143157.3659-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_235515_905924_49CDDF5F 
X-CRM114-Status: GOOD (  14.67  )
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


> In order to be able to test queue number changes we need to make sure
> that the host reconnects.
> 
> The initial idea was to disable and re-enable the ports and have the
> host to wait until the KATO timer expires and enter error
> recovery. But in this scenario the host could see DNR for a connection
> attempt which results in the host dropping the connection completely.
> 
> We can force to reconnect the host by deleting all controllers
> connected to subsystem, which results the host observing a failing
> command and tries to reconnect.

This looks like a change that attempts to fix a host issue from the
target side... Why do we want to do that?

