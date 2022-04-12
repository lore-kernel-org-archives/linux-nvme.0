Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F29C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 10:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xikeLUM0UGFCmj7TulGNqSKQ0G
	4mzZbOVBDchKkOy4cuC/2Hy872RejiLEMYmj77ZLtpcD88gAQH5gP5WoZFN3C7gwVVGDAVDfxHRvM
	wOf9o4LjTeFqpvzslkz8OnFWdU4F/6FlOYdc7Hs+zm3mGpAmimnQdfF1FA4U76LWZouyJ9ETIMxO7
	ullLqEGfrkYNICWg7gMu8iScv1tJhTmNopvm00VhGnx2BpIDI/TsClSeimvqP7CvbrDnokAC7CP0F
	TvPaDtE4pAWcE/2c7lEjQMT1/aanYoEl5oLp1qMuIPfjQeIsV6QITr6aMOXSBc4+TXOUNKX3R7DiP
	4vX35rxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neDiQ-00DHRD-37; Tue, 12 Apr 2022 10:25:42 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neDiD-00DHJi-Ol
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 10:25:30 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 v64-20020a1cac43000000b0038cfd1b3a6dso1423190wme.5
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 03:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=F8ma7XVHEiAuqGBe7S7N8bwsXDbA20eeWEtC6ih903hy+7VyyZqz84FWv3vH2K1oWT
 grq9Zyy+wORYLKNwiOBfIAk+ExECNMNdnMrfXkMJVxVdWgbm2Hgb8TmYgT3AjPejl9sv
 71utHUKKu+ePRhO5Yv69kiPYk3rySkoUMsr16bGao8vPacaLPP4RxnjJm+i3R42dNK5a
 G5ss5jrHC63xwfDqQc4cxSuvrV8VLGcRC/ud5TpRjd9Rk2Ni6ykB9z3dA0oNvUCEOKLo
 +74/idFXVbew/gdKcUBH6C/BaiqRToNuW+c+mGnmGJQU4VjJsCmoxf9exkhuvtl2prHX
 ERLQ==
X-Gm-Message-State: AOAM533KaRZdZLf2/eFWDm8K3rNYsy44KBr+0kHgz5drNHP0DYmculLq
 qSvLH9hLCZe1PlB59pZCYqBI8dSpgoo=
X-Google-Smtp-Source: ABdhPJygBpRMeNf6wy2ifShsWc1NhVeD8/zdu/N9JBOBFICk7UPLFoUygpFgO0iyyVaFh8Jbh98kOQ==
X-Received: by 2002:a1c:545a:0:b0:38e:b1d6:9184 with SMTP id
 p26-20020a1c545a000000b0038eb1d69184mr3419884wmi.32.1649759126333; 
 Tue, 12 Apr 2022 03:25:26 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 w7-20020a1cf607000000b00389a5390180sm2001951wmc.25.2022.04.12.03.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 03:25:25 -0700 (PDT)
Message-ID: <093123f9-c8aa-36ab-c213-c85bc9ad24cf@grimberg.me>
Date: Tue, 12 Apr 2022 13:25:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-4-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220412061126.244414-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_032529_847082_DE1DB888 
X-CRM114-Status: UNSURE (   7.50  )
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

