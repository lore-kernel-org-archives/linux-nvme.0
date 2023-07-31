Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D283C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rbU4XO+GvXnhyxq9QSPb06TlSO
	ThoKa9jLZtexxtykS2DRtBsmiGA0pDyXhxSq7iLwequu55lE77SydccwBPzgXKaZ2i7mUa44Qnf03
	0ZI8XdHcsTfz05PnQRCA9zRJEHZkzgqhn/fdsa110w9O8Dxq2CbW4KU1ayWELFK+Z5mFTX17lRT4V
	QbUy6D8m+O0J907x/AEGNXuoXB5wzzxzZi3jEnlpm/aSmoVnTxza3h5DF799BC24dzk3gR5M4+X6P
	+lSHQCKwJ5wNMXN+85TTjtSlc53qhDob7x+uimlISA9xcBR0m3kz3sBBfTl7qJX1JrTkhFICnZila
	YkO8fUfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTK4-00FsVa-0w;
	Mon, 31 Jul 2023 13:52:32 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTJK-00Frue-2H
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 13:51:47 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3fe1f70a139so3256745e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 31 Jul 2023 06:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690811504; x=1691416304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fOwZnfgdsfHl8UhTyR8UFCtzcyen/SHmtce/OOj4cxUy5XgCja8Z7CER14AGePhlVw
         5/A1HRHX7Iry4E5QIwiLNacA08hWSa/W6dfnqCWPC0o9Y947lIyErYiHFuSy9rE2rVu+
         AzjVwr0w1F3Xu5eKxV8Zb5kpLFyZ17Rxl6cvKCmc9Gs9cbyG0WU73VERiSA+wyd91HyI
         wyKPKVMn96UuUOFQoFEDK8KqS0An8bcqn+opJ7z+eJkqZgyTPPbkzfu8aGG7EeHvyP7O
         PC6tUfOj/kH6snNfQmqcgObcu+mUW4j8UqEULR1FTB3val2tFcSvAF8TOrbv9OQRKSqy
         5MUA==
X-Gm-Message-State: ABy/qLaweSuD3lCxB3F3Y74etbK87PYdOntSXnn120Zht7KVEWkd65Q1
	1TbqKknU85nWhy/fPXii/PJ6FnTkxtw=
X-Google-Smtp-Source: APBJJlGMmPciRbX3khPzZG/zec5Sjkb0lpADKxI2keeJewtrWCPvpr8swI6z98Dz1ALgtpozwwhZpQ==
X-Received: by 2002:a05:600c:8807:b0:3f7:e7c9:4039 with SMTP id gy7-20020a05600c880700b003f7e7c94039mr6429093wmb.4.1690811503545;
        Mon, 31 Jul 2023 06:51:43 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003fbdbd0a7desm14129553wme.27.2023.07.31.06.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 06:51:42 -0700 (PDT)
Message-ID: <220e814d-84de-afa2-5bd1-da20e11fdf8f@grimberg.me>
Date: Mon, 31 Jul 2023 16:51:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20230727134748.4163796-1-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_065146_741942_8188DC34 
X-CRM114-Status: UNSURE (   6.27  )
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

