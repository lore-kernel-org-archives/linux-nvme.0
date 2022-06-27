Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 08:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8QcvcucK/UAaLI0xf5u7UQLYY9I4Wy+EdIIQdG3B0Ac=; b=yLFewFPAikk6a5nJBCMRH/0He2
	AECMYhuE1EZga/t5ScJRsald5gUhCHQdvjSzgdoMRhxkQ6VKSjlRccAp2qiUJkGS2+JfNi2huYpXK
	COza6lw7XjIpRvT9M1eOwUdfl85cpzVyj+sx4bwMSXNgKnsZ1W8i1tGoWGzsysjOXyyAoqKNJqJlC
	CqsDu/CZ+dHtaGviLi1Rl9lasi6BEZfYIvvXdg0S0ap23hiqjBZCWkStUUNgsfTLNi+OfFhZV44wY
	JH0BIGNX8rKOCsRXxgzut/EgZWhAj2gROIk3m1vs3KDE+zMZwhw4Jm0u7+2FxG+J+CtRDyIy67XXg
	0xyrmK2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5kU0-00H0DE-T9; Mon, 27 Jun 2022 08:52:36 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5kTy-00H0BT-8J
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 08:52:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 150E41FACA;
	Mon, 27 Jun 2022 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656319952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QcvcucK/UAaLI0xf5u7UQLYY9I4Wy+EdIIQdG3B0Ac=;
	b=KaGct1P0sdWuSTUyc6Z85lBoLHICxlarxdqjW+24rqo/pPMYMVLltjHZXkqtXPy/PYvoRv
	c5MwpF4Vb3sijk5A/tRu7o52HaJHhV8kxnfwFbERu/xs/tB7hGlxC8L0wH78M7tC47wWeH
	homer5Vgzk3j3nU0HKkp8TtitB+udAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656319952;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8QcvcucK/UAaLI0xf5u7UQLYY9I4Wy+EdIIQdG3B0Ac=;
	b=lQEPxS5VlIlauwzUs4/1sWiMRShnI4B8MbClMHIcW7B/E/EZVVHLMlpihufOn/m66qF738
	kSyxxHdqo+qKHJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 07C5113AB2;
	Mon, 27 Jun 2022 08:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /5LfAdBvuWJwGQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 27 Jun 2022 08:52:32 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH libnvme] fabrics: don't treat host_traddr 'none' as a valid hostname
Date: Mon, 27 Jun 2022 10:52:28 +0200
Message-Id: <165631993994.15513.14550580034616383621.b4-ty@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627080639.108828-1-sagi@grimberg.me>
References: <20220627080639.108828-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_015234_496489_025D4971 
X-CRM114-Status: UNSURE (   9.65  )
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

On Mon, 27 Jun 2022 11:06:39 +0300, Sagi Grimberg wrote:
> We treat 'none' as an escape value for optional arguments, do the same
> for host_traddr.
> 
> This makes prints like the below go away when passing --host-traddr=none:
> sh[3244]: failed to resolve host none info
> 
> 
> [...]

Applied, thanks!

[1/1] fabrics: don't treat host_traddr 'none' as a valid hostname
      commit: 1d62f8aaacec67ab42a01c96a696b52c5f4e0c01

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

