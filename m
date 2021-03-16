Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3C0C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 20:42:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 407A164F7B
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 20:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 407A164F7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+/57lQothwo0meY+IJ+sbPrh/2bgNOwAEuOCbYnSITw=; b=PUpULorICo1sy5SGjwJgUHWF1
	sGxReaYKrVHMItBjY7HQLPVvIYXDyr2rb105L902dCI8aaxkNCYdgkju394FdmRuV4NNx+gNuKj3S
	LO+zq/gPknKxExLQj7IP/2+fO4qrDjziCVmcuRbe0U2fIh6lTYenWHq/2UPicklhCTyrl5KV69zTr
	cfZkTjHRKX2Mf9ATCknpo7Bjb/Lp9UOppsnrySb+ptkSAR3EU+YI/pD6DnKahtia+zMMic4XPZs3i
	mf6j8Hrv+YAp0klWI2PvySXiL1dEf5IAwLpvoKRva8S7RoJsic1ZOndomYuNR+vThb/7zFpVC6Zmb
	FfB7Uv7xQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMGW9-001pe6-O2; Tue, 16 Mar 2021 20:42:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMGW3-001pdF-W6
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 20:42:14 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEB4E64F80;
 Tue, 16 Mar 2021 20:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615927330;
 bh=TjTwzhq2sGTGsYpToU5MpWJqybqsULdr3UF1MBBuPpc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=G8Wo2rHPmgIaCYj0XSYV/PMgSb6GLnwjxwfflSRrqUcSd2cySTNLdItip2rPBZZ9+
 4OWUT7sWVR4KpUC6Yglp//Cdgfu9S58jJyMsj6b7JrsJe9Qpuy8YKzAyiONeNbyGBP
 TYv4M0tU0hwL51cv8aYJO3MaWSnY8U1/PLJZsLogS3+4vAdh13SNsdTsDM7rcIGbYz
 aZ8yx5S+YYlIXVmmiZ1vc7a6tQXJHc6drFxb8umn9CLkn47mSPlIPEapkq7DIph5ww
 pcewLvAuHQctt9fcMDW8r7Z0uulzsKyAOm7J6jdT4VxmLs4MDlCw5bGzx2jdn0ez/E
 J798W3gPpaIyA==
Date: Wed, 17 Mar 2021 05:42:04 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH 0/3 rfc] Fix nvme-tcp and nvme-rdma controller reset hangs
Message-ID: <20210316204204.GA23332@redsun51.ssa.fujisawa.hgst.com>
References: <20210315222714.378417-1-sagi@grimberg.me>
 <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1b2ccda9-5789-e73a-f0c9-2dd40f320203@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_204212_672036_2F326779 
X-CRM114-Status: GOOD (  29.69  )
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

On Tue, Mar 16, 2021 at 01:07:12PM -0700, Sagi Grimberg wrote:
> > The below patches caused a regression in a multipath setup:
> > Fixes: 9f98772ba307 ("nvme-rdma: fix controller reset hang during traffic")
> > Fixes: 2875b0aecabe ("nvme-tcp: fix controller reset hang during traffic")
> > 
> > These patches on their own are correct because they fixed a controller reset
> > regression.
> > 
> > When we reset/teardown a controller, we must freeze and quiesce the namespaces
> > request queues to make sure that we safely stop inflight I/O submissions.
> > Freeze is mandatory because if our hctx map changed between reconnects,
> > blk_mq_update_nr_hw_queues will immediately attempt to freeze the queue, and
> > if it still has pending submissions (that are still quiesced) it will hang.
> > This is what the above patches fixed.
> > 
> > However, by freezing the namespaces request queues, and only unfreezing them
> > when we successfully reconnect, inflight submissions that are running
> > concurrently can now block grabbing the nshead srcu until either we successfully
> > reconnect or ctrl_loss_tmo expired (or the user explicitly disconnected).
> > 
> > This caused a deadlock [1] when a different controller (different path on the
> > same subsystem) became live (i.e. optimized/non-optimized). This is because
> > nvme_mpath_set_live needs to synchronize the nshead srcu before requeueing I/O
> > in order to make sure that current_path is visible to future (re)submisions.
> > However the srcu lock is taken by a blocked submission on a frozen request
> > queue, and we have a deadlock.
> > 
> > For multipath, we obviously cannot allow that as we want to failover I/O asap.
> > However for non-mpath, we do not want to fail I/O (at least until controller
> > FASTFAIL expires, and that is disabled by default btw).
> > 
> > This creates a non-symmetric behavior of how the driver should behave in the
> > presence or absence of multipath.
> > 
> > [1]:
> > Workqueue: nvme-wq nvme_tcp_reconnect_ctrl_work [nvme_tcp]
> > Call Trace:
> >   __schedule+0x293/0x730
> >   schedule+0x33/0xa0
> >   schedule_timeout+0x1d3/0x2f0
> >   wait_for_completion+0xba/0x140
> >   __synchronize_srcu.part.21+0x91/0xc0
> >   synchronize_srcu_expedited+0x27/0x30
> >   synchronize_srcu+0xce/0xe0
> >   nvme_mpath_set_live+0x64/0x130 [nvme_core]
> >   nvme_update_ns_ana_state+0x2c/0x30 [nvme_core]
> >   nvme_update_ana_state+0xcd/0xe0 [nvme_core]
> >   nvme_parse_ana_log+0xa1/0x180 [nvme_core]
> >   nvme_read_ana_log+0x76/0x100 [nvme_core]
> >   nvme_mpath_init+0x122/0x180 [nvme_core]
> >   nvme_init_identify+0x80e/0xe20 [nvme_core]
> >   nvme_tcp_setup_ctrl+0x359/0x660 [nvme_tcp]
> >   nvme_tcp_reconnect_ctrl_work+0x24/0x70 [nvme_tcp]
> > 
> > 
> > In order to fix this, we recognize the different behavior a driver needs to take
> > in error recovery scenarios for mpath and non-mpath scenarios and expose this
> > awareness with a new helper nvme_ctrl_is_mpath and use that to know what needs
> > to be done.
> 
> Christoph, Keith,
> 
> Any thoughts on this? The RFC part is getting the transport driver to
> behave differently for mpath vs. non-mpath.

Will it work if nvme mpath used request NOWAIT flag for its submit_bio()
call, and add the bio to the requeue_list if blk_queue_enter() fails? I
think that looks like another way to resolve the deadlock, but we need
the block layer to return a failed status to the original caller.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
