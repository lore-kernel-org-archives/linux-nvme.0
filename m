Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FDEC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:31:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6668461056
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 09:31:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6668461056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=QVlzIpILGCX2cSbTj10pta+epgM32rCI48aokEI8INc=; b=KfljvIdDEis0Tv
	3I+bPURZUd6vPsFUeKfa8ZTbO4M6OCK8GNOSFZ7wpJTP5K69X8eq8cLqsExooEmnKMu6XD1RwfVo0
	LQ6a7cg+UGKTtV/QHLnvZDC4QOpb81YDCDztsXC3hpb6XKo/CuiXu00qkx0tAB3yR+mf5mzHD1/y7
	7auyYuelqwABjOJ+dkwaKRhOv7G4p3nhBC/Xv11NTVU09YCEjqmU3CDVzrKwlK1cJIWMwCm9IT9Np
	RQ51t7tk/GSWx7h9LJdjpim+397fLQ7BupMEe8DfTApfa/KFjtNBC286GKeTkdnMoVTr7JZsB+EFl
	Lf6OSRIe3T4TRpixrOlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ4mS-00528m-0n; Tue, 14 Sep 2021 09:31:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ4mM-00526i-O7
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 09:31:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58102220C5;
 Tue, 14 Sep 2021 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631611861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kleTtUGI4frcW5XKf0ZIxvfz5xt9nURnbuxlPNVmvo8=;
 b=U8edeJvigDZ7TzGBT0NYlq3AjoOqHVGf2/YmKc0MLoNVSlgJcXAaZoHRjNcWWqIPYNVONw
 /JhjDKQRMxwfjeaCeC0oXgdYQkpdac7eC/FLUVucT5Tb+PES1hK4Z/MaSn1cAYoVZViCHq
 EwPXnO6aILYNy6N5FPLJ/EjhPBoa3Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631611861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kleTtUGI4frcW5XKf0ZIxvfz5xt9nURnbuxlPNVmvo8=;
 b=/re32NDJ9OT94bTHYyMIOKeUALOy97/QRCnJ8AKRq4UpdGrLY+jV4SVKfiLs5AaJ8PAykk
 jCRn9TPlR/f4f5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45B5B13E55;
 Tue, 14 Sep 2021 09:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id YDtxEdVrQGH5RQAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 14 Sep 2021 09:31:01 +0000
Date: Tue, 14 Sep 2021 11:31:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Saurav Kashyap <skashyap@marvell.com>, Sagi Grimberg <sagi@grimberg.me>,
 Nilesh Javali <njavali@marvell.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 GR-QLogic-Storage-Upstream <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [PATCH 0/2] qla2xxx - add nvme map_queues support
Message-ID: <20210914093100.oeunl6q3kp4f34ab@carbon>
References: <20210823125649.16061-1-njavali@marvell.com>
 <c72c7669-8818-77f1-2e5d-98bb24308f08@grimberg.me>
 <DM6PR18MB30340DC93DCC82CFFAAE3ACCD2C59@DM6PR18MB3034.namprd18.prod.outlook.com>
 <YSRrmOmrwm5olk0D@T590>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YSRrmOmrwm5olk0D@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_023102_987198_6BF561A2 
X-CRM114-Status: GOOD (  10.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Aug 24, 2021 at 11:46:32AM +0800, Ming Lei wrote:
> OK, got it. Even though without this patchset, nvme-fc actually relies
> on managed irq since qla2xxx driver uses pci_alloc_irq_vectors_affinity.
> 
> Now the patchset[1] isn't good for addressing the issue in
> blk_mq_alloc_request_hctx().
> 
> [1] https://lore.kernel.org/linux-block/YR7demOSG6MKFVAF@T590/T/#t

Ming, do you have any ideas/suggestions how to address it? I can work
on it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
