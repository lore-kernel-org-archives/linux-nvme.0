Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FEC6C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3D444qcOPFha0L0K2dQU1SS3ZqEAq2s8GMmjPhI6N30=; b=G2x/h1ZAmQWBXNeddT+ilQUPmf
	Y/5p1UZRhyG5T8+hDnrwd+Rah3XbC/eLLdRqvqdS9hh+sA9fFoppMUhgOdLTdR9ApdfckR3GnwGcn
	mgStYrOdPDxIKI54vP8gnyj7+NVDOSPvGVAQ6tze0q6Z3PGXSRQBb+4aMLquTkgnXYzN+pRD7HKZs
	3uxAKwQnVZ4MYG8mB6eCBGL9rJwrM1Xc098I/jyiiDCfOAPwixrKd0phXCT03I0aELL9RtGGMTVaF
	I8Ppqy0av+hOW1xa+TY95CA5ROTGhB0UCW4WpeotyvesN/qF3tbixZeZWLU7hvSQbajIWpz5KbXZ+
	UnXipGZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petdQ-00F8Lo-24;
	Wed, 22 Mar 2023 08:15:52 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petdK-00F8KO-1r
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:15:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0408567373; Wed, 22 Mar 2023 09:15:39 +0100 (CET)
Date: Wed, 22 Mar 2023 09:15:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>, Yanjun Zhang <zhangyanjun@cestc.cn>
Subject: Re: [PATCH v3] nvme-tcp: fix a possible UAF when failing to
 allocate an io queue
Message-ID: <20230322081539.GA22139@lst.de>
References: <20230320133334.57325-1-sagi@grimberg.me> <915f65a2-226c-ae20-0575-e20120e72a72@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <915f65a2-226c-ae20-0575-e20120e72a72@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_011546_755106_AD4A3EDA 
X-CRM114-Status: GOOD (  14.55  )
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

On Tue, Mar 21, 2023 at 05:12:57AM +0000, Chaitanya Kulkarni wrote:
> > +#ifdef CONFIG_NET_RX_BUSY_POLL
> > +	queue->sock->sk->sk_ll_usec = 1;
> > +#endif
> > +	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> > +}
> > +
> 
> since its is not in the fast path, is there a particular reason not
> to use following ?
> 
> if (IS_ENABLED(CONFIG_NET_RX_BUSY_POLL)
> 	queue->sock->sk->sk_ll_usec = 1;

That won't compile, as the sk_ll_usec is not defined without
CONFIG_NET_RX_BUSY_POLL.

Note that this has nothing to do with a fast path - for cases where
IS_ENABLED works there is no performance benefit to use an ifdef
given that IS_ENABLED is ѕpecifically designed to lead to compiler
dead code elimination.

