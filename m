Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E64C001DE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=voPZVihT3jhQAE+bQukxUMDUrOSYAi2zGU9Q6bbP430=; b=lqJwSdS0fULrqcMcuK+Y1Wup5m
	Yv54TRkWrNFhDtwovL9RUpbsqTmSBS+AJPhAFHgf8DjrPz9klFSsvr6oyo07zcOw8bSLcGbYf2LlQ
	Odq9DOsGKHSxdwZ5Ff6Sn+NI4rth616W405xPpRpmdoy7f9+LV3TtlNQvPQYwmkEbNjKFgpMIw+lO
	H8DGrgZh8Tpv2FfdyYyblL+Zq4WSqNBXYW+fzL9q9U6NTLZ2+TZCSARY+8emZjTwxWqy7pkFrpD0g
	vIqWQk8YmzDeieI+GNsX4ylSSNBGyp3+HfE8QeAJgM0Ui7wyZqTG/4Yeg0Qol/WfCcuvJiEvNlDHV
	w2vptc/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVDvB-00FRlO-0c;
	Sun, 13 Aug 2023 16:26:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVDv8-00FRko-1b
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 16:26:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B14E9638AD;
	Sun, 13 Aug 2023 16:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6D4C433C8;
	Sun, 13 Aug 2023 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691943985;
	bh=s5dT010UIn2FJfSNfbpZQ1GBn9UlLwHEftGd4vg+tIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dhu91dYEvIvHGT0iKN69McmHh4aWRUmmzbLmpvoJ0U/pyS6LG9nHStJLzAgoAwBoH
	 bGmE8oPUBKHzWlfPelaa8CW5T8yL9AXTShR+9patEuTrLsb8CkeYPfJq/2Bg6R0EqU
	 DhRmd1uxF5Hvcbc0fFPXCkPh8FPzScqquqsLL/fY=
Date: Sun, 13 Aug 2023 18:26:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: stable@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5.15.y 5.10.y 5.4.y 1/2] nvme-tcp: fix potential
 unbalanced freeze & unfreeze
Message-ID: <2023081310-playback-thirstily-c79f@gregkh>
References: <20230813144510.15401-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813144510.15401-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_092626_589475_7A330FC2 
X-CRM114-Status: GOOD (  15.75  )
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

On Sun, Aug 13, 2023 at 05:45:09PM +0300, Sagi Grimberg wrote:
> From: Ming Lei <ming.lei@redhat.com>
> 
> Move start_freeze into nvme_tcp_configure_io_queues(), and there is
> at least two benefits:
> 
> 1) fix unbalanced freeze and unfreeze, since re-connection work may
> fail or be broken by removal
> 
> 2) IO during error recovery can be failfast quickly because nvme fabrics
> unquiesces queues after teardown.
> 
> One side-effect is that !mpath request may timeout during connecting
> because of queue topo change, but that looks not one big deal:
> 
> 1) same problem exists with current code base
> 
> 2) compared with !mpath, mpath use case is dominant
> 
> Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> Tested-by: Yi Zhang <yi.zhang@redhat.com>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/tcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

All now queued up, thanks.

greg k-h

