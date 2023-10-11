Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43825CDB466
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Oct 2023 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqLFXCkRuazXSzUmp68ZlrMXdMIeavVC2+XfhX7BAfI=; b=XGL4t4uMyuwlpqeyUSZIITxJ0x
	ZHX6haV7IWyqHleWMF+5Uly86GE2q/48IhTdoZDhCkNkca57C11jA5sjRNUpXRiaeGqsVYtTEtCRk
	lWOXgpjffSGV64jOXHzSGFJadG761W6R2lV6L4Z0QQFUPgXpi3MG/HRefxMr9WA0gjhsPyABXJYxK
	UPR8uKe2h0z5DLd6jcuOtRarjcf+KhYHzeSTOoE41NHhS5IaG+/QFBOa5PW86LFHiaMJbZUbJaSCq
	iDqwZoiI5gyBYtMShQ+WTkngGmJjGeoWmYI9Hyma+aT6Rhw/ZjVNHQu5fR/uABlW2t2IzddzSjkhq
	c0rXvgfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqd4h-00GLcT-2l;
	Wed, 11 Oct 2023 17:32:47 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqd4e-00GLc2-0X
	for linux-nvme@lists.infradead.org;
	Wed, 11 Oct 2023 17:32:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6E40C6131F;
	Wed, 11 Oct 2023 17:32:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C54C433C8;
	Wed, 11 Oct 2023 17:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697045563;
	bh=1f/EjuaPCbCGCWkRuzwu7a/NWcfvSrtywlpUesiHtM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D8QiIfdkartjbgMJbdZfAIe/B8248Oe+9iU9+iNObtvUFhpcUx59HjafLbdesD7yY
	 9C39bIgRNubYlaCDttZgUof1EpP4dEP32Cl9MpjhA8O+DRja0sEdA0YtjXTtFPYJNw
	 6bBxWH1L8CsDbDNpWe3T3NGqwiC4xuNJ9S1QK1Y4AIXuZVZavIXj/YCY9RxiRtG8Jb
	 nKXAuXP7Hqt38P0ZIXlXkta7z+NYTlJdVwUML5xaxLNvux4O0rJi2MJYHTVI5FE4X5
	 r0LWeUhQuNvybeYIB9K8ldbcVQpDjUAECauna/3lUFllgKZ7HsWrfJq4bO/6iFE9Hh
	 dKUapuhSPA1mw==
Date: Wed, 11 Oct 2023 11:32:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Message-ID: <ZSbcNnJP_ug4ojyl@kbusch-mbp.dhcp.thefacebook.com>
References: <20230824143925.9098-1-hare@suse.de>
 <20230824143925.9098-12-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824143925.9098-12-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231011_103244_251052_37239FF8 
X-CRM114-Status: GOOD (  10.68  )
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

On Thu, Aug 24, 2023 at 04:39:18PM +0200, Hannes Reinecke wrote:
>  	args.ta_data = queue;
>  	args.ta_my_peerids[0] = pskid;
>  	args.ta_num_peerids = 1;
> +	if (nctrl->opts->keyring)
> +		keyring = key_serial(nctrl->opts->keyring;

The key_serial call is missing the closing ')'. I fixed it up while
applying, but a little concerning. I'm guessing you tested with a
previous version?

Anyway, I've applied the series to nvme-6.7 since this otherwise looks
good. I'll let it sit there a day and send a pull request to Jens if the
build bots don't complain.

