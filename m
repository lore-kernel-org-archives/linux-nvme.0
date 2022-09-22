Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E321AC6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f5uC1dpUTQ1XnuOIUr3VHfCRs730cbLXKx2WvCGllsA=; b=2L0HchY2f8ff7J1/RnNUp/xDfE
	vyygEokSwwvvU6nYRhXPFO3K5SIrV7qX7nWSKF617xLtUvNjrmC3ZtMoERraqcq1TQIVLOpjWH8WO
	/3ND+XVTWnYwA+rxa4pCS+HaU1dGbtomdTsE2okk8XJy6wyx4Gq6ZCEV8AVC6zzVmSuWdEaADkxPd
	mPPuFL73ftlsj7blSPaEqKCEeu2Zo/doUI5uGxYbSlNShk6kmHXvO7xtZOJka3GvKGo8OTqwHJaWQ
	gE76DI2CrcLnjpRSSD7t6wwBlAPv0M/J4EnfkixxRTF2BHRVMfSXe6YwdRCuw7E1ztGaV3sV4t3k4
	yDNRYoSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHhS-00ECP6-7k; Thu, 22 Sep 2022 08:36:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHhO-00ECM6-1A
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:36:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD1191F37F;
	Thu, 22 Sep 2022 08:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1663835802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f5uC1dpUTQ1XnuOIUr3VHfCRs730cbLXKx2WvCGllsA=;
	b=anbPTBNhozW+edJ+1ysa3D9moA3J/mn63BCcQDDQfNvXooMTnapoyPuyNSJmGpOD/VOvSJ
	WT7sTjrWVvTiUA0eOlEVhawO7MevB9jWoN9UQMBQI80aCrQJ9tXzz6wu6ysik3S74xE/b+
	4cIkBTzAVhWAZUGeGl0EzDgAa4T3vPU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1663835802;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f5uC1dpUTQ1XnuOIUr3VHfCRs730cbLXKx2WvCGllsA=;
	b=205mES1Oz9TBWE+9a58wmmqkR9tJU8IEUJO6AzFyWXRJ5kZw8lo1itN6zIDP+N0/P4v0on
	0T8QbsP9YovRiHCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EBB013AA5;
	Thu, 22 Sep 2022 08:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0xuAJpoeLGOiZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 22 Sep 2022 08:36:42 +0000
Date: Thu, 22 Sep 2022 10:36:42 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v2 2/2] nvme: send a rediscover uevent when a persistent
 discovery controller reconnects
Message-ID: <20220922083642.ghdlmwofsfx74sca@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-3-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922081538.13364-3-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013646_300091_CD8A7924 
X-CRM114-Status: GOOD (  14.49  )
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

Reviewed-by: Daniel Wagner <dwagner@suse.de>

