Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198B4C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 11:49:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81186108B
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 11:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D81186108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZdC4Fw02mRA8qb8kbb6piCr0zYe8gC9O+9o02iZ4Cvw=; b=4pmcoZfBqB/BAB
	DfjSvRkxzA/G3ZhuVwpr61Jy9WeikGzI5ZwGYANQpUI/BUuCD5Fjz+xbywjOV6eqPsvJVAayynPeT
	KMFmq94e8oI3NK3sFxiO/N+BPAyITCksHsKJJaBO03+TvAo9RcJxPPDbnPOdiw97ZqgIn7m+xk2eE
	HcpMqy0iid7wq5JXGRDAx7cvxh2BEJ8FhWN73DKwDwvyakrybMQ0R6grYvtflpju7/qRh+VD2KkxM
	HwhY6HyMFX4rdM3dMpfrxceWvqpamzv0RiODic3xy28QwXM04IeE38XhnEV9fw7FHihOcEqG4wjSq
	kot8kd5TpLEQbb6AfScA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGK4P-005Oqa-3b; Wed, 18 Aug 2021 11:49:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGK4J-005Opq-Q3
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 11:49:19 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 188FD1FFB9;
 Wed, 18 Aug 2021 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629287354; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kIIwbBMCo0jcO7goEPPzyNXcpgv0ZfRxkw1OI2DKg9U=;
 b=cvDQUSmaMajNBAaWANNjFAPuYf014CtCoH5fbTcsllTDHIkK4+Rik8SP1o6ovkc8a/AEtN
 xgOZD4CgrcMLajonJiusPhvKzMjTxoYGNvlYNpPtcdL/8u8n9xOCVvaVrB0Adzf3ubzIuX
 hIctoGpeDmTDqiXvdiAnq3KV3wNZpqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629287354;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kIIwbBMCo0jcO7goEPPzyNXcpgv0ZfRxkw1OI2DKg9U=;
 b=gP+PGR+0oBO93iDjr4AVDXc3qR1HzgxCSwy/MyDPrnYBCX+k2und7Jod4kJgHtkh8RwJPg
 HPDI0TSV33dXWHDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 08284136DE;
 Wed, 18 Aug 2021 11:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id WtrLAbrzHGGfPwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 11:49:14 +0000
Date: Wed, 18 Aug 2021 13:49:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <jsmart2021@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210818114913.lfy2nzc7kssul6er@carbon.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
 <3d4edf17-2be6-b7c3-a6fd-b439e5e52eab@gmail.com>
 <20210818114309.ovkutmwvmrgugv4i@carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210818114309.ovkutmwvmrgugv4i@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_044916_038013_A6E39609 
X-CRM114-Status: GOOD (  13.74  )
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

On Wed, Aug 18, 2021 at 01:43:09PM +0200, Daniel Wagner wrote:
> On Thu, Aug 12, 2021 at 01:03:07PM -0700, James Smart wrote:
> > try this. Moves the location of the freeze and will always pair with the
> > unfreeze.
> 
> Yes, this works. Do you send a proper patch out or should I just pick up
> this patch and add a commit message?

Forget it, the commit message is still the same. Let me respin this series.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
