Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49547E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 17:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2MXXooDF03EIaiBZdi+hqW2uln6RdtDsTRTopxg3w0=; b=d6irJHAW8+eFupb/3QoTXNMSSH
	FbEhePg88iOL45GGjilPjArrCnACpaV0JHmwiEKGdNsd7nBi2LNHkJ6Dx+fe7Uf36X3H/NRKZh57H
	dCJEkiQCgY9MlrkRvGjy8hDWsiLGVQSqhfMASpp5uw8Y9qA9OxaG37HXAqJyyC5dhY+8lLo9auJsN
	8dWo4V3qyzN3Pgzi2+oxTgsdsBHGlhuG6S6xtLfSr8sbPVpQrBlW/ujLSXS66doTevBejiEAzyWp5
	FI5a0nLzSi1LzknHVyQnntFIXhB7XFmFsmKfEiL82ush/WMfDgMbQ11Axwix3ZpSEH9Dpa9mkMzEF
	mNk+BDew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZWX-00000009Jt0-1ohr;
	Wed, 08 Jan 2025 17:07:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVZE4-00000009FgQ-2cpq
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 16:48:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1CD755C53A5;
	Wed,  8 Jan 2025 16:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C18BC4CED3;
	Wed,  8 Jan 2025 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736354891;
	bh=U8Byqjcc4/RMpCN1iqYpRW8U+d2NscG9JXTHQmo2bcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AxUYkls7VIzBU5jb8SdeKbcg598W4xcaK3fyHmXJ5NjnNcKfjknpjHEyrKWuO2zpc
	 egMvUTOqUERkQ8+7gcZMPizOM6LEcUf4QsNttdz0YZ9wiFifzNealgkT5cZKIHIOrC
	 EbcJ/A49rVSVypEejY7iaGPknVRS+EbjleJ2HFTBKn+71idcbCuEikKv1PIE2lFfZF
	 JNZh3/HJdudELBEH+rKXuTXFFY7mwpbRweYHDutp3wQh4urtOht3f5boWXPDW7L+IP
	 xh5HGjR0WYjxytSRicfldYka4AfqNor2dG9KV4mfbMr3YY3SbgKWhczW42DhPROYfD
	 MXTwG901rVtFQ==
Date: Wed, 8 Jan 2025 09:48:09 -0700
From: Keith Busch <kbusch@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix comment typo
Message-ID: <Z36sScswQMhaJyhx@kbusch-mbp>
References: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6460798716383804d15e987b0c218bf9969b33d2.1733657672.git.baruch@tkos.co.il>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_084812_711010_9A79D49E 
X-CRM114-Status: UNSURE (   7.77  )
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

On Sun, Dec 08, 2024 at 01:34:32PM +0200, Baruch Siach wrote:
> envent -> event.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Thanks, applied to nvme-6.14.

