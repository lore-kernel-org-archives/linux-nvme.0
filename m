Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B27C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:17:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35086124B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 06:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B35086124B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VZRNcivXo7yt86DQekyiHCIVW0fEMMVMrXyaGi2kKXw=; b=DL2Tbt3qlQNHEq
	AmINwgTCWRlhvfOjDfKE7AgeQHTGg2HFwHpZZlTnZI4w5DdoobLmg1fjyCQJqhBjXFLGEL8MFr2Iu
	1oF3EWLBFlaz4BI70+9VtiuQxhKSYZxqcqlhs0R7kwjoSUPYzXkb7jB5yf6jM6abvXqsEpPDRMTvO
	12fH9oWj50eTPlt6dOcHY9CebdHdq71dH9/Tv20GFnBcRCVebjzqCwYNsF2ILd59GAk5w091Oxn/J
	mknhirmDXGKrZhYgqwTEZva7nRK2eRHFEI8dT1cVM85lLe6fu1otIzQW2KDwlHXi+TItmEvEMovDx
	OiUK1R8nhmVkuQEw1EJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIPkK-001ooh-Qe; Tue, 24 Aug 2021 06:17:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIPkI-001onv-Uo
 for linux-nvme@bombadil.infradead.org; Tue, 24 Aug 2021 06:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=qF6BRVtzKVgghor1P9ZGHoGt4E7dX5k+ejpk+dyk/2g=; b=SBO38hzeQXv6m2c52dS8JXGVs0
 CxCHfl7Uyo197fvhgSiBCfNAb+8ml7tpeDWepn8if7abJN3Fu8BBpAjED2K5ZcSwhPThhtP3LORGe
 wAXFWpFxhNpKy84ntO/swQ22soAzcrKeg3lku4px5saf8HWWKrYgkVA8TR20l1GwoFVz6FnXQ1FPY
 H4ErhpE+DE6BtAqmTzXMJKP/znR2ostjLz9ZpgI7zCw3p/w0JAQEr146TSDoLBhByEmlKLwGH9Mdr
 lXV3u4dsVxXkWBQ9EEY4bLuFxNENVUCx4inNzbv66prbDoe82t8fwJM8zXqkloz67CtosayTNkc1t
 FBsyLieg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mIPj2-00AdnG-1X; Tue, 24 Aug 2021 06:16:10 +0000
Date: Tue, 24 Aug 2021 07:15:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
 beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
 swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
 josef@toxicpanda.com, hch@infradead.org, hare@suse.de,
 bvanassche@acm.org, ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] md: add error handling support for add_disk()
Message-ID: <YSSOnEiPvCHZXVpb@infradead.org>
References: <20210823202930.137278-1-mcgrof@kernel.org>
 <20210823202930.137278-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210823202930.137278-8-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

On Mon, Aug 23, 2021 at 01:29:27PM -0700, Luis Chamberlain wrote:
> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> We just do the unwinding of what was not done before, and are
> sure to unlock prior to bailing.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
