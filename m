Return-Path: <SRS0=/QSy=NJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00D9C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:45:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9297361042
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Aug 2021 12:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9297361042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nk6pmGh8IlxaI1GvZ8RyFQPz6HObtya2+9MAdz7gTWk=; b=C7xzdNK3BqDVqw
	BFvi9C3k6ON8EcaejODxiC9D+ny6PcxYokjcULdekcGIviv5pObLfMeilzLmUqtB78sqik2Pjk/xw
	jYNgLVVwzFCm48dspdK3+Dwy8/lyOAdFZqEHQsJEsEqot7sDP5tifBSOovE+aj0ZNfAjkTrdNTadG
	zHMQ6Bd9hWv6OekXG/J19IrVgAHo4F++ZzlP+3ZH/ayTdWQ9RC+DM5ht1XJP4i5IjAqgxpvAzyxJr
	9bTyZdSgTgMj8Ydu9xvVyVXSDsBl5yLo116p6hJE7AvEGrkosO+edC3+YLrA20nYLX8hONBc4u02u
	ymR5EXOEsWsfCOySezuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mGKwM-005Yv5-3W; Wed, 18 Aug 2021 12:45:06 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGKwC-005Ypc-Qr
 for linux-nvme@lists.infradead.org; Wed, 18 Aug 2021 12:45:03 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7189E20071;
 Wed, 18 Aug 2021 12:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629290695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzEdLiDQM8rs0jwtsINY05exG7qfOg7U1lRRWprWkkA=;
 b=WBW7Y00xYUWYhHRfBQ+tUq3eGXIsDtQDbj8iYk2kaVoY9QS/SdUswgkzoe7LIc1kP7IlKS
 uqb6v9asYdywsfZLNiPPlCSTOBg1ZhCsA1oXK+iDJ3bBxSzDeWpxKG0G/sjsVyRbDXD2qp
 S4hE1icbJ5maFY+fgmKiCulau+tDpnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629290695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TzEdLiDQM8rs0jwtsINY05exG7qfOg7U1lRRWprWkkA=;
 b=lmoLbw7jphvHByq06Xn/y8rq0Z3BV+OJJ3EPua0W4GoAw2LRXOQyYXEw0LJrMZeHWtD08o
 uKFqiYMAV/VZ1GCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5F92D1371C;
 Wed, 18 Aug 2021 12:44:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id H8rUFscAHWGnUwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Wed, 18 Aug 2021 12:44:55 +0000
Date: Wed, 18 Aug 2021 14:44:54 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <20210818124454.vcfid2otecdprlsh@carbon.lan>
References: <20210811152803.30017-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210811152803.30017-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210818_054457_081977_3F68DCE3 
X-CRM114-Status: GOOD (  14.45  )
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

On Wed, Aug 11, 2021 at 05:28:03PM +0200, Daniel Wagner wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> When triggering a rescan due to a namespace resize we will be
> receiving AENs on every controller, triggering a rescan of all
> attached namespaces. If multipath is active only the current path and
> the ns_head disk will be updated, the other paths will still refer to
> the old size until AENs for the remaining controllers are received.
> 
> If I/O comes in before that it might be routed to one of the old
> paths, triggering an I/O failure with 'access beyond end of device'.
> With this patch the old paths are skipped from multipath path
> selection until the controller serving these paths has been rescanned.

ping

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
