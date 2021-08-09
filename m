Return-Path: <SRS0=jKil=NA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7288FC43214
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 09:10:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B5F561056
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Aug 2021 09:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B5F561056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=22GLK2ayio7YYKnk4OrLMT+3jLECaNuqrEWqTsEgPlQ=; b=4xxFe8WOq/xoQw
	A9y7WGol0A/wtR/Nc1ctE0nkSyGBreqhj+6ydSxyQ9AHe0EnoV5Tx71xmUESyKGPrUlVypy7TIV/C
	rfzaHZnaZffCIoBuL8Tmc+JA6sUwcXZP38WqSeN0iiNkMsZnvNOm0MfOsgbgeBb0e/C71SYhilPiU
	VR+BYVC9JjI+Ymb7KcUeGT54IC7BteE6+9KIzHIlrKf8Ef298xPKsmXfWb/Bvttk8V8Wk0dNzWohv
	QbPm8ko0W4q9mf7aW3pAhPiK1tZ8Ugs/4hgMI/F4FaaqZrGLsOfwW5uq3s0jAZMq14og0/vh+eBmU
	QemIf4ZKGBOe7CltLNoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mD1I7-00HYCe-RA; Mon, 09 Aug 2021 09:09:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mD1I4-00HYBp-UN
 for linux-nvme@lists.infradead.org; Mon, 09 Aug 2021 09:09:50 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95AC621F44;
 Mon,  9 Aug 2021 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1628500187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qoQMlqTicS0HtimnKTTbCDkN5674ozjQ0AoY71P8px0=;
 b=YO1Vd1BF59SZJsXEP03mFbkDMzLgDLCuLDrBJwug4jMtdOKccpi1RcpsydKPbhTg9RXf6s
 UiSoaisfiNLLmWrcml0Ule+E3n2nSnj9gRDDcGfa/oeDW8N38aAiAEox3gFIv7qlXrSdEa
 yfLEyVdVG/lXo13re9arw/Hb1q1Yjng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1628500187;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qoQMlqTicS0HtimnKTTbCDkN5674ozjQ0AoY71P8px0=;
 b=Y0kK/8oHEapwTCj0LNczmKG5p33oMgaTxfbDwlqKYdCLGoN8EX2nu0wgQoGOzzmu/3VPRq
 czyeTZZL3hXQ28Bg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 85D33132AB;
 Mon,  9 Aug 2021 09:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id wPliINvwEGFTLgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 09 Aug 2021 09:09:47 +0000
Date: Mon, 9 Aug 2021 11:09:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com
Subject: Re: [PATCH] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210809090947.luoqaooi7gc6u6yu@carbon>
References: <20210805121541.77613-1-dwagner@suse.de>
 <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <47ef76c6-4430-ca24-405e-a226d4303a39@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210809_020949_170033_F1DF3C4D 
X-CRM114-Status: GOOD (  13.27  )
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

On Fri, Aug 06, 2021 at 12:42:00PM -0700, Sagi Grimberg wrote:
> > @@ -89,6 +89,7 @@ struct nvme_tcp_queue {
> >   	size_t			data_remaining;
> >   	size_t			ddgst_remaining;
> >   	unsigned int		nr_cqe;
> > +	u16			status;
> 
> Why is this a queue member and not a request member?

I was not sure if the TCP transport specific error handling should
impact all other transport (size of struct request). Also I tried to
avoid accessing cachelines which are not already in use. Except this I
don't see there should be no problem to put this to struct request.

Daniel

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
