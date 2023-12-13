Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA4CC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=H8/y7itv7zGMKTfde61Db4U0AL
	Ws0qxt07wfYm5CW2nzAa68hTvWCg+WptILkCkHsqKfBHeDVYdIk7SSBFK7pi2HP0rH1FsWBkm1LXP
	hgNY55MKw4iS8u8bDm/8wakqNgyVlHbkdHrxyGW0FK4mftN2p5znMeDqpWS+Yg/TWhuTk4gR9kwfI
	/KbpCn4vkyUlg/ZGWpQmwpKx3Ws1DVHny/GIZ6NW2IjGkpixnRT63wM/061b7BexO/cC3bGWTWQgx
	kyxkvzIeHElCXGnUb4aw//qqriglseDIIDGR0HmRwAEo3z91WzAc+jfkHTkRoEDCaZH8wFGYRvgkP
	xurhce4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPLO-00Ep0z-1k;
	Wed, 13 Dec 2023 13:32:10 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPLM-00Eoza-1H
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:32:09 +0000
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3361d08a31cso319761f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474325; x=1703079125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mwL9e7lg1th0OqGfFlsKHx/q1wO2YuQBS4mjiqOpFmC+8qsbQDVY+zo3iFuj05J/d0
         onG9olBH39elBui8gSGYEVAOqTADYlU7+B+M+7xAoxoeEA0GpyXJpYQGcqmCA5h9F3im
         vvXpSaqwVNCNksh1BYdt/yziSRegqzUAFdzrOVikAhjGsfWzxN2yG2X/UxyQl3z7m13+
         fs6pphFKL/GwKRDwWY2g4ic2/RKjk3oWEvB6nFNVVkprRtExjDmiLDQwDYs+agO/RgHI
         I1h+o2/HIkDNt0g8JUCXRDp7pLCSmTFhSiWqUZrx1H68LCaYIT+W22j5jJkDASC0P4ze
         mD/w==
X-Gm-Message-State: AOJu0YwlGCcQf6pm8MzHJXUVC5r6908Qn+qC0b0QrZcoQ4rR80ifdfPq
	yQIgWtLVq5BYKy6kmHttDe4=
X-Google-Smtp-Source: AGHT+IHXsDE9trL/Px/tkEAZE7u67Q9HUWPkNuKGxXOCifeipZqvtHEOmEcoyazz8F1Or/KsHfFJ7g==
X-Received: by 2002:a5d:44ca:0:b0:336:34d8:3da with SMTP id z10-20020a5d44ca000000b0033634d803damr2201839wrr.4.1702474324657;
        Wed, 13 Dec 2023 05:32:04 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13308331wrc.99.2023.12.13.05.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:32:04 -0800 (PST)
Message-ID: <72e633b2-13d8-45c3-a7ea-1075dbb95aa8@grimberg.me>
Date: Wed, 13 Dec 2023 15:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] nvme: rename ns attribute group
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-5-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_053208_428442_14873571 
X-CRM114-Status: UNSURE (   4.83  )
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

