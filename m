Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52562C5478A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 18:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVtj5UeLN9PzLE+nAc3He4Nr45+iGWDtonODqu2YIag=; b=JArJI4+DRlv76ahFHJ4BqZ43Ze
	U03zHOFq8GeRyNvnhhyu6RjAVgTAxmKzRrQOeT6I6Tde3eaoJDwXWW+fCvyFKF48GUK2ieRXgiT0i
	fKxDC7P30QJwkqD2O1Ek6sZmmmRFha4ZzPufTZNaoVRALUb/9pTw4OjIIEGVWR5eT0/RRohUysBxs
	0BF+jDX3BrLbthkIwgG3mPsRUru1pRsUstQICqRgsJ9dGjxgJ4Io8lIkITshDIrqoVSepwuHNE8p0
	ALVClQ63uVlsQ3fvtecdrNmQquIJCHuPGktKt94Vbz2BXLtKBpjODkIqLPXTunUozJdNGBdWlxxEP
	uLtlGy7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcqxC-000000020zE-1Xhm;
	Wed, 21 Feb 2024 18:04:22 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcqx9-000000020yk-42DZ
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 18:04:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id EB3E2CE1056;
	Wed, 21 Feb 2024 18:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBC0C433F1;
	Wed, 21 Feb 2024 18:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708538657;
	bh=CZQzgLXnK0wfVh9AjBPaaAYevg83M6W8YPFqFEIq3Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HkZlqsNba/I8LjXS72j+mE53PIhJqcBnBnNysOlWO4TQc11r3BekpgSQjEinuCuFO
	 xtgFu/YKINPsAdHUGhmyS1EbdxarffVXg6N6MiuD6K3nrXKWapbSf+UQE0bLZwO21+
	 0VoZ6ic0UfcfX0KwYXcy24cm1hTMooIqRSnH5EpHLMl4inWycugFO/bZL4w4FGtLY1
	 AUg7ueCGOFIaLVCoLI5FpqzWdATYupWBVlBypqOekY62AdTqVdQloEtPbzoS7yhnxP
	 poCvEI7GIJD9ruNHmq6j2TRBn+Y1dn1I6cl+AtjmzPFSojG/hu5A5rZ/eV6ml6tacR
	 h/Ae47EqUdHlg==
Date: Wed, 21 Feb 2024 11:04:13 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] nvme-fc: fix blktests nvme/041
Message-ID: <ZdY7HavMstT3KbHe@kbusch-mbp>
References: <20240221132404.6311-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_100420_203121_704091A3 
X-CRM114-Status: GOOD (  16.31  )
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

On Wed, Feb 21, 2024 at 02:23:59PM +0100, Daniel Wagner wrote:
> As suggested by Keith I've merged the new flag for nvme-fabrics with the last
> patch. I also added some information why nvme-fc is handling the initial connect
> attempt differently as requested by Christoph.
> 
> The new flag is called connect_async and the default is false/0. I've tested
> with a patched nvme-cli/libnvme version and all looks good. When this series is
> accepted I'll update nvme-cli/libnvme accordingly. Note, that even with an older
> nvme-cli the blktests (especially nvme/041) will pass with a newer kernel.
> 
> (nvme/048 is still fails but this is a different problem. On my TODO list)

Series looks good to me. Sounds like it's not fixing any regressions, so
I think this goes to the 6.9 branch. I'll wait till end of week for any
other feedback before pushing anything out.

