Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFDCEB64DD
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=3JwtKGiChuqoR3o0FXgxU7P5fc
	HJoB/gSie1u1WqhtyWa2kvQKRpSpL2ZYj5FDAJ0/nsGprVyrdc2Wmef4XvJNEKEBCJPwPMWnvkliU
	8EBnNmbdHiu9f73p6Hi0GK9k53gZbc6IPFayk1N080A8kv9qIqMJCENo8yeMBkc8CzCfdkkaNlk6Z
	i4/6lDWhc5ipLrzkvdVtt/YF1K4v6AjNr/VunQxaPfEuLFZvFapIf8FjuvcJeTHmpse+zjTbqVULD
	/MTQ750Z47tIHDsf8vX+KmfzwOngzQ5R92rIDWBYFRhs0UcG8A1Pip8bb68XCl+3y+FGAnPVGZDIZ
	67edyh3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7wy-00E0DC-2a;
	Tue, 11 Jul 2023 07:38:20 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7ww-00E0BG-2S
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:38:19 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-3fa99b4f71fso11396785e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 00:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689061094; x=1691653094;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=DCAuEavyBDElvKaM7Wv99IqeLgARZM0tRDUrg/d69FWOBOqLoaZnMLznjbCkJBBKvV
         5pKhafONW1TNfIB0RtA1q6zueqXDqRjlMmI/+8jiZxu+BbY8J4aS0s/BoW793BnFOL5F
         15eq3VQANef+Qmgevh7kb3jBpNjtGTAsSxZdqzNFMPmiwzQzuWEcEbaCNV3hbH8gH5C9
         hhKT1NO3ZW1n13rTFRWkRj8h0U8MXp01RV3Zc9W5heQosI/v8K7Ym5xzcHk5FRtHRRAh
         GzTWNbOjO7oMCldFbYf4GsQrzdwZuqHH4PhlnjThdmNne34UFMerhC7TPquYdhZ5OSBj
         wbmg==
X-Gm-Message-State: ABy/qLaug7WKNn3aCqQ+rjya7qS8GNhpGz06KmpZwCuve6aEQU4alY8h
	Td2mpJsrnpj0Uj/xs+1fSDo=
X-Google-Smtp-Source: APBJJlGhMo0LwHavKMaNG3X5VB8oFNN4xOiOYRQC4HlPGAWfWGqaqUeQaMJ9fYph0QLTMh10Ru5a2g==
X-Received: by 2002:a05:600c:358f:b0:3fb:3dd9:89c with SMTP id p15-20020a05600c358f00b003fb3dd9089cmr15462019wmq.0.1689061093762;
        Tue, 11 Jul 2023 00:38:13 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n13-20020a7bc5cd000000b003fbc30825fbsm1723965wmk.39.2023.07.11.00.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:38:13 -0700 (PDT)
Message-ID: <a3702d5e-a0ac-a2ce-4bc4-e48e39f649d2@grimberg.me>
Date: Tue, 11 Jul 2023 10:38:11 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/6] nvme: tcp: remove 'shutdown' parameters from two
 teardown helpers
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-3-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230710153555.1766438-3-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_003818_795150_8BD2F8D1 
X-CRM114-Status: UNSURE (   7.56  )
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

