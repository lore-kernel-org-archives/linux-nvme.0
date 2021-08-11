Return-Path: <SRS0=LdLJ=NC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E690EC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 15:23:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91736024A
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Aug 2021 15:23:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A91736024A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/5HncvAGddZJykE2YCVfQNr0Y/dCc+8NWeXL5tyMWug=; b=gRxjS/ZagAvPVF
	935XP3j2+uAx+nvaGEnFmXqNwJcp6+Cq1vTg2GOQSJ7tPJKQaIR4mp6l+glzxBbeM3JR2k/7VbiGt
	XqhZXqragBf/BXxI1p7rouAWx4lGQHkOUi9g3GKtU/S8XxR1h/hWcjMOOrVSPUp9IN/AzPcOapp4t
	TtQWGTU3B2YdC/7VtIydFPENgDKtWSYrGsJaiKw5kYkclkYBIJu/lEQBhiXTH1M3ItQj/PXohMYZN
	qSpCgRRAEnumO8SSCHzzGxh1K09JcBWIu6BaPM1Q6/kPozMctwOZg38oaRb+Nr/XV0dYExpbopvBQ
	U4n7cMYLul1nNDsrjNUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDq4J-007XWX-K8; Wed, 11 Aug 2021 15:22:59 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDq48-007XVY-9H
 for linux-nvme@lists.infradead.org; Wed, 11 Aug 2021 15:22:52 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D54A41FED9;
 Wed, 11 Aug 2021 15:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628695366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2CL0JIMo06T6k87Dn9C5Yfg1nQrCmuZMLg5uKbT5cM=;
 b=v5RogW0qlP81ZV0ygXJLYlSdN4gXOyh+/I+TGtwtgvwaAPEmEClqfk6nqKL9dof7rSMQTc
 /X8lfHXRFc/8B5rUIksiLPTiyzMjGQVTIkkm42QqMqpTodhDXNX0VqiRNyCjGFsbTHlYNv
 6MSizKf1w9/uBDY/gpgpPw6QlHYVTjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628695366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P2CL0JIMo06T6k87Dn9C5Yfg1nQrCmuZMLg5uKbT5cM=;
 b=EZEwJyJj7YRZ8NGTA3ZbkjwaMxzDzD8PLDOsXn8PL5jhDbQWEuteKU5vhUwmy5xHCxPFv+
 LXbdGILVb43eR4Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C4029136D9;
 Wed, 11 Aug 2021 15:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 6unUL0brE2GxWQAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 11 Aug 2021 15:22:46 +0000
Date: Wed, 11 Aug 2021 17:22:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme: invalidate paths during rescan
Message-ID: <20210811152246.ppr46xj437cxhqdy@carbon.lan>
References: <20210730071059.124347-1-dwagner@suse.de>
 <8718c238-de35-ad35-898d-e6620446276f@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8718c238-de35-ad35-898d-e6620446276f@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210811_082248_518017_ED7F4212 
X-CRM114-Status: GOOD (  14.03  )
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

On Tue, Aug 10, 2021 at 06:18:01PM -0700, Sagi Grimberg wrote:
> > +void nvme_mpath_invalidate_paths(struct nvme_ns *ns)
> 
> invalidate is not a great name for this very specific case here.

Okay, I opted for nvme_mpath_revalidate_paths() as we already have
nvme_revalidate_zones() which does also capacity checks too.

> > +{
> > +	struct nvme_ns_head *head = ns->head;
> > +	sector_t capacity = get_capacity(head->disk);
> > +	int node;
> > +
> > +	for_each_node(node)
> > +		rcu_assign_pointer(head->current_path[node], NULL);
> 
> Here the ns can get re-selected as the current path.

This is on purpose. By clearing all current_path the next
nvme_find_path() will select a valid current_path which might be the
same path.

> > +
> > +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> > +		if (capacity != get_capacity(ns->disk))
> > +			set_bit(NVME_NS_INVALIDATED, &ns->flags);
> 
> maybe instead of invalidated reverse the polarity with
> NVME_NS_READY? clear it here and set it in update_ns_info?

Will do, see next version.

Thanks for the feedback!

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
