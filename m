Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24E9AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 10:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=UuQFLMwL5Ynpu+Sro0VoJnm1mr
	YNVAjwURvroOxwJwomeIhTjz+OMOx6Q5E/TP7i9mbHZYkfKD7WpZw5LQUIZ00PEvbwZ1HR/C9BjZx
	dTctcmML4m1TfxVSRW7JkR9gQfe7+uHMZNFBvIUek3dJLLF2zah9365M2Yp8usXHFXxDFCrhyOPqF
	rFe1nVHz8GRfwG9OOx5u5hnymo46MkFeACZuLN+uO5zn6qbcEva/1sKkBbr5jrzbOKkNQlClvFSiT
	DFBu4SmknTlLxU1IQ/aXpQDhQTuF6tvDsy3ulyR3Zyp1CbqwCJYoJzeGu26115yeeUorHglzHm68P
	FeO5IF+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neDiC-00DHK6-52; Tue, 12 Apr 2022 10:25:28 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neDi9-00DHGn-7p
 for linux-nvme@lists.infradead.org; Tue, 12 Apr 2022 10:25:26 +0000
Received: by mail-wm1-f45.google.com with SMTP id q20so11662116wmq.1
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 03:25:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=nSakOV0BmI8tKjrnUWyOnonVd1wrY9pfhtMy5OCbp9nyGHY0ej6STqrJLU4jxu3cNh
 LjVKRwsk1pD7mqS5F+zwK3/XbZitkd6BJd6dXIO7/6J90n1ZgFTIEnfuzN5KKZbbG+qh
 BjXRYmRilnyDDmD6Q2QCXjV3UbP08wqKg0dMPGiS8QoWTsK5XmkurLKTtQ8+HH6RkTyj
 zTxJTFUPf7MmOCCJM1lhKFxyx72UBxD05YUWbo0J95QM/gklQHRfnUPKTh6CvalHh+3z
 mQAEWcSxZqpTHSWRuVm7UfaIPrFx08M6hCV2e+N6iW70RFHCyPVkIcidIQZpSt7wdeaN
 CGEg==
X-Gm-Message-State: AOAM532V+xSK8E5JRspIamnuG3aV9xx0POIpdLbhPMK1r4nCwGQvQall
 D0XX5zj6+H97O8Y5n7nTU6kmHsOfCTE=
X-Google-Smtp-Source: ABdhPJxGuGDlJJAPUxUUo6W13JAbGie1fsNVdlZgTX+8xceDZH5iJYReKOxAK+rkboLMJUjvm4voIA==
X-Received: by 2002:a05:600c:3ca4:b0:38e:54d0:406d with SMTP id
 bg36-20020a05600c3ca400b0038e54d0406dmr3346497wmb.199.1649759121096; 
 Tue, 12 Apr 2022 03:25:21 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 ay41-20020a05600c1e2900b0038e75fda4edsm1918992wmb.47.2022.04.12.03.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 03:25:20 -0700 (PDT)
Message-ID: <ee0d3f0f-85ac-f66e-be92-6caf8bdb6736@grimberg.me>
Date: Tue, 12 Apr 2022 13:25:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/3] nvme-pci: disable namespace identifiers for the MAXIO
 MAP1202
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org, =?UTF-8?B?6YeR6Z+s?= <me@kingtous.cn>
References: <20220412061126.244414-1-hch@lst.de>
 <20220412061126.244414-3-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220412061126.244414-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_032525_305257_5D280C28 
X-CRM114-Status: UNSURE (   7.22  )
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

