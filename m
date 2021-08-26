Return-Path: <SRS0=DYpX=NR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FA3C432BE
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 08:05:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D9C60FE6
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Aug 2021 08:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 26D9C60FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3PkgBQcSvJAiD2+UkcrkpKFPxpMRS0/esQqrUF7pEdM=; b=lsKk8WNuRexs4F
	S8IZK/lxVSUb7ppxjkABs0zQT7ynnto4UcLLeORDMYkzKLY/9Vb0OL9E1k0qLsdR1lIAGH5YnGnuf
	qX8V8hPmzrP9OnH1ESRgnZLE7IhQnx6ELKpGrjDoSA51oTjbaWN6Zxw/Svg1epZYIEIWdFx+n9Z6R
	1rkFkmsOCburuidAxz0lT5OT2qgLwGBGNL91ej53QxNgHUHX0tEMYBx5Wd5FyVhrzboDtJUZEfP1h
	Hw+dJS8YDbx2vgKt4U3kuge59g+U8kwNrqJ+RlCgRuSKxTfEfXbix/2d5a3IVpzbLTi1Mxow88Qlx
	yGW2rIiMHZVd9N8pL9gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJANe-009VYs-40; Thu, 26 Aug 2021 08:04:58 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJANZ-009VXm-3M
 for linux-nvme@lists.infradead.org; Thu, 26 Aug 2021 08:04:57 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C8CB1FE50;
 Thu, 26 Aug 2021 08:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1629965089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dz4kMtmgcRiHH+eY6OlEi5nZ3aLXbNcHgM4etPf13YA=;
 b=RaXHj+z76JhybAusnJe/l5NgRbJwuKMyClTuYWeByEJJa/3JcL7lcatSFh3wD6+BIsO7KH
 lVKUfqGj/RN39FluYHyasW77HJs5DlJ/VQJ9i8apnUjLEz3zFh9zh7ASrPMz7HNOcUDcoj
 Bd69K7fsaoOAiDFvrRaF8RRqaRLheHU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1629965089;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dz4kMtmgcRiHH+eY6OlEi5nZ3aLXbNcHgM4etPf13YA=;
 b=uOQW8kR7vS07Lld8N+NnGkMD3J7DCLMAXy5tHiraRSCQp1sBKlYEMVQC0k2GdVXCc9MKCk
 Dl4GJaPW/HRM9zDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6F15713A79;
 Thu, 26 Aug 2021 08:04:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id L3HLGiFLJ2HhBQAAGKfGzw
 (envelope-from <dwagner@suse.de>); Thu, 26 Aug 2021 08:04:49 +0000
Date: Thu, 26 Aug 2021 10:04:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, yi.he@emc.com
Subject: Re: [PATCH v2] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210826080449.6pzvgihxzqbsosrx@carbon.lan>
References: <20210825124259.28707-1-dwagner@suse.de>
 <42916ab0-2997-b19f-47ee-e20e8e868a86@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <42916ab0-2997-b19f-47ee-e20e8e868a86@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_010453_342880_BD4274BF 
X-CRM114-Status: GOOD (  12.16  )
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

On Wed, Aug 25, 2021 at 05:27:10PM +0200, Hannes Reinecke wrote:
> > @@ -506,6 +514,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
> >   static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
> >   		struct nvme_tcp_data_pdu *pdu)
> >   {
> > +	struct nvme_tcp_request *req;
> >   	struct request *rq;
> >   	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
> > @@ -534,6 +543,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
> >   		return -EPROTO;
> >   	}
> > +	req = blk_mq_rq_to_pdu(rq);
> > +	req->status = NVME_SC_SUCCESS;
> >   	return 0;
> >   }
> 
> Can't you move the initialisation to nvme_tcp_setup_cmd_pdu()?
> That'll save to to have to reference the tcp request here ...

Yes, that's a why better place to initialize it. Let me spin a new
version.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
