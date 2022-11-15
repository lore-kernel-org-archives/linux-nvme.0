Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE26C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NbUIpRnhp4GS9y/6fUvCtCzw6YT3o06bAe+jrChjIiI=; b=RUjUOCjAerreMBG+W/sdnAZcg/
	zYeLFftCeJrVnI1hQbztsgsEhDm8aqBpMsvUX2fcOzkaW9xbSJtWdxMe/xnrmhJ6XIoGjG3CqrKAV
	h/X1UCf5u+aMsCD5aDm9gOoiDbVyy/fboFUPDShIRRC8X5CKK18KxkoR/gwOEanA1QyB4xdxpnX8B
	i+w2VVwABrdp9A9uAx0vjVSKzL2tJt/Hh6vqZaoISI+8DKnDPYJAuozS1XY/aSX/Hx7GYrTK1dGrF
	+ZreJZZs6QIpjlV0hFbMoSSHpkBxSRr3SVAHjrvR4sytVyOu/oyDTlkHpipYRBVw1FIFTygYMnhfk
	16DVbplQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzY9-00DP8t-LW; Tue, 15 Nov 2022 17:16:41 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouzY6-00DOx2-N3
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 17:16:39 +0000
Received: by mail-wm1-f45.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso10751662wms.4
        for <linux-nvme@lists.infradead.org>; Tue, 15 Nov 2022 09:16:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbUIpRnhp4GS9y/6fUvCtCzw6YT3o06bAe+jrChjIiI=;
        b=NJPJnyevv6VCzpjsgYtQVCIC1Co2AJelnVYNJlXeQNolsfnxr/jtJuXeXSmT1VUrFP
         IvrPsjAuUHjq4WSDrBHbmgC/Ol1oVV8qEKjNG+/lYtJtQ61LzVyy4va+MmtlDdwmzzog
         gYtBMnPzJ8J3VmcHBPG/lokW9h3H8xWagYOwRCymGXgqAf9HqgNdvIHvyBFTvWj9ao1H
         pM4WJ00r7kr2jOosB8/UJJ+6gWWizk6v9UoVDnRoXmMmh1d7/VBDwp4tl8A9fdS1PgjV
         P2GHUkkj8tttKLGZnbUnbkVqyzj4tBJ3e5/DeMaaQ8mouK1kzWcAtXTPViNvnlyCmhOj
         6Cpw==
X-Gm-Message-State: ANoB5pmOqpZV98usHZuKFHNSnzfteFQ69bJ+oCj9l4PljxT4pcQwOMiz
	QnCg8tqYP+oejJ7W2aof1Ro=
X-Google-Smtp-Source: AA0mqf4zfSviKGWfcwWDeLfCbtj0Jdfz9f9++NXPVx3Z4+iZG4vTHXJyvNtJCJm51n56nkiZszls9A==
X-Received: by 2002:a05:600c:43d6:b0:3cf:615f:54fb with SMTP id f22-20020a05600c43d600b003cf615f54fbmr2207817wmn.76.1668532598188;
        Tue, 15 Nov 2022 09:16:38 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a17-20020a056000051100b00228d52b935asm13003252wrf.71.2022.11.15.09.16.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 09:16:37 -0800 (PST)
Message-ID: <cf1b6850-23b5-f726-96e5-f82c6038fa55@grimberg.me>
Date: Tue, 15 Nov 2022 19:16:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-auth: fix compilation warning when CONFIG_NVME_AUTH
 is not set
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>
References: <20221115143532.1142332-1-sagi@grimberg.me>
 <20221115161005.GA20314@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221115161005.GA20314@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_091638_792067_A1CD7EBF 
X-CRM114-Status: GOOD (  10.92  )
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

> On Tue, Nov 15, 2022 at 04:35:32PM +0200, Sagi Grimberg wrote:
>> init/exit functions should be empty static inline stubs when
>> CONFIG_NVME_AUTH is not set.
> 
> I've folded this and another similar fix in.

Thanks

