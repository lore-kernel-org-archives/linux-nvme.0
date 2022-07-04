Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A6DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Y1yU+uyYMoqwzNmnSPdcB4rQIIRze0y46aqscJmlYA=; b=THMqGstBixWNkQaON8gNMo+fFy
	79gUMviSF9VB45RjbI4qFulLf60ZaHZ0fbrkMxpWHalsk9r0+rmlwPufsCZo7F4wR5ncr88XUVX1C
	jXUL95RTrZaA4710joFMBVGyvnwTUrR8Bt6/WqDqrXWZvSnhZ7DDsePZvErd7GBr9lH7HskRq+Vrn
	p0WpU8J6Yn27Mo1b/NYwdQim28Psyo8JDSYNLVD494P77zCl9dZ5L9XervrVLXwPtTQy8uCYOFz3n
	7gB0LGNvfbLlkCCyUextvjK9poe46hDlGfcfLtOcSf3uAolgWyRREggODqlFRk71IbwZ1j7zPgE+K
	3NN3HUEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8Jzf-007Wa4-Ss; Mon, 04 Jul 2022 11:11:56 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8JTu-0076AT-0a
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 10:39:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C3222CB4;
	Mon,  4 Jul 2022 10:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656931140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y1yU+uyYMoqwzNmnSPdcB4rQIIRze0y46aqscJmlYA=;
	b=og29tcfABqIkZgL3HvS3Kx7DUTsfctiMie6/H6OM8qnk0rBj89MtGYMImnScFiedz2h1VN
	14dS80iaHdGXNDXY/j8NsgIOJBU/5y+kdz+De1OQYRZ9QV2RdjvC0fbMa5eBSAC47NpCWl
	VpkrWyRymlHkxOgCTO6cYpY3TTMZUik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656931140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y1yU+uyYMoqwzNmnSPdcB4rQIIRze0y46aqscJmlYA=;
	b=LXY2ldkfEZ1EAZIlaFb/bmMygxtkmtPliiwEbtbY5vJ9DZLLxpOkymy2N9pd8NfuBrTEQ1
	3JAkE7d7FY+s45AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 562661342C;
	Mon,  4 Jul 2022 10:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8R4DFUTDwmJeeQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 04 Jul 2022 10:39:00 +0000
Date: Mon, 4 Jul 2022 12:38:59 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH nvme-cli] udev: re-read the discovery log page when a
 discovery controller reconnected
Message-ID: <20220704103859.nb4xoguj3hjeyajq@carbon.lan>
References: <20220627080650.108936-1-sagi@grimberg.me>
 <20220627090255.5vpqvzcd7l2vjja2@carbon.lan>
 <7d8f7f85-9984-14eb-e16b-b3abc15312af@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d8f7f85-9984-14eb-e16b-b3abc15312af@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_033906_253544_05289EF4 
X-CRM114-Status: GOOD (  13.02  )
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

> > Stupid question, but when we issue the initial 'nvme discover' wouldn't
> > we run this rule as well? And if so, is this okay?
> 
> It will... and it is redundant, but don't think its a big deal because at
> worst we retrieve the log page and try to connect twice, one of these
> will see EALREADY...

Sure, but I am already seeing a bug report for the EALREADY. I'll add
the patch, though don't be surprised if I report a bug sometime in the
future :)

