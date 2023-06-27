Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B303EEB64D9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 15:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TJXl5sSFwDoNY+zK714MZL5cU/Y1tLtv/+sy9DGOL5M=; b=srR6X2h02eoBAB64q4WWjiO4bK
	pTcvDuXchBpVmpTie/PyGXSKwCyi59Z7QU1n0ZAUDeCKr7LnaDJKuxvGT+DHdfz7FHCkS8aJqux0y
	G80vpB3Sc2aRG4JX4gbBf58UXMlUlNV6GJhZf8bKfeM5FX8E3kcydembOmpwvR9rpv3y11VcomJtz
	NLrOj0Ie5/vvw2kTAcdaJ6xzHD7+tZnXyYgI3/A5zTXrpCIM60H1wjkgLViEQZQ1yELAnX8VvC6w7
	zzUgm/7ycJnxWAhUcP6obNq17YqpoPlF2HWVJGpZyuZH0LTVgn+4Ac5N/I6HHE9xv7Ogk9OzQdHrS
	toz/gBQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAee-00DWmo-2b;
	Tue, 27 Jun 2023 15:30:56 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAed-00DWmP-0m
	for linux-nvme@bombadil.infradead.org;
	Tue, 27 Jun 2023 15:30:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TJXl5sSFwDoNY+zK714MZL5cU/Y1tLtv/+sy9DGOL5M=; b=hg33jus/uTzaeWxZqwEbE7nAcE
	v9j647EgFA4eI78mRz5nhclvB7w9T0KOTVD+g1wmaFlBkaSM0+4QmmeQ9bcsrUmttnQr/34cUK6pN
	S5JMVLwsygNwG3sJGvB1nrvtLehdkfiQpLz/ncrX1xUrdIiMe0J/jfyJN5we8TJOb/lt316RARzKC
	TMi0hEDqXO5HyS/6TRIwqKGOT86uNFrttJD531HRWSbRpf5MRY1q+n+bR/CI/Ow5bjZUOoS1pu55O
	MAeGqVTz5J6WIMApzFL3XUceWtRYtK9AlwtTxgCV/qzqTtvg1mdzwLRCKt5Bcbrs3+ru/gGWK4Q2W
	RaR7dQmA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEAeZ-004hyA-2s
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 15:30:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFB66113C;
	Tue, 27 Jun 2023 15:30:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C3FC433C0;
	Tue, 27 Jun 2023 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687879846;
	bh=TJXl5sSFwDoNY+zK714MZL5cU/Y1tLtv/+sy9DGOL5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXDyqSstA4Oh9qXFuwkDfWNh93QmLoDP2nlrXSGs3wd+a4filfvtnbxT1QshKs/Fl
	 x/CfVH1CsiSIdUQdYBgXvC0r/VNnlwqBiwq1kBL5KK4RYBKoZtq4SpbpCGhdM+nEuA
	 o+FhCAr7Cp9V7Go2k5pfiFoKKUnnHtN42X36DFBE/RU1SEQvXWI/3VrQ60MCul5ma8
	 SlbUtRhJBx37Z/GiZsbNhTRr6vI5TxDMW45+DixK3FzVQpS4KlvjFc2xFuVsgGztsT
	 vHX6rFtecyUFHlzo2UeDn+GEaDjS1VM1YDwHZo11QmAFrTANotQkMeU1aaqfkPgiQ8
	 NcIllnhT6hDnA==
Date: Tue, 27 Jun 2023 09:30:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-core: check id->mc before setting
 NVME_NS_METADATA_SUPPORTED
Message-ID: <ZJsApH5rwOcsmFB0@kbusch-mbp.dhcp.thefacebook.com>
References: <20230624103502.8772-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624103502.8772-1-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_163052_184743_4AF5E182 
X-CRM114-Status: GOOD (  10.61  )
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

On Sat, Jun 24, 2023 at 12:35:02PM +0200, Irvin Cote wrote:
> The NVM Command set Identify Namespace Data Structure defines
> the metadata capabilities field (mc) that determines support for
> metadata. Check for the value of this field before enabling the
> NVME_NS_METADATA_SUPPORTED in the nvme_ns data structure.

The MC field is primarily for use when sending a format command to know
what are valid possibilities. If the reported MS and FLBAS are out of
sync with metadata capabilities, then the controller is broken.

