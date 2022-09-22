Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9882BC6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=cO6lGryNT+qtjzcwVxWsETQk4N
	qDfL8miJoWg6WdtxnpKJE5rxeV2P90d3rF9otcQsob6evcRM0zV0V1S8VDnGfYIzBqT3e7K+2YZc7
	8jDwiNWSQWtbIdssa1Lh5GhPRmZ0eHBLkvEbZ6gFLTnmyo84pOsaYUDRY23e8IedyVye21d46Q7x5
	++9nzkKuYpBgt+ZFkZ5c4lfBnyT4M+eDl3EQ9xw/jVctcqN17E2LMmvBkAYBhzo5UPq6ux8XzWvCH
	Z+4njK6knUT1+dzMfOKyCOIkQy4Z86Cg2clb37lMGi9PbS81eZQ54+/1lNPGtFZnOZwkKBLabkQ5t
	NXBRgPMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGEV-00Dhfi-AZ; Thu, 22 Sep 2022 07:02:51 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obGES-00Dhef-Lu
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 07:02:49 +0000
Received: by mail-wm1-f54.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso698171wmq.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 00:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=5UVcqSE9eN7Rz788nu8SBEpM7s/93IWBmDO6KmAJchkLvU2FUn5LvdH+98ZBr65Iut
         VZMSV+GBP+Vm7lOcpHbvcEU9nk7wiVATP1yVqMjOX5ma5FfZotkbvbgTTThsnFfKBiFy
         2p3prJNYLhr7g1mUeYSQihc1k8xiQiSgTtVkl733aW78V0A+4/qVnkLqbuun9lFpzJsj
         laHAU/KbE7EpSgVXj0736/aMzl9j9NB6q0GSSiDmm9ggY7+5dJ4p5r+hyR918OefpUJ/
         1TvEKdjwlvTt1NjCDyKKfVIASepT/61PDfu9+hal8deOjgCiktLHr/FbDVi76co5gP5D
         RhAw==
X-Gm-Message-State: ACrzQf1CFtbxBZ9fasZ75dC9mYsZBWea2n7LtiPUNmK5lIlsJO5R5s6T
	dKlT2ZGSStGsqZ+TKGp64yk=
X-Google-Smtp-Source: AMsMyM7iVa7Qc9OQ+TLlv5l/uBESmpiCDsKq+/SK2CThXEjyF1TZXnkFjIfslHnRi0/B7TTMeQObaw==
X-Received: by 2002:a05:600c:5490:b0:3b4:8db0:54d7 with SMTP id iv16-20020a05600c549000b003b48db054d7mr8292385wmb.62.1663830165981;
        Thu, 22 Sep 2022 00:02:45 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0022add371ed2sm4743923wrf.55.2022.09.22.00.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 00:02:44 -0700 (PDT)
Message-ID: <62d3700c-0581-6446-b2a3-8c61ff71a356@grimberg.me>
Date: Thu, 22 Sep 2022 10:02:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-auth: add a MAINTAINERS entry
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, hare@suse.de, kch@nvidia.com,
 kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
References: <20220922063429.1573089-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220922063429.1573089-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_000248_719583_A9A3B61C 
X-CRM114-Status: UNSURE (   6.89  )
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

