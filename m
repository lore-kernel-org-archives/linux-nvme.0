Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C59EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPjwo+x59Os+hrJhiGHbfxpsb/12V6BxCHQQczNp5Ak=; b=oSX/mUP04iUOFjloJN+E53d614
	MF+Hk+KXnd1O3pOduyfQ/rNPFMUQmST9Hd+SMlFRniUwW2rmmHrsS0+puMYJdWMWPtMoBxGzwc68n
	IIwlR61AlE2HiWXMf0f4SeTspMqLOeLNkquuNCxPZhnJoxzWRSTdwvttVgC0Hm98Ed4CCJysbirNs
	ZhO654buJ86ZbOtF6Q7qFbA08GQ894DKeER65OA8xHtGZaHKQDT6ibuR7+yC82yFO+Z2wolnmG8Oi
	4awtsKa5Thiow+Tyz8OYY14zKR1rccZgFITWLEySNbQao8JQB3U0rxMWVeW0pE+5Gl0LAE9hZ9L0o
	ge3OOMiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7rh-00DzSv-0u;
	Tue, 11 Jul 2023 07:32:53 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ7re-00DzSD-2i
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:32:51 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb78676973so1429694e87.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 00:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689060766; x=1691652766;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPjwo+x59Os+hrJhiGHbfxpsb/12V6BxCHQQczNp5Ak=;
        b=aDd2h2P34BEIKFUlxYoSvkSy9FVHERh9C/YXToqdw/pTqIWq5E7/vOEgdkD5EQ64TZ
         gkRUOftAAO3XpprXZZ4wavC/1bLxu/StkrSW2qWjZRt0nsZ6uCDtAzMPgeX11B9SDgSH
         Glnka5kfaYTgFSFD3yM2XNRjrxfg+/aHftv3OVQx5IYuxuzcSJvEcIRvA/SCHEwr3IKy
         QxcSBhur9PsyCUNPkOtV7RgtLQ8lIeSpX99gcfoobZO+Wdy5Pg0M898CVgm6Hppp6sYS
         A31s5j11UksC9+uooXR7m5PxZk9RVbYTW7hP3/JVwF830mKcDH3vjKualPGP1iBe8FzJ
         oP2w==
X-Gm-Message-State: ABy/qLbMAh5gD6gXfOQYzOcyHSIgBSObdc0RXua9yJGBZGfTRfxgOJZi
	DHnscIl2+WdpSRNP1xdIYis=
X-Google-Smtp-Source: APBJJlFfLGOK59tqcZJx8FYw8hj6OENMLjzZJYaWC1oILQuZTK3ixaTulOm+uALruw4f2v0XXjc2pQ==
X-Received: by 2002:ac2:55bb:0:b0:4fb:8eac:8571 with SMTP id y27-20020ac255bb000000b004fb8eac8571mr9589381lfg.0.1689060761568;
        Tue, 11 Jul 2023 00:32:41 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x24-20020a1c7c18000000b003fc00892c13sm1697086wmc.35.2023.07.11.00.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:32:41 -0700 (PDT)
Message-ID: <eb478ccd-dbc5-4ba3-b625-22b0fdba4a2e@grimberg.me>
Date: Tue, 11 Jul 2023 10:32:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/6] nvme: unquiesce io queues when removing namespaces
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-2-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230710153555.1766438-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_003250_884499_91DB66A1 
X-CRM114-Status: UNSURE (   8.97  )
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

Thanks Ming,

Can you please phrase the patch title as a bug fix, something like:
"nvme: fix possible hang when removing a controller during error recovery"

Other than that, looks good,
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

