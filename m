Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FED9C07D5A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Nov 2023 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=S64XHdH7cbzw/MyAyHuG0HkOtJ
	XHTvg9+WOg2b6r0Eb5U8C9fZYQFJ2uiJUDjF3eUN9cFZUF3MhHAVXBXowabwc1v4pWXLkepjzksQI
	HDKrndvYbUfbExXkhfwvsnBmQ1aM36Y3KnklRFiasoid+oo6JBlWuYamdLdDnUlL7FW6zu88SvgnB
	fUkkEelCL+WUTAo0Alr8ILy3UdHeo2Y6ggSxnmfKK+dguORjaUYUKnHmx+hlzz5NuaK9Lq8k1Rh3t
	2Qs8oz0A5jLcKCinJPnW3gi/d+t3bgDkDxKqOVoomo8l+RE/lwzP02/F8jDgSFEW+JzoFpU0+PHlf
	rqCBtYBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Egp-00BFF6-1G;
	Sun, 26 Nov 2023 12:56:47 +0000
Received: from mail-wr1-f53.google.com ([209.85.221.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7Egm-00BFDJ-01
	for linux-nvme@lists.infradead.org;
	Sun, 26 Nov 2023 12:56:45 +0000
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-32f9baca5bcso844043f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Nov 2023 04:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701003402; x=1701608202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=YZM64xF7Uj/Pk+RHW65xUR+CQOYmfi6ldR1F3GDWGiaS22Kz3X197jxKfKLAwKTorp
         Fwe/rNLe7LVNrAGTDbKRAcUcTTkFrv+nFeNtvnupG6OK5DV969Ey23qUQKnq6AvTkeTb
         gRj33HpcchLSsvn4XCe4GaNbjwCIxblaURN8vaiKtGi3+nCp1eOmZ3Gj//6UvYEPSeg9
         0maWX0vEbfiDx4etoR478NlswBuQxHevuz/6w60HPhx+JOrYTpbLrFo9jwE7qR4WPyww
         +qSwfeLxVxnAfzpmfLhxr8EDyy+OLukNK3+oSBEhiOQr+oa7/VfLIjyuKuyTRn6tSScm
         4sVQ==
X-Gm-Message-State: AOJu0Yy2+wajTO13BzjGIzYAnCEBZhlqH6VxjkF2WfUgHehp+vKCbGVN
	lTvn33frp08K3XBXYVqURQI=
X-Google-Smtp-Source: AGHT+IFJh6+wqE2Mg47iY97XAH0U5KdN6S53/rpdsveQmSlaOVdUGVpRiHPNitAglT2NybGCAT4G4w==
X-Received: by 2002:adf:fd4e:0:b0:332:fbce:89e6 with SMTP id h14-20020adffd4e000000b00332fbce89e6mr1076275wrs.7.1701003402108;
        Sun, 26 Nov 2023 04:56:42 -0800 (PST)
Received: from [10.100.102.14] (46-117-95-192.bb.netvision.net.il. [46.117.95.192])
        by smtp.gmail.com with ESMTPSA id s15-20020adf978f000000b00332d41f0798sm9294435wrb.29.2023.11.26.04.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 04:56:41 -0800 (PST)
Message-ID: <5a4573ae-0ede-41ad-a382-5a5a454fe9ea@grimberg.me>
Date: Sun, 26 Nov 2023 14:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] nvme: fine-tune sending of first keep-alive
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20231124205659.523248-1-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231124205659.523248-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231126_045644_050569_44230ECB 
X-CRM114-Status: UNSURE (   3.76  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

