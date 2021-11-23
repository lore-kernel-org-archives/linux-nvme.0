Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D237BC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=zl6LNjRL5+qndwqH8EMDnNKYCJ
	bSHYYzxzv8lbiuuQ4VITRgK3miw2eLrt6cxW5n2RuBfkJyJNPHDWs6njMiNdF+IbBtuKF4RGn/JkF
	XM0BhtwapCzsTMrzMFuInunzNJS0y8HmPL50rvp4mE9RM7dHY2KJCEktVoerShFuxJ8hp6Ew4SHQ8
	DDbd8JnBjGZcjFzDZY+eNzrHgDkIAErDrA2Z2EVdHxww8V+qJoCDe9g9muC7FEbY0ss+xCf8FICMl
	Ch7jO9+G8FIw+ktG+rxa4JVqTjLPdvJJWYmuxbmHWr3+vXQUKj/jvuPorQmD3fAyEFJwep6oSW224
	AmhxNgeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYaW-002rTh-Ax; Tue, 23 Nov 2021 16:24:08 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYaM-002rQU-Mo
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:23:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0C1C468AFE; Tue, 23 Nov 2021 17:23:56 +0100 (CET)
Date: Tue, 23 Nov 2021 17:23:55 +0100
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
Message-ID: <20211123162355.GF23957@lst.de>
References: <1637665136-3563-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637665136-3563-1-git-send-email-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_082358_913776_57F87C56 
X-CRM114-Status: UNSURE (   8.57  )
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

Thanks,

applied to nvme-5.16.

