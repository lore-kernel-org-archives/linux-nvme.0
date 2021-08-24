Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC301C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 13:45:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A882161262
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 13:45:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A882161262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iklShpp+8S8IAz1VH2VRgZ+qNnTvbhiiYa7ZNXKCDKU=; b=Qq7qt+cppMGqWj
	qv9iqAE9wBwCojgPRxto4YVV/TB1TtcrKTnAoAE73GEHoe7CEemBHrR3yZyXurDFOU4R9pp6KLb9o
	BFoTKhif22jWohYElmuBau7jfcXsTTvZrLaIu4N884gjfZ2kFAhUxtWWkNd7OJp+Eg9VAmjEKMhxj
	XR+ypu00MJgEKIm+oopwGeGYe2IHX/cXFvWzKTAPzSuavIXRq3H1dg0s+mOSWa+5GT4ScrK0++tcz
	uEsIdGh6w1xg3jJ5loVSnZn3+OWjCmxGpDmrQQaTDkxL7X3wDlzHFLrSJ6CJ7qkGTnfo9hnrrw4NC
	YgfBE0wWlFZNsei3L5nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIWjj-003Hid-5l; Tue, 24 Aug 2021 13:45:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIWjd-003Hgc-OJ
 for linux-nvme@lists.infradead.org; Tue, 24 Aug 2021 13:45:05 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 749F92209E;
 Tue, 24 Aug 2021 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629812698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQT1R0eSRQSRF+rzGFAmoytGRsJKhqfXEc1Tzckzx/8=;
 b=QO6Onyd99Thl/apaIzjmQn/MNLhZL4OBuYG1DvbASn1odsCNXJ7A5WNVVyWu9pcKolAJQo
 Wql0VdVYNceEQaIpkt9Q7/dedkE/ST50vB+vEnwsxTFK6EguAkZNqGQ0yQSjgJmzAtyG9S
 HFvytrQ0goihl4KQvXXpMcQB27yzcQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629812698;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BQT1R0eSRQSRF+rzGFAmoytGRsJKhqfXEc1Tzckzx/8=;
 b=vpOGwQaLbAxn9Qpo7vy/AzUZUgjZZe1MOodHAwiqhxtzTu1MZo2Cn2N7UIUtb0UF4XD4Pc
 tBbUFZxFJ1sSNpCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5C66B13A50;
 Tue, 24 Aug 2021 13:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id akkTFtr3JGGuNwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Tue, 24 Aug 2021 13:44:58 +0000
Date: Tue, 24 Aug 2021 15:44:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
References: <20210811152803.30017-1-dwagner@suse.de>
 <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210824_064501_989538_7E2C78CE 
X-CRM114-Status: GOOD (  12.80  )
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

On Mon, Aug 23, 2021 at 10:16:23AM -0700, Sagi Grimberg wrote:
> > +void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> > +{
> > +	struct nvme_ns_head *head = ns->head;
> > +	sector_t capacity = get_capacity(head->disk);
> > +	int node;
> > +
> > +	for_each_node(node)
> > +		rcu_assign_pointer(head->current_path[node], NULL);
> > +
> > +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> > +		if (capacity != get_capacity(ns->disk))
> > +			clear_bit(NVME_NS_READY, &ns->flags);
> > +	}
> 
> Shouldn't the null setting to current_path come after
> we clear NVME_NS_READY on the ns? Otherwise we may still
> submit and current_path will be populated with the ns
> again...

Ahh, I got it this time! Yes, you are right. I think Christoph has
dropped this patch from the nvme-5.15 queue anyway. I'll resend a new
version with the order changed.

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
