Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A141CD4840
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qlEari2kG32M54tVFnyEXOzLYg+ODt7mjqN+nPJLo3s=; b=vBw8Pu0fNgJWxzlcNPhYzGieAT
	AqJyEA5EtOa19qjNSlT5VOlDwKTAwrw+Uu9+83Uy0rkxQ22hg7Z47BYOxZvbeiNEqYkeSae+jhsws
	agBEBkwABu2KRp+sJ8xtgHET/frhd8ZBhS5pe2yDLKlyWr68DccoH5aQ6Gy5VaLgz5rZtAmX1Kyg2
	awN6zJkEP7hHWYOIK1HERMS2mZdpnkjG1Np+KMgn6GzWVrkWynO4fEtAoOpJIzmdohCZZqHY8pXIv
	/c2KOvRmZyh5NcQ6dULDNEa6i3nHVA0o2rd7PFj4n/p1tb55e/qj5z+i+LkJbRJmeRqt9ZJKELd7v
	BE6ECIIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPo4-0000000DXti-0kUu;
	Mon, 11 May 2026 12:32:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMPo0-0000000DXs5-2e4P
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 12:32:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5D6146732A; Mon, 11 May 2026 14:32:12 +0200 (CEST)
Date: Mon, 11 May 2026 14:32:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Christoph Hellwig <hch@lst.de>, Maurizio Lombardi <mlombard@redhat.com>,
	kbusch@kernel.org, mheyne@amazon.de, emilne@redhat.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mkhalfella@purestorage.com, chaitanyak@nvidia.com,
	hare@kernel.org
Subject: Re: [PATCH V4 6/9] nvme: use per controller timeout waits over
 depending on global default
Message-ID: <20260511123211.GB17601@lst.de>
References: <20260508133335.98612-1-mlombard@redhat.com> <20260508133335.98612-7-mlombard@redhat.com> <20260511081040.GF29677@lst.de> <DIFTJU624OOA.3TZPJSC4SF1CC@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIFTJU624OOA.3TZPJSC4SF1CC@arkamax.eu>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_053216_805790_E0BF013E 
X-CRM114-Status: GOOD (  17.31  )
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

On Mon, May 11, 2026 at 01:42:47PM +0200, Maurizio Lombardi wrote:
> On Mon May 11, 2026 at 10:10 AM CEST, Christoph Hellwig wrote:
> > On Fri, May 08, 2026 at 03:33:32PM +0200, Maurizio Lombardi wrote:
> >> Instead of passing NVME_IO_TIMEOUT as a parameter with every call to
> >> nvme_wait_freeze_timeout, use the controller's preferred timeout.
> >
> > This should probably go very early in the series before even adding
> > configurable timeouts as it just drops a pointless paramter.
> 
> It drops the parameter but uses the timeout value stored in
> ctrl->io_timeout, so it actually depends on the patch introducing
> the per-controller io_timeout.

Well, switch to hardcoded NVME_IO_TIMEOUT early, and then replace it
with the variable timeout like the other instances of NVME_IO_TIMEOUT.

> 
> Maurizio
---end quoted text---

