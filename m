Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEECC4338F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 08:58:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551D96103B
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 08:58:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 551D96103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=mmwE7M9L4CYAxvNkxfXflkIZ0/zzj8A/OZPKRfXrkOw=; b=VrEODQHvqlME7C
	FcycyaoVrMXkQ0ym54+ml34pzJFfsofH+i6DXUFOQzs+GUDIFD7IDaj/3ins81M3yfrjKwsdOTjdE
	7GrCwfIBORn8jGCwUhSRYfX6xHQXl9Q9B5wvGbTiMNSBfXzJbwAIh+Dz5bCbEK+uaPS6jZfhQ5tXS
	B6DONnHy0AhCchk0CiZ+H87FVUBpuhLk3QA380/sb3H6Ze+C9rk3rgqwFNtSIBE2tD3ALWLthD2zF
	uwrNpejINoJYTZ47ntc0nuUwM92FSO51XcraIMcFzF5dqWcYl+cAepxY5D86xtlJ3VC+1YHKvBYSt
	eFqjwfR7gZZYgk0BtLmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD16p-00HWcw-HW; Mon, 09 Aug 2021 08:58:11 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD16n-00HWcE-0r
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 08:58:10 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ADD161FDAD;
 Mon,  9 Aug 2021 08:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628499487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcWWQK19Xa6GOBXM7LflCcqBUTWsQXKfbG2mDyL0SxU=;
 b=padfdtL4ld65kA1j8ASFunpTuCaQEeDyeltyz6XAOhqz+lA7V01Vkx08xKncHn8cXQN15B
 FcjnC0XRgwDa7iRVNGgiiP5MeDchU1WbdMa2I06fIzTlfKCzJSBfHTCNFftPLrlssgkt5D
 fg/ZIMh06KcKGDEHaZx1mBhezmfPnpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628499487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DcWWQK19Xa6GOBXM7LflCcqBUTWsQXKfbG2mDyL0SxU=;
 b=tEH0w+p3OnOz/t86IhLTtsNTIxHjArVIP4uUz0SIdIA6/6AIE+7gPMhivvQcO8vJJygI9g
 upu+H6b3V9IsatCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9CE43132AB;
 Mon,  9 Aug 2021 08:58:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id FIfbJR/uEGG6KwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 09 Aug 2021 08:58:07 +0000
Date: Mon, 9 Aug 2021 10:58:07 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Hannes Reinecke <hare@suse.de>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 8/8] nvme-rdma: Unfreeze queues on reconnect
Message-ID: <20210809085807.p5agrbuqxhlznmkr@carbon>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-9-dwagner@suse.de>
 <46d4d7cb-314a-3822-f59d-00588609421a@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <46d4d7cb-314a-3822-f59d-00588609421a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_015809_259863_096B9628 
X-CRM114-Status: GOOD (  22.58  )
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

Hi Sagi,

On Fri, Aug 06, 2021 at 12:59:15PM -0700, Sagi Grimberg wrote:
> 
> > During the queue teardown in nvme_rdma_teardown_io_queues() freeze is
> > called unconditionally. When we reconnect we need to pair the freeze
> > with an unfreeze to avoid hanging I/Os. For newly created connection
> > this is not needed.
> > 
> > Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >   drivers/nvme/host/rdma.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index de2a8950d282..21a8a5353af0 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -901,6 +901,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
> >   			error = PTR_ERR(ctrl->ctrl.admin_q);
> >   			goto out_cleanup_fabrics_q;
> >   		}
> > +	} else {
> > +		nvme_unfreeze(&ctrl->ctrl);
> 
> That seems misplaced.. unfreezing the I/O queues when setting up the admin
> queue?

Indeed. After looking again on it, this should be almost identically to
the tcp.c fix in nvme_rdma_configure_io_queues.

BTW, I am working on getting a RDMA test setup running. Hopefully I have
all the right licenses on the array.

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
