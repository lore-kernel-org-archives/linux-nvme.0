Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB95C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 16:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VszlENjCJ3QQ5KvFIeSsfGOEUhb2i0XX2RaQ3R5pOdc=; b=wO6VwY6n8MtfYFJSgiAbqTbGem
	+SmYTs5SOuREtxFyGZG1b0ylYR/nW924gD6wJakLt3KvGsVzZvWfeZZXXVhn9QwHqFtknR1HE15Ej
	MYj6jjMcEeCKhhhZjXWAq/LhylbAw1/CK2v4Lddw6CtkBfb9Sv45h5VEM5nXud2OD12xU79CgkNEY
	n3c2tHg7iNpgYlcADxkFqP1k3Qy0cRRJ44sdUWRIDIaYkN822Ruikz9Ry6LIOGnTTi1t0ylw632gi
	yjnD0DOu38bWveo+wpwGdXzVpvP7MCuHATpESJRsasXAiMN9DUCTh2yvWMeb/MQj5jzBexylQl41H
	E2lQOBAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpYaF-002rOe-Vx; Tue, 23 Nov 2021 16:23:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpYaA-002rN0-B2
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 16:23:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AC27168AFE; Tue, 23 Nov 2021 17:23:43 +0100 (CET)
Date: Tue, 23 Nov 2021 17:23:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-tcp: fix incomplete data digest send
Message-ID: <20211123162343.GE23957@lst.de>
References: <1637575721-3055-1-git-send-email-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637575721-3055-1-git-send-email-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_082346_550179_E7E0C964 
X-CRM114-Status: UNSURE (   8.26  )
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

