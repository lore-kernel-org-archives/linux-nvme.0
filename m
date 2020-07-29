Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C805C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:22:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A317207F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 17:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WsnAROc3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HlADSP7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A317207F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ejhFOvRPiOrDH2COpOoTRImOPmMAvJBwxD+E1P7MTO0=; b=WsnAROc3yUVmVpNc2LzLG6VCM
	BhfNDqDxhLVaATZ1ISZ2M+L7lW8DFu/mVgp2MnD6X5erNrI6EkKULY22KRfNN7O/OAkoghVLnjb6q
	7DNpWwG+uYWWc40gQhqXTMMTW3Ugi1Wk0olpU2LFnCljjgcWy824U0KMCHHZ5zKthRiyVcZvXq+HL
	/DCUWHbEzt4pD/fkHUyGee5gI2ZAp42WZVzkYs0ASNO9Dr9IwEi8RIa4R3tUZNbKgZ2XGtHKJMfyL
	QlsXSxh29oiXj+sBSnKqGYc+nfpZtHs+BKGsOW0jdOSY9q2nN0Iq5IPYX3PscFCGZ20z+7Nxxx0B+
	3s3ySuzTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0pmd-0007Zc-RF; Wed, 29 Jul 2020 17:22:27 +0000
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0pmb-0007YS-TN
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 17:22:26 +0000
Received: by mail-il1-x142.google.com with SMTP id b18so14895356ilo.12
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 10:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=W7fvMYge5Q1Ta5p3ZvTDXHqTSeNclIrTI36qUUMcAyk=;
 b=HlADSP7HKrDglShgm+sXTufnPs0+oLEn6CDyQVp7hr8PS5qbFk5gR4foanrAE0Kzs9
 e0jKxzLT03vgXhTHPyj9LKaFHGS+9Z4w1PzWAB66+VKVxZUmTz+GghMqxEYiGPVrvg7K
 jdV/762jk/s/4tuUzynFFhA4wFRkIfxAAX9avl+dhE7J5IWdYspYmaJSr/ahm4udBsdU
 6/NlBUE1chWWBddh/fVr4Rea1ZtVJSw+nDNTq46lEIWZ4WsBo1FEdW6AKerm2EQl3san
 R0khvOFoKkrk655BHg21o/iTbBvaJ6VVN9qtbtadYckGXx7sKCBi5ZGPJH0moYRRhj+R
 gUoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=W7fvMYge5Q1Ta5p3ZvTDXHqTSeNclIrTI36qUUMcAyk=;
 b=dl4S83uxY6APbzsNYATzexJuCcw8ow3qAKuLNgiq60TZ6KPPcKgkZZBIUOfiU733qe
 DgW8L8AAdeXezmlFG5WxVOqPJyHtxCJvxpPvuW+opM5ZrMImOKUeGPpypcDsTUOXuX6D
 Y0l45VBdIiWf4/ddUgWU5CSlV3oY5/WWLmQewJp0sr65XPYVL0upHm0n10PLX6ObLU3Z
 AoJn4HIZjUYF5laz1+op1nXbV1t2U1qVglrsKVNUDOxfeRGE46B7XtM/qAJYgcgs9wRr
 44VUtq7OK7kFOz8Bk0ctsWvL0SYUsR5nNoTMQBRla3SuBvEVnJQuB1tYcspg8EuShTIc
 zIvw==
X-Gm-Message-State: AOAM531hqdOpjW9GJW+c5TYT685436b8Mnw0ux+PtwbtNLaBjgNDG4/7
 TuxEvDTY6N5Nx/sSkv1SRREH7phtVIk=
X-Google-Smtp-Source: ABdhPJyMl252WFz9msu4K9+BvPKZAA/tJsIfTjb1igEHkElhCA3ASMuGm3q8N4FB7r/ObCgy9uvIDg==
X-Received: by 2002:a92:bb84:: with SMTP id x4mr36499223ilk.177.1596043341266; 
 Wed, 29 Jul 2020 10:22:21 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
 by smtp.gmail.com with ESMTPSA id d16sm1521944ill.47.2020.07.29.10.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 10:22:20 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for 5.8
To: Christoph Hellwig <hch@infradead.org>
References: <20200729170952.GA21060@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fa539a99-31a0-81cc-0d7b-3952721b2b22@kernel.dk>
Date: Wed, 29 Jul 2020 11:22:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200729170952.GA21060@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_132225_968124_E3984FA5 
X-CRM114-Status: GOOD (  19.21  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/29/20 11:09 AM, Christoph Hellwig wrote:
> The following changes since commit adc99fd378398f4c58798a1c57889872967d56a6:
> 
>   nvme-tcp: fix possible hang waiting for icresp response (2020-07-26 17:24:27 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git nvme-5.8
> 
> for you to fetch changes up to 5bedd3afee8eb01ccd256f0cd2cc0fa6f841417a:
> 
>   nvme: add a Identify Namespace Identification Descriptor list quirk (2020-07-29 08:05:44 +0200)
> 
> ----------------------------------------------------------------
> Christoph Hellwig (1):
>       nvme: add a Identify Namespace Identification Descriptor list quirk
> 
> Kai-Heng Feng (1):
>       nvme-pci: prevent SK hynix PC400 from using Write Zeroes command
> 
>  drivers/nvme/host/core.c | 15 +++------------
>  drivers/nvme/host/nvme.h |  7 +++++++
>  drivers/nvme/host/pci.c  |  4 ++++
>  3 files changed, 14 insertions(+), 12 deletions(-)

There seems to be more here than what is in the pull request:

 drivers/nvme/host/core.c | 15 +++------------
 drivers/nvme/host/nvme.h |  7 +++++++
 drivers/nvme/host/pci.c  |  4 ++++
 drivers/nvme/host/tcp.c  |  3 +++
 4 files changed, 17 insertions(+), 12 deletions(-)

In particular, this one:

nvme-tcp: fix possible hang waiting for icresp response

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
