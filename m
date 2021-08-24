Return-Path: <SRS0=S+bv=NP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BDBC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 13:49:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB5861262
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Aug 2021 13:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AB5861262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CR8wbuq+t8oQ5he/bdFajjvtEDv99TpNNDjqL18t8JE=; b=QWV9obYVD/l/qQ
	r+R/zCE5GCVCoSnJdMW340PiNXQXc1FsQX/FhYTljrU4sUStB3d/1y2Zb5YyPDcngXLfKw+L6OikP
	IkDH+pb31NO5sW/qqsmJA8jxl2H+ignGhTxCaUGH3BGyXNWoMf2Rh1LPadY9ZJs4waGmQfJQfUlSA
	V7jvLe7s6AHDERxurKMc5PvyNbFjfQRKoMnW0jCh1i6lJ9HfpHHfLQNi/a5D2bwcbUuNQwSAB0MHo
	NUQUGzpW3kh9Gzp9XMmuU5nFUW/Dk7BTTyellwySvn2HeAbtiP9yFICVaS84StLTBRu27Ft+KweTN
	v1ohkT8QXMObsHrPwiIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIWn7-003ITI-93; Tue, 24 Aug 2021 13:48:37 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIWn2-003IRh-8I
 for linux-nvme@lists.infradead.org; Tue, 24 Aug 2021 13:48:36 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBC942209E;
 Tue, 24 Aug 2021 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629812910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GT3SmtXIOdQpOv7U9TlSYCVsuxmf5fTKn+506gv5IZw=;
 b=GxyFEVtEhRzP9l/Wah4AwVdFN3Gcmr1GxywIjXTIdJIbfzapFiiY7kJE+Ucph4NrnJN/vb
 vAZUIEzYo1gAYOiK67TEI00TqbFuD7zutOxok96aK98MX/+UEGjjGs/fy0IxeoYv3G0MxL
 QlxGhLeVUAT1AuKX+MohJ6CBJnOngVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629812910;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GT3SmtXIOdQpOv7U9TlSYCVsuxmf5fTKn+506gv5IZw=;
 b=1XytS3pPNRH/C5ZKx25mGjTo5sNWOCpVKo4X7IPZ/WMFBt9YtfLR4fp0nxL4YgSG+qew1n
 OS8SJV/iO7dKlwCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DD01713A50;
 Tue, 24 Aug 2021 13:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id YH2LNa74JGF9OAAAGKfGzw
 (envelope-from <dwagner@suse.de>); Tue, 24 Aug 2021 13:48:30 +0000
Date: Tue, 24 Aug 2021 15:48:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v3] nvme: revalidate paths during rescan
Message-ID: <20210824134830.gdl4vojwhlsoypne@carbon.lan>
References: <20210811152803.30017-1-dwagner@suse.de>
 <93e8d113-55bb-e859-bf3d-54433dd23683@grimberg.me>
 <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210824134457.x33n7ihoe23jhyfx@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210824_064832_486547_1D9C116F 
X-CRM114-Status: GOOD (  18.31  )
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

On Tue, Aug 24, 2021 at 03:44:58PM +0200, Daniel Wagner wrote:
> On Mon, Aug 23, 2021 at 10:16:23AM -0700, Sagi Grimberg wrote:
> > > +void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
> > > +{
> > > +	struct nvme_ns_head *head = ns->head;
> > > +	sector_t capacity = get_capacity(head->disk);
> > > +	int node;
> > > +
> > > +	for_each_node(node)
> > > +		rcu_assign_pointer(head->current_path[node], NULL);
> > > +
> > > +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> > > +		if (capacity != get_capacity(ns->disk))
> > > +			clear_bit(NVME_NS_READY, &ns->flags);
> > > +	}
> > 
> > Shouldn't the null setting to current_path come after
> > we clear NVME_NS_READY on the ns? Otherwise we may still
> > submit and current_path will be populated with the ns
> > again...
> 
> Ahh, I got it this time! Yes, you are right. I think Christoph has
> dropped this patch from the nvme-5.15 queue anyway. I'll resend a new
> version with the order changed.

I am blind. The patch is queued up in nvme-5.15.

@Christoph, do you want me to send fix on top of this patch or do you
want an updated version of this patch?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
