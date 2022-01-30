Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0662DC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jan 2022 09:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=HvwB9+/qFl2RFNFfKnzHx7tebx
	dzV0otFhGTY1sxM4Vvx2lRrHmuZCBGGbG6+rZHBWIuyel3VIC38mh9h+Vv0lJnGrvUdDzOzlllv9R
	2PgYIlv3r4tTS6erNrv1H4Nq5Ptyo9IggtYvOoNggJHW3XCu8JiNl6mMBIesnT98W8jXjGozgWtwe
	tpEj9kLQS5Gc25qJDL6bjQ3S9/x1F+w/KQhpi8j3KWMCxLd9t+1dmKXP3IS+SO3R31JDT/Urbidvs
	lf5ZNFoVO6YsLHXk93HOf2ht8XpSPU0xYSOaZXWBX27cISC4awsbi+A2stR3YUrHxhGQ3sJKUHpvn
	HUiWt+sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nE6lL-006HQq-J1; Sun, 30 Jan 2022 09:44:47 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nE6lB-006HOu-Fy
 for linux-nvme@lists.infradead.org; Sun, 30 Jan 2022 09:44:38 +0000
Received: by mail-wr1-f44.google.com with SMTP id e2so19680511wra.2
 for <linux-nvme@lists.infradead.org>; Sun, 30 Jan 2022 01:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=dJVn61EHnL6x9IpNb4XTj0pJdGXCIAUt96Kb/oLem1dobqtHl9b+r7HcPM/8my75Jv
 lwWy3d6ENRZbwtJSKJh66dJspbjzL964ClKyjd7dqHQhuod3v2v6W3/3AAiqSdOgipjn
 S9ldNtybOpM1gcUosY4lBEjvMzJXPnt5TfgjHX1mSPggdbPOV32DuEZ3eKAIdh/at2nu
 8ADfCuEsy2JLSPmOUDBfE01sTLwOeNiggTTfTT2l+O9SOQMFOCZUK6iqhKW7IXLfpD9t
 H2pNEL9C+UJl7q62L/F+Av6+uxDPKjC+6PLn0jc9WHuNxgW/VRf2s1EhrERqufd4GKMu
 dMKQ==
X-Gm-Message-State: AOAM530nz+JPPv+zgcSsfgLdzYkLraIxoaPRqnTGtwUhHH/enavFa4BO
 rq0zioqgG8YbCHqCKH5iI3Q=
X-Google-Smtp-Source: ABdhPJyAmaazuD2YM/ESsrjh1eIFnG4uMcYsizwFEvn189kHNnXjEUXdd+4T7ayd9e1g2aAof02Y1g==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr12935794wrp.474.1643535876352; 
 Sun, 30 Jan 2022 01:44:36 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id h9sm2713352wmq.8.2022.01.30.01.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 30 Jan 2022 01:44:36 -0800 (PST)
Message-ID: <48ae1afa-42bc-b1a8-6b58-e59320153394@grimberg.me>
Date: Sun, 30 Jan 2022 11:44:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/9] nvme-tcp: use helper to initialize connect_q
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220128092015.19289-1-chaitanyak@nvidia.com>
 <20220128092015.19289-4-chaitanyak@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220128092015.19289-4-chaitanyak@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220130_014437_546690_37B14713 
X-CRM114-Status: UNSURE (   5.42  )
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

