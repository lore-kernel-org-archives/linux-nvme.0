Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E76EC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obC1H73kYWHPkG4wu3mJ2CwpJvBxYklv1/XandoYE3Q=; b=Yr/518dupUbPscH/ywq6zlmVNL
	3xaFO3hDToqdnJFZIH6IrVgCko9msjAvpwirzT6klObXv7pszYnHyEjqQwyUm86sD8VSEIuOBhqDl
	b3j7UkUmnVkeUyl/cpnJSwAlsjZP+/R7qAGt45gIqrFRKkWNZnJ4Jm2ApOW/NyYXlbljeisu6TsVl
	QzrD6TxS1pWFNW7rfSRDXcQhmYmn7F1BILQEoUW4ePyr4wd4J842J15LF77+rY6uMa0B3ZwwyyVC9
	/dnIF69WPlQyNHAOSpzN2Rb+P6l/rXoWXd7/TXOHr2IlF5HdTbXZ82oxDBzRO/2kNiDJ2q0WCTA0k
	cIK7Rw0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSyP-00GGFX-L9; Mon, 14 Nov 2022 06:29:37 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouSyM-00GGCY-P6
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 06:29:35 +0000
Received: by mail-wr1-f50.google.com with SMTP id cl5so16245612wrb.9
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 22:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obC1H73kYWHPkG4wu3mJ2CwpJvBxYklv1/XandoYE3Q=;
        b=SpcFAgRvC5bN2TrbY/4hDa84UObTZm0TglemrrEyBW5RKcFqYPmqrqbvCfmCFCf6sg
         Gdv19TLc635kqkA1keUxL89WbOmI7Tct5gduyOLAS8FvBzHRG1vf8Px2CnTwdRo7Sz4U
         7dJF4y3BJP+CodAIpDw0irxdcMl+iLagjWBDJS2EreER81Ow/hJz4CIein0hnkRd4NGX
         3vxL+aK18ZF/4k/ALGC3y9oJAwTG3zQWslRKgkp++2LLRvWtpfwGVA5HmD4XyGIADmCn
         6Mhk5WeCpE0LZ8XH7Pbk05yTMEmJmXSCoJm8l9oMEdcYbWx4kAOOX1/O7UQfLvyOAPd8
         N4lw==
X-Gm-Message-State: ANoB5plK4erH86N90JSDTpqznDTGAbmejWaPCdzYGczSs/++fYKZh1u9
	zoCC+pjDpduY1oFG0Fxiv+o=
X-Google-Smtp-Source: AA0mqf4LAao9G2+P4JK/SmsHLkqRHI9wY8jwy0HEel86sHvhZKGhs2qdDmF8hMRytTW9ucVcou2fMw==
X-Received: by 2002:adf:a4c1:0:b0:236:6f18:37e6 with SMTP id h1-20020adfa4c1000000b002366f1837e6mr6291096wrb.262.1668407373104;
        Sun, 13 Nov 2022 22:29:33 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id j7-20020adfb307000000b0023c8026841csm8656064wrd.23.2022.11.13.22.29.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Nov 2022 22:29:32 -0800 (PST)
Message-ID: <ad14a460-cee0-a71c-8728-3d0612b08c46@grimberg.me>
Date: Mon, 14 Nov 2022 08:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 11/13] nvme-pci: move the HMPRE check into
 nvme_setup_host_mem
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20221113161138.883195-1-hch@lst.de>
 <20221113161138.883195-12-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221113161138.883195-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_222934_848794_62FF8DEF 
X-CRM114-Status: UNSURE (   7.97  )
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


> Check that a HMB is wanted into the allocation helper instead of the
> caller.  This makes life simpler for an upcoming second caller.

Same here.
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

