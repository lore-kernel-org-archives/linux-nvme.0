Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35B1C19776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 08:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7RRv5o4nN7h5R9vLyabNovDNuUJ5T6+hjcUJfFHTVQ=; b=lg3h/AunXzsjb7X4sJTrKP5msN
	yALrc/W0aSw9dl8KLkxvnmFHZb1lhQwTN6/6LeLvTvBhIA/NP588L5j403OHv7qYyKVPUoyOlfi70
	3T4LErt3dGxIgag65czeR2Q9f8jwrGC/Fe318r3/rRsGIeUPFiMnl1yq+2kulrhfNVYvc7R83NTVu
	jzZoumau8AFV9oJaw68wcw2ky8oOxPqS5BAxS6O7Ay7wpkDf/zcN7NiQYPB3OUq0grPOGVUVLaSEt
	ZIf48jLN6IaAtQN7upjH6CPCxshmrtYhslvWdPjrllYHPIfxcm+jvAtQH/7HcA93DJGVTQNk7AASD
	SDXlXgFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvX6-0000000A8F1-0mif;
	Fri, 28 Feb 2025 08:15:44 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnvQk-0000000A6sJ-3slX
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 08:09:12 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 908862116F;
	Fri, 28 Feb 2025 08:09:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7470E13888;
	Fri, 28 Feb 2025 08:09:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1zUiHCVvwWcDMwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 28 Feb 2025 08:09:09 +0000
Date: Fri, 28 Feb 2025 09:09:04 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] nvmet-fcloop: track ref counts for nports
Message-ID: <0f8504e1-c890-41b2-9cfb-2b45cd92e6ad@flourine.local>
References: <20250226-nvmet-fcloop-v1-0-c0bd83d43e6a@kernel.org>
 <20250226-nvmet-fcloop-v1-4-c0bd83d43e6a@kernel.org>
 <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b09a75-30f8-4db7-a02b-25ae405f7340@suse.de>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 908862116F
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250228_000911_114147_9A921E05 
X-CRM114-Status: GOOD (  19.10  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 28, 2025 at 08:19:19AM +0100, Hannes Reinecke wrote:
> >   static void
> >   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
> >   {
> > -	struct fcloop_tport *tport = targetport->private;
> > -
> > -	flush_work(&tport->ls_work);
> > -	fcloop_nport_put(tport->nport);
> >   }
> Errm. Isn't this function empty now? Can't it be remove altogether?

Sure, I'll get rid of it.

> >   	nport = fcloop_alloc_nport(buf, count, false);
> >   	if (!nport)
> >   		return -EIO;
> > @@ -1475,6 +1491,9 @@ fcloop_create_target_port(struct device *dev, struct device_attribute *attr,
> >   		return ret;
> >   	}
> > +	/* nport ref get: targetport */
> > +	fcloop_nport_get(nport);
> > +
> 
> I would rather move it to the end of the function, after we set all the
> references. But that's probably personal style...

I don't mind, During debugging I started to move the get/put function
where the pointers are updated, to highlight why we do the get/put. But
that was still pretty hard to find the leaks. Eventually I added some
debugging patches which annotated the call. The left over of these debug
patches are the 'nport ref get: transport' comments (*). Now that I am
confident that all is in balance, there is no reason not to make the
code more streamlined.

(*) Would something like this here be a no go? It really helps when
trying to debug the inbalance:

+static void __nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static int __nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
+
+#if 1
+#define nvmet_fc_tgtport_put(p)						\
+({									\
+	pr_info("nvmet_fc_tgtport_put: %px %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	__nvmet_fc_tgtport_put(p);					\
+})
+
+#define nvmet_fc_tgtport_get(p)						\
+({									\
+	int ___r = __nvmet_fc_tgtport_get(p);				\
+									\
+	pr_info("nvmet_fc_tgtport_get: %px %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	___r;								\
+})
+#else
+#define nvmet_fc_tgtport_put(p) __nvmet_fc_tgtport_put(p)
+#define nvmet_fc_tgtport_get(p) __nvmet_fc_tgtport_get(p)
+#endif

