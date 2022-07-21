Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B875C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Ct36Wl1Th6gvgFXfbjqm+QqR/H
	MSnK/0rh4y0n3Vtoind6sIv9GftAYhWcKreWQS9rJMCuOHht9zOr9HSFiUv78D+z8QdzjI80B7ET4
	cPL8SNBcI7ZSLZ3H9dQivV5ZA5N5Vil8H39AMrtOxvNt7euTIAKIfNJjRU/usRucPCzdBbd70x3jf
	0vObxkYsgVUxE7YKLFg8ftfB7iDYu2ZwXNSeCaOK0o/p7GPZl0Ld4sdgesliy3ly9Wq4QVWcagG7Z
	PEbu+teqq1cmzYhQMxtSkyJExGkncBP3AOt0WgYED8STgVTU8E90TZveEEjFi/yWuLCPZelZ2Vtx8
	NSqu4K0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeVl-00CmAh-U3; Thu, 21 Jul 2022 22:19:13 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeVj-00Cm8S-K7
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:19:12 +0000
Received: by mail-wr1-f48.google.com with SMTP id m17so3891230wrw.7
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OEGhwlK7V0hRMehxyJTADbOPC4W55UhcZW+f6DPi2JMqvQPyQBsZ+N2RgPmeSiKJ4B
         rBCEyEZ4gav9qISSi2Jr96UM8AnoNxqekETHyqwVVLOtVoot/XWJa1BuS/VhRZkCvQPM
         6HrNIvNZnZXyeaNQ6g48ySZiopkkR5vbyse2YN//8wNIAlOF705dWV62GmTkXEiQHUWQ
         NIHKjIiWZSSUBpkQBWdycHI59OEFk6IBFEA6TppdP6qEoDIOdnZPCKPTSR2krAbCtWkh
         rWrpEGN22MqGlOH/bu6qCEa2eqYfsVEQEYBnjhojXOgN33dOL5bbLWSY3zwIVk9MwPVC
         GpdA==
X-Gm-Message-State: AJIora9ZimxBpSyJ+oRyg2GEggtJlukpSatbaFhMjiuDZIRUPJ9kJrH3
	yKB9TP/UIAbMngCDEgfYjan8pAPUtFc=
X-Google-Smtp-Source: AGRyM1uNyVanPlALduWeohLKLcX1XXRxAte28tEMeB2sXJRVPQlKW/gLgB+LVWz3P2o5UutD8Nlb3Q==
X-Received: by 2002:adf:d1e2:0:b0:21d:bca6:2371 with SMTP id g2-20020adfd1e2000000b0021dbca62371mr336218wrd.315.1658441949584;
        Thu, 21 Jul 2022 15:19:09 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id s2-20020a7bc382000000b003a3253b705dsm2972806wmj.35.2022.07.21.15.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:19:09 -0700 (PDT)
Message-ID: <6879a0d2-af5a-7d0b-ba8b-f77df901a47b@grimberg.me>
Date: Fri, 22 Jul 2022 01:19:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: don't always build constants.o
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org
References: <20220718051252.231757-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220718051252.231757-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_151911_666887_C9988DF3 
X-CRM114-Status: UNSURE (   5.76  )
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

