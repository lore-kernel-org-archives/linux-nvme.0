Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB90FED3C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 13:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LOfyl4z18uTtlRWV7MzmS7MQV0AZEN/953WyL9wn54U=; b=cLJFAj4dZLROT5L1Ufk8hx/xgR
	jlcncQuKlJbQgxm8wpvwHg2iZtz54v46nDdBiRaG3kwjtmAxLIE7xj2E/thQL+Is0iGECSBHAtFB+
	qwcaN5el1FCuiFPXavkHfSpLdopaQqt+En8k7Ba76sXplv8+IbUc4/hBcANSaZ8i+396VEoj239Y5
	jPFoUXZumhSzq0BrWlklqKIC7rSTwQposK5u+F7ffu1j6Ji3jERnH+DR+5rGjFrJ/hHvT8LqM48hN
	dhyNGo9nfmv8rsDyDFHelxneroq9fR759XIDoZa2nNDmjj0Wc7GrrF2L+XlR4b58irybOMhBOOQkM
	bd6G7krA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGjY-0000000DFsa-1ViH;
	Fri, 24 Apr 2026 13:38:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGGjV-0000000DFry-0hyc
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 13:38:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AC77668D05; Fri, 24 Apr 2026 15:38:08 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:38:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@arkamax.eu, mkhalfella@purestorage.com,
	chaitanyak@nvidia.com, hare@kernel.org, hch@lst.de
Subject: Re: [PATCH V3 1/8] nvme: Let the blocklayer set timeouts for
 requests
Message-ID: <20260424133808.GA16434@lst.de>
References: <20260410073924.61078-1-mlombard@redhat.com> <20260410073924.61078-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410073924.61078-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_063813_349233_D1ABE873 
X-CRM114-Status: UNSURE (   7.62  )
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

Looks good modulo the missing signoff:

Reviewed-by: Christoph Hellwig <hch@lst.de>


