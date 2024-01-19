Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7318FC4725D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jan 2024 08:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cte9FR6Tj/4gvsaCaaiswpa4Akx9oWH+HBVA/j09VRY=; b=edNQLEJrWAjYGx12pHl+bE+O9u
	T+KcBZ21E+XFa560HV/TqqqMkh4ihR8lPd8zc88njMxxhz+spIbZyfeggeWHAjPhOnl8N/ngwGKMN
	j5TgoekXgRl3rT59r97lnL2mOaVdIkarkKBHfF1XqrXytH34T95x/kiQ6F7CxRwatLvoFXImPjll+
	wSVu4kQ/T2YwjUc4hOudqJDvGnBuB0lbEnTcMTOZuZoTsz5J+6T7Iw2lLdedKBrCzqMtorK4vOXKW
	kNa2VCVK+Nt/kMaWfCkCrD0wgE6KHn40U9NsSdBWXlA1ZEuHPv0EPqzgvdC/qg7GOt/d0cGD4BxIP
	CdZqCpug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQkSP-004s9A-0S;
	Fri, 19 Jan 2024 08:42:33 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQkSJ-004s8S-35
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jan 2024 08:42:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9008021E35;
	Fri, 19 Jan 2024 08:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705653745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cte9FR6Tj/4gvsaCaaiswpa4Akx9oWH+HBVA/j09VRY=;
	b=ObGxJ02eA+s0PM2N2zL7/btPn0MWHhpE6Qo8wGatZBY++rM0cwZc3tcCQ2cXTjQPRLZoLy
	X7beNVBbekd8riGD0qfcvxwv5J/yZWA94MPfDKaSRInZj7AToVGxnHaaD7gZD64LhW3U2I
	z/2h++ZHPFeT1zyT6PNqdYt0QTN6dAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705653745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cte9FR6Tj/4gvsaCaaiswpa4Akx9oWH+HBVA/j09VRY=;
	b=71uTnxW4rbMeyXICdjeXLL5he0RSh3K3sZ/Yqth34FkjBrXRS7i4kJmiiim799krV5zdvS
	eJ+a02o/META/1CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1705653745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cte9FR6Tj/4gvsaCaaiswpa4Akx9oWH+HBVA/j09VRY=;
	b=ObGxJ02eA+s0PM2N2zL7/btPn0MWHhpE6Qo8wGatZBY++rM0cwZc3tcCQ2cXTjQPRLZoLy
	X7beNVBbekd8riGD0qfcvxwv5J/yZWA94MPfDKaSRInZj7AToVGxnHaaD7gZD64LhW3U2I
	z/2h++ZHPFeT1zyT6PNqdYt0QTN6dAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1705653745;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cte9FR6Tj/4gvsaCaaiswpa4Akx9oWH+HBVA/j09VRY=;
	b=71uTnxW4rbMeyXICdjeXLL5he0RSh3K3sZ/Yqth34FkjBrXRS7i4kJmiiim799krV5zdvS
	eJ+a02o/META/1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CC1C136F5;
	Fri, 19 Jan 2024 08:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rL+pHPE1qmXgRQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 19 Jan 2024 08:42:25 +0000
Date: Fri, 19 Jan 2024 09:42:24 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, Niklas.Cassel@wdc.com, 
	chaitanyak@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: Re: [PATCH] nvme-host: fix the updating of the firmware version
Message-ID: <oxg3l33bnkpvtjyhrk5czbpvuk4t6w6urfywdrrboypblll3kc@hjx6z4rlfjot>
References: <20240118114854.672748-1-mlombard@redhat.com>
 <3urnhr2hdyn67zbw5a43cscnumbd3h3a2cd63n3ofaslwec2yv@yg3dpb22s2pb>
 <CAFL455kjiM9=ifcJOLAoKWzTHhuJkWrhPH8n+Me4fFxUAEmF-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFL455kjiM9=ifcJOLAoKWzTHhuJkWrhPH8n+Me4fFxUAEmF-A@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.02 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.65)[0.883];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[55.04%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240119_004228_156650_EA5BD78A 
X-CRM114-Status: GOOD (  21.63  )
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

On Thu, Jan 18, 2024 at 02:21:03PM +0100, Maurizio Lombardi wrote:
> čt 18. 1. 2024 v 13:31 odesílatel Daniel Wagner <dwagner@suse.de> napsal:
> >
> > Is this not an undefined behavior if it is not in the spec? Just
> > saying this is not so clear to me.
> >
> 
> I don't think it is relevant in this case.
> The spec just says that bits 2:0 are the active firmware slot and
> bits 6:4 are the next firmware slot, it doesn't say that
> they must have different values.

I see.

> What the spec leaves undefined is what does it mean a "current fw slot"
> with value zero, which is invalid.

The valid range is 1-7 for the slot ids, that rules out the value
zero IMO. Yeah, I agree not a thing at all.

> By the way, I submitted this patch because we have a customer that complained
> that after a firmware update he noticed a discrepancy between the fw
> version reported
> by the kernel and the one reported by nvme-cli.
> He says that this patch fixed the error.

I suspected this but it was not mentioned in the commit message. Good to
know that it fixes something. In this case,

Reviewed-by: Daniel Wagner <dwagner@suse.de>

Thanks,
Daniel

