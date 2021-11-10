Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3454C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 11:18:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86A1A610D2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 11:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 86A1A610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UhlGqKzvEEJ5Z+Ixk3FXxUpR7oNMYE7xkQrfu6eryDg=; b=AfxyfMezenAvR7ry4J9Bu+iCSX
	PkpS4PQL+egKPpSQltYas/ixSuMWECIZPhK5ocdeSuy8AitakWmvLufK+BPnPiHydolNPvUOfmyDS
	dx8gtWsVbp4e3aKgrModRPGyxw7ZkZB9ixNpmCANQoNOibBbWbNG4/9PV5qJt5bNiQ8pNR3W1mQ66
	fJmWoXnVxKyhdBV7iY32+SYLpTodgEt5evriSqU3a8Q80Wmwe1PAx4+7oJ04XTi2nb/N023f9/rP2
	fktr0u8z6fqZVLFSOSIJMC3zhOWMY+DJd1Gc3uKDuPLRvJQmDsdCQcRBuTVfmcyYRrgl/UGHLumnn
	7ZWdR9SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mklcv-005Gu1-L3; Wed, 10 Nov 2021 11:18:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mklcs-005Gth-M7
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 11:18:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F7A81FD43;
 Wed, 10 Nov 2021 11:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636543125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhlGqKzvEEJ5Z+Ixk3FXxUpR7oNMYE7xkQrfu6eryDg=;
 b=eMMNvWMxeVZbtFMsFfsG8qqPFo7rENdRtChbVmHTuJFtoOKQ33CklnMMSg+EQF8VBD3ITa
 +vcS0Ou1JNy9j8kCddV3dO/ktJfJBShanUfyBHlRabh68xAaMF7/ORMfanuRvqQbcQpKMx
 67M5k4bK0e8KA/oQwlQoCRTTrGCnQY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636543125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UhlGqKzvEEJ5Z+Ixk3FXxUpR7oNMYE7xkQrfu6eryDg=;
 b=VjADz84P05lWSTWW7+BZBtP46IEgaHy5Rcgj7XdBE1uqxIh7EnBr3lwzU26tirvzTS+C31
 z3yOUN3bMYJplFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FA1213BAC;
 Wed, 10 Nov 2021 11:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wgJhE5Wqi2EMVAAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 10 Nov 2021 11:18:45 +0000
Date: Wed, 10 Nov 2021 12:18:44 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me,
 chaitanyak@nvidia.com, oren@nvidia.com, benishay@nvidia.com,
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com,
 jsmart2021@gmail.com
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
Message-ID: <20211110111844.cv6wqhonfk2jzapj@carbon.lan>
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211110103247.i7jnkg3bpbet42wm@carbon.lan>
 <917d7535-9749-2738-6162-4d2d390e478c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <917d7535-9749-2738-6162-4d2d390e478c@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_031846_916161_C43F5570 
X-CRM114-Status: GOOD (  11.36  )
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

On Wed, Nov 10, 2021 at 12:56:38PM +0200, Max Gurtovoy wrote:
> It's strange that we need to add all these if conditions and logic in the
> fast path for RDMA/PCI/FC and even for TCP for some non existing target that
> was buggy in the development process.

The concern is that a buggy target could easily cause unnoticed data
corruption, which is even worse than just crash. IIRC, I wasn't the
first one seeing a wrong cmd_id, although it seems to be pretty rare
(well, these days even rare bugs happen way too often).

