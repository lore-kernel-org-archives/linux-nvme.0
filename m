Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0B5C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Apr 2022 15:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tq+S0ZwW64kEhUV42u3bffx/awLpgBYauKTSsN+kozQ=; b=W9xD7RAymGQQpN5i7hwHQ6h0nj
	D3b2RKsVFodrIqXL/2oq8LXHr7w3BLFxj3MWV9vVeTjM7d6iN1XEhH39A2FRBpHEs/3YtbcJOXmfp
	QWuXB6cubJ3+xuoaDb+EAeAhs6rAWrHeN81ekq2iLoYC8HrBAWp6xPnEJiZ0w9KxhSjO3p2EWHGyF
	3D1pOSM/2pSqBtmDz1jYT3VecQ/EUZkiE+rnt9I+xOrRRlPhnGhfwJ6p9rsRUAvsTqehpIUW8tCNC
	Wk4CN+RWp+3/ApFt22RKFTcD8loqYJsD6a3UEbi4lBnxvSlLRLbpEUaKvVSypVwjIHyW35maMKhpa
	xs6pvCng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nbP5p-00FeHY-UK; Mon, 04 Apr 2022 15:58:13 +0000
Received: from marcansoft.com ([2a01:298:fe:f::2] helo=mail.marcansoft.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nbP5P-00Fe1C-TJ; Mon, 04 Apr 2022 15:57:50 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 (Authenticated sender: marcan@marcan.st)
 by mail.marcansoft.com (Postfix) with ESMTPSA id 09EA9419BC;
 Mon,  4 Apr 2022 15:57:35 +0000 (UTC)
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
To: Christoph Hellwig <hch@lst.de>, Sven Peter <sven@svenpeter.dev>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev> <20220324061620.GA12330@lst.de>
From: Hector Martin <marcan@marcan.st>
Message-ID: <18f3a7e6-16d1-2037-90e7-1c0b1b2fbb1c@marcan.st>
Date: Tue, 5 Apr 2022 00:57:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220324061620.GA12330@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220404_085748_122006_E1C69660 
X-CRM114-Status: GOOD (  16.05  )
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

On 24/03/2022 15.16, Christoph Hellwig wrote:
>> +
>> +//#define DEBUG
> 
> This should not leak into the driverṡ
> 
>> +#include <linux/blk-integrity.h>
> 
> As far as I can tell this driver does not support metadata or PI,
> so why is this include needed?
> 
>> +/* NVM Express NVM Command Set Specification, Revision 1.0a, Figure 18 */
>> +#define NVME_OPCODE_DATA_XFER_HOST_TO_CTRL BIT(0)
>> +#define NVME_OPCODE_DATA_XFER_CTRL_TO_HOST BIT(1)
> 
> Please just use the nvme_is_write helper where you are using these.
> 
>> +static int apple_nvme_sart_dma_setup(void *cookie, struct apple_rtkit_shmem *bfr,
> 
> Please avoid > 80 character lines.

The kernel hard limit is 100-character lines, not 80-character lines.
Maintainers for existing drivers are certainly free to stick to 80 chars
if they like it that way, but I don't see why we should still be
enforcing that for new code. See bdc48fa11e46.

And also:
https://lkml.iu.edu/hypermail/linux/kernel/2005.3/08168.html

Quoth Torvalds, addressing you personally:

"If you or Christoph have 80 character lines, you'll get possibly ugly
wrapped output. Tough. That's _your_ choice. Your hardware limitations
shouldn't be a pain for the rest of us."

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub

