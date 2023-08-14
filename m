Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BA20C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Aug 2023 12:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=kU5yfYz/fMY4017CSvD0BaJIjg
	sOr6Hm30GDJ8jKx4uCUJ34HCdrqKFM+bxkSJ3oF+Ba4kT3Lgb7RFo9Y3ze4twvG/Ll4cJanhiJLOg
	z3GBxCYY/9gA/Kk54PR7AgLc17GbtoO+b+u7aQSdC8rKxbP4iPS0ZC3reuDyX3o1S6DxxG+UmnsP6
	KMtwbt6SVwl3F0V6h67PwtNWgXYu973KBYRXwKUzZCFAFVKAOLq3jLiJK9rAH0hY1ebWQZ5h438F7
	AqDQVvRjzYSCZLx5owGGLMt7E0R1IkAj55gopqqAWTf535pdN9J7rHslosso9p/Y1flbHMj5fOSdV
	JkIniVcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWMa-00H0jp-2f;
	Mon, 14 Aug 2023 12:08:00 +0000
Received: from mail-ed1-f47.google.com ([209.85.208.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVWMT-00H0ia-0J
	for linux-nvme@lists.infradead.org;
	Mon, 14 Aug 2023 12:07:56 +0000
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5221bd8f62eso1339474a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Aug 2023 05:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692014868; x=1692619668;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ava/BiFuETg6U40z2gL8bEIsh2XBMm9oGcJKFL34I46poJx0dY9Me9TmK6t5hMxvBS
         eQVv1PtBWI5pej+GNIfxPJoruP8n8K3ahljWbmSDtIqPbUSS51I9aG2nHUjskBksG66G
         Oe3+7mfYyALsx/q1t1WXq/7lv7avsiCENw5a25nP55TumL0for+IO6pXX7d7ENy2nuOY
         cS0XXqSrZn7JJHgmLxX6lVYUafy6c9UZ0aAxiwjbMtNBT3ArwyrptWIwTpa+Pv0CiVo4
         58dsXLcDgvXVI2pGlc6det35HDHrPM/+toHR304xMwJk07BoBJUmqkrdnIEb8fKV3mNG
         nx0A==
X-Gm-Message-State: AOJu0YygYEpSNxOeFkbCC9oiyVnxfJdeThuFcjkT4ptfw38NMxBO40mq
	5fCakNQL5dZJRUINfjjm0as=
X-Google-Smtp-Source: AGHT+IGcelZsJE4I1ve4SYii4MRlYCXgkAdzgvdIliZCGpeDWyVhjZJpryR1khJ+Rs/PQxpkjDkPVQ==
X-Received: by 2002:a17:906:116:b0:99b:d594:8f89 with SMTP id 22-20020a170906011600b0099bd5948f89mr6886195eje.0.1692014867980;
        Mon, 14 Aug 2023 05:07:47 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id mb8-20020a170906eb0800b00988f168811bsm5635390ejb.135.2023.08.14.05.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 05:07:46 -0700 (PDT)
Message-ID: <4eca46c0-7fca-f4b6-78d2-21b523e748ed@grimberg.me>
Date: Mon, 14 Aug 2023 15:07:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230814111943.68325-1-hare@suse.de>
 <20230814111943.68325-11-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230814111943.68325-11-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230814_050753_137715_EF9A99DB 
X-CRM114-Status: UNSURE (   6.74  )
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

