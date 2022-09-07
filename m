Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2946C54EE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Sep 2022 12:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHUUK7beoCDrD2jFmK3WDA+beuDUZr34Z9gNGBPS0BU=; b=wbB1+W4ADtIPV7vbKg53DG63wA
	Oz8zjA0T6WYfSe7NsrvSyzBmzNobZyuFCqtEkpBIdhvFZUQVt/DGUihOMdjCyuZ7Ex1ZeHF2Lqav2
	T02+D20hmqrHKYUHSveec0fD2Nu2/VZqdlcqY8kzfGDvpvJu7ZXRuorLXrz3nfWXe19scCAv3wE9K
	0ZeFA9w6w6l1JrHfjpyKhxpaQNZ6DIRW3wDYfm95wZ+OKQ+UBPzbQ8Ggy/yTHNNN1+DATz3XpxCYq
	j/RbbKFEII0R1Hg80AYZqFIKx+LlH6H82VPUXd/1BEnE0dz1GIX1zVtAOrC49q4la1u2ac6yRJDiX
	+stnDR4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVuGF-0068u1-JH; Wed, 07 Sep 2022 12:34:31 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVuGA-0068p6-Jf
	for linux-nvme@lists.infradead.org; Wed, 07 Sep 2022 12:34:28 +0000
Received: by mail-wr1-f41.google.com with SMTP id bq9so7260347wrb.4
        for <linux-nvme@lists.infradead.org>; Wed, 07 Sep 2022 05:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IHUUK7beoCDrD2jFmK3WDA+beuDUZr34Z9gNGBPS0BU=;
        b=FBi6uDovGE+Tj15Gz5sprZPhZNhXIPUvSdhYyCIGZwus9A7no72MMxdqE7VBo00b15
         YLy4e1b/MER2NY622k4jXy4tdqHhyWejuwrr3IqQGy64SqXU0NfvQCOfkR5xGGf/y9H2
         Da3U4uvJhDSzFe6prEqWSIIC9gh9AI6erDEFpCkcA5I6darwSnFX81eQvhhlLsekOKe/
         wz4rr1bC7f4dZbV380fqHeTfCvlOjmCtdZD9jPh/L9CYaKcS5AY7HWNYz5SybbpC0abB
         rapKZzyZ4QMawvd5YfQAJ9fxEUOh6cH3/Ie+urZotLeIZlJZIQU4L4GuFJ81HH3QV4KU
         6FTA==
X-Gm-Message-State: ACgBeo3cqhnxPdbYA/ZYsURJtrgx8K8UbzliLHIozrPMtKa1NTVaSFR0
	sV93PKWBZy7RZcvRUJpHrO0=
X-Google-Smtp-Source: AA6agR4wLQW7dtCpR9Gg8nJQNsRYuycnoQk0AyjEL/QKRdATPfo47Vttlulr/xROmlbxeRbpx2muDg==
X-Received: by 2002:adf:ea05:0:b0:229:9c4c:ec78 with SMTP id q5-20020adfea05000000b002299c4cec78mr1191200wrm.213.1662554063872;
        Wed, 07 Sep 2022 05:34:23 -0700 (PDT)
Received: from [192.168.64.104] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bd17-20020a05600c1f1100b003a540fef440sm26671091wmb.1.2022.09.07.05.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Sep 2022 05:34:23 -0700 (PDT)
Message-ID: <facc31c4-955e-c82e-191b-150313e73f6a@grimberg.me>
Date: Wed, 7 Sep 2022 15:34:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rdma-next 4/4] nvme-rdma: add more error details when a QP
 moves to an error state
Content-Language: en-US
To: Patrisious Haddad <phaddad@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: Israel Rukshin <israelr@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, linux-rdma@vger.kernel.org,
 Michael Guralnik <michaelgur@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20220907113800.22182-1-phaddad@nvidia.com>
 <20220907113800.22182-5-phaddad@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220907113800.22182-5-phaddad@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220907_053426_697058_86935B64 
X-CRM114-Status: GOOD (  12.00  )
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


> From: Israel Rukshin <israelr@nvidia.com>
> 
> Add debug prints for fatal QP events that are helpful for finding the
> root cause of the errors. The ib_get_qp_err_syndrome is called at
> a work queue since the QP event callback is running on an
> interrupt context that can't sleep.
> 
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

What makes nvme-rdma special here? Why do you get this in
nvme-rdma and not srp/iser/nfs-rdma/rds/smc/ipoib etc?

This entire code needs to move to the rdma core instead
of being leaked to ulps.

