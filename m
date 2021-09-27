Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B2FC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:53:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B9560F6D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 07:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17B9560F6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WTPJ+vOhwWznXHSzl9CEXgBmwN2mai+ch8rkkemKN88=; b=mulx8gQD2Jz3y2GFSzE5Ijyopl
	PGUWrU+rqnXgaA7odV38iAUamXBU9rKlRNhLSy7MOL9eq+YshPBHgGzMXa/nc7/2spTO3KobrE0fe
	ng6SsudHDfnSfajt5mjrrUEXk5WVMhKHwFZ2JLrtLarcr+k01Rn7cbZLNupWtMJpWEPjGN6a8J9rj
	KEflfACY3dauKkXaUcl4IoiGZOlSs9ylkHbxolpm3fWWsjDzgHoLuwxnYfHYWUTrYvr9GlTFr4Xfd
	K5uHh7RBJ/Ftr0/I2gpSoXjfjmo+XKfp2SmQecUsoiH7jflL2GnWJlmDicxQwiJbcVUvoj3CIMzIW
	daTRo1tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUlRc-001sTo-AU; Mon, 27 Sep 2021 07:53:00 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUlRa-001sTO-2V
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 07:52:59 +0000
Received: by mail-ed1-f43.google.com with SMTP id ee50so65600636edb.13
 for <linux-nvme@lists.infradead.org>; Mon, 27 Sep 2021 00:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c4vg9lCY/kiWphc1Nxc6GTJqMY/xHxF59vvytmu19J4=;
 b=gka0KIGbkyS761298NMtBvQeMexnByQrtQj2TDFUjP7UMP4rYuu3trRMMec6E8Aj/3
 jrymoGDwlkXkJG9UED65j0/26NpvIlyA2gmjzgkTMs/2LrwecljAbi0qOhnflIFaiwe/
 R8cnMObUJhp4GkAjH7yZPT3VYEjM8puu7ljR0gwB4KqBaQQARpHRH5ohxOrWyGkpHGPL
 B3o5yX2kHoXSd5BvbwPncsLlXLMzDPwWFfbYIX5fKFa87Hd8I9JgVSELkE7U+RoE/++W
 EOgX6fP+hu2xy8iHLyR1w2ROjWMyCMejTKeTKHqOxJ/lKvdoiFxdWdQC/AfrIzg02pFF
 E8/w==
X-Gm-Message-State: AOAM530H25N/WrWGYAmHlcD1gHdMwHx7lj0yFrCfdxlTVtdT4SEfb6KV
 IEUAqxMhqXOQseu0iCyiN0U=
X-Google-Smtp-Source: ABdhPJztf1I2x0WrbSWOTttQF+vDEjpXayD6Aht7FksaP5YIBlq1c0SS5LEolznJ7mRR5XqipnEYsQ==
X-Received: by 2002:a17:906:3699:: with SMTP id
 a25mr25522459ejc.452.1632729176684; 
 Mon, 27 Sep 2021 00:52:56 -0700 (PDT)
Received: from [10.100.102.14] (109-186-240-23.bb.netvision.net.il.
 [109.186.240.23])
 by smtp.gmail.com with ESMTPSA id 19sm8283726ejw.31.2021.09.27.00.52.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Sep 2021 00:52:56 -0700 (PDT)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
 <22a5f9bf-5fbc-a0d3-b188-c67706a77600@grimberg.me>
 <e8e4a164-5803-5110-ab48-751def26b976@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <77845fe5-79b7-62fd-95ae-ae95f3744663@grimberg.me>
Date: Mon, 27 Sep 2021 10:52:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <e8e4a164-5803-5110-ab48-751def26b976@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_005258_146812_A2AEB60A 
X-CRM114-Status: GOOD (  11.48  )
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


> Actually, after recent discussions on the fmds group there shouldn't be 
> a requirement to stop the queues, so I'll be dropping the stop/start 
> queue things.
> (And the change in controller state, too, as it isn't required, either).

Hmm, ok.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
