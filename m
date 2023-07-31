Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C5FC04A94
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 18:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VB+5m893PwEwWpbA7Z6gW2NyakGQws9FJI79vg+uUcs=; b=c43Oo1cR8uMwCCFTvKrLyDB0br
	/fPmOn6lgsmTbSgJfDIMDFY6HIft5XiOizm7lu8me2csQtXsxbCXmcr793l+HO9N4+GBiAfh+G0tl
	NEutjZWW+Qrb361oBREXL2aSWJot2CKapbUN8bVp5iLrNNMB94NTLmX9gqUk4SW2FRvrWXRm9vHuQ
	CxCrdekX4IOiOMGtNaRSMloOoBxbTWlKYGODIWdz1Lr5WW2N7UO90fVlNGs3MnflPhnGTE3u+fCMu
	B81nHgS77FsejZ/yu5kJA3ylj+0nYfVTSzjCS5V21T74y/4SUCHlq1uBk9RfP1qmh2k4Jr4tvq2yC
	jDtRphmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXTo-00GxeV-10;
	Mon, 31 Jul 2023 18:18:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQXTl-00Gxda-2e
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 18:18:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9509C61278;
	Mon, 31 Jul 2023 18:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6403CC433C7;
	Mon, 31 Jul 2023 18:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690827528;
	bh=nA2HY/secIyeR0dLcyOtcvRUq6sWYkW9OKihqqNxehw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1iKk8nbQaYdhqBScm+HXMK83XXkjFrwLj7DvJ5SFOMC2BtjhMynQwuValsxzeDYc
	 kq90UBArG95KNlyEulM6VqUX02xlerzDHft2OmWFpmCZhapWQtUCtJGNvJV5/hAEmK
	 8nRutoGpvZsbJKXnJShiorvC9evqGbHy5XvOSLf0vNNZO7VLzUfQcW/RHk6Hjtl38U
	 bxeTa3Yzys4A8NgsK+qzNdXwhkaaJRKQj7Ek4bdBDhuonAxOkrTRxZIhYRSrZNesuM
	 KTCtplGX4dJM7IoHD1FxInxfvZYPCpCrccYh0dIQwVC1CI5Iu0C0cWtqnVHn8otn2m
	 NJU1fCyjy9wvg==
Date: Mon, 31 Jul 2023 12:18:45 -0600
From: Keith Busch <kbusch@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	Mark O'Donovan <shiftee@posteo.net>, Hannes Reinecke <hare@suse.de>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [1/2] nvme-auth: unlock mutex in one place only
Message-ID: <ZMf7BUH3ZD+GA7TA@kbusch-mbp>
References: <20230727134748.4163796-1-shiftee@posteo.net>
 <28d11fc5-743f-0810-8ab7-3fa2a3f98c65@web.de>
 <20230731135152.GA6016@lst.de>
 <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51771bc-32a6-7424-ba02-bcc8ab9bf3f8@web.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_111849_921626_D1EFC9BE 
X-CRM114-Status: GOOD (  12.96  )
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

On Mon, Jul 31, 2023 at 07:46:25PM +0200, Markus Elfring wrote:
> >> Are imperative change descriptions still preferred?
> >
> > It doesn't fucking matter.
> 
> Do you exaggerate here?
> 
> If not:
> Does such a feedback really indicate that you would intentionally like to
> disagree with specific requirements from the Linux development documentation
> (for a discussed patch)?

The subject is already in the imperative voice, and there's really
nothing furthur to elaborate that would help justify this patch's
inclusion. I'm not sure what point you're trying to make here.

