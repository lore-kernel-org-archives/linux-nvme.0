Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7498C001DB
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Hp2eYv1GqsuWmb8DISToA0bAyg
	zSEmghH5c5vhBATchjAWTk6kjjhtsd6yM7s/MkLs7qvRNrr3fSMBUVoTI1kwbmaHw7KXS8eawJUW4
	DFJXtA/hJhKkZV1DND5usOmLuRKEJ2xpJj8iwTyLOy1VqRRo8t2o7/8QE9KeRmozLlLnKcP3n9N/m
	dD/I0ODrniNcKaCcs4tLB/75xGikKzfaMkCAmHVsyqVxLdBfbm0ZXGPuFlwhM2h00DXu1mn1gdBR3
	64jWLgDCPb8n2RG45JJFsFRTsrOf5MsVyZT8ijfZXSYCwO2PqyGEsmaQawWhEwVSsyWR5l//PPWMW
	dVmgFHkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWNP-00H0uD-2m;
	Mon, 14 Aug 2023 12:08:51 +0000
Received: from mail-ej1-f53.google.com ([209.85.218.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWNM-00H0tE-2y
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 12:08:50 +0000
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-98273ae42d0so129821366b.0
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 05:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014927; x=1692619727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RYv4f2WcClRDvTUaX8g2aL0gghUvOc6NNjcanMSvlT/Vs4NXY9rA1kbZzB2hI2A9YU
         IMMiAzfOQl710iy4Ck6nr1o4/7+g/49E8QtFYNHBiRGnwOzMSXpDK8KY7hYO/l1RBPPP
         sTU1Fm2U95FekE6tMpevxA0hB6QDUGQEQpnBBrWT6G+I+315t1i8m1h8WRH4ELVCurxh
         /n0WhzJL2mu9+XwU+iRgnLbXtKUuACQuy23vupkIa5fhqP3ZKvPX7HndKvT+dzySLF+X
         1IIl1KB/D2+LpclX0fwCmxwHXqU53Oz+eDSzctDmB8rOMMAWqC/TIjairAwCW6vsZCKn
         +BfA==
X-Gm-Message-State: AOJu0YxzkrWmpdWunilcl/LPXoTv4FuOL2EXBKAAjn4+Y1t8KB4keoFO
	mXqDdA3hME8gYpSmNlCTv50TK2/cHpw=
X-Google-Smtp-Source: AGHT+IHZIzveksLz/lxJd0IdgUso5wkRIHbYFFY/QMlld0F17v4urnbMFYI0DVL2Np7uct7uJi3uKw==
X-Received: by 2002:a17:906:5354:b0:99d:a228:d0c7 with SMTP id j20-20020a170906535400b0099da228d0c7mr3298970ejo.6.1692014927064;
        Mon, 14 Aug 2023 05:08:47 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b00992b510089asm5602465ejb.84.2023.08.14.05.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:08:46 -0700 (PDT)
Message-ID: <0d5ccbb5-669d-ed84-7f6c-a27ec4e32782@grimberg.me>
Date: Mon, 14 Aug 2023 15:08:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 16/17] nvmet-tcp: control messages for recvmsg()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_050848_957441_942AACD3 
X-CRM114-Status: UNSURE (   6.80  )
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

