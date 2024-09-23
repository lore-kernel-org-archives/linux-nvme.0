Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E34EFCF9C6E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2024 12:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=57Uz6MnU1j3xahihVP2lT+ameE3wU7kvWy7bwRKIGG4=; b=cFouEesVeCz+CIX3jIFlAUrezD
	vLS1Ll0aJ1hJ7r3mzGtaivPsWUkuV8t5F1+OIpaXacPRXIzNmJ9S7K2dT4h7C7TE8KLGD7Keslnuv
	406OYZBAYb4LjINlDreVCrTOxZ7EA1+GdmSbXJNCDXq4rW9sn8Odttt0vyO631BzKAnqxsnMPjEPS
	qg6s3yKgw5xMVxnA/BLHyLdvsrG4loLMLjLa1vZB+OYVqdcc1EUSb7TlKOF+/VQ7Twi1PniLE4lmJ
	IHfY1sMTjEw44+kt4Mk8NrFeQQqYL6on95rm4HzgOe4HEF5AUedIKa2IZBtQp6U/42oZ+9k9t3zsJ
	2lrjvbPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sshp0-0000000H8dT-3Y87;
	Mon, 23 Sep 2024 12:05:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sshoy-0000000H8af-1ydV
	for linux-nvme@lists.infradead.org;
	Mon, 23 Sep 2024 12:05:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2802068AFE; Mon, 23 Sep 2024 14:05:32 +0200 (CEST)
Date: Mon, 23 Sep 2024 14:05:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: remove CC register read-back during enabling
Message-ID: <20240923120531.GB13481@lst.de>
References: <20240904215405.1980512-1-kbusch@meta.com> <ZvEg1Fq6wy7eQ5VV@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvEg1Fq6wy7eQ5VV@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_050540_672412_1AE21605 
X-CRM114-Status: GOOD (  18.43  )
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

On Mon, Sep 23, 2024 at 10:03:32AM +0200, Keith Busch wrote:
> On Wed, Sep 04, 2024 at 02:54:05PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Any non-posted read should flush the previous write, so we don't
> > necessarily need to read back the value we just wrote. I've found at
> > least some controllers that respond with 0 for short moments after
> > writing the CC register with EN (enable) cleared, so the read-back is
> > overwriting our valid ctrl_config value and ends up breaking on the
> > subsequent enabling.
> 
> Ping on this one. Looks okay?

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


