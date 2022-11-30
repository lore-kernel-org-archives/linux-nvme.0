Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7179C4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 08:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=wKTbA0N5OXohBZxfFMNniGKlyV
	KzyjU7cU1vaC1hKjDK9eULIZa3x12MTXDpiGOWTTjsJVelTusLVTIcYaj5o461zVYZn+QCGQ4f1nw
	Pl7XLfEQa9DAiBdhIMXQX4e0k92+omGgoZj6BTI2NEgeN+HoUcJR1WlgeIWowD89nokw9Jl1inmXj
	k+wH456RqwzCc2q7kPlyKoFSkEuxnILGggxpwLKwQ4xtXacpn6aUr/Ogq64IWOs53bSiN4Q3ww0TW
	Y3oAK1tqV1Hb8Ybaiw+z5dUQNwiYFeyYX3wTOhlum0EADdM8GfxXDae1NVW0y3khRXQ1SH1duVIdu
	9vrQNAsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IY4-00EZmr-M0; Wed, 30 Nov 2022 08:34:32 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0IXk-00EZd8-8Y
	for linux-nvme@lists.infradead.org; Wed, 30 Nov 2022 08:34:13 +0000
Received: by mail-wm1-f47.google.com with SMTP id t1so12657205wmi.4
        for <linux-nvme@lists.infradead.org>; Wed, 30 Nov 2022 00:34:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=KrSYPLs+roTdV6EE/LTro9SUaLRNhp5sEMvmzomkm93MbS4yLZVunteLK5ikK/JV/T
         cxc3dkTuPNUMAYYziL1QWJA/8vBAkD3CZXgAbm1nzu4LUrTvklUzRZNMRW51HiMa1PVs
         weJc3K3xiivH+BkNHOr2kzjP5fM8zcJZNUvSYh+lpG9yRwHRrJ1n6kSqEmWu2zMAAD+K
         x5PCpVYX8ywwVo7PB34P9S4Ep1AiLP9q9D44bXfY/zqtWX+p9yayTAJxkvk6zRIEHxMn
         8o4u7QQjqCeIArAlFKFshtXpLrpOvokTvVmoRsdR0PrOM3wM2Z5bgwCq2t+a8V3d3puE
         fWlg==
X-Gm-Message-State: ANoB5pmiZNSYQD5lWg4HrCcD4XkF0DPOwila3cERnj5kWonT9v8Up+d2
	4SD/esuA5cPCmNJa8V4fBl8=
X-Google-Smtp-Source: AA0mqf7hralODtPM3kyCW/scqKhM0Mel1Cg3aZ6GRI48+sZFmcKKCvozLmI8ZI4qCPLXINPTqntOGQ==
X-Received: by 2002:a05:600c:1d94:b0:3cf:7385:7621 with SMTP id p20-20020a05600c1d9400b003cf73857621mr33171057wms.62.1669797250172;
        Wed, 30 Nov 2022 00:34:10 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id g3-20020a5d5543000000b0022cc0a2cbecsm848665wrw.15.2022.11.30.00.34.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:34:09 -0800 (PST)
Message-ID: <3b8aed2e-25ef-7de1-3339-3f722b044eaa@grimberg.me>
Date: Wed, 30 Nov 2022 10:34:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme: don't allow unprivileged Write Zeroes passthrough
 on read-only FDs
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, joshi.k@samsung.com
Cc: linux-nvme@lists.infradead.org
References: <20221129090016.1311006-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221129090016.1311006-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_003412_366482_DC81080C 
X-CRM114-Status: UNSURE (   6.50  )
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

