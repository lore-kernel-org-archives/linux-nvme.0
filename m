Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CD3C001B0
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 07:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=v1nTqDi/t5h/a2FJkCzdv3GXVI
	Umi7mOZ3vggFt3ZauX8GG4cbII808WElEgeUvF12EiSlF6m8EHjgnBhQpfEMpURhmR06BqCcpGgF1
	w9CsNkS+pzd9PEPv/5gjWyO1zrVAcVr/PWI15MFIQErJ43AOkG8osokI3wVOJT6WNfp99in1U6TKn
	iPvVQe/Ef15btdkCb3jW4RF9u5Kbm+32Gp8DzGKKVtGOHlvIZVsVOwM2xhjBRYmidDTGv9U/ow8fF
	GhtAdUqfaJvdbPDvIjJcn8EO5XLypTq1N2OhC9qe+v9H8BoDMRlxzyvDphduyZLRjsAf4SV23drD7
	suzdx0dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuMo-00GKTd-0E;
	Mon, 07 Aug 2023 07:09:26 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSuMl-00GKT9-22
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 07:09:24 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3176ff39a28so998225f8f.1
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 00:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691392162; x=1691996962;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=k+RW2VkeUwPWvQFpGBR12CxJk6PM1P+X+fZoWIDpz04baP9ghAVVETzJ8XLtOT3zIq
         rHeIUhcs1uHK70c6fvlXnolIRQ3M24YmCocUnj8J3H4JxkKbxKdyyktvMzliDlXKR+Mf
         tdsHkXwOE3nrPP5AtuxkM20Y4E9cRO/9diC/tU+M6SOEk3RAgx3qBTsXNq15UmTQx1OI
         x/bUdfqCx+NqScxyHgUp8GEMzPCnPS1wl6COvpX1FtJ0lnVEy2H/kqYBdTqJ/7u84dHV
         DzLKfOQMhHpWAcfrrqLFJ+502j3fmi4HOzuNkl/ESaDj8pzjEagDC3gx9VDSbQFztEca
         izZQ==
X-Gm-Message-State: ABy/qLakDX0GUEmzZj+VoY7u7ny7fKT4zMqvdCH31eQmGe6whMGbguue
	pEXi7Ifj7krkCAtch61tKVQ=
X-Google-Smtp-Source: APBJJlGwcMR8g1rl/tiM1LrhZup7kXfOdKB6kZejczLsc3dguNHSs48NA9v47s0BNiahjIZIy/v1Og==
X-Received: by 2002:adf:cd0f:0:b0:317:5f08:329f with SMTP id w15-20020adfcd0f000000b003175f08329fmr19243089wrm.1.1691392161638;
        Mon, 07 Aug 2023 00:09:21 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b003145559a691sm9653459wri.41.2023.08.07.00.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 00:09:21 -0700 (PDT)
Message-ID: <c8f4232e-2727-498b-d8c4-e635166de34a@grimberg.me>
Date: Mon, 7 Aug 2023 10:09:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 01/14] nvme-keyring: register '.nvme' keyring
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230803105102.30949-1-hare@suse.de>
 <20230803105102.30949-2-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230803105102.30949-2-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_000923_668603_4A5ABACD 
X-CRM114-Status: UNSURE (   6.57  )
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

