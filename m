Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F56C48260
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 12:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=; b=TkvbPMuiUjyxiXXrCpda61upzE
	Qs+GFVJZznzH/8TaeFl2RNda/qAChznvPnhNI8SVDP1RPwE5Ab/MWV83c29RIkslISYq5M8NVd6CG
	a7xWIYUthH7o0YRT5jo2igA7iDuYXkSbW296/McZjEtpqLDiZXk7PVhXOXlWNpFgpeqbrzJdlmHtY
	bj9CqLsYxtJtFMsCc9Z8Ji4cDYbAq8yqqroYb+BL2X683VQOZ+j06ZCqjMGBtZpH8pQuo77Gl1VSV
	/i+zT5MDlYGuF/Ig8nKGum/MyNbUpB0TtwJ8iXprvi3RnR6G0qlNZGIHsoGy9PIvGHWLTcFb84YtV
	8DToKlrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raxVp-00000002KXD-49ib;
	Fri, 16 Feb 2024 12:40:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raxVl-00000002KVO-0eJ1
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 12:40:15 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 51EB61FB68;
	Fri, 16 Feb 2024 12:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708087211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=igJDODRLJf5ZZ/kNCLeNrPbX3BK5cFBFZl1Suv1lxxiFQE9pVrEIdDgbmtuBChwp1F9Sw3
	tzA7/ZiMC3iO+U73leK9yUA16P2tmSJFbQvwrtk5/0/4jSnPqDY9ZDFtvxdXd4F6+g0/xx
	yIqxM9y7ef87S0VbdQoeHjbYGkZy9og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708087211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=g7z39LWDzHF4YqaFQ8QSkxoB7wsTG42z4EvBJyUWPDpRWdWuic0dF37zbo7gLGJrvsRryj
	nunN3xwSgmpXxFDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708087211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=igJDODRLJf5ZZ/kNCLeNrPbX3BK5cFBFZl1Suv1lxxiFQE9pVrEIdDgbmtuBChwp1F9Sw3
	tzA7/ZiMC3iO+U73leK9yUA16P2tmSJFbQvwrtk5/0/4jSnPqDY9ZDFtvxdXd4F6+g0/xx
	yIqxM9y7ef87S0VbdQoeHjbYGkZy9og=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708087211;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8SE3qrLWVEbZxr++ON5K97v+oJUCvjFpwWzmyWT38QU=;
	b=g7z39LWDzHF4YqaFQ8QSkxoB7wsTG42z4EvBJyUWPDpRWdWuic0dF37zbo7gLGJrvsRryj
	nunN3xwSgmpXxFDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F7A013343;
	Fri, 16 Feb 2024 12:40:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id e0kPDqtXz2XTIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 12:40:11 +0000
Date: Fri, 16 Feb 2024 13:40:10 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: James Smart <james.smart@broadcom.com>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v0 5/6] nvme-fc: redesign locking and refcounting
Message-ID: <dotdh6bz2togarj62bjegvlxadicsxl7h42qbt7zkbu7oyyzqc@dw4eafuqtzfd>
References: <20240216084526.14133-1-dwagner@suse.de>
 <20240216084526.14133-6-dwagner@suse.de>
 <c5f27e3c-d034-4a40-bfb5-1bd5ec5f5dfc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f27e3c-d034-4a40-bfb5-1bd5ec5f5dfc@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.73 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.13)[67.32%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_044013_379189_1C1BF9A9 
X-CRM114-Status: GOOD (  14.04  )
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

On Fri, Feb 16, 2024 at 12:09:20PM +0100, Hannes Reinecke wrote:
> Hmm. I'm a bit unsure about this; essentially you change the rport
> refcounting (and not just the controller refcounting).
> And the problem here is that rport refcounting is actually tied to
> the driver-internal rports, which have a different lifetime
> (dev_loss_tmo and all that).
> 
> Would it be possible to break this in two, with one patch changing the
> controller/options refcounting and the other one changing the rport
> refcounting?

Yeah, I see. I completely forgot about the dev_loss_tmo thing. I'll try
to split this patch.

