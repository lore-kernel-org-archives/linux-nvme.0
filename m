Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C7C636CA
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 15:04:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D09E26113D
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 15:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D09E26113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chronox.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l3igNh4wljnT+g0H0v4j/Zme60suJ27aoFwExx4yFhU=; b=KFDyOYbTqL1+0o
	zwgVFeVp9x5kz8ordEwBHQSf0QSq0brOUoLrSX6kJjfKBgiF9lVwx/pqLHS084Wg6v+zGWCA7VHro
	8gEyLuZ6uFwJ3/q7xTZxuIWhYelFmZvft97knciJm9MNB3FOgLq63KZwJ4rl/DKgtxChEhGKJw5X7
	mxt0hDbIeZDuSGSSFqrGOcpnK01BHjTqaKLtkpDcDsspHZn1o34R9BGp1kRwZ1JLHvxq/lkwRnEyt
	ZJIi4vB6jFejfNWiK94HCUcGHic3p/NlRI72pAFO+ZcCkcKyuUstjWxfGTzDo+pLIVffBWGnsFw/D
	YrdVlyqMPT5vlpSPW9wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4lr9-006k3A-Cd; Sat, 17 Jul 2021 15:03:55 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4lr5-006k2a-P8
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 15:03:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626534208;
 s=strato-dkim-0002; d=chronox.de;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=7WJUP7CO371Ox38MLS3F6Pu/++9FjOfLN9lRQi3hrS0=;
 b=fhIgSQhlyEv7Y3ASIp1IWSiIQDJz/w3kvFQNMjYiIClN7mSXQ6Y3gerLG6EIwtE5fq
 qUVrDtGMi0JvXlWKv32dUiUYMD3w98w5Gwm7u7xkDqUi42JfnoL1M5u/cuQjYm9ll/em
 82TigQ4h3N4Ls1DczcSqUPpfm0wBacohxrgLSSFhH1KMLaKvweWESlwSHur2zXoToMGg
 zRz2gRqEARmPaW0N455fFi18wTC/ZnC5uzMXsIbf+qvzVl8c1BK0QyDsAvJ/69pGcfPF
 MoxB21fEeozwV9BzqefRtCgtus6jCIUaUBtOCg/ksoUvggI+VKn/fLRk06Vyf2IInURe
 ywRA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPaIvSZEqc="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
 with ESMTPSA id 9043bbx6HF3RC9v
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 17 Jul 2021 17:03:27 +0200 (CEST)
From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/11] crypto/ffdhe: Finite Field DH Ephemeral Parameters
Date: Sat, 17 Jul 2021 17:03:26 +0200
Message-ID: <29491463.gfxVf8N7Et@positron.chronox.de>
In-Reply-To: <20210716110428.9727-4-hare@suse.de>
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-4-hare@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_080352_057645_15EDCDE1 
X-CRM114-Status: UNSURE (   5.47  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Am Freitag, 16. Juli 2021, 13:04:20 CEST schrieb Hannes Reinecke:

Hi Hannes,

> +#include <linux/module.h>
> +#include <crypto/internal/kpp.h>
> +#include <crypto/kpp.h>
> +#include <crypto/dh.h>
> +#include <linux/mpi.h>
> +
> +/*
> + * ffdhe2048 generator (g), modulus (p) and group size (q)
> + */
> +const u8 ffdhe2048_g[] = { 0x02 };

What about using static const here (and for all the following groups)?

Ciao
Stephan



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
