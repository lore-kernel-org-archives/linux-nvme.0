Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E12EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jul 2023 07:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=na6WUH9woHB6QEo6KBr73wBbzDPTvIKU6Yox4EuOFx4=; b=pwezuUFD5kxJ8NY9sWHOJ7S1v3
	unXp8WBza+MvBMSI1r8NuPxUrWQpm9v9EI0DMUaMYEjY0QVEyEoFuOfC1PIsoiz4CGtkW2jbP38ZT
	a2+QLj9vvhsgFJ/Ti00dNCm8CVHC7wae/WliYshct2xBQybmrDONbXClGXLxc+LrB22Rzbe1M5Hqy
	OXSELpYJtCfctj1PJfAbFHvTlha0y/Qa54TBBBlmjXQuFx9xbTO3EAj5yjhWZ5fLT9de8Vf+NOdQK
	tTnrVBwDCsvWV8OkcQo1k+rzAK7XLqD+ZKjuw9n7LV4O3nyUxkR5HiXqbvlrAI6X7opBGWvQpauhX
	KnMrXdUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ80w-00E0rA-1d;
	Tue, 11 Jul 2023 07:42:26 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJ80u-00E0qH-0Z
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jul 2023 07:42:25 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-3fbb634882dso12938945e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 11 Jul 2023 00:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689061341; x=1691653341;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na6WUH9woHB6QEo6KBr73wBbzDPTvIKU6Yox4EuOFx4=;
        b=f72MDQHUr0SHBmNf/R/PcfnFyyO4oIW1ieteHPSPoV0JHC9C06kEDGSIvSf/R9U86b
         44QPJar0S0loOj8LTb14fQi1oPZ+zgpVvQ6+lgLY6VFoZcIqKAfNaEAYy+KMATZPcKOh
         5nVSXP2FGXpFPseg9Nc0xLBMvaqJ8ECGdG5jRZNwZ6cCv/ZuqhPdGAIi8q03hrng6T/p
         BiVz8Iz7WG44HnTZWEs47h2QRsavt7sXWu/m5cN4vSn/hAehA8vgOQeFF/9/g9R94jiS
         WVKCGbo0gZnjWljU+fAwed/eKojCTOjWN26mPbourdZ1lNinD6SbI490Q/aDx3idBlvC
         9egA==
X-Gm-Message-State: ABy/qLZf5Q+014EUBUbc0H75hba2jx1o3mfSoxcDtjI/3Ly1EvB4DAKa
	EH7BT1+zunDcRiE1Fnwuvx4=
X-Google-Smtp-Source: APBJJlEKBUM27hYQF2YImcYzUHoQ9MOkbj265p7LkYuFuTRlQnNCXwn4Px14HxPA7QWqNhzX/pcu2A==
X-Received: by 2002:adf:f286:0:b0:314:1593:9f2 with SMTP id k6-20020adff286000000b00314159309f2mr13709210wro.4.1689061340511;
        Tue, 11 Jul 2023 00:42:20 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d6147000000b0031412b685d2sm1480250wrt.32.2023.07.11.00.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 00:42:20 -0700 (PDT)
Message-ID: <3b34caf4-2900-396e-103f-639a98b9bd45@grimberg.me>
Date: Tue, 11 Jul 2023 10:42:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 4/6] nvme: rdma: unquiesce queues until ctrl state is
 changed
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Chunguang Xu <brookxu.cn@gmail.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
 <20230710153555.1766438-5-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230710153555.1766438-5-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230711_004224_217520_7B455B50 
X-CRM114-Status: UNSURE (   8.19  )
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

Same comment as the last patch, I don't think this
is necessary.

