Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9382C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fChIS7SF6nm8gZuMqg7g5RM8auvMS4gNHlZoat1RXb8=; b=PnMX5AaH4fgd5NnepcFsYjHb7j
	Lynxw5hc0RFRhbErCCwva1Grrb5Rv+4YJcGewdAd7HQVEU3Y+Rey8TOwqZ5btOEc39k62V52FnjvP
	dOmav5ATh/IE5qslqZ+SjfwRkXr7DfU4gs8VHw/7BvEkz3dyaP5s1RJZQgX0vcNnKaK+/rjoByjBG
	j184Wfb+1flAaNT86XJCD0j9qUDODe4GOcxsOKzqLGbI5tbaJgu+N1JPdvb+NoyRq6WUUwjp8ZweX
	8wSSyUakhyWwnJgAbKUYcMbCW5YTrFZ+akSHlsiWKiu+5eIif0q0x1dGY4yQJY+NlSlfkJUhjugZ3
	y49fK/NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC1k4-00GHgP-BH; Thu, 14 Jul 2022 16:31:08 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oC1k1-00GHdY-7x
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 16:31:06 +0000
Received: by mail-pl1-x633.google.com with SMTP id q5so871455plr.11
        for <linux-nvme@lists.infradead.org>; Thu, 14 Jul 2022 09:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fChIS7SF6nm8gZuMqg7g5RM8auvMS4gNHlZoat1RXb8=;
        b=MXUAe2lacoSQtWc3n+mnrIopZwD4pVJER7BbVPAKYYOYjOQwFkuQ3Ed13z70prQac2
         MXJS43xgkYkGFPOGhZRUlhGS5u04P7DmvARkN8XY/88OMShxtVYRZa3IVRjDOl8dOjMy
         1qludyzTG2FCczX2S0sJWe70NSJ44iFzVJ08Ol1MsiYNEH20S8r7Kounwf82YB7tM7zw
         yLS0G+3kLv09txBU7WjGqZAdwyj2LAdIFzkeb2wuIcgFe4Lmi7DIShHzXW9qqDSVg4Q3
         rWqJwJkAOf3cFUVM9F/th/vUJRrA4y3nlpT8QPb2bXetHsYJjBfMF7siXd0M+1DXc0pe
         Paxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fChIS7SF6nm8gZuMqg7g5RM8auvMS4gNHlZoat1RXb8=;
        b=vpAAV1IhPJjfxH0fCjQk2CJh5xtYo/71dR9qQv/zl5cw2hWTKGpazcdWnmb2bsssSV
         xQtxBlpOQuIZlaJ85k/QHkylMqdI4JhO7+u+XIpNCyoYam4Zf140R+8L2VY7JK3rt4bK
         T2iHuSvN8niwsSryRrjIq5g7FF9Zr7D+Ieivg3mx/D/4A9/r9Tgs9u7l3RrMqhl9Weqp
         PEIJGmcCLqb60np9n/fXWI7QPPXTktAP0ZcyolINGMVq1FCK220qmYmpgIuq6h2dFKqb
         eWN1xNMkszZHaZOup3IiDFkgGDBwHsruGuygTUO3lhIP22tG8+T9ldNjVxkmdvD+Anm9
         phVg==
X-Gm-Message-State: AJIora92iLZcfrp/s71/DPILfcwjjyjjjEF9eWlsqQYpLzsAXIR7SK6m
	GZQ/hEcvjSf/8f/flzijh7tO0g==
X-Google-Smtp-Source: AGRyM1tC/2ESlB+Nku6uVdiTIFXXf12AdH6j2c8BO8CJN5VVvj3eS4zOkkHebVaRVRXh+DPcwqwjDw==
X-Received: by 2002:a17:90b:3910:b0:1f0:386e:c0ee with SMTP id ob16-20020a17090b391000b001f0386ec0eemr10502114pjb.141.1657816264205;
        Thu, 14 Jul 2022 09:31:04 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bf1-20020a170902b90100b0016bf2dc1724sm1664645plb.247.2022.07.14.09.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:31:03 -0700 (PDT)
Message-ID: <aa3f3387-2550-4f46-2dda-01d6d776e7e1@kernel.dk>
Date: Thu, 14 Jul 2022 10:31:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [GIT PULL] nvme fixes for Linux 5.19
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YtAqRsNAUZXA60+V@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YtAqRsNAUZXA60+V@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_093105_314424_A0ACFA86 
X-CRM114-Status: UNSURE (   9.57  )
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

On 7/14/22 8:37 AM, Christoph Hellwig wrote:
> The following changes since commit 6b0de7d0f3285df849be2b3cc94fc3a0a31987bf:
> 
>   Merge tag 'nvme-5.19-2022-07-07' of git://git.infradead.org/nvme into block-5.19 (2022-07-07 17:38:19 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-14

Pulled, thanks.

-- 
Jens Axboe


