Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF587C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:16:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B30F60FA0
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 13:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B30F60FA0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=CiIHi87rKaGHIcqHPoQWnJjJLS
	xKiakKK6LiYvaBp1FBW1gzXvMovk/Q5tMm+xsB2PZrm7nD+2FvoIaJEI6eStSNLRVkECELb3EMAD7
	av88lhc8h4/eLmKI7jk+IvOg16JOa40PkOP4d5sZuIfcbihDOUiq552ofI8gmvLysJ/Npcm+BxBkE
	NJd7/lRnA0yC0PfY/YyUQsD+ZPGG2p3hWeqjibKD3QOx/vabDKXlnn1X3yGxasxXMH3lY6WEjjXhP
	swkpaWNXfmlOWYRZghnG4zkXpESAqG1y5H9qCCYAc+mTDoGod0wRevi/Xjc/k5oV2dKYotWxPT284
	M3HWyhUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPloZ-001jxu-3R; Mon, 13 Sep 2021 13:16:03 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPloW-001jxT-T8
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 13:16:02 +0000
Received: by mail-wr1-f50.google.com with SMTP id t18so14693781wrb.0
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 06:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=d6A0m5sbv1QatSkVb8B6oRyhyZ7h/5mA8nm04FxsqaqRxSGcETOKaSiwrPuWODLk42
 TeawHa32yJzYrUs9U6wvmMhK0al5TAoHUM6AGNI1j44/N1Dx0nePsJvlxvksiiN34yBc
 O8cFOzHUR7OklUoXXR8kiPKBNnNebgrLQpy3Wl3yWN0ko1Yq9zH46+sCntomi4FWNCPB
 UsDL2+BSEo5b3ER1oBIQCs25BMkurmBCCTaBW1gMlX8mkGt5aYXAwr1Pw0FiV8y7kYcD
 MKS8MXetzWIxpFUOvVZ2l2vLzneMXMYLrMhrStPOpEhTrlMeDCq3okGV7OYd75agN+HU
 JyWg==
X-Gm-Message-State: AOAM532DFAoBFEdhiLxdwjylMc8dghzQ4sDAwVOqXakPDi705714lWxJ
 QeoWliMnXWsW5qDpnqtFZxQ=
X-Google-Smtp-Source: ABdhPJxFgeh4+N3wpZmHrqmgbG2kFVg3bcDyohXhCvE1/hCk30HeAA5pubOAFoAdz4U2cEWP72hMzg==
X-Received: by 2002:a5d:58e9:: with SMTP id f9mr11291202wrd.325.1631538959458; 
 Mon, 13 Sep 2021 06:15:59 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id b16sm7535459wrp.82.2021.09.13.06.15.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Sep 2021 06:15:59 -0700 (PDT)
Subject: Re: [PATCH 01/12] crypto: add crypto_has_shash()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <fd70f87e-9890-22a8-ef80-f221eeece498@grimberg.me>
Date: Mon, 13 Sep 2021 16:15:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210910064322.67705-2-hare@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_061601_008234_D472CD26 
X-CRM114-Status: UNSURE (   9.32  )
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
