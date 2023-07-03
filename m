Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F8EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jul 2023 12:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D0PUdrTV9JSlB4itt4V7/IvaI6ZLS2ukRynlxQ8p298=; b=EzZou9324Rgg9vuxvBhZWZJPDh
	DLyzVt2K88eJJ3l36z7DtQjbGIbUsEGSwJuwisAnpVwYQuFjUkjZGhUJQ0hkwJWZMAxwAWh0+hH33
	Ku+6L8y1cQ12JOL0zN+Y9tMZOQl1xqYVz/2zXSXGJKAXiJ6R/1GQOxCLJSpKxIWHNl8tlY612Fai6
	KC4oBopY68zeyF3IH1KGfeWg4fRsXopv/r/hppRFRdN6JUob1unJ91WPhLtEvcKqo3c+hPBlqI324
	6I4wGvDfUpGmw3+F+Hn/3vbAi0OLY1EJojH7lWlrje6wH7EflHolLrqYoHHgfR3W8x8JFw6nXcEQz
	TfTc3LmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qGIjv-00AUq5-2P;
	Mon, 03 Jul 2023 12:33:11 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qGIjt-00AUp9-1E
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jul 2023 12:33:11 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fa988809c0so11964885e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 03 Jul 2023 05:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688387586; x=1690979586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D0PUdrTV9JSlB4itt4V7/IvaI6ZLS2ukRynlxQ8p298=;
        b=VEKpWpW1X2PkYGquk20XWAXqVeX9EpnGU9wIwhhHs7LMKDJ6G5FYJIzMok5qn7m45F
         f6awF++dovuqlPuMW4g9oTpbz0K3iZypAi4HHQvp5rs1A45KVAn5e1fHhgVlsjg/z8oz
         PEGp5McCaqX13xoXgZj54tsPz0LEo4bg4yTnj5atOtFpix0myTqqn4ZBpYkawEML9t2U
         unCIAsVpbeUiDx3x/9VN9rnInj2X73hr11VpYLuu+XnDApjFQ4x5Jhk/paY3rSOFrCex
         QgvgSi6XhhX+mjfgWs32NXbeXsCYw60xlaJVmGL/8AfkkvXY0wj4JgXRsxyeuL0sEFTK
         l2uw==
X-Gm-Message-State: ABy/qLZ1FJuEjJqfnTiHuzbZBJgKnNDeHIxkixE6qCPvtwvoQShMg8z3
	FsPBzX6zLhUD1x7KU1B2AIo=
X-Google-Smtp-Source: APBJJlEY5kLZN8dU3O1mOnZemT4WcPab4YtHfjkBNhV0Ml3v2n0l++DGvcTaCwSRgnI0nbqPrjlZvw==
X-Received: by 2002:a05:600c:4f49:b0:3fb:dde9:1de8 with SMTP id m9-20020a05600c4f4900b003fbdde91de8mr125665wmq.2.1688387586411;
        Mon, 03 Jul 2023 05:33:06 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fbc2c0addbsm10150089wmg.42.2023.07.03.05.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 05:33:06 -0700 (PDT)
Message-ID: <12a716d5-d493-bea9-8c16-961291451e3d@grimberg.me>
Date: Mon, 3 Jul 2023 15:33:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCHv6 0/5] net/tls: fixes for NVMe-over-TLS
Content-Language: en-US
To: David Howells <dhowells@redhat.com>, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
References: <03dd8a0d-84b9-c925-9547-99f708e88997@suse.de>
 <20230703090444.38734-1-hare@suse.de>
 <8fbfa483-caed-870f-68ed-40855feb601f@grimberg.me>
 <e1165086-fd99-ff43-4bca-d39dd1e46cf1@suse.de>
 <bf72459d-c2e0-27d2-ad96-89a010f64408@suse.de>
 <873545.1688387166@warthog.procyon.org.uk>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <873545.1688387166@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230703_053309_419285_509E1905 
X-CRM114-Status: UNSURE (   9.10  )
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


> Hannes Reinecke <hare@suse.de> wrote:
> 
>>> 'discover' and 'connect' works, but when I'm trying to transfer data
>>> (eg by doing a 'mkfs.xfs') the whole thing crashes horribly in
>>> sock_sendmsg() as it's trying to access invalid pages :-(
> 
> Can you be more specific about the crash?

Hannes,

See:
[PATCH net] nvme-tcp: Fix comma-related oops

