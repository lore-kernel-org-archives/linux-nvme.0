Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25DDC432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:27:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5CC66112D
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 11:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E5CC66112D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=dETbzuaqXxbQEHwPV2s8YjPTMX
	8icTmYb1oOby8ymOFFBphy+qEbcYdlYaFwptVJqBVPSyLFZOOZj1WRR+ZDff4mC0YmWX2NsFFfJbN
	PhDzLY8QpuUIEeERdr9FHUQnMqXMG5PbnAv8jz9PDl/pZ1erV6Wod3KWhvhAhJEOYooJx58EQ/F1z
	7OSm0bcuDB05xKHJ4OMJ9wXfaKV7BnyvL1ozbpZDrVf0btcZuUAtF5KNeKEut60fbGc1iFpTZQThz
	KTRBiLbT+ip3mu6/twk1NfB/xMxGes5KlZdFEImpxtOxNW6Bq7tBgeBgrG30oDCUhOl+zmQwCQLCW
	XAPmLN4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKfR7-00H4s8-Sk; Mon, 30 Aug 2021 11:26:45 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKfR5-00H4rc-MP
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 11:26:44 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 v20-20020a1cf714000000b002e71f4d2026so11241329wmh.1
 for <linux-nvme@lists.infradead.org>; Mon, 30 Aug 2021 04:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=VO7EhnBbum7P67y71EN3orc97F6wU9YBMmqVagzMZjnhWgDU72YM8on4VNXrt3ovyh
 cEC7140mi2ukfP/tyvXybgidXoDS++X0BdExxIjzhoXt0KFvTXqmUpuZkkJgwWNVVNzm
 d2A+v2L467/ZyV8C+1QcW6g+X8EnAFWxq4vtaxCsWqGHmU3RGTqrfRfx4qYFVXhlnfhD
 AJXEnpjAgUABTu/JIlc0bH+1XplCB2i9TYWsNCXkIl6XSzPYfd2P6snMLGfTkgBTjKVn
 1kFYXqQ5VCnrwKcHp24qJxUcG4VGu++jmJkXpTWeDaIcrugViinW6OtRoEqsNscrqIET
 Ydgw==
X-Gm-Message-State: AOAM5337f04b7i5FZEWR6KwOipF8mTLjRd+/OblTMgdSjFmVQ0bge27/
 W3sIEAqLa13cdIm3TJKPJjy7CiP8blE=
X-Google-Smtp-Source: ABdhPJyJZ4T6UX/EsIpJO3ZBBglcFqkmR936zo8tYcBNPXkS8yxo0hOJjHJbL3XoiVHB19GfbicL9A==
X-Received: by 2002:a05:600c:4999:: with SMTP id
 h25mr32045384wmp.175.1630322801215; 
 Mon, 30 Aug 2021 04:26:41 -0700 (PDT)
Received: from [192.168.64.87] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g1sm4228255wrc.65.2021.08.30.04.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Aug 2021 04:26:40 -0700 (PDT)
Subject: Re: [PATCH] nvmet: return bool from nvmet_passthru_ctrl and
 nvmet_is_passthru_req
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20210827061818.170603-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <65e4b1eb-462d-edf2-a33f-43fd9f6336e6@grimberg.me>
Date: Mon, 30 Aug 2021 14:26:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827061818.170603-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_042643_786176_FA09479F 
X-CRM114-Status: UNSURE (   9.58  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
