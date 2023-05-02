Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D429C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 12:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KbeXHGKWj2YyZ1B4O+LLJ0cAowHX1KL4MZ0ye5IodE0=; b=2C3gUadZf+XTAvXCMLOtQ9UNZO
	cdsDuamMqZ+PffQ+7n3/Ck0vHVa2sxwuOWHVdcSvCXV7q/Rn/H9C2Tyz+w4Q2JONNcnxM1J5QWrb1
	9ufDnmzaCIc82vb/OcFIkwKZ8UnIxLoLCIbYisO5KZqnbN7keCFrQrN9bo6bPr3ZxWfP10A2oByx9
	AJsJIbvgZc7GBMRTwQsgM79fFc+9AHKuurqbg4ZIhqZ2akI2zgvTGKII2La9gBsc8AcrNbyvqBg3X
	o2kdA8v+SRNr4iupfdoJr2FqzjKeQK74Ad0k4tNxHofs8j4hNv62K1qGP9N6ekr4JZuzr50vrEsDH
	+2LK6YJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptpX0-001WMw-2p;
	Tue, 02 May 2023 12:54:58 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptpWx-001WM9-2a
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 12:54:57 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C75D81F8D6;
	Tue,  2 May 2023 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683032092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbeXHGKWj2YyZ1B4O+LLJ0cAowHX1KL4MZ0ye5IodE0=;
	b=agtIXfyiT/A60NnvYLWabSU43bc+veyerxOHpQdJC/Nx8hJZsVnRQALybNg0BKE3chUKb8
	AvudVQ3Qp6zlEBK6dN8EQzfp0jq104A5DIjFWmMm5CkvP63GQ2doPWvUqGL9aCCzkdgwgN
	CWpyj18S8I0y4CdDcnmtbG6G7ElShnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683032092;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbeXHGKWj2YyZ1B4O+LLJ0cAowHX1KL4MZ0ye5IodE0=;
	b=NU92dZ2HIKWCyjU+aPZkQuFndzCN85HxRWzQL6ZGDZ9r2jmNrpOywKjDNCGG2K8K/SU1v/
	UtMoZRj69Ia0emDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9C2F134FB;
	Tue,  2 May 2023 12:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GxJWLRwIUWQDSQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 02 May 2023 12:54:52 +0000
Date: Tue, 2 May 2023 14:54:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH REPOST blktests v2 2/9] nvme: Do not hard code device
 size for dd test
Message-ID: <p5eminun5jsblyb3k5nycsrefpzlzqlrihozlz3ezh65hcsfnu@pxhvomc3qwmn>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-3-dwagner@suse.de>
 <z3lbxnnewuwnozrme27okchaxytt7zegj4emgpt4gmewsvcr5k@aordfdu7tai4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <z3lbxnnewuwnozrme27okchaxytt7zegj4emgpt4gmewsvcr5k@aordfdu7tai4>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_055456_008732_28B8E132 
X-CRM114-Status: UNSURE (   7.55  )
X-CRM114-Notice: Please train this message.
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

> > -	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
> > +	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
> > +	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
> > +	count=$((size / bs - 1))
> 
> Do we need -1?

Not really. My aim was to just to make it test case a bit more
reliable. The original test didn't fill up the disk either.

I am going to drop it.

