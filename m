Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19110C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 06:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WuUwuh2UJHrwkV+OnAKpQKGxVWCdiyrhfp2L4ViXtE8=; b=o/MshAg+B0o+zON0GM3wmnPy7S
	MmJwsPd+6pOI8xuExVWTzkyZaxwpEp2gC+gKZ9MLPY5LBR2daufZ1gnaK1HmWBFhGv2EEp0+H3tlu
	uJmWWo9i9/aKobRTDgGc6kexMGffEcXUuar+trXV4ATxjt6pVmpAMnnbNPVnGs/WWOH0IIHVlXDT+
	9a/e6WZZKNIlqMvVx/++F7IxdQdVNwaDrJ6TYESJQStDqDThUGWLTJA8fT2G2pAXzFXBxBkcx9cis
	sLqTnS1Mgtr7giMeGdAUeYpmBUe+3ypfi6yb3CcQ97xMpRrkT73b8gydXX+cqxIl1Lhfxj/EnXRo0
	A1/gg1og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngguS-001eEq-6B; Tue, 19 Apr 2022 06:00:20 +0000
Received: from marcansoft.com ([212.63.210.85] helo=mail.marcansoft.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngguG-001eAV-JZ; Tue, 19 Apr 2022 06:00:10 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id F1035419C2;
 Tue, 19 Apr 2022 05:59:56 +0000 (UTC)
Message-ID: <e2a6dc4d-0e8a-c4d3-fec3-e8b0b874235a@marcan.st>
Date: Tue, 19 Apr 2022 14:59:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: es-ES
To: Christoph Hellwig <hch@lst.de>, Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spdx@vger.kernel.org
References: <20220415142055.30873-1-sven@svenpeter.dev>
 <20220415142055.30873-7-sven@svenpeter.dev> <20220419053157.GA31530@lst.de>
From: Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 6/6] nvme-apple: Add initial Apple SoC NVMe driver
In-Reply-To: <20220419053157.GA31530@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_230008_836973_45643B01 
X-CRM114-Status: GOOD (  12.40  )
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

On 19/04/2022 14.31, Christoph Hellwig wrote:
> On Fri, Apr 15, 2022 at 04:20:55PM +0200, Sven Peter wrote:
>> +++ b/drivers/nvme/host/apple.c
>> @@ -0,0 +1,1597 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Apple ANS NVM Express device driver
>> + * Copyright The Asahi Linux Contributors
> 
> Is that actually a valid legal entity?

It does not have to be. See here for the rationale behind this style of
copyright line:

https://www.linuxfoundation.org/blog/copyright-notices-in-open-source-software-projects/

TL;DR name- and year-ful copyright lines are basically useless, as they
become out of date almost immediately after they are applied. This way
we acknowledge that the files have multiple contributors (and that the
copyright line isn't trying to be an exhaustive list thereof). This
style is so far rare, but not unheard of, in the kernel; there is prior
art (e.g. grep for 'Chromium OS Authors').

(I get to re-tell this story every time we upstream to a new subsystem;
I think it's the sixth time or so :-) )

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

