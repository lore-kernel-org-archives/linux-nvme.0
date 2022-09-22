Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AD4C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vPXPz0VwTxsO5sCvRekhFmf2/FI4gZ7yc5YeJWJUQ8U=; b=whtcw9r8hoJ6j3iqztZaAwA7vZ
	zFRb40ifViIcZ9F29KCfCYPffFCzOLr9zydq0YUQYVCQqXinMhVLIOJX+bSkRFEbSvBh+r5f672e9
	CBmxlcionJJiygBfvkTiCggDZfucu7gQCFhKnqrI5TUypTPeaqmOE/WtmZ0ZlWUpVoL9s3jdhlzVl
	Z1iv1+6loPG2SUb5Vmjskr3Ff8qc0GlcpIUv5TIbwLL1pXcRDQMR+c7BzA3S38HzfslTsBecCGp+i
	kvRNjuTNciY0Z8+pvs0khkYz47qn2iXq1GANM1lq+kVQ99w/yUnnb2zAjRTaEgzoVqMYdNfUN8jSn
	bCACZsxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHbP-00EANw-Dj; Thu, 22 Sep 2022 08:30:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHbM-00EALH-TK
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:30:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1431D219AA;
	Thu, 22 Sep 2022 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663835425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPXPz0VwTxsO5sCvRekhFmf2/FI4gZ7yc5YeJWJUQ8U=;
	b=rM5tgmC/LZ3qz9f3ZVUEJSHet+SoPsXjJdHTBOxUAeh1xIUptiKunx5LDx3Jh+nQncyb8d
	KspMKnJRs7Q7Us7quG7nz/Wd7lV5oqQrN9M5GYADyXhGxm7HIykuWAUFZa27GGe4vQlclA
	UpXIMXJM/zDUuzhkdsdrSnANoVhRS10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663835425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vPXPz0VwTxsO5sCvRekhFmf2/FI4gZ7yc5YeJWJUQ8U=;
	b=9Ikjg09UQsZXsI7L1uZTHPpTxaDEnp574TcA2VhqAEdA9OWweusZZC4SrYJz+N6yumQSwe
	7kN7Hrcp2gJ3qpAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05E6913AA5;
	Thu, 22 Sep 2022 08:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id V/NJASEdLGMpZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 22 Sep 2022 08:30:25 +0000
Date: Thu, 22 Sep 2022 10:30:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 2/2] nvme: send a rediscover uevent when a persistent
 discovery controller reconnects
Message-ID: <20220922083024.rk2igxroroqextzc@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-3-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013033_142541_6E32130D 
X-CRM114-Status: GOOD (  20.16  )
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

On Thu, Sep 22, 2022 at 11:15:37AM +0300, Sagi Grimberg wrote:
> When a discovery controller is disconnected, no AENs will arrive to
> notify the host about discovery log change events.
> 
> In order to solve this, send a uevent notification when a
> persistent discovery controller reconnects. We add a new ctrl
> flag NVME_CTRL_STARTED_ONCE that will be set on the first
> start, and consecutive calls will find it set, and send the
> event to userspace if the controller is a discovery controller.
> 
> Upon the event reception, userspace will re-read the discovery
> log page and will act upon changes as it sees fit.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 10 ++++++++++
>  drivers/nvme/host/nvme.h |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 70ebf27ad10e..07a21e0b9cf7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4822,6 +4822,16 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)

Stupid question: nvme_start_ctrl() is obviously also used in pci.c. Is
it expected that a PCI device also sends out the rediscover event?

