Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C64C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 10:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbiv0/cwwrefMvBAB5SZJRFMMULSG6RCwIlh8quXJUw=; b=JPJLWEnJ+uihgFEnh8tObgnia6
	kme+UC/MyaLE5BuPRlukrxNBRF4IXiIaeHQ6wOrFQO9kB6j60d57IoynFMurAAL0gocmFvXaY2r+U
	bVo0GOTw9LzLWSv9VXfyiJtfLo3DEoihqrly9lDO97P4Ueo/NnF0lJnpey93N/xTl8B0ysJzMbHi5
	EJXTCZke0ooF87yiMw7SqxhE4O6Co5+LNNzLVVM+JAWmCpidyc/Jcj3ubg23Gnj9OOuvo7ydIu21k
	F+EuOR+RltslJxVTyw/AdUg4W1tufn2gU0WW5oYrR15RFRawoRL4EgjBDop44/ERuIo2jySYzdlsH
	Pfs/U7gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndrRt-008Pja-8L; Mon, 11 Apr 2022 10:39:09 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndrGZ-008K2C-1E
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 10:27:28 +0000
Received: by mail-wm1-f51.google.com with SMTP id r64so9586169wmr.4
 for <linux-nvme@lists.infradead.org>; Mon, 11 Apr 2022 03:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=cbiv0/cwwrefMvBAB5SZJRFMMULSG6RCwIlh8quXJUw=;
 b=ew6xw1pcLVUu4SZVomNf9OYjDZtkEwae5R88yfAQ+yccRql3LSfqAMkPGEwNdrzLf0
 6rAkn/6sCxg6DSbgB2iubXXiL3gXpngiymmZXbG+6y+xNi2sEq4jyodE6RHxfxAFmz5S
 tf+RbrclZrP4KhYQo+/6GZBv+uaGPdkHqotFUqZ/R2I2jW94i7TgR7WsUkU92Rgn3OAf
 wMe7bKkBhUiK/jgwj2RwLFwR+NPK5MKWQTtBcxo7tEwpAqEXhjUinCc1BBUpUMKvxF11
 wPf4CA9qs50wiq6caqemoYNJZYjxPg6Zj8QWF1kVneolfaUt+C0dE8cJXCetDXzVTW8U
 NeTQ==
X-Gm-Message-State: AOAM530SXjTuFcW3gsBSsgMJZaVjbX07zSTdo78yY6aMBtHzx55sy4uP
 UwSfVSjkvLbB2Aq2oeswlvCIH6bdpE4=
X-Google-Smtp-Source: ABdhPJxf+3OTIC+fkuu1RPTqw8t4AmL4Te5OvtMsn19w24QjKAurMWRweTgbNahuTnp9mCpRDnW2dg==
X-Received: by 2002:a1c:f312:0:b0:387:8bf:bd3 with SMTP id
 q18-20020a1cf312000000b0038708bf0bd3mr28445456wmq.112.1649672843992; 
 Mon, 11 Apr 2022 03:27:23 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 v15-20020a056000144f00b002079acb2349sm7725466wrx.1.2022.04.11.03.27.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Apr 2022 03:27:23 -0700 (PDT)
Message-ID: <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
Date: Mon, 11 Apr 2022 13:27:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220411061301.GB14797@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220411_032727_159276_46DB6B7F 
X-CRM114-Status: UNSURE (   9.74  )
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


>> Don't check the non mdts limits for the discovery controller as we
>> don't support I/O command set, this also masks the following warning
>> reported by the nvme_log_error() when running blktest nvme/002: -
> 
> I think we can skip the whole call to nvme_init_non_mdts_limits in this
> case.  And we should probably key it off having I/O queues to also
> cover administrative controllers.

I'd also move this check to the call-site instead of where it is now.

