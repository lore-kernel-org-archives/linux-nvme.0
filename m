Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38AFC00528
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=48qZt8XcPLOP/azZ9ivO1s4lmFfjwphGxuJGQox37uI=; b=Aacit61NzRJWO1LlMG416KaZIv
	A31z7XXVgKgJSkLCUQgzmreZeMKa109Z00ki96TD72clmfwxgWaHh51rHhpVzl+vQNgI3ZEx6zMoH
	jawJ4Llxhzk3mm9x1rVXNfQWaUxqHN735GIj8r8Mln1n8/n9ob+AVQKa38DPj/rxdI1auRoaZL1Nk
	EQHs3D5sK8cPHPTgtrYdGddeoGSQV65EGWsYlY0sUViV+NKnEIsAKdIjSz7gu3TKUz/BrrSjBF6m7
	kHoGEXsIocKI9SVQeYgkAzSQMr5gvQ09qpwiF9cB1Tyn3QI2TwkdnzajxzPECj++QvRJMKQ2EX8Lp
	bnFOSk3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXro-00H17E-1L;
	Mon, 31 Jul 2023 18:43:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXrm-00H16W-0x
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 18:43:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E891761265;
	Mon, 31 Jul 2023 18:43:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6493C433C8;
	Mon, 31 Jul 2023 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690829016;
	bh=bQ/n8sSgCr68cHiUeFkcrAzZyF3+4MF0xc9n3lQWFmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GlBcUs+tj/rB8Kr4/aS1wQy0dxaXhr+MgaDlDb248BRZscPDFynVptF5gPBtzyNqZ
	 2mVsD3KicAODOKzLEiH1C25vd2JL1Ngffupjpp8LT73xAa9pAbIksbYNJ+1zlpBFov
	 6q1MDoWroeBTETSKEMgAGeae8hNfhWvcNCGiLJtISQkYt6u+XPlgTUZGPHbPk/atmD
	 U36KnntBxPdzJzO0bTiHZGmVbifwXeqxiwy29jK6JKcW8SaFuUI+GziyKaDm2y835Y
	 2hSKSIaKgM2xfxs6AwEH9WKsO9qoPSfAVacqhPMpi5aVwVCHRXoFgjz2XLEZCEHz06
	 OgvNN1V2kkbcg==
Date: Mon, 31 Jul 2023 12:43:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-nvme@lists.infradead.org, kernel-janitors@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Mark O'Donovan <shiftee@posteo.net>,
	Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [1/2] nvme-auth: unlock mutex in one place only
Message-ID: <ZMgA1SGzi+VnJ8xS@kbusch-mbp>
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
 <20230731135152.GA6016@lst.de>
 <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de>
 <ZMf7BUH3ZD+GA7TA@kbusch-mbp>
 <f551a681-7893-b2a2-9565-8a4c1bd01e33@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f551a681-7893-b2a2-9565-8a4c1bd01e33@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_114338_375061_183D9FA1 
X-CRM114-Status: GOOD (  10.42  )
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

On Mon, Jul 31, 2023 at 08:37:12PM +0200, Markus Elfring wrote:
> Does the concrete requirement for the usage of “imperative mood”
> mean also that a reasonable subject would be insufficient alone
> without a corresponding description (or “change log”)?

The doc you linked to is a simple guide for people new to the process:

  "This text is a collection of suggestions"

It doesn't claim to be a list of concrete requirements.

