Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD7ACA0ECA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 11:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EZXP38riNq/RMj6QmFF2WUhv+ow3GuTMETHb3JsZAHo=; b=CYbFKSr6i0XmcPg4QSaGSe/dqI
	ChUD22lv5VuslwFI8xttyMOwEk17WG7yGZb1QXoSE/SEdQ4uDlVomvG9Yvk2dLlzNIHgBToPWVFNz
	jj/0brOx+JeMa/lk77SQc/DX0dIqW6kn69+eDbnzrKO75et+CFycZ4BxJUEmI55x5AABgLQ3ksd6U
	DR02x5YK9TNLW4tgilNdL1mVgUkZ2m9x6eSthPiu6VDrwIU/HAwW/6XOGSojJCioJu2L+3Ld3M+mh
	CKBbI713jg5VzApjTXIj2ahDNGG3Df2vgPkpkgjxF3y+BdaMJqTQ39vS9yVP1H3erRl5szzSdHcLs
	TlULBPBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1dd-003DQJ-2G;
	Tue, 12 Sep 2023 11:33:01 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg1dc-003DPr-0x
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 11:33:01 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-31f8ddc349bso358475f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Sep 2023 04:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694518377; x=1695123177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EZXP38riNq/RMj6QmFF2WUhv+ow3GuTMETHb3JsZAHo=;
        b=uReJ4uu0etX5T4M3sdE8ZTyVDo9FecGpd7aCpzFdQinQ3Yo+C/v1WAAI3lbifLM5JM
         N26s0Hw/LvlFwftSJ+dMhcioWyzoc4KrLU17yaFWLZoHbyRJaG7QiG3/ugo+q5O2ztAQ
         VCOGSsGCvFPptmuY6erGFuucS2YV8WosEwzBuSn0TtgJOZVAVykcpTlMEDdZ3jvBzQxb
         xmJL+8Hmlvs3JEY9/mYw0TOQ7FJ0Rk5n7xeeASAd2FlV4AcD2ZNjpeXEaIegM2DDU7po
         Bt4vVXtOrJeApPNQDNNH5inVSMDeKhAcSWx6r4Q6LqY38RNTskuKtqjYLz+Tst52DwBa
         /Gyw==
X-Gm-Message-State: AOJu0Yx733eMwvlDbtPBBDLag+1HkTBkiRA3E9+LGb4Gpy2yXsNZ23Dt
	jBRT2n7F8MHI9QsEfwLNjxY=
X-Google-Smtp-Source: AGHT+IGQRqKdl4AyyF+OPdGe7Fm7NS5fIoeHX0DPiNMDXdoPudnl6N85noWCVOOMid/VESR08ZOgEg==
X-Received: by 2002:a5d:43d0:0:b0:316:ef5f:7d8f with SMTP id v16-20020a5d43d0000000b00316ef5f7d8fmr10716819wrr.3.1694518377177;
        Tue, 12 Sep 2023 04:32:57 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id u7-20020a05640207c700b0052889d090bfsm5755892edy.79.2023.09.12.04.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 04:32:56 -0700 (PDT)
Message-ID: <01b61651-5750-30b3-d980-3b97c3907a1a@grimberg.me>
Date: Tue, 12 Sep 2023 14:32:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 16/18] nvmet-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-17-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230824143925.9098-17-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_043300_332067_15BD6F6C 
X-CRM114-Status: UNSURE (   6.83  )
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

This looks sensible to me at this point.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

