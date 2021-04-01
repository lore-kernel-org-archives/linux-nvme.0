Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF11C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 08:26:56 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FAB26100A
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 08:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAB26100A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=C35UzfH2jGcteyAkMhYU+T4If
	bChf5tVe106zwxBtdOKOW9P6jSx4xOxNcexzOPYoUs8zP38YAqbL/JapVUiWzPzezVRE89EbSpate
	OPGm0vMWHWyslyHBnfHmUK9XYxim5LVyLJcGhSkEJSDynHe5GfB+FcrgNzYL9urLgJnrvPYVR0Km0
	JKSooOMqEiy2ESJyJ1vt/dkYX9k92bswMBtSAd89FQoX5Qttuhh1MrT6bua6wRUWiGG2GPSxisEES
	vVIjMrYPYznuLT85n3ROZ6OL3HN4/zCPj0ch8/vo3FoxZixwjnVHpTuQ1QRE/AzNX5zynO9mSgTJP
	CHc2FhRGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRsf7-008vTJ-F7; Thu, 01 Apr 2021 08:26:45 +0000
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRsf2-008vSR-Rm
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 08:26:43 +0000
Received: by mail-pf1-f182.google.com with SMTP id j25so902766pfe.2
 for <linux-nvme@lists.infradead.org>; Thu, 01 Apr 2021 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=lr0jFOZ4Enqn3FyfAn9k4KSJ9ksR8Ecv+uqY1DXdpDobqy5hbva/gM6GiFY4QXfPPt
 neayEB+6eOeXT2vqORjLaPO56KWaUEzn0zDjxsUROCAkn/8/8R6YHtolP+Ih9g1DxkQr
 kr0nF6CRElOJEdxJdQdnBwndK/4r4zxpEhGcksrVu5gd2DxeGpkcqFJXeIufSIgoP5LJ
 b85Vki1dFlGp6PUTWVsEmXbjm6KSYA5IwRWcC1MQLEoJHv3igJQ5aKtv38DDPftDr7LP
 cpB4vk0bn4rhpGAT9CqjK50P/qwMbBmqEIHdwH958v92gxOfNu2thQYb5X/Caa3wdcYq
 CUcA==
X-Gm-Message-State: AOAM5336++BabW1KG/DTwROnV2Sb9qxLjRDLU33e0QU2boh2Ke0qLHTZ
 LpvDQnbeqapscPWPfOrqIcBVkp/AS30=
X-Google-Smtp-Source: ABdhPJzJBu0MTiDQ/MoRF9Zz9ZHzg9PpSnTOU+JjatRW5P86tCR7vyhJAd41hdssGxhEiy3kkjz1sQ==
X-Received: by 2002:a63:2e87:: with SMTP id u129mr6546541pgu.107.1617265599063; 
 Thu, 01 Apr 2021 01:26:39 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:bf93:1a21:45ef:9cdc?
 ([2601:647:4802:9070:bf93:1a21:45ef:9cdc])
 by smtp.gmail.com with ESMTPSA id w17sm4743801pgg.41.2021.04.01.01.26.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Apr 2021 01:26:38 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Fix handling of large MDTS values
To: Bart Van Assche <bvanassche@acm.org>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
References: <20210401035952.7249-1-bvanassche@acm.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c9c7e35d-adf5-4b2a-3f6b-6f64155cf59e@grimberg.me>
Date: Thu, 1 Apr 2021 01:26:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210401035952.7249-1-bvanassche@acm.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_092640_972724_C2399BBF 
X-CRM114-Status: UNSURE (   8.73  )
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
