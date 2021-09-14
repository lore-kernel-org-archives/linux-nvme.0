Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ECFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 08:46:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA07160187
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 08:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AA07160187
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BuWb/8s17MHheMZtYHuQS61aF10ul+71hKJRTvxawGg=; b=MWFGG8Jf8chwU8
	4WWcjWxfXNMHogJZF1wVQlU9somSisJSwaJNlaSJDx6kLboFmHupU1tiqFJt0DAICuJ7wZ9hepTr+
	0cW/JrbA3R1cqWbN+w6Db7bHHAD/ZPN0t9Q1qRZaAaq2QxAXeB8bGVQ63HhW022m3rAb2K1N/Lvej
	lhw6iO5VRENOc9XTYMZVeRnWP7QffwzUtZgxo/+9tya62nZ76Y2E+vntZQPJuhRzQuinVjM2LCj9R
	M5shnDxLVLTYOFEEFrX2nR8kvnujYctpH5neFBB5o8f2ZevUg/d/FmlmUMqjLOSHUPhupmF8RJeiD
	XWbNGUQYEXHiu0FMq04w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ456-004l0Z-VG; Tue, 14 Sep 2021 08:46:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ454-004kzY-4M
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 08:46:19 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3B18A21EA2;
 Tue, 14 Sep 2021 08:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631609174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kZkMH63iTQ1WWrdV9xSbbANfuGbUt17bCT5Dl2F/Da0=;
 b=XWISWXbcR3YdaeFQmM4w9+ukkxf4jSK2eqmQDo5iZ73XBLhF4jEDM8+2E0VxGtr5eFJxiC
 nmb3T0gwe1ndT5H4JdLDKKBI4kjUyc4fjA7c0T2KqDcf4D22+99oItZYY+wjvqFoIvzlqP
 K00ktKQrEH5F+uB2Tz7EXYr8uqK/J68=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631609174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kZkMH63iTQ1WWrdV9xSbbANfuGbUt17bCT5Dl2F/Da0=;
 b=MJG30rqDnzxe65gQiiRdUUjTdYTTjoLnMy+u/ZtPzlpYnjvOOgqHQqAJZ29ngBM7p6RPor
 ImJkDb/zx1w6yLBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29AD313D3F;
 Tue, 14 Sep 2021 08:46:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KUIwClZhQGGpLAAAMHmgww
 (envelope-from <dwagner@suse.de>); Tue, 14 Sep 2021 08:46:14 +0000
Date: Tue, 14 Sep 2021 10:46:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [RFC v1] nvme-tcp: enable linger socket option on shutdown
Message-ID: <20210914084613.75qykjxweh66mdpx@carbon>
References: <20210903121757.140357-1-dwagner@suse.de>
 <YTXKHOfnuf+urV1D@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YTXKHOfnuf+urV1D@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_014618_368776_883BC945 
X-CRM114-Status: GOOD (  19.88  )
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

On Mon, Sep 06, 2021 at 08:58:20AM +0100, Christoph Hellwig wrote:
> On Fri, Sep 03, 2021 at 02:17:57PM +0200, Daniel Wagner wrote:
> > When the no linger is set, the networking stack sends FIN followed by
> > RST immediately when shutting down the socket. By enabling linger when
> > shutting down we have a proper shutdown sequence on the wire.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> > The current shutdown sequence on the wire is a bit harsh and
> > doesn't let the remote host to react. I suppose we should
> > introduce a short (how long?) linger pause when shutting down
> > the connection. Thoughs?
> 
> Why?  I'm not really a TCP expert, but why is this different from
> say iSCSI or NBD?

I am also no TCP expert. Adding netdev to Cc.

During testing the nvme-tcp subsystem by one of our partners we observed
this. Maybe this is perfectly fine. Just as I said it looks a bit weird
that a proper shutdown of the connection a RST is send out right after
the FIN.

No idea how iSCSI or NBD handles this. I'll check.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
