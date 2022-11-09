Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61E4C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ra2BTy+b4bd8Xw9UWnK+BHvDsh7x8lOOkK8hYoGb6ug=; b=AfCzYQjAS5GFzFAHUCb7c+pTc6
	hcUzd8Vif7HYyn2YVgaVCReTRpbMnCFoMk5zJKAE3QNwmvupU2oKYB09KmYBxgWIcL7TX36XbpKCr
	000thGUJgq/u7zDw7QgKlcd4HUMHRcEI0Dk7EHqn8eAM9YKug+HfiLz0tBPSslWSJ9VcYyxOugic8
	B49RbKmywcjBnJ8EVfUA4VJaQGLTbbOlHRUAUxEXT6IE0cVB1l/UlI/hqKEXEu2dxPNZfWyeo2Hmg
	GsnCFdIwSSLDLyPJo0sr7H0RbFAx4I6Hx7LJbfa8x/0hkEoeic12QfJSN09L7TwFcNyjHFD+Ihm0H
	wCTcpidw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc77-00ARVd-Rq; Wed, 09 Nov 2022 03:50:58 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osc3z-00APfa-JY
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 03:47:44 +0000
Received: by mail-pl1-f173.google.com with SMTP id b21so15941587plc.9
        for <linux-nvme@lists.infradead.org>; Tue, 08 Nov 2022 19:47:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ra2BTy+b4bd8Xw9UWnK+BHvDsh7x8lOOkK8hYoGb6ug=;
        b=okPFNON7WBAwsCCagnFPzuq1CzTtFaC1vQEQFHr11RUuN+j6OgBkrqu3sYFy1cZAw4
         RqYPkoc+V2n7Vdqwj2blRomCL/ZtSJPPSXde/N/Vzr6+vr8o3Jv3dS6MSCd6gg8Qh+3/
         vuYPf6R3y+kNhQAgGWXf4yIfHHbVKUfVWhQGHTlGIopbwFOIsBu/EMMAAR65Rm69r+ji
         PCfIDcxcGCNsRgUDiHmEJWPsjHJ/bTfWVVXz/POfzcPKDMA13k0cPevfvRNxiUF9Fbl0
         JcYNFr5/ywLeggh+kCRndcmSEZdn4Vvoav6gEdknOaFCqIQLshPWpEx69gr40wDN2t5h
         5uEQ==
X-Gm-Message-State: ACrzQf3a25o0SbFVRy94wZ3z2Qt9EsDyFkBQXrRSgp/KM2mDtlCsfRgm
	K7zJEN9jqNjnAKfrCoZJFgc8vvDKgII1zDSI
X-Google-Smtp-Source: AMsMyM6LHmIo1nlkFaZbvhQ6SgUvZIH4PyDisOKI3TGgwz7hFrv9kV7qseR4HpwYkyn1nn06om3vnw==
X-Received: by 2002:a17:902:f7d3:b0:187:ecb:20d5 with SMTP id h19-20020a170902f7d300b001870ecb20d5mr55750700plw.101.1667965662215;
        Tue, 08 Nov 2022 19:47:42 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id b14-20020a170903228e00b00176acd80f69sm7772537plh.102.2022.11.08.19.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:47:41 -0800 (PST)
Message-ID: <dc068a33-d71f-2d13-16c1-317e471a8574@grimberg.me>
Date: Wed, 9 Nov 2022 05:47:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 00/16] nvme: rework dhchap authentication host code
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_194743_714483_4AD5E8BB 
X-CRM114-Status: UNSURE (   8.94  )
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


> Currently the authentication code is fairly fragile with respect to
> mutual locking between secrets sysfs override, re-authentication, and
> controller resets.


Title is misleading... not reworking the authentication code as a whole.
just the arrangements of how the queue chap contexts are handled...

A more appropriate title would be: few cleanups, fixes and enhancements
to the host authentication code.

