Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B92AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 13:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4K8+vy5dp3/xTVfHeKHTcJKAcIEET4rNNgmvT9+qeMk=; b=UmyEBGVcYR1cEmCeng4lX3EZHP
	RcJ9e+YXQqCEsnKQceZevqKC2l+dc2UvTVahckaQEAtY2mSB91u+I8fZiK4h+zNG/hBWNCWWBrk84
	XdmtfkjW1w+G7c45m+i9QiI2Y4mlIcD1axwaujS15JxsVjPj9NTxOpkDWd8VsLhKgP7trRWWGgJLJ
	7iEk/PmX33h4RozUFz4dVcqeXZLvM9ksAGQ0KsJZeLG1Otmn8DCBX79T7lPHNPC/WVXyZAFdtINQ5
	BHxWZByFgVN9V3yZSiGsLp3NIB3gZnTOAWcUIBXDWTtxkjbh8a7E7fo4rtXLdtqlo03BHZt2QgMlv
	E7K8yN8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntUjl-008831-BX; Tue, 24 May 2022 13:38:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntUje-00882a-Be
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 13:38:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 942EA21A25;
 Tue, 24 May 2022 13:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653399483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4K8+vy5dp3/xTVfHeKHTcJKAcIEET4rNNgmvT9+qeMk=;
 b=fDmiJG6shcVdHm1tvBpyJU5QfdIj817auEWvlggdUyuNh9vxvLz7B+gO89FbXjVFowaPrO
 AOFpK3ZdiIXhU6oWw0Q1UQL+2LzpvX92FsGJ/eGdXdlZxJ1+VdNqRNhl/AUXnSOFsa6tnu
 t5m6WSoxQgIycz9Vhm0ZhnOgYnep3Ok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653399483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4K8+vy5dp3/xTVfHeKHTcJKAcIEET4rNNgmvT9+qeMk=;
 b=P9pZBIqoqtV6WK1HBo9FTH5vG4UF1MMkX/9Unc3T8f4i4JzRbU1D2dzs8sdRb2jjRuEYpj
 dclMljiLQ8viz6CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8662D13ADF;
 Tue, 24 May 2022 13:38:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +YrNILvfjGIrAgAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 24 May 2022 13:38:03 +0000
Date: Tue, 24 May 2022 15:38:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [RFC] nvme-rdma: Stop queues when starting with error recovery
Message-ID: <20220524133803.3f6dql3waflypl5q@carbon.lan>
References: <20220523152102.41000-1-dwagner@suse.de>
 <c3e5bad8-8cca-8058-38d7-0eea2ddfd6bc@grimberg.me>
 <95e18f3a-7997-ccbe-7889-18585bb72ff3@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95e18f3a-7997-ccbe-7889-18585bb72ff3@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_063806_589372_BCB068B3 
X-CRM114-Status: GOOD (  28.91  )
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

On Tue, May 24, 2022 at 04:13:28PM +0300, Sagi Grimberg wrote:
> 
> 
> On 5/24/22 16:12, Sagi Grimberg wrote:
> > 
> > 
> > On 5/23/22 18:21, Daniel Wagner wrote:
> > > When we enter error recovery we should stop all queue activities and
> > > all armed timers.
> > > 
> > > For example, we could arming an ANATT timer right before we enter
> > > error recovery but do not successfully recover before the timer
> > > fires. The timer is supposed only be active when the controller is in
> > > LIVE state hence we should call nvme_stop_ctrl when starting with the
> > > recover activites.
> > 
> > This takes me back... IIRC the main reason why the error recovery
> > handler in nvme-rdma (and nvme-tcp) does not start with nvme_stop_ctrl()
> > is because back then, nvme_stop_ctrl() could block until an
> > admin_timeout expired on an inflight admin command (I have a vague
> > memory that if cancelled/flushed the scan_work), which delayed I/O
> > failover, hence we just cherry-picked what needed to be stopped to make
> > sure I/O failover will not be blocked by anything and progress quickly.
> > 
> > If I look at nvme_stop_queue
> 
> nvme_stop_ctrl obviously...
> 
>  it does not touch the scan_work, but it
> > does flush ana_work which includes I/O, so it can still block on it
> > to fail after admin_timeout expires... also flush failfast_work is
> > taking the namespaces_rwsem (although read access). The fw_act_work
> > is probably meaningless for fabrics...
> > 
> > Maybe we need to have something like nvme_stop_ctrl_fast, that will just
> > stop the non-blocking stuff, so failover can work quickly, and then
> > after we have failover, we can do the full nvme_stop_ctrl() or the
> > reminder of nvme_stop_ctrl_fast...
> > 
> > thoughts?

I suspected that nvme_stop_ctrl() might have unwanted side
effects. Maybe factoring out the common bits from nvme_stop_ctrl() into
nvme_stop_ctrl_fast() and call it from here sounds like a reasonable
thing to do. The function name could be better, but naming is hard.

