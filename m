Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CD6C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 06:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=; b=kQT2h27tV3hACoTnxw7tfahxbk
	zSoefo03mJ8ciVHhigrPzyBn00g7lxUN+IHRPjnUKDqcbCrp2/nrGS63dm965u1HzWmToZHt26cPI
	OMAvOk8vc5NX9AzpbFFXetmCkfv/PoNQd40Q7rDxwx3U9zAcVbp20ChLByQrsPbcKMZMmCAN8/fQ6
	QBcGFAv4ZJfHfnFtUUGXutPdWT/D5xfKwT/3RJt8aCQNNIrLg/I49YIspCjAqUoMv4mzIrbzRxyZS
	8h1gbsU5/KDUAD9u7Nmq+8jSZV4ZkfHsWEggPyFYpR12/9HdcpMrWMeX9qxTURp2MXbddFDMf8zLb
	BEWkxa1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwcko-0000000B9Zm-1zRL;
	Tue, 16 Apr 2024 06:57:18 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwckh-0000000B9Wb-2wox
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 06:57:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4540637903;
	Tue, 16 Apr 2024 06:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713250622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=Vj4EW+4tSFjfDqc+RvANS6DYpNtTdAXdIK7O1g5MF//WY+Rf+HzYMC3oUtIePdw1ZPmw93
	RLUAZGITwpzYLBZtEdguI197S/4tsSBSV/TnEAtsooHU9F6QoSBARLpMTm38eVH60mzdz1
	CfU/A4zZ6z/A3N5S7d6WzZuHwLNAjaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713250622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=dpkAv4KPIgwZ57QQEkDBGR+06uqkjsX1dPp6kzqD2KZSlfOlKbDZRcPBqXd+XtqtFh4ivN
	PvRz0jTsGsJzoABw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713250622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=Vj4EW+4tSFjfDqc+RvANS6DYpNtTdAXdIK7O1g5MF//WY+Rf+HzYMC3oUtIePdw1ZPmw93
	RLUAZGITwpzYLBZtEdguI197S/4tsSBSV/TnEAtsooHU9F6QoSBARLpMTm38eVH60mzdz1
	CfU/A4zZ6z/A3N5S7d6WzZuHwLNAjaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713250622;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tO6YKqvR1Orl0Jyn0aSJ7A85sVhbE34JsSsizeJW7qY=;
	b=dpkAv4KPIgwZ57QQEkDBGR+06uqkjsX1dPp6kzqD2KZSlfOlKbDZRcPBqXd+XtqtFh4ivN
	PvRz0jTsGsJzoABw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E92013931;
	Tue, 16 Apr 2024 06:57:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R47nCT4hHmYgSgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 16 Apr 2024 06:57:02 +0000
Date: Tue, 16 Apr 2024 08:57:01 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
	James Smart <james.smart@broadcom.com>, Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] nvme-fabrics: handle transient auth failures
Message-ID: <qn4grwiboyzfoeqnow2decvvnq7wpymsc6yt5o6kxmmllrdlpj@6ymom3pxgsj6>
References: <20240415124220.5433-1-dwagner@suse.de>
 <20240415124220.5433-6-dwagner@suse.de>
 <51fc1a3f-7166-49cf-9652-a95bdc5d2119@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51fc1a3f-7166-49cf-9652-a95bdc5d2119@grimberg.me>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_235712_007589_FA59CD21 
X-CRM114-Status: GOOD (  22.35  )
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

On Mon, Apr 15, 2024 at 11:51:19PM +0300, Sagi Grimberg wrote:
 > -	if (status < 0)
> > +	if (status < 0) {
> > +		/*
> > +		 * authentication errors can be transient, thus retry a couple
> > +		 * of times before giving up.
> > +		 */
> > +		if (status == -EKEYREJECTED &&
> > +		    ++ctrl->nr_auth_retries < 3)
> > +			return true;
> 
> I did not suggest nr_auth_retries.

Correct. I explained why I didn't want to use nr_reconnect counter here.

> Where is the 3 coming from? The controller already
> has a number of reconnects before it gives up, no reason to add
> another one.

Sure, but seem to you consider all EKEYREJECTED errors are transient.
But this is just not correct. There is also the case where the key is
not correct on the first connect attempt for example, or the ctrl key
gets updated but not the host key.

> Just don't return false based on the status if it is a transient
> authentication error.

Not all authentication errors are transient.

> The patch just needs to be modified from
>     if (status < 0)
> to
>     if (status < 0 && status != -EKEYREJECTED Plus a comment that explains
> it.

This is not correct. This patch is not following the specification
already and I don't think we should bend the rules too much. Hence why I
limited the reconnect attempt on auth errors to 3 attempts.

