Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E28C432BE
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 10:05:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0585F61090
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 10:05:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0585F61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=otdYO4pe98YtCJu4zs9ZYv8pyxfcLuTE9Rt616yJ0nE=; b=TazSGwQJM8pSJ+
	aI1h2ggnQauT9wt90390cX4WSOdZMQdfqsoqQ5BcPn/6Kud8usjRGf52nxIr9sbj5IsvazWQ0Nj5f
	5u3tzse8MT4qaYFvH1/uBx2vdRRPlQZTVKta45mjUtxTIg7HqyL0iBn4iKjBx5Rj3vUwv+P8ob2sp
	Qke4XSUkbK0xZMnwEN2wpFpL9b3+718u46YD9D3sotXQSttWODoEgUSkS93YCfR7hg1Peaneu2e6q
	Bm13+CF3L3c5Xd5LYPTJj3uOPzX3l3SECFLUYUvLTWFbfKNWKSbztrFf2U/KddTXi1hUB/FSqkhu7
	AzpdpZDWXrLdZ7Krnj5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKe9q-00GxU9-Tq; Mon, 30 Aug 2021 10:04:50 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKe9k-00GxSo-UG
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 10:04:48 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9E4B91FDE9;
 Mon, 30 Aug 2021 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630317883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/BZ9Nzbh36Uo0OVwK8BMQEKq6pKk8VDrZgnYLw2r5LY=;
 b=qeXtqhtrEOPqMzRzjW9t+TL3jD98MhlIpYFJ14zcXaGcQZrNOZmLbncf5x17UL634db6rd
 6zt9q/NPMSYigFoIOBBEtFa0LyjpNJEfDC3wxg+AhGcVnttMXNuBk0DB5nJTJSpQc7qhSG
 2NSpDOIlgfXwxDOzxYehTIXjSfJcg7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630317883;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/BZ9Nzbh36Uo0OVwK8BMQEKq6pKk8VDrZgnYLw2r5LY=;
 b=w9mIVkZ+OuEEu+8qMvcwqgTG2QA7yK6/k+KJ8QRCp1byGlaAS0DamOhqqmcrWNh5Tdu/M9
 7K5DA6/Cs8gmOmCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 8AAEA1365C;
 Mon, 30 Aug 2021 10:04:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id KnbNITutLGEdQAAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 30 Aug 2021 10:04:43 +0000
Date: Mon, 30 Aug 2021 12:04:43 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v1] nvme: avoid race in shutdown namespace removal
Message-ID: <20210830100443.b2zkdp4l3vi2gz42@carbon.lan>
References: <20210830093618.97657-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210830093618.97657-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_030445_175937_06A2533D 
X-CRM114-Status: GOOD (  10.48  )
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

On Mon, Aug 30, 2021 at 11:36:18AM +0200, Daniel Wagner wrote:
> Though one thing I am not really sure how it interacts with
> nvme_init_ns_head() as we could be in running nvme_init_ns_head()
> after we have set last_path = true. I haven't really figured
> out yet what this would mean. Is this a real problem?

I suspect it will regress the very thing 5396fdac56d8 ("nvme: fix
refcounting imbalance when all paths are down") tried to fix.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
