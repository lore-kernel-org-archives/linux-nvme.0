Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EC0C5DF9C
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 16:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBbUphAOQKMOQW28xwmU4cg0elZwwdzp6JPWC72gUDI=; b=lykL5mzxHDQQkO5SAdwU+/q5+c
	fw9gdpIqSmflWMHiqbGyBV49KW23bFVRFF1GDPNhZU/1FC4jKhxQAFaf5DUqNI2ikA+FPNbe5Voom
	wtirksjnvRd++jG4yX5Dnap2Xry78dgWZZMZ+wLMM9C64HMHPQ+5tyq09fWnjpFamWmtj7+DSxcv5
	itJP8qFeMT6mlOiKlDpDYjCS0HPD2YbEFv+eycPRpuY9ZN3oQ9NxXr403WoZlKo3Gw1rxYmZ27GTQ
	ojZpkQv6D3cd3lGTbrmjaCFlumoIkk8AwLLByCiQDv6Fgqbt+DWKSkJRhtsbwm9GL6k/j+/jERL+x
	gRXB7cXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyX70-0000000GzOO-2aLB;
	Mon, 24 Aug 2026 16:01:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyX6x-0000000GzNK-1RwC
	for linux-nvme@lists.infradead.org;
	Mon, 24 Aug 2026 16:01:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 7E13643508;
	Mon, 24 Aug 2026 16:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A721F000E9;
	Mon, 24 Aug 2026 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787587282;
	bh=KBbUphAOQKMOQW28xwmU4cg0elZwwdzp6JPWC72gUDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zD/RP5d9Uvvtj9kDJXhLJp/FupKCT6tuw67c6q+wZtAFX6l/6muK6sJkSQTHj9IH7
	 v8X8NU4tGf4ZoNsPUuxSfsQQaWImoHFsd1jbX8K+2RmFuqScZLKA9MHpv4WcPEIjDy
	 WbCpQ402/9KSqQmuYBRIV4sW6lMpywSv2ZbvHN+k=
Date: Mon, 24 Aug 2026 18:01:17 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ibrahim Hashimov <security@auditcode.ai>
Subject: Re: Prior report for the nvmet-tcp unbounded SGL length fix in 7.3
Message-ID: <2026082412-matchbook-perennial-03af@gregkh>
References: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ysrSKO9ufMWQ=s_xM_uh1OhKmEb8v0tOwYH+g2vtxeWqW8DQ@mail.gmail.com>
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

On Mon, Aug 24, 2026 at 11:42:50AM -0400, Shivam Kumar wrote:
> Hi all,
> 
> I originally reported this issue to security@kernel.org on 2026-03-17
> (Cc Sagi), Message-ID:
> <CA+ysrSJUFi8cHzU8g9Nrbbkcuo0F7vh8CMn3ht15gSk3BbK45A@mail.gmail.com>
> and posted the first patch for it in this thread,
> "[PATCH] nvmet-tcp: bound sgl->length check in nvmet_tcp_map_data()"
> (2026-03-19).
> 
> Commit 4a3f002 ("nvmet-tcp: bound SGL data length before allocating
> command buffers"), merged for 7.3, adds the same NVMET_TCP_MAXH2CDATA
> bound with the same status code.
> 
> These things happen independently, and I'm glad the issue is fixed.
> Would it be possible to get some acknowledgement for the original
> report?

"acknowledgment" in what way?  If the patch is merged, what can we do
here?

thanks,

greg k-h

