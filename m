Return-Path: <SRS0=aO7+=M3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D927C4338F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 08:09:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FEF60C3F
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Aug 2021 08:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 25FEF60C3F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=houE7V6U+lgo0W8MPpIB69+XVzYcA5MentUNQvzLbmU=; b=waZfyjxPHBvkwF
	NwOPb8e3qQMmFThAPYt16QxYshpVL8GjNouiU/vEWxT1jDPBZNDk7snzsHcgwFe/nQG05AxQDMq1E
	YyreCb1GeoKhSXQ1YEc320Qa4z2DD+jZPgpDCEH5pi8rX9uKQb2Pas4JpTWN6nxtoiqf7kldYYG42
	26STp8lu9Pek08vPAze5AsZ+cBUpjIxpnj2IsXNhkGVJrAUsdKLF+fcCgNYsaxm1wV9YiiEkDUhug
	ZtcsR7mONNEBp/Du67Qbd48SNVTTiO0aWVdj7bS43h7nF59mXE7g8XCMBb20cTp1eeOoPgyBV0QLy
	MsY8e2LX4SaEzWhFpxUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBBxQ-0055DE-Bs; Wed, 04 Aug 2021 08:08:56 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBBxM-0055C5-QS
 for linux-nvme@lists.infradead.org; Wed, 04 Aug 2021 08:08:54 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8E244221B0;
 Wed,  4 Aug 2021 08:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628064527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvpB3zh3SOr6slWuKcuT2uU4LOafEsUV0r9cmtJhW1E=;
 b=jA8tOYOHgfa95XM8mbTftmwXKk9dXpC2EXH2PBnEr0crMFF9Gc1XLGKipZBRG8PrdVf8Rj
 ILjl9my68aeTb0ypVaC7HeS+U2jVJqB73T9Z1FlklSOrfrfKudZw9PjoOwoiWn4NQifxQL
 NGDGARL+phWhYc4NuVWF1f6xkrR5ZaE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628064527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fvpB3zh3SOr6slWuKcuT2uU4LOafEsUV0r9cmtJhW1E=;
 b=/Cl/0ponuW/tE+glDAmSw7ncgJ0akyzTe7lT46eL/PTLbwReTe74OUVRts3aaTb4JZl9Fj
 WHZy9ugYYTXoyBAw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 7D6EB13790;
 Wed,  4 Aug 2021 08:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id He2VHg9LCmFFVAAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 04 Aug 2021 08:08:47 +0000
Date: Wed, 4 Aug 2021 10:08:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Wen Xiong <wenxiong@us.ibm.com>,
 James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH v4 6/8] nvme-fc: fix controller reset hang during traffic
Message-ID: <20210804080847.bajae2twtnmccvq7@beryllium.lan>
References: <20210802112658.75875-1-dwagner@suse.de>
 <20210802112658.75875-7-dwagner@suse.de>
 <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <79c89923-f586-79e7-6dfd-c15ceb21f569@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210804_010853_049580_33276B56 
X-CRM114-Status: GOOD (  11.85  )
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

On Wed, Aug 04, 2021 at 09:23:49AM +0200, Hannes Reinecke wrote:
> There still is now an imbalance, as we're always calling
> 'nvme_unfreeze()' (irrespective on the number of queues), but will only
> call 'nvme_start_freeze()' if we have more than one queue.
> 
> This might lead to an imbalance on the mq_freeze_depth counter.
> Wouldn't it be better to move the call to 'nvme_start_freeze()' out of
> the if() condition to avoid the imbalance?

What about something like nmve_is_frozen() which would avoid the tracking
of the queue state open coded as it is right?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
