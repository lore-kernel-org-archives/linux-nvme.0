Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F06EEB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YJhnEkfD1jsN4t8MPe/F0flXlGnvUjNwChAguWMLs8w=; b=p8mZwDADqdIN6kiXRw3Uik8ywG
	RjaaDCrftsy/JGYKCqQl68ikwjz1H9LsN4egLNLU4CfvKmz0A4ki8z8n89Hiar+SffvmpuLDXwm4p
	kJFUniwRqSE6oJL9SWU0te2J8upgWTZW/lxw3IE1avOWMKEP7ozQFJMaN+xNt3GiDRmIHVDMxTISl
	h2DQTFCDyL0Y3E7OlCyhJ7D1B6vOzD01y8a7a/lGTMIDdmIf+A0DqfT14yh75n/uva4cYDeOi2t2P
	78TQWKA5XiItohli7TI0C+YfQzld5WDfktNypk5u/8tujp8dNEQc98Q0vIZ86XAm/EMwwBbgvoXYL
	aA9fD6pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYDh-005npV-1L;
	Thu, 17 Aug 2023 08:19:05 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYDe-005noT-0F
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:19:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D6DDF1F891;
	Thu, 17 Aug 2023 08:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692260340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJhnEkfD1jsN4t8MPe/F0flXlGnvUjNwChAguWMLs8w=;
	b=Lgove2rkHKp59k+4QbLjeat5w5zsp2sbqj9E4o0+Bom2uhwsBBcq/QORQQiqFI0wOASPF9
	bupjXXVksie+fiAgCJMxwxyZBxo0ZLH7BaojlZNS4smCNV3fbJ/A9obJhkIg9ytzWyEZ+n
	TB2BN+jyT6qNDx+Fo0URyollvMkOr44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692260340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJhnEkfD1jsN4t8MPe/F0flXlGnvUjNwChAguWMLs8w=;
	b=fmZsvtFo5krEWNZ6g8FFEkrIEfS0hbkrAt8u1AU0HzbP+KiT3evThdT5JHS0HanvGSNOb9
	I0w2lnfE4qPwYEDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 993111392B;
	Thu, 17 Aug 2023 08:19:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HZ2fIfTX3WRBUQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:19:00 +0000
Date: Thu, 17 Aug 2023 10:19:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>, 
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Message-ID: <lqazvjte6tnjw45txgeo4yzj3cvyj427z5ldwnbbr5j7wf5jwf@g6twqzzqgdgl>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_011902_260871_147713E2 
X-CRM114-Status: GOOD (  20.51  )
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

On Thu, Aug 17, 2023 at 04:30:20PM +0900, Shin'ichiro Kawasaki wrote:
> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.
> 
> However, this wait by _find_nvme_dev() has two problems. The first
> problem is missing call of _find_nvme_dev(). The test case nvme/047
> calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
> for the first _nvme_connect_subsys() call. This causes too early I/O to
> the device with tcp transport [1]. Fix this by moving the wait for the
> device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
> add --wait-for option to _nvme_connect_subsys(). It allows to skip the
> wait in _nvmet_passthru_target_connect() which has its own wait for
> device readiness.
> 
> The second problem is wrong paths for the sysfs attributes. The paths
> do not include namespace index, so the check for the attributes always
> fail. Still _find_nvme_dev() does 1 second wait and allows the device
> get ready for I/O in most cases, but this is not intended behavior.
> Fix the paths by adding the namespace index.
> 
> On top of the checks for sysfs attributes, add 'udevadm settle' and a
> check for the created device file. These ensures that the create device
> is ready for I/O.
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/
> 
> Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

