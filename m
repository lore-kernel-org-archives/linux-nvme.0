Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E736EB64DC
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Jun 2023 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eltHA9+OmtlLdhqXlF77o5UG+bcDjfus+AzL+r1n+Mc=; b=WuUqbcCX7TFcT89T1xhU+5q9qZ
	Oui66FWm9pZPxIpgEUU8POPmcV5fBEMfbYQc9QIvx6S0nib2Ods9J2xgI0iOqoZxAA0oXlcuVJbCT
	bhRny/lCkfZdJszWHeLgLNNWAAaCwVD2LcjKQUaa/YU6pCFkvTIIN0T9vyqAP1eNYi8T0g/hfxSV6
	U6AgtfBvJt+2B0X1G/YRvtHPGWOJRlRLqptU9tcF8xWVcoFCA0QpDU9pVfqgdV//4gdID4UPKI8w4
	ckLR6+IY4cmpvbu7myjKG6i8lV0IDn7MDN7w4XgA+ki462IyJv3TOo2AEoVjjcGYDutxl7UR3Op77
	VWSYbrmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qECNr-00DiSM-1Q;
	Tue, 27 Jun 2023 17:21:43 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qECNo-00DiRo-0h
	for linux-nvme@lists.infradead.org;
	Tue, 27 Jun 2023 17:21:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B1E84611EE;
	Tue, 27 Jun 2023 17:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A85AC433C8;
	Tue, 27 Jun 2023 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687886499;
	bh=PNa3JO5n3o6b4BL7RU2Bc1a+YpeIOyCfFKQrodxsVnY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOx146YjOLFZ9EbNKmXBZGJ8sqoSEVaJYHeK1K3l9v3O+1R+gCSJ45ImvfIJXMHz6
	 /y3513mIkK9OCgY5vbteiaiNdz2SM2HLNK76ViDAp06mnEabU/oQcjU/cmnzwHO3lj
	 Ib9z0BZs38/H40JeVUlHWuQrJCJxPptUF/M9a9tT/ldBiLX7oVVYW/6TbXxTyfg3KI
	 EAoiviytnXGDkWdPp4Dh/KZBK0jTDfF00ia1TCvCdiyrg6HG9oaQXy8C0xDSca2Xxc
	 CCcWFGqAKUf/oAsUGk5STw+AVnpZ3zpDeT+38NtLGsDAUWj0CSwd47EQY49chbFV+t
	 ojPRV9j7KSvrw==
Date: Tue, 27 Jun 2023 11:21:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH V2 0/4] nvme: fix two kinds of IO hang from removing NSs
Message-ID: <ZJsaoFtqWIwshYD6@kbusch-mbp.dhcp.thefacebook.com>
References: <27ce75fc-f6c5-7bf3-8448-242ee3e65067@grimberg.me>
 <ZJI/1w8/9pLIyXZ2@ovpn-8-23.pek2.redhat.com>
 <caa80682-3c3e-f709-804a-6ee913e4524f@grimberg.me>
 <ZJL6w+K6e95WWJzV@ovpn-8-23.pek2.redhat.com>
 <ZJMb4f0i9wm8y4pi@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRR0C9sqLp7zhAv@ovpn-8-19.pek2.redhat.com>
 <ZJRcRWyn7o7lLEDM@kbusch-mbp.dhcp.thefacebook.com>
 <ZJRgUXfRuuOoIN1o@ovpn-8-19.pek2.redhat.com>
 <ZJRmd7bnclaNW3PL@kbusch-mbp.dhcp.thefacebook.com>
 <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJeJyEnSpVBDd4vb@ovpn-8-16.pek2.redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_102140_317271_DB64AEBA 
X-CRM114-Status: GOOD (  21.62  )
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

On Sun, Jun 25, 2023 at 08:26:48AM +0800, Ming Lei wrote:
> Yeah, but you can't remove the gap at all with start_freeze, that said
> the current code has to live with the situation of new mapping change
> and old request with old mapping.
> 
> Actually I considered to handle this kind of situation before, one approach
> is to reuse the bio steal logic taken in nvme mpath:
> 
> 1) for FS IO, re-submit bios, meantime free request
> 
> 2) for PT request, simply fail it
> 
> It could be a bit violent for 2) even though REQ_FAILFAST_DRIVER is
> always set for PT request, but not see any better approach for handling
> PT request.

I think that's acceptable for PT requests, or any request that doesn't
have a bio. I tried something similiar a while back that was almost
working, but I neither never posted it, or it's in that window when
infradead lost all the emails. :(

Anyway, for the pci controller, I think I see the problem you're fixing.
When reset_work fails, we used to do the mark dead + unquieces via
"nvme_kill_queues()", which doesn't exist anymore, but I think your
scenario worked back then. Currently a failed nvme_reset_work simply
marks them dead without the unquiesce. Would it be enough to just bring
that unqueisce behavior back?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b027e5e3f4acb..8eaa954aa6ed4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2778,6 +2778,7 @@ static void nvme_reset_work(struct work_struct *work)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_dev_disable(dev, true);
 	nvme_mark_namespaces_dead(&dev->ctrl);
+	nvme_unquiesce_io_queues(&dev->ctrl);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 }
 
--

