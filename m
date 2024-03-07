Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0F8C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 10:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=DRCTvPX06+cRHERDULmeKBdIYQ
	5gwhM1Q2Kx9WNicOuf9fOzu5sKlxKuxNOqPbBDrdcQoypxWP8yV7kpVIbtOiS3KzQQxTMjVNtHH/3
	n+kRT7LRjXo32/cnzjlOQRimPMoxtAG0s0tneOBdaAgsZRY2qwRV44he0HXY2N2tdALW/GVwT/Yq1
	RT0t8MEg5rkA4wcA0jiuS88ABmS4jhk+WxrfsbasDL9aDSvES8P7yXX1RRzU5RwiUOHmkdztv/IyY
	ynmnOSeJLYOUZNpzQJRX9qJQve/mj1tBEUY+wOxhiqgWicPtZYs6CgeWEBCnfpOsCsuggyxz2ty19
	GjiC4UpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBF7-0000000490t-3tTR;
	Thu, 07 Mar 2024 10:44:53 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riBF4-0000000490M-43VC
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 10:44:52 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33e12bcf6adso236903f8f.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 02:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709808289; x=1710413089;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=JvYEA1YkGF5AotHRhqrDowy1nxwPstcAi/cfxcU7rQkww/etCp4xPgQ2E7QA28x3Fb
         jXUE3EJ+Ma71EnlbmCJZ+9VsUO9FhGKy+xrBA3y60l3XPk3xqoBpl49cVBFnKoK/6MVx
         ERVGxtX6mrm20N922y7gj+L4/AcCejDiPZ8Mbh/Jfp38VzZPXdP7dIvF8/KI4P398KC4
         E9KQtlB/Bu1kT27goQJATeuBiefgrhmhGQXr09OFVdOuLIHcsjvgPju83j/x2xULffw3
         7dNHpu6n8nD649jVfc1x0AEzxb3OUwikSgC+mEh9vA20+XUlXW+04e6e4kzIbP/qtDwB
         pTqg==
X-Forwarded-Encrypted: i=1; AJvYcCWmSaA7/VtJggaKxPnIUjPUDJLJanNKOULaEegm63hOz3IOXsJfHOq2Doj842k5F51bzR9WOIhPmG7Vw/qdL1laieqc9hFtzHVZzoJ9XiA=
X-Gm-Message-State: AOJu0YwgMw6d+SNAOLdc/ORcAQ7l41dsNCUd0QOdtXsw2RBYwvIvanpV
	6zXUg1GK7E4o7f46CDwCrOWwAPjFbx4rgjCCwTR3T+sJVrRw3Sea
X-Google-Smtp-Source: AGHT+IFVAVYdpBic0wTHTWSn9zd2eSvKDQ7JXvsxdyrbzjy4uvS32yoKNNZSwQXHCzHGd+paF1QSAA==
X-Received: by 2002:adf:e883:0:b0:33d:9e15:12bf with SMTP id d3-20020adfe883000000b0033d9e1512bfmr4209283wrm.3.1709808289364;
        Thu, 07 Mar 2024 02:44:49 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id dp14-20020a0560000c8e00b0033d8ce120f2sm19910553wrb.95.2024.03.07.02.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 02:44:49 -0800 (PST)
Message-ID: <a98c0a95-c39e-41fe-aec8-ba532739d21f@grimberg.me>
Date: Thu, 7 Mar 2024 12:44:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] nvme: add nvme_auth_generate_digest()
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240127093058.15699-1-hare@kernel.org>
 <20240127093058.15699-4-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240127093058.15699-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_024451_008667_1D30AC88 
X-CRM114-Status: UNSURE (   5.39  )
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

