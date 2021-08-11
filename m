Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41A7C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 10:26:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C482600CD
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 10:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6C482600CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ijO0i4SiOCtEwmJOrB1c+XBa5GgjKyUMw1t1b3swYrY=; b=lV08mtDXttF4Ln
	iFvEPr8pvZ1oFkIfQ1JkIuQL9W7RYiOuRWgC3DSed+F9C8BaweJZOskeo2gP8LLWAKBtTGV5sPRCJ
	DiO2x0edz026+tvuua2zkXp+U7ov6MBtXi8JqaoJlWusWpIOnRrI0BbTOOpjZFtEEcNEldrBOowsm
	hMZSY8s0yI957L99tv9PNKdnavuomxBgM1nanPnUXu3g83V+I25sQImtztNeYBYmNhyKf4ylKKg02
	pvLBLtqcKlZH5ZEuPBBc3GwDYsG89TkMv4slnnVax+XtyCAZC//A+GWMoe6i3TuVyEKEpKPboj3FO
	5I0RvDYKcGSnexgXVBGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDlRR-006cjE-63; Wed, 11 Aug 2021 10:26:33 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDlQq-006cgr-Tb
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 10:26:00 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C49081FE29;
 Wed, 11 Aug 2021 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628677553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dIVroiF9CWXaHpVcigCtxn4G9TJ5tno4t7MoqivtmBE=;
 b=b+SuKVfs3TEK9nrziOok74mNZMgUtiymJF99t0VR8N6PbJOj4rqd7s7kiJeR5uwkFJE3V1
 qUuRkJhU8f8/CcC6xfB8bQ3ZpF2d4GnhJg1XqaXKt8Voxto9QGaBYOa1VSDjUz72YRjtih
 Dfku/ugQMlkKEyOeoAWGJMbPyGnXvFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628677553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dIVroiF9CWXaHpVcigCtxn4G9TJ5tno4t7MoqivtmBE=;
 b=88LED16uP9Jki6B+ocpzbFNhVd5PaojtVuvOjAht+8CLWYWTDGJ9K3HcZ5vgvumzwoISXg
 sp9gxICXsIV91YAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id ABDC8131F5;
 Wed, 11 Aug 2021 10:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id MS2KKbGlE2GbDgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 10:25:53 +0000
Date: Wed, 11 Aug 2021 12:25:53 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 2/8] nvme-tcp: Update number of hardware queues before
 using them
Message-ID: <20210811102553.auradulozluc5ond@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-3-dwagner@suse.de>
 <8373c07f-f5df-1ec6-9fda-d0262fc1b377@grimberg.me>
 <20210809085250.xguvx5qiv2gxcoqk@carbon>
 <01d7878c-e396-1d6b-c383-8739ca0b3d11@grimberg.me>
 <20210811010718.GA3135947@dhcp-10-100-145-180.wdc.com>
 <079108ce-6ca0-800e-e3df-29d015a4530c@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <079108ce-6ca0-800e-e3df-29d015a4530c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210811_032557_147540_0E4ED8D6 
X-CRM114-Status: GOOD (  19.72  )
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

On Tue, Aug 10, 2021 at 10:57:58PM -0700, Sagi Grimberg wrote:
> > > I think we should always wait for the freeze to complete.
> > 
> > Don't the queues need to be started in order for the freeze to complete?
> > Any enqueued requests on the quiesced queues will never complete this
> > way, so the wait_freeze() will be stuck, right? If so, I think the
> > nvme_start_queues() was in the correct place already.
> 
> Exactly what I was trying to point out (poorly though)

Thanks for explaining. I think I got the general idea what the different
states are doing and what the transitions are now. (famous last words).

Anyway, the first three patches are the result of debugging the case of
'prior_ioq_cnt != nr_io_queues'. Starting the queues before updating the
number of queues lookes strange.

I suppose in the case 'prior_ioq_cnt > nr_io_queues',
nvme_tcp_start_io_queues() should be successful and we do the
blk_mq_update_nr_hw_queues(). In the other case we should land in the
error recovery.

Wouldn't it make sense to always exercise the error recovery path if we
detect 'prior_ioq_cnt != nr_io_queues' and reduce the number of things
which can go wrong?

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
