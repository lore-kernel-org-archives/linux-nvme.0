Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9D0C352A1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 12:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Gzw9cKXHDLH8JvKLrKq1TrtDH2
	X5M0beJ/Az5RtlsgmGde4L7fLuNtuECPCI9uWHK8T6Eylg/0z7qD/lPOdY/YOVoGqVLxYzymPjOxu
	ySSURLzD0pheU15ipJIFQQdoJbKAIlVAu3WnFZdnq31BadW0tPZLCA7VNWb6hrP48AexWzTMAHQfW
	V/kuNnu2ZbraOX1gvhj7GbFh2FLmiVr3V1DJ+J1h5mo+B9zyBeKtszM6aJImhwQbxc4LpUCoDfLri
	UMaK/tEqkDSWzUa1PN8Ne15EVLAKLIgynOQ/NSZekmBURXAFsx2oR3a+vxlGNnrONyl4u05cbAj9O
	h82B77Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wh3-008wcX-HD; Tue, 06 Dec 2022 12:05:01 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Wgx-008wZZ-Dm
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 12:05:00 +0000
Received: by mail-wr1-f42.google.com with SMTP id o5so23167154wrm.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Dec 2022 04:04:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=6ixgzYAlQKiBFYfM0fgSM6C6Lx12BSFBulW6i3QEofyP2olxIls72JpU+zoRjl2Ii2
         74YU+jZS73rdMgbHE3rMLjAlR9ZfpRPe+hR5ERkFqHsHlZcA/1kja2ljfxsRaeY+L4U+
         XNqwVTomg2P2ERcWFCAeIKhp/GxBUa2R2p2j3uyN8hZaIHnROqlv1+kWeNw+SQ438xWK
         1h3+7Flz5XZqdntYZz7vV1lI9CIr/SCysJIP2VDVLt5KQm1iSEZoU7UdzuBvSvJedkqu
         fuINSCW08iP+sXb4PZcrgQ+PWKkAp/XXO8jQi9jtfJ0vvqnJdt6eEidcU5rRiAb5IsRn
         Z35A==
X-Gm-Message-State: ANoB5pn7Z6eFZFjjNYxRQTUv9atyDBFphFYaziPl5nYnyAsAfRfzqRli
	zUy6gqSI8e38hKj8O23O2P8=
X-Google-Smtp-Source: AA0mqf4YZobaUIz4ruLJwmukxNahoBE9GvVJLYqf4A1qi1abwaypWmwppnvyQrtCOmyOHfHaQus/bQ==
X-Received: by 2002:adf:fd01:0:b0:235:83aa:a6ed with SMTP id e1-20020adffd01000000b0023583aaa6edmr50462012wrr.543.1670328292847;
        Tue, 06 Dec 2022 04:04:52 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id o12-20020a5d670c000000b002424b695f7esm10000028wru.46.2022.12.06.04.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 04:04:52 -0800 (PST)
Message-ID: <caa167d2-0eec-6efd-7da5-3505bdd96b7e@grimberg.me>
Date: Tue, 6 Dec 2022 14:04:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5/5] nvme-pci: use the tagset alloc/free helpers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
References: <20221130174240.227616-1-hch@lst.de>
 <20221130174240.227616-6-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221130174240.227616-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_040455_477060_654D6887 
X-CRM114-Status: UNSURE (   7.14  )
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

