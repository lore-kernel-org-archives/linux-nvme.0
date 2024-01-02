Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C50C46CD2
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Jan 2024 21:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djDE0kLnCXXLaPSstiDGt7A04G7tmp5Zn2vS9Nqch3g=; b=bLnBiZE5JEp+B721xa6GyjBlXy
	wRISFcVDmGp52H4BLP2hE/iZXN92wbRr1b4jFywXotXDdP7ymiEc86iXlTDCyCj+ncVzy6jdDjcCW
	My2xz3miYwOrMmHPiO4J0IcoNtzy7Up4CTqRK1v0qLD6IY8sF6mNAXPsiVSAUnsr3xoIbJ8vzFmI9
	wUNLkpCGzp6IHfhlRZGx2gW3gSy/cXtL9biA0Eriav8fTpchXAsGEIpC0dDD6kE5E5sOqsCfVwX/X
	hU5pQtHs/TyMnLrUvIplzgE7xWxarzxK0yIxJuxPzVgIWV4PesdvXL1qvTsLAH9XrOYhph036mYzY
	Y0ptq6Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmQl-0093pE-1p;
	Tue, 02 Jan 2024 21:36:11 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKmQg-0093ok-2E
	for linux-nvme@lists.infradead.org;
	Tue, 02 Jan 2024 21:36:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 0D224B80EAD;
	Tue,  2 Jan 2024 21:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18851C433C8;
	Tue,  2 Jan 2024 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704231363;
	bh=/Tu1p48wBPy7AOClCXdtk7/dL0MSgw0z7yEN8J+Cku0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QqKkdFFALloiFaEAuhXV1aBwSAZsCcKD7QJUO8cbq0kv13cqlGbluuoElFJDM6t0S
	 xvh5cONP3FdeienmLwnS2r1T4DCCSpA7gOTYT5WcGqVsgCpHeIkz0lxlq0CZUVXlrX
	 v5/hIyUgWs3zP7KPFYZX41lFl3kR3exFEgLHWtNV4FD+9ZOK5h4wQ7HKJINRMd6w2n
	 N14JqlWKI4EAOAlTyK47w4AP1Wn6T6l1YGIrM0QFSPQVqkFSxoHVFCuLerTga/Nj6z
	 IRd/Dj9N25AB0a4/iKHwTjJPgE4aILgZmYM0vMyYUmyVZivZFnAk2p3LFEjMAtZ3e+
	 0yugzAe/9HOlg==
Date: Tue, 2 Jan 2024 14:36:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 00/17] enable nvmet-fc for blktests
Message-ID: <ZZSBwNifBWtD5fFr@kbusch-mbp.dhcp.thefacebook.com>
References: <20231218153105.12717-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240102_133606_900993_F75C615A 
X-CRM114-Status: GOOD (  18.68  )
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

On Mon, Dec 18, 2023 at 04:30:48PM +0100, Daniel Wagner wrote:
> Another update on getting nvmet-fc ready for blktests. The main change here is
> that I tried make sense of the ref count taking in nvmet-fc. When running
> blktests with the auto connect udev rule activated the additional connect
> attempt etc made nvmet-fc explode and choke everywhere. After a lot of poking
> and pondering I decided to change the rules who the ref counts are taken for the
> ctrl, association, target port and host port. This made a big difference and I
> am able to get blktests pass the tests.
> 
> Also KASAN was reporting a lot of UAFs. There are still some problems left as I
> can still observe hangers when running blktests in a loop for a while. But it
> doesn't explode immediately so I consider this a win.
> 
> Apropos KASAN, it still reports the problem from [1], so anyone who want to run
> this series needs to revert ee6fdc5055e9 ("nvme-fc: fix race between error
> recovery and creating association").
> 
> The first four patches are independent of the rest and could go in sooner.

Applied patches 2-5 to nvme-6.8.

