Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BD8EB64DD
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 19:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZ55P4iDNKgYah8xE/kBoxRGzc03qwyRThJ/jPQDUzA=; b=UeKsSpfCZVZl5jVBm4Ac71+J0r
	lJ/osI09vqT/afB2NlrIv70IK1uRmZymkzATaiMecY0l3D2d6FR9ys1CsgZaOe2JQJHwIsB8sRD9C
	lyHJtHqnE1lXe3RTIzbbq2B+wlJZdFJcWRkpmu2uxZEZ7P7NObLQdYMVS/XO44Wc0JAPsKomDugqA
	6aJzNvJ6My5Dep9m50mzspjerTFo3FtEA2Dz5+Vou5R0XnhKH/qy+tUXQI6KBnSYYPPmmLIw6Ykth
	rDfdEyMRDSbrTstkT7gCZP4bQIzGZMqtdP74qWcMwm7DSs13ZdIhu2yrXjpGgqVkB+2maKTpTvdHk
	XJ85mMrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1LU-005JHV-2d;
	Mon, 24 Jul 2023 19:35:52 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qO1LS-005JGD-0X
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 19:35:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CA66061290;
	Mon, 24 Jul 2023 19:35:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA18C433C7;
	Mon, 24 Jul 2023 19:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690227348;
	bh=+3SNOt1+WZwJata7+r2bIJ7TFCvk4aRi9FuKIxNSs58=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f/f7ORKUlKe81g7fI716ruYhgDBzhpBjZilLIqEUDahKxfHcQneQp6a5IoB0HMYAt
	 WxdZI1sNJZU7LJ6WLc+P7eGIUHJp+Clf+KGZAhcmKGkg/j7L8zyTJAy2A873bSOIgf
	 /XNiQiNpR1HCZKP5+R57LgYzAZo4Q9BnVNROa6OXzfbhBuBDGfdvluVV7NL0hMrzar
	 WEYmLDqJ/zj/mf+3J+AWj6K/PrJBjnaLEi0Z3+6HKzw/5LFsxoiUSk4py2F/5re29j
	 GdBo+d3QbiXgBIbN4BeyOD8pNhyomD+LENIA/iN+1RDhjcc+e1SdKouVfPh4vVfg5a
	 wWdX4f87RzhpA==
Date: Mon, 24 Jul 2023 12:35:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCHv8 0/6] net/tls: fixes for NVMe-over-TLS
Message-ID: <20230724123546.70775e77@kernel.org>
In-Reply-To: <9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
References: <20230721143523.56906-1-hare@suse.de>
	<20230721190026.25d2f0a5@kernel.org>
	<3e83c1dd-99bd-4dbd-2f83-4008e7059cfa@suse.de>
	<9f37941c-b265-7f28-ebec-76c04804b684@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_123550_269217_4ED25993 
X-CRM114-Status: GOOD (  17.74  )
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

On Mon, 24 Jul 2023 10:21:52 +0300 Sagi Grimberg wrote:
> >> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> >>
> >> Sagi, I _think_ a stable branch with this should be doable,
> >> would you like one, or no rush?  
> > 
> > I guess a stable branch would not be too bad; I've got another
> > set of patches for the NVMe side, too.
> > Sagi?  
> 
> I don't think there is a real need for this to go to stable, nothing
> is using it. Perhaps the MSG_EOR patches can go to stable in case
> there is some userspace code that wants to rely on it.

I'm probably using the wrong word. I mean a branch based on -rc3 that's
not going to get rebased so the commits IDs match and we can both pull
it in. Not stable as in Greg KH.

