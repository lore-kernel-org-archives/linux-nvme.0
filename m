Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4725FC7114A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iFfxD7oaGsRaQSy5iJb7YSpPoSeZaiRMZ9ZmlFQYpP8=; b=XMo2TP80xcJFWlHLgO26JXf25d
	SWnDcUBLlg74qRY35BkCRBitxiFFbxOqwIqw06zK81/3EZqBl3+FxgHlKH6BKbRNFGApzyzQxu4JW
	k0gSMch7ncRa2r9WFFBGU9e0nbxQSy8fw0t7vW8Is6zsC1v7vSrZEoUqOr4fKCGdFzH9Xr6jWek8o
	66WlPhS3q6XnzIiwt/FC90PyREfVOBbkxzX9pZMP4DzOx+JdbJyC7PZnfq8cEZBrd/65amj4N5BNR
	9MCqzjY/02yIAJVvGHLCa0m1ik7zflmcd1p3LwlJTFrCjiLfeWH/ZjoJDDJYagwsE2M+svhWdT+Ka
	gTeAY/iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRON7-00000006Cyp-12Yw;
	Tue, 17 Jun 2025 04:56:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRON0-00000006CyG-2dNz
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 04:56:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D617268D05; Tue, 17 Jun 2025 06:56:18 +0200 (CEST)
Date: Tue, 17 Jun 2025 06:56:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
	Alan Adamson <alan.adamson@oracle.com>,
	John Garry <john.g.garry@oracle.com>
Subject: Re: fix atomic limits check
Message-ID: <20250617045618.GA2148@lst.de>
References: <20250611055432.2401372-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611055432.2401372-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_215626_813033_C4BEF82A 
X-CRM114-Status: UNSURE (   8.04  )
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

Can I get reviews for this so that we can queue it up for -rc3?


