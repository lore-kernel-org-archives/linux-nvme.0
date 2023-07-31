Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12108C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 12:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ne2X0ScI/iNvfYw0dOQwSVen1zftEdtKusxtCcGTGuY=; b=vkm7MEoDxEdffmjHzvJYoEISBr
	yUGtoGo17iijhOXDhss57nL5Y5Hvr/WIJ1QQ3g1+JrPZBVpr7PpFfqKDaX5LT/4HUwQGBdm77gmvD
	BeNMHduP7hRqXxyjfaN/mw0uaiLkIqHyZdLdQKraw1iaIuvHRs6nKP1FZW57YDPedOXOCj2fHyVJQ
	3jYysTYQz+b4enGtNrv+TlnLVYGs+V7Ema/Icuy9ckPLHaDJ7BsJu4JCHYuBlmfSvn0KwXo7PC1Ry
	cYva0cUeZHaqzEDSgwqCVX8jaXXxdJmHOS1ZzCVYMhmbmezrl3zvrFqo712X+HOTOnaAAaFFfaqJl
	5WB9D4Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQRa4-00FU3O-0D;
	Mon, 31 Jul 2023 12:00:56 +0000
Received: from mout.web.de ([212.227.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQRa1-00FU2I-0S
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 12:00:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690804838; x=1691409638; i=markus.elfring@web.de;
 bh=Ne2X0ScI/iNvfYw0dOQwSVen1zftEdtKusxtCcGTGuY=;
 h=X-UI-Sender-Class:Date:To:Cc:References:Subject:From:In-Reply-To;
 b=JAoMPtNOd3CYEM4kgiSo9T6eUlWApsL1Uqt56dTyqa5cSM/KZ8tyK32zZmScbXTxywudNRQ
 BhL6AtZan0cY/TK7YIG5VcI2gXcSN/aBTx4y+0gZmVBp+8VJkb6/uof8Hlvz8VkCPQ43I/7Kf
 S5iz8XD5zwCLKYF5ngkK53SYHowY7ErYedAM/C4pkjZzT4wUdiz960FeKcSAWybbRf/DnynmG
 AZqkXmMBeR+51+ih6g4zLt+ImxjPmpgxI1KOMjimP1mzCbfdJhj8+L++uFzDpA289gFhRCYSr
 ZLRaJ2pwkBKz4BQ7sJbc+TCiZZgMsE3Pk+XMkznXNCzNaqqIODqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1pnJyy1Vpm-017x9C; Mon, 31
 Jul 2023 14:00:38 +0200
Message-ID: <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
Date: Mon, 31 Jul 2023 14:00:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
To: Mark O'Donovan <shiftee@posteo.net>, linux-nvme@lists.infradead.org,
 kernel-janitors@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20230727134748.4163796-1-shiftee@posteo.net>
Subject: Re: [PATCH 1/2] nvme-auth: unlock mutex in one place only
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230727134748.4163796-1-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:iShlFSjBrrXOnrwhWmcBvS+/YT70Xqjgu+boPNio5H+jwx0j1WL
 JzgRuB/W0yKyB685E5xn7DStrOMIG9KSzbTPxF8bU8ZltyI9nI6Q91x6n/1ByLVI//pPzTU
 B0cNaBDyZk/VCYtQaWN+LvhR+UpSH6sIlzvJZtQO8ExNE8Yg3x5nX9vOH8ZL/AcbCr7/ABH
 ql0t0NAn/1jC4xunEm0Lw==
UI-OutboundReport: notjunk:1;M01:P0:o6Xty/0SEN4=;f0wld93JH8Vulca+0xWKyFtVJkZ
 6qkBFGUXD0GSb5x5JnqjTgOX5p8grG8IaV4zQ5ciBTSSh77JlhnORiyBNET1hG+R6AqfuLIZs
 dOfWH7WDhea9b/2/yRLQzgXvbZCr7TTBMjO4YTO1wmsAo6iWws+BCOJHBswTMuAd5Mz+R/vEm
 hDxY3DDcJLMRfHk+Qt4seLYRt+osKK8AQekS63gMx6eqjX64Erc5J3sa01ORaQiUdWwSsCE79
 LOQYsPZL3d8M0evbTRjw6lm039pDQo5bxb8yCGUWSt7HPHW3c7V0KpmH/51ZXUQHOtINXHyzU
 QPkRHl9SR93e/h20m/6oJIm/T48CQ7AFrQIQvHD9UAvi48cxe7kyafeqK9yukriHwnBAv5Kk/
 CzE+BAWzfEtuJy9BTJWq6ixZw/DO7iLMCKnEQhjz9DhKaf6mlmJd+dw2znD3WaATGYxo2l/t8
 qMFv93x7VQLfbGIMGTJLNpgOVaV/BKlkDFMyb4bU7MQksn/nhcVzHvbztRZSNNeMCHY6sEiaM
 Y6xD8Ycdk81ZKTeyrv/K12D+cju29DRE8iV/oCHqokcILTfBHWlMJBxWE+jHrsohZX00HZbOL
 7HY739HlheQFJWC4jDWaNA6nJjkagdVbrCcdgHxevsz0ie0f5OxQwvPZpB7a+7GZ3QJOMq+6J
 ys1vrL3eUrr6DtOKamZrxwvD2VqZJjl9hsPEo8KsrDcDwMix06dtNn68SMAP9JDx8OmvXbESe
 6TT5Xlkou7DrMOPhcQRac7E0vN7VQD0dLTnqlpDciohhwYbXl1keMj73bFpJtNtOS3Oe3/uax
 7dmVxSHoa2HMtmGCg2Zr7414JlnPq/pk8dkIxrDT8GFMyFZz3uKFR+DU5cNHUUQSMBuePWIIK
 Uf/6Cwkyx+/XPEitXKnWKVkvlhY7KY/rh//05BQboviQD4UThDaZWEan9yzzOM11EUr+JzYps
 I41wDA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_050053_623118_5CE39153 
X-CRM114-Status: UNSURE (   6.27  )
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

Are imperative change descriptions still preferred?

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc3#n94


Will a cover letter become helpful also for the presented small patch series?

See also:
https://kernelnewbies.org/PatchSeries

Regards,
Markus

