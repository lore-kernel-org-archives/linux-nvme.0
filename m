Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ED0FD3760
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eaxgYMDu4b1CCqhGuli8mqFA6url1u1XPz3Kqvl771s=; b=HVqwnc/9hDwOgS6M7vkpUrRp7P
	+oJ3KWrugdCFwXbFoC1mw9h6kvaVbXH89azd6QCAGnr6zD3FQPtNuRyT8E6JegFZ/6KTPiw+wz7gm
	BlEcc9sQmEbcS4TnCBrrlE69KGpzpsz5T7G1hc/Mf7a0nJSTiICB1bP15B+tm4VvaCLUMY2b8+Wej
	dcX6s6cmNI+uak+wuEMWDQPPkwPB05q35VY5e2+IMC493LP2XKUp+TzFwlZVE8NvhJcTSm5ytlYQm
	/EKRQ80feH4II/85Xlp76hnxdcmu7iN1t8I437MA/wgqjxcWhvorDZYXwfqbwjrh6yqc5oUzrICez
	WsNqAMWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGFe-00000004EBP-1940;
	Wed, 25 Feb 2026 14:52:34 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvGFZ-00000004EBJ-2ZOb
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 14:52:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B6552600AE;
	Wed, 25 Feb 2026 14:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3BEC2BC86;
	Wed, 25 Feb 2026 14:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772031148;
	bh=eaxgYMDu4b1CCqhGuli8mqFA6url1u1XPz3Kqvl771s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KoAeoXkhhl1bznc4VYkRWZlAg2ppjiWIUk0dnyKZ/zNxMFttbW7QyxEtB6pG5zQjx
	 kRRp3jq7uA9gplfRPwbQrmmtlzahdHgrT48RPrE5hr9qEsas/hD22oR8nBpFmdJIz9
	 nKF71nxtE2uzxbqki8A49/NOqHEKaD1UetwZWfwNEopBdyqg0SRSjMIfs1BlmAd72/
	 S1D/QAw/CU+JLfxhBZKU86lpGi2wPVQg1fPzvTlnR/ls1nbYymevb3TDDKOiQii4u/
	 +yj1cu91PsamtV8cHHpRoUJyc5VGvw0IdmN62fKfAcoiMma3V/oyST85F6eJ5Ymxe7
	 N1uGyXNaHKg+g==
Date: Wed, 25 Feb 2026 15:52:23 +0100
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-nvme@lists.infradead.org, bpf@vger.kernel.org
Cc: lsf-pc@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: LSF/MM/BPF: 2026: (V)FS: First Round of Invites Sent
Message-ID: <20260225-aufeinander-kummervoll-1953a06beae9@brauner>
References: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260110-lsfmm-2026-cfp-ae970765d60e@brauner>
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

Hey everyone,

I sent out the first round of invites for the (V)FS track.
The first batch is also the largest batch. We will send out a set of
smaller invites later.

Note that the first batch includes everyone that indicated that they
would require a VISA.

Thanks!
Christian

