Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E371C47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Eadoq8Sllwjj6D+0urVjo0Wk4X
	J4vlJcv/ntpPBrpLKMvnyXxFphM4atC4IiPH/sm9fC9rx1DNh1oYOzjXEcjxA6Nn00ZgmiEkmo8QA
	23G15StqHIq6h99bzvZiBIfiVDPAYvarsWZBPm9xvKnOZMCRnpYfZ2DAifzJpY6swpy7+R3oZHt/j
	WSgzOVWB/u6xl5oYbH9zasSrout2HmmNkEsz5daGe5j3eX8lMu98MVV+erVW6acLoQB6Px0YXsNmg
	8CCC77UW/0ReS3NPTmjPHH+Z0/u7rgWGy3x20tIbIaWL6LyMQdCVsCg25A1s1P2OXRGPk6WwBZ+4f
	poBN0ndA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUlqv-0000000GJ1x-0HzG;
	Tue, 30 Jan 2024 11:00:29 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUlqs-0000000GIzp-1ZSn
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 11:00:27 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33ad9ec3ec2so394628f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 03:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706612424; x=1707217224;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=U6avTUCFzMvXcPqSmviNdSOH+dL8RKdpTBzV0jvT48lc+pMNpwXjUo99Htj+qgHMoP
         zvcKxMSh3ndfaEpkgbMQmQDtj6nUWU3PAEVqTXGm87YzZamB0TlDNMnIO8K+hxpcmYr7
         a6BlkOD+c9VMSpDg1pu4hm+YzQxDEkl9ymCv1PVwPbRFPtfntLT6YHh/vFEiAfWe54qQ
         5Yi2Io4vFGaZGVGTxlTivGK99+af630hMdgUDijRAuojDsOTG+YYp24mooBx05ZO9xfQ
         TqCEE+sOUN2AzwD4/MtkzF8qBuRNannJ7hwo+yLrEo27N4FSQNzBraPWJ/1ftr5IN3Lk
         GFtA==
X-Gm-Message-State: AOJu0YwEOLR3yThwb+Sv2UwH0FLWIslRm9X6z6bc6hDR8mOyDIrVf2qL
	vB4YINuseY9M26Mmu7BfYlM/onJUTqPl2c3kIp2FNrJFhHcILqo6/9zXCRB5
X-Google-Smtp-Source: AGHT+IFQfDULjl++Z0FDGY7lzg1/qV4v9STZSEL+S+NcOHdrTw269dWbjvLGqU1ytdtHUpotvUx7xw==
X-Received: by 2002:adf:b30e:0:b0:33a:f09f:de51 with SMTP id j14-20020adfb30e000000b0033af09fde51mr3223788wrd.7.1706612423808;
        Tue, 30 Jan 2024 03:00:23 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t8-20020adfe108000000b0033921c383b2sm10424767wrz.67.2024.01.30.03.00.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:00:23 -0800 (PST)
Message-ID: <6ac3abc4-1014-49a7-ade8-c1b03441e658@grimberg.me>
Date: Tue, 30 Jan 2024 13:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] nvme: Change 'bool shutdown' into an enum
 shutdown_type for nvme_dev_disable().
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-4-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129181953.1183084-4-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_030026_434592_7724129E 
X-CRM114-Status: UNSURE (   4.78  )
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

