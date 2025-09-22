Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F186CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3SaxZpvGgtf+z81ZuzC+9CirM/9zyIobI0pH9dpmM8=; b=pyw/u2ouRst3RG6GV0m1HgdUT4
	IObGSjiSMJ4UySmO2Lj2sE/D0qUk+kvexN3lHySTSfSUl3fHaDuF/9oODTFgECwxuMJDI0dYB2LEe
	j5spwQszndh428qsQBF7JbpLgU7fWJhLxhv8Ame7poTguArMjU6fzM9UKoKLO9kzsHRVN2rxcDive
	87XZxuuyXRuQmP9LjqCsdNS4b9UU4Rp13Srq0V+RmKS1Ayl3TQD+hrVkZLyuK6tWdiD7Hqt3e+P3L
	TOFFcxQHjncPuTQCvG7mQ1H8cnlOokhQ2/Y3i0PKvq2pCKGeuWNNCqHkyKrsv4yU/cdxMU8mEoUsC
	UlqwcVDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kY0-0000000BAIP-3wUu;
	Mon, 22 Sep 2025 17:41:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kXy-0000000BAHs-3V2V
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:41:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5393F227AAF; Mon, 22 Sep 2025 19:41:50 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:41:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH RFC] nvme-tcp: Implement recvmsg() receive flow
Message-ID: <20250922174149.GA14736@lst.de>
References: <20250912115829.58669-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912115829.58669-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_104155_017965_18DD5611 
X-CRM114-Status: GOOD (  13.71  )
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

On Fri, Sep 12, 2025 at 01:58:29PM +0200, Hannes Reinecke wrote:
> Switch to use recvmsg() so that we get access to TLS control
> messages eg for handling TLS KeyUpdate.

That is a very spare commit message for a huge change.  Why did it not
use recvmsg before?  I'm pretty sure there are some tradeoffs here.

> +static size_t nvme_tcp_ddgst_step(void *iter_base, size_t progress, size_t len,
> +				  void *priv, void *priv2)
> +{
> +	u32 *crcp = priv;
> +
> +	*crcp = crc32c(*crcp, iter_base, len);
> +        return 0;

And fix the whitespace damage while you're at it.


