Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115FEC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 12:02:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF50460ED5
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 12:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AF50460ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KNX1hoJG5oRZoXISPd7BuFuJDNk5EDyjxQm11sd+uqs=; b=4mBOMIFR6ERmpz
	ccktLfCH4xUr+1fUkUwBsIxiLMOl3OU/48HLASjfzYiIALMB4ER8t0k7ZCJJDKhOt9yZgTdWBlaN5
	ctFcbHOi5Jub4pyOXR2ffXXjA9XbTw7hHm8w0fi1CHAlo/2BP8C7y22vb6HSgt3ytuNk71+pSFC9X
	8zFJ5VPxO/YT2Lnbh8wXf9seo5x0WSS83OpDkfteh7uxTqFNz7hC5OoLFKKQUCt9Xb9T2m4EtryKs
	vji6cxTDgykOPrh88KOMlRCADLW6XVJxi6PD9MSkfrHCe3SPN1bs5CWX40mbjXy1Q6W8+G8mAwlbP
	VvhPwGmkPln/PImPDcNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH3Dx-00B2XI-2R; Fri, 20 Aug 2021 12:02:13 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH37L-00B0K7-Bq
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 11:55:27 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B4EFD21F55;
 Fri, 20 Aug 2021 11:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629460521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TO8SPS42MqtUgER5AvlMEomQQplZq9qOHXpgo20Scrk=;
 b=kvs9bcNGubJH4ZnJkboxY/xli6iMNsaCm9srblPmUkUp9bC61imZQDz4eoQ3zMo70Obwxr
 yiFSOR4f56RmogCgx80MArxynga3Hs/FwILY6MmbWN1PHUn6nZI9QC9yKzCgvUKjZUVJrZ
 kUHGfJSPRAHm4k2doOCQgU9fsscS1EE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629460521;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TO8SPS42MqtUgER5AvlMEomQQplZq9qOHXpgo20Scrk=;
 b=5knjeyv2pt/rSDf5q/9BS8fw8r+GScRhnWksQVbjUEnaQs7QCbHyk0CUNP1cSr2fXQIiio
 3wY3MN9CMPgpIeBA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A388D13AD0;
 Fri, 20 Aug 2021 11:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id tSOtJymYH2FIfgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Fri, 20 Aug 2021 11:55:21 +0000
Date: Fri, 20 Aug 2021 13:55:21 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
Message-ID: <20210820115521.alveifzvad3zuwh4@carbon.lan>
References: <20210818120530.130501-1-dwagner@suse.de>
 <20210820084832.nlsbiztn26fv3b73@carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210820084832.nlsbiztn26fv3b73@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_045523_622490_11E40ADA 
X-CRM114-Status: GOOD (  15.56  )
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

On Fri, Aug 20, 2021 at 10:48:32AM +0200, Daniel Wagner wrote:
> Then we try to do the same thing again which fails, thus we never
> make progress.
> 
> So clearly we need to update number of queues at one point. What would
> be the right thing to do here? As I understood we need to be careful
> with frozen requests. Can we abort them (is this even possible in this
> state?) and requeue them before we update the queue numbers?

After starring a bit longer at the reset path, I think there is no
pending request in any queue. nvme_fc_delete_association() calls
__nvme_fc_abort_outstanding_ios() which makes sure all queues are
drained (usage counter is 0). Also it clears the NVME_FC_Q_LIVE bit,
which prevents further request added to queues.

I start wonder why we have to do the nvme_start_freeze() in the first
place and why we want to wait for the freeze. 88e837ed0f1f ("nvme-fc:
wait for queues to freeze before calling update_hr_hw_queues") doesn't
really tell why we need wait for the freeze.

Given we know the usage counter of the queues is 0, I think we are
safe to move the blk_mq_update_nr_hw_queues() before the start queue
code. Also note nvme_fc_create_hw_io_queues() calls
blk_mq_freeze_queue() but it wont block as we are sure there is no
pending request.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
