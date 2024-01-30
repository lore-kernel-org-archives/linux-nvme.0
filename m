Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3E5C47DDF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jan 2024 10:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Luayi0+bc3tDnFdpI80lX1uZJ5
	/ud1q4yufnIEbSqezmEnstM+XU6194Ypr+Duaiyvc/LSek2SEmy9m2rlBRxRv1u/k3ntnghZKP+vQ
	Kf/nVlr7WgE/1FYfOVkxEHRJsIr1Kz01EA070uu3XQeOlo3yH9dNbJCF4luSZYgsltnfxVhoPByWK
	amALyXbR8/CNMCrbJ2mzO2JRHpA8nX1YbDBJrqVh8/Y7CaFRBaLRiwQ+q4hGrp3i/a08N7I6tgblr
	ddVT977v9DL5FqSv9ZyRoTCNGIJg0k8kUdcDetORpwwLGailnThgFYHRc1Zb7e93/6VVewIzY58zk
	vAPF5wTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkur-0000000G4zF-3fv1;
	Tue, 30 Jan 2024 10:00:29 +0000
Received: from mail-lf1-f51.google.com ([209.85.167.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUkup-0000000G4ww-0YpT
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jan 2024 10:00:28 +0000
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e4e36c09cso987917e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 30 Jan 2024 02:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608824; x=1707213624;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=mwBPkruLaXL5fmOTl5tQ5VCBeATakKKxrXagXLvJCyjsUEwvdRUQC1FPIO21Up5CmM
         a2Nxjp535g6gHDt/mqu+OOUrlTZp97r5DijL40j49dEwMXCjk8CJqo5bwe39A8T8n8DN
         1S0ERxT/YXD416jArO2KU+CU9GE+mcaPY5c6rN8VlbyGS6vFd+3hL78ZTnnumOgO9ItK
         JSSwEjLyq+oXj3Ckh2VW3qDOXIJk37w+FWBXDXG25jmn72uMNjuJ3q4iP1QKFuAk05rF
         NYo44GbMwQJNAKMrYcaZo+JVbTVWeKBvwwskFnSLsmsBgA99Oql/SgW1BjQx3UQmDXOv
         vrFA==
X-Gm-Message-State: AOJu0YzOXnPJRui+q842keg+g5f86UelzVIuo+ICJ9U7DFeM5C1glmPK
	G4LcCXmdcG5eLojNuXaPDZJJwa2mRL4eOzKTcstMlr7z5VQKuvJBhN7K1j1Q
X-Google-Smtp-Source: AGHT+IGHMVlWraFqoxYcv8VuPZmZlXmk0RqhXDeHDuj1iLdtSCCRfovAaZR1rZU+xOlz3+KUaoOepw==
X-Received: by 2002:ac2:5f6b:0:b0:511:19b0:3f1d with SMTP id c11-20020ac25f6b000000b0051119b03f1dmr830092lfc.6.1706608824445;
        Tue, 30 Jan 2024 02:00:24 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bt4-20020a056000080400b0033ae6e9faebsm7422419wrb.4.2024.01.30.02.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 02:00:23 -0800 (PST)
Message-ID: <efee31a3-4d51-4515-947c-84d4db5d892f@grimberg.me>
Date: Tue, 30 Jan 2024 12:00:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] PCI: Support two-pass shutdown
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de, gregkh@linuxfoundation.org, rafael@kernel.org,
 bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
References: <20240129181953.1183084-1-jallison@ciq.com>
 <20240129181953.1183084-3-jallison@ciq.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129181953.1183084-3-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_020027_178841_7E74AF16 
X-CRM114-Status: UNSURE (   4.69  )
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

