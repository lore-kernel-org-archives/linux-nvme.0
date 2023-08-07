Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08B13EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Aug 2023 08:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h6/N/2BWCZVt4vpliwKkLCg3WqtEz74CuKiBhIx40us=; b=tprBKytwDY8YgiGiOr8+2qo5Gb
	trowGYeGNgKH8GLcuNxayPiS0AoYDKzJdTozJvE6Zdjyc02VUzXWEoWLgkAFc1ik73GuKQXzWubmq
	e53AzGNNV/kaqnlP7OLGSrQg+QsbCw30ibIDpnYUQcn6thaQN+/sUgepetxQ6x1Mns56p5SZnvcud
	vRxAwe7nYE9/esXBNZ7u77J6tpv8Od/Umk6wrvaNVFFpuAWMBxnSOg/WbtuBI4pY7YPfBxkmPi+GO
	Fa7JQE/o4R0DrsTe65waE/1aRWWSR7kCEXNflLD3p6pE8uYWODB2tnqucmsnzIfZm3FXzNFBm+Pis
	BrUMOPJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qSw0x-00GVQ8-26;
	Mon, 07 Aug 2023 08:54:59 +0000
Received: from mail-lj1-f169.google.com ([209.85.208.169])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qSw0u-00GVOK-1V
	for linux-nvme@lists.infradead.org;
	Mon, 07 Aug 2023 08:54:57 +0000
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9eaa7c83dso7810761fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 07 Aug 2023 01:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691398493; x=1692003293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6/N/2BWCZVt4vpliwKkLCg3WqtEz74CuKiBhIx40us=;
        b=LsBbppBz6S5mHjOMxUSN3nfcQDCBXtSNfq+DZPTJLfb+d6On1uBV6noKt1Ud01hp1n
         AvWLAiYBQVPUUXNHKCa3IHjFJ/3jROSl0RRKkMTVClRIidlLbVVUPwDR4J+/cnwA7TsS
         VbSuINmHg7px5s7okTczP2RHI51Xv3y/hYVw9RjPqmF7eO1xAW9tc4mqbwRKPp7Ddbau
         zbgDea+Pe98oKUCbNmQKbG+AYpC94p5+re6JuHh79BcZYMIqsE2fPzyPx3QDBWqbZ18/
         cq5kp0Wl70YezymVfrnBYrTHe7//9XPjEpGiofjO4BNx7t9c2UHHj461b7BDWXAlC0ZO
         iqhQ==
X-Gm-Message-State: ABy/qLbbN7EboApB/pLdawNR8yVRs3sRXX8V7nz0CfSMNd+y06h33h8i
	JcylioGceVAqHLnjLeP6wVA=
X-Google-Smtp-Source: APBJJlEGcMVKwl0W7c8WvYG+q4frq5Hi4j3WsVsQ1We3MBIWusK1fRwqVOTAjh4sAE67WwjClGV2Hg==
X-Received: by 2002:a2e:bc84:0:b0:2b9:54bd:caed with SMTP id h4-20020a2ebc84000000b002b954bdcaedmr16416061ljf.1.1691398493118;
        Mon, 07 Aug 2023 01:54:53 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b00985ed2f1584sm4859899ejd.187.2023.08.07.01.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 01:54:52 -0700 (PDT)
Message-ID: <40f2231a-df19-fd4d-f6f1-105aab5e5d84@grimberg.me>
Date: Mon, 7 Aug 2023 11:54:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2] net/tls: avoid TCP window full during ->read_sock()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230807071022.10091-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230807071022.10091-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230807_015456_502459_DBDD4764 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> When flushing the backlog after decoding a record we don't really
> know how much data the caller want us to evaluate, so use INT_MAX
> and 0 as arguments to tls_read_flush_backlog() to ensure we flush
> at 128k of data. Otherwise we might be reading too much data and
> trigger a TCP window full.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

This looks fine to me,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

