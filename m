Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09784CCA468
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 12:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UO6aQf5NOBsAlA3OxJnU+ytw9DH8uapgUyQtK/Rr4JM=; b=Qouo1vV4LXzbK942749WvpbTJ7
	LrLtul0Zcmzkf4rhPVKN5/iOgo6BnqBRdUAxfdNKxbgeaok5O4uZiowjsRX1rYNduNCzjY6SpNHs5
	Z4CAfXaP2vHzqhXtePWGmMqXqlFwvZ2uhZIBZL34ket4cFPQOMl0+YO1Ph8ngtjsj+Jqmctgn3lFL
	FVwsrb+fyOPnNl5REsevbT/TXXdl5JKVSKVgpoBvNKB6G8BRcUrxRLum2QbLeRaW9n9JsOcYnGP69
	vAv4Po/dHCQkFv/RZrkGsLc98KXiib8zI6SAt3WUqFToEEfvBXw9QCA3+Ou+eIJmAwT7iveyw1bAY
	yd70HZ9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ZZ1-00000005Hwu-47EL;
	Tue, 30 Sep 2025 12:34:39 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3ZYz-00000005HwS-33D9
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 12:34:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B07984483B;
	Tue, 30 Sep 2025 12:34:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C32C4CEF0;
	Tue, 30 Sep 2025 12:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759235675;
	bh=+yrvY7toINzVpswa0PAIaIDdQ59Q6vtlbr+hG/IBIvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Na5QvMguViKB31Z2oVtF3L0poZv3ki4wIiLtwIsSrwKeg3yYjCLdK594nVPl5xlvt
	 DxEhULZL+aDaWgj3h+sMzQIEtts7zs2CelzQr3Y5T7Rln7XDk4VRzqUDMbFREn/gsT
	 hW58Vw5J6WIiCHAqnNJMRE76GRw0OC5AUG7rhdtQR2zyQFCT5A9txawFDkMfHs7r0d
	 KM1Sh6mDu/YIEHNAo8R7eKpJwG+45vNe21JwZ12G9GGtS+IU2f9TeMkmrPW175PJNK
	 N1QP57FGyu+2284KZZsRzgDU7HPMBJ2v7l54Jwht/zlpXeeVwzBB17wsR4eVcFJb7B
	 HWyXPGElb2GRg==
Date: Tue, 30 Sep 2025 14:34:30 +0200
From: Keith Busch <kbusch@kernel.org>
To: Rolf Eike Beer <eb@emlix.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	stable@kernel.org
Subject: Re: Backporting of 3659fb5ac29a5e6102bebe494ac789fd47fb78f4 to 5.4?
Message-ID: <aNvOVkpKhEHXAxcF@kbusch-mbp>
References: <5015244.GXAFRqVoOG@devpool92.emlix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5015244.GXAFRqVoOG@devpool92.emlix.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_053437_790707_43E37E6E 
X-CRM114-Status: GOOD (  13.90  )
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

On Tue, Sep 30, 2025 at 10:34:35AM +0200, Rolf Eike Beer wrote:
> Hi all,
> 
> I just noticed that 3659fb5ac29a5e6102bebe494ac789fd47fb78f4 ("nvme: fix 
> multipath crash caused by flush request when blktrace is enabled") has not been 
> backported into 5.4 stable kernels, leaving CVE-2022-50388 unfixed. I assume 
> this has happened because it did not trivially apply.
> 
> Is this assumption correct? In this case please see the patch I'll send as 
> reply. If not, what is the reason?

It doesn't apply, though it's a trivial conflict resolution.

