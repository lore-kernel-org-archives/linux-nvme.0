Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA86C38A2D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 18:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=e7xveoDu2pPHerRsXzzcK5lB9d
	ZmARl6L0QJxEsV7OIkrzbiANNUYFzNaTf0P7yX7RYG7sP9HQKCgrbHp8OvaBHCQUQLGZYDiAuKx7w
	/E3YzufhB6VV3cJIlBoKzzZDk+X58PMEqbJxV8tO5jlumiSQJyEUmqnz/E2UUYRpidnO8DIuj0on1
	38N8gh1JFvOwsZ6xohobxAep3CDWgGga+EPCyndpREwsdorp961tQr122zypiTB4cWnP8GwM/HIkm
	htxXhR+d6Wy1jQxCeCARqfOXmOdDKUrmDSo0dG/m9H8pzefHjEopWoGnCe2QRjW263P/I1ufIucLN
	IU8FrA5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on2eh-002izj-Ht; Mon, 24 Oct 2022 18:58:35 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on2ee-002iyh-Ed
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 18:58:33 +0000
Received: by mail-wr1-f48.google.com with SMTP id bs21so1730964wrb.4
        for <linux-nvme@lists.infradead.org>; Mon, 24 Oct 2022 11:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=e75e6X99FRrK/qzFV3fgNx3U83GAjJSYkx4LiTo+mBiOXimd5Cnlivx5gBRm5VU3we
         gqk3Z8/BtGy4C4RFioGBlS6xx4v3GsLhMvqKZYXZpOcRtjorteiohkFLlS/3lTbA0PZi
         Uh2vi3OZStB4GuLvu8Q8sE4sIEPMXihdq3xw0PWyAJH5FgA0BeIldZpAxINSVSJjaUpy
         5Fa5bk8mzzEVQpV8mF+P2GMhws4EwoTIoIvS1OYkB7RXTwBEe6JSnyPb3FeSZ9Y5gpNn
         DsCy75AmtVFSd4zhMeJ7vnlTNw/xaorhKiSOt5kv+ef0TB16a4GI7oJ17BaTiLvpsXnw
         uY3g==
X-Gm-Message-State: ACrzQf0Dm1yV40mJKddho/qhIEa8syEFnkOk5l8Sd4JUumYzbHFdJb1b
	j1Z5JrtwYOwDHx2OfhU5864=
X-Google-Smtp-Source: AMsMyM7///Z6avYgwOWExcUSGXZaRWZgeoVPGfIrJopsRLsAc7d7HHr4x+JUPlYu1gzqXT5C6mBS1w==
X-Received: by 2002:a5d:58d9:0:b0:236:5b81:2c99 with SMTP id o25-20020a5d58d9000000b002365b812c99mr10080462wrf.494.1666637909773;
        Mon, 24 Oct 2022 11:58:29 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id x9-20020a05600c420900b003b4e009deb2sm615019wmh.41.2022.10.24.11.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:58:29 -0700 (PDT)
Message-ID: <0b9859f2-2216-549b-fef5-02e70a9b2141@grimberg.me>
Date: Mon, 24 Oct 2022 21:58:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme-multipath: set queue dma alignment to 3
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20221024185745.3164002-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221024185745.3164002-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_115832_510979_D11D8748 
X-CRM114-Status: UNSURE (   5.61  )
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

