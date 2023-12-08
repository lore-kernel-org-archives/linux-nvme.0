Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE750C10DC1
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Dec 2023 09:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dChrB1aaGyO8fT5JK9u5mL9odiGYVuDJncDDcfewYEc=; b=PQKLrYY9pyjZ5BMS6+obTOHILf
	r+nW6RmukB1cTfTBGoqwgpfNLBNRoDSP2d9yPR1mGuE1JiE8HdagruL/aI2l7E8H0tx5D9W1LCTmI
	C8ePBYosO8qwwmVfnYcOURqFcRZyTQC/TKKcgLOIT2+qjXwof4yBdTEjDfauqGZu57U1SXSV25bde
	0TxiN+G0Ndcc91oRVMACW//Sh9sm2NCSolibzZtv77jzjXtlRFPdfTokAGkBzqwe9lV8ZaK6q2fqF
	CGeROlsMoekVXuP3pQ2nuzc0uP10v+tgRoUUhDpKrSpr608DIUb5zdo4S4QRaxi9MsGAm4uPh1q82
	HCu8C2Tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBWt0-00F6Ar-2p;
	Fri, 08 Dec 2023 09:11:06 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBWsy-00F69t-1i
	for linux-nvme@lists.infradead.org;
	Fri, 08 Dec 2023 09:11:05 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6E9601FDAC;
	Fri,  8 Dec 2023 09:11:00 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BE6A138FF;
	Fri,  8 Dec 2023 09:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id O4/3FKTdcmVIOQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 09:11:00 +0000
Date: Fri, 8 Dec 2023 10:10:59 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 3/4] nvme: add csi, ms and nuse to sysfs
Message-ID: <dakki3aqgyv6ylnnaketcsqsqwen23ffqawmzsrypfu3p7gh2m@n4ut2vb6hxz3>
References: <20231207123624.29959-1-dwagner@suse.de>
 <20231207123624.29959-4-dwagner@suse.de>
 <ZXH2is7F56nRlGqd@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXH2is7F56nRlGqd@kbusch-mbp>
X-Spamd-Bar: +++++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [13.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(3.00)[1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[20.18%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Rspamd-Queue-Id: 6E9601FDAC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231208_011104_716870_12B38B45 
X-CRM114-Status: GOOD (  10.53  )
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

On Thu, Dec 07, 2023 at 09:44:58AM -0700, Keith Busch wrote:
> On Thu, Dec 07, 2023 at 01:36:23PM +0100, Daniel Wagner wrote:
> > @@ -3418,6 +3419,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
> >  	head->ns_id = info->nsid;
> >  	head->ids = info->ids;
> >  	head->shared = info->is_shared;
> > +	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
> >  	kref_init(&head->ref);
> 
> I think we need to add:
> 
> 	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);	
> 
> So that we don't get periodic messages like:
> 
> 	[   60.469730] ns_head_update_nuse: 39 callbacks suppressed
> 	[  159.532901] ns_head_update_nuse: 1999 callbacks suppressed

Good idea. I'll add this.

