Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5836AC47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DHZELq6Vv0OOpJT2G/raSTh59S/pSxtRcGiffif7/zI=; b=EkXq/IOZItodVw/oee2lSuCjpR
	RRR4WNVoYV+7PPKi4QyLWfK+4YJ6kivLeOd2af/yJYSvcT9OazrvLxoCou1OgYyX0DWkhEdK6yugk
	ZKoUpB76FWGRvcI976HQ2XdURU9sP+quUpxmvpWkPxxv34N14OwkZKB8ckZ85XNCqNsLeqXQtLoS+
	XC6teVYSWAYuQLN2NUnHHxAXHC5HsAh6+heVSuKxYQRBTMZuNqdoatzDMnU2zPrT18F1ByeqQgI0P
	ezTx6Ja0ncTSg1A8K28mHLDXhHlj4GqOM08f5w8/rG54f2ifrQDCVfE7qI1gMAx8vUpVtUwfm3jNF
	510iwRWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwEO-00Cijt-0I;
	Mon, 22 Jan 2024 15:29:00 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwEL-00CiiP-17
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:28:59 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8577922176;
	Mon, 22 Jan 2024 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705937334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHZELq6Vv0OOpJT2G/raSTh59S/pSxtRcGiffif7/zI=;
	b=kPBZ4px8Z0O49WBAmboktAt0VHueztUDuHO1qbLHO2A2xeg319yDqngrSv/YDo9Zo0sWc9
	ipFpiA7ehXN3Y6dnVeNfRMAvrW8uJBex+8bXy8NqDr/XJtaidHAL6Gzu6rKLKFqZ6vfGVI
	MulwKzW5BhmMhe3WFeDlQyU+dhA3/W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705937334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHZELq6Vv0OOpJT2G/raSTh59S/pSxtRcGiffif7/zI=;
	b=rAqdH9EUkE9J5KbpKEy1cuMzRq6HyCfVZstL+w7q68eImvbUFCKthFzHFpzbS4btw5MtVE
	GPeXFwLfIN8q21DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705937334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHZELq6Vv0OOpJT2G/raSTh59S/pSxtRcGiffif7/zI=;
	b=kPBZ4px8Z0O49WBAmboktAt0VHueztUDuHO1qbLHO2A2xeg319yDqngrSv/YDo9Zo0sWc9
	ipFpiA7ehXN3Y6dnVeNfRMAvrW8uJBex+8bXy8NqDr/XJtaidHAL6Gzu6rKLKFqZ6vfGVI
	MulwKzW5BhmMhe3WFeDlQyU+dhA3/W0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705937334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DHZELq6Vv0OOpJT2G/raSTh59S/pSxtRcGiffif7/zI=;
	b=rAqdH9EUkE9J5KbpKEy1cuMzRq6HyCfVZstL+w7q68eImvbUFCKthFzHFpzbS4btw5MtVE
	GPeXFwLfIN8q21DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71E78136A4;
	Mon, 22 Jan 2024 15:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l/xVGraJrmXPaQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 22 Jan 2024 15:28:54 +0000
Date: Mon, 22 Jan 2024 16:28:53 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com, oevron@nvidia.com
Subject: Re: Re: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI
 offload
Message-ID: <juclu4662fnok7u6bh5hnekm7ggqly523nnh5mfbzf2nyompjr@ykwshckwj32s>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-8-mgurtovoy@nvidia.com>
 <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr>
 <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com>
 <acr7me2i63tk33ljxst55ifobw6vqnp7mtnsiuv5fszwimrcyj@lnmydpvawzfu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acr7me2i63tk33ljxst55ifobw6vqnp7mtnsiuv5fszwimrcyj@lnmydpvawzfu>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.46 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.66)[82.82%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_072857_532520_BCC672EE 
X-CRM114-Status: GOOD (  14.18  )
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

On Mon, Jan 22, 2024 at 04:27:08PM +0100, Daniel Wagner wrote:
> On Mon, Jan 22, 2024 at 05:17:11PM +0200, Max Gurtovoy wrote:
> > > What about 'enable_pi' instead of the inverted boolean logic?
> > 
> > we can't change the default behavior (that is "enable" by default).
> 
> But couldn't we just have
> 
>     enable_pi = true
> 
> as default then? This should be the same as
> 
>    disallow_pi = false
> 
> ?

Ah, I get it now. This interface doesn't work this way.

