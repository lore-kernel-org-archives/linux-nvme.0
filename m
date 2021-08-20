Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB510C4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 08:49:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77262610E6
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 08:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77262610E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PO2KUeb2zIZqY5XdLGU24yiiBSNHHuVTF6Q1L8nyurc=; b=RKNdl/UxKtaIuw
	o9QyTQtIbdfFmqMwsb2X8N+a70ZL2ZHO5zPos0zwS8O42kY3OQs/1nAGcGHWDP1oyxvGEjjdJVIZg
	qkH/8hgqgNjhvpg50EbHbIc+/I/4nMoZGvWrggdWxWne0PnGcKuu1FMVT8kWBHVGfURT1A7pSN7w5
	3QJzTXmUSdmwPkRrCSyUYSZ7hA4Sa71DMQRLm8UJtSSUdx77mcX2KWGWtnHO1KN193K+YR+V9KsW1
	TcBe+CcoH9Eta86QeZD2sBUGyaFiqGcA9bUpDMepCx7nC395B92XJCZJJxckzKBe9vMKSNSKG2RqG
	ZiTpb3Nqyms5ys7ZFaAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH0Cf-00ARHl-1z; Fri, 20 Aug 2021 08:48:41 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH0Ca-00ARH2-9P
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 08:48:40 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BDA2F22137;
 Fri, 20 Aug 2021 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629449312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCaN0M5amMyZRXL8tzm/AX/hJ8arauZM7tvxoIPOVXY=;
 b=J6uwkYNyjhSkdRI9DQp/ktI23jMY43QGD4lspGzN7ETfV32kT89QCV/g6oDNNPY9BoI3ZI
 ewlvw+eL6vtEEqLBBCTfiEZj8vEqyDWw8bRKnxjQ45Lk6Ynt+mvkL5NGMET9PigBi4QDQ3
 w3cNKXgQ2FEkKo468F9hAyAXjQvqD7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629449312;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VCaN0M5amMyZRXL8tzm/AX/hJ8arauZM7tvxoIPOVXY=;
 b=3RlKmB/KCREuzvOCADE6fhAT5sFxtWEWxg4Mo7SDzTGdpLPioigWW9+mzLBwAvA4pQR/fa
 063pT9bYeXA3A1BQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id AD6881333E;
 Fri, 20 Aug 2021 08:48:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id kc8wKmBsH2FwTwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Fri, 20 Aug 2021 08:48:32 +0000
Date: Fri, 20 Aug 2021 10:48:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210820084832.nlsbiztn26fv3b73@carbon.lan>
References: <20210818120530.130501-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210818120530.130501-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_014836_531486_901ABFF4 
X-CRM114-Status: GOOD (  14.31  )
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

On Wed, Aug 18, 2021 at 02:05:27PM +0200, Daniel Wagner wrote:
> I've dropped all non FC patches as they were bogus. I've retested this
> version with all combinations and all looks good now. Also I gave
> nvme-tcp a spin and again all is good.

I forgot to mention I also dropped the first three patches from v4.
Which seems to break her testing again.

Wendy reported all her tests pass with Ming's V7 of 'blk-mq: fix
blk_mq_alloc_request_hctx' and this series *only* if 'nvme-fc: Update
hardware queues before using them' from previous version is also used.

After starring at it once more, I think I finally understood the
problem. So when we do

        ret = nvme_fc_create_hw_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
        if (ret)
                goto out_free_io_queues;

        ret = nvme_fc_connect_io_queues(ctrl, ctrl->ctrl.sqsize + 1);
        if (ret)
                goto out_delete_hw_queues;

and the number of queues has changed, the connect call will fail:

 nvme2: NVME-FC{2}: create association : host wwpn 0x100000109b5a4dfa rport wwpn 0x50050768101935e5: NQN "nqn.1986-03.com.ibm:nvme:2145.0000020420006CEA"
 nvme2: Connect command failed, error wo/DNR bit: -16389

and we stop the current reconnect attempt and reschedule a new
reconnect attempt:

 nvme2: NVME-FC{2}: reset: Reconnect attempt failed (-5)
 nvme2: NVME-FC{2}: Reconnect attempt in 2 seconds

Then we try to do the same thing again which fails, thus we never
make progress.

So clearly we need to update number of queues at one point. What would
be the right thing to do here? As I understood we need to be careful
with frozen requests. Can we abort them (is this even possible in this
state?) and requeue them before we update the queue numbers?

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
