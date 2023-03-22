Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71950C6FD1F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 14:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptObVw/QtoM5D2y2i54Oeq2Us4c7EFmLTYsYhcCjInI=; b=Yy4J+RdjN1/LP2fm92n3yVIKja
	q3DCr1PqvlmDVDgQc4twvxGRmmugdixRHk1qDqPbiddFxihEHEs/npbr7fCH2ZR7YrDK4nwsCAt9I
	yp2ues539IQkFYaooV2uxWzVTes4Fl9gdpg3fMXcREad1r4EhTOSMgU/V+n8zdC3S5y3+cfd3/BP2
	PsDwxD5KhNhmNjV56t0Z82BEbCSMvjcEU4GKYaJhAbqW4aE5A0ytd/dgT+9qDYuVpiwt/MEgCvodC
	m4RGVNzGkZ4+/JW/H6SRMq61srGJs2r4k7F3OZO5ZKxw4gDnZyQTqv0WnA1I4RII7jUENbPaO/9qB
	frr7OLeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peziy-00GMIh-36;
	Wed, 22 Mar 2023 14:46:00 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peziw-00GMHs-1r
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 14:45:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 261FF62135;
	Wed, 22 Mar 2023 14:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159AFC4339B;
	Wed, 22 Mar 2023 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679496357;
	bh=1CqlgGyaxSbqJLKw1Zf8lNBZD34fL7zsNgh3LojnYIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WTY/FW9DyW+TBizcHbzhVt7CkAvagGslPzS18TcS07D3RGegRXwarFCIkbTEOPJOq
	 3Y6twigaw+nwROohTBCYULX+AQkXGA4tXs0DXDur4ee23M3vMa+nwjeGnNjVObqvRw
	 480Kp9uyFRbG1/a3/Vxj+sCYTlfwNyl6Diy6YSr6lRUM6H7F2uHTC6jcX137rAYsaX
	 vY8tJBk9kgFZU3VYUnGwikytlGUjNRBf2Aa9TYEBB/NsHhrKAzqCMCvWT+WPM+Ox7K
	 AmzuunBoQ+R5IXJzwre+9rMfN/uaYGwm4igbIUMWQoNaImm/0pGLTWH5/WQIjn8KRj
	 2e3TwoJDvAxsA==
Date: Wed, 22 Mar 2023 08:45:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] blk-mq-rdma: remove queue mapping helper for rdma devices
Message-ID: <ZBsUol590J+8ie4r@kbusch-mbp.dhcp.thefacebook.com>
References: <20230322123703.485544-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322123703.485544-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_074558_657124_B244135D 
X-CRM114-Status: GOOD (  11.48  )
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

On Wed, Mar 22, 2023 at 02:37:03PM +0200, Sagi Grimberg wrote:
> No rdma device exposes its irq vectors affinity today. So the only
> mapping that we have left, is the default blk_mq_map_queues, which
> we fallback to anyways. Also fixup the only consumer of this helper
> (nvme-rdma).
> 
> Remove this now dead code.

Thanks, this will make it even more practical to unify the queue setup for nvme
transports.

Acked-by: Keith Busch <kbusch@kernel.org>

