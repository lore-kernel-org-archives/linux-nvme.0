Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B19C7EE2D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Feb 2023 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B3YEIkeV1KI4xTL43s6J40Jp5R4JmzZeHnmzi6hqOzg=; b=mDtgJJAA+ZGs/A54ul2CVY28oc
	j773fWn2qI9ap2y1vmJXbKNfqhVtmPyq7Bi6cMyjWjnesqp5By/uyroZZeFUPRFzfeMaMwxglEjLf
	kCVxWjZRXcLmvRHYVDIXfRpzU7aVRaQNcouvixTNdASlReM0rWZaJwbi366S4wc4uIQ8TzTfOGlBa
	jB05xcJOCSWwS3ujaFBZq6/Aea/flSLj8yfoZNhJ2IbJtXoRRHtFhKdJ1ZrlnJJTleW/L4c1uiT3k
	WnCa/XNu6cs1iBnraMN+d0uLz+aEdBsrRi3cAw9vol0CpXcXpNDwtiQA59e3k8JvgO4Wg7rvKpk0Q
	KDbIxm5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWZRo-008z4a-4T; Mon, 27 Feb 2023 09:05:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWZRk-008z40-9U
	for linux-nvme@lists.infradead.org; Mon, 27 Feb 2023 09:05:25 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 24D2A1F8D9;
	Mon, 27 Feb 2023 09:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677488721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3YEIkeV1KI4xTL43s6J40Jp5R4JmzZeHnmzi6hqOzg=;
	b=ufpH5I987bw7VP+bPV3HySGMQN4mEv8cOujY3Up5p1uFmEqfUOTYfSAgU42gaQrT0aM9Dz
	PkzCm3ktnrANMwnbR31SC0bqkOWeFrTDLz5+5KKKa6LBhTi0RpqjLEqezdJi+d7V5fbYBz
	MxI+3jIn0kwg4Jk7LtDQ3CDlnsTZ8z0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677488721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B3YEIkeV1KI4xTL43s6J40Jp5R4JmzZeHnmzi6hqOzg=;
	b=g8+aVpSMdDw4ic62r02o9/NTAtA1N+AF5TBwE3XRUiyUnsp9l3whOt7fdWK6q1KmGYSlV+
	CVzBy10xnZnZeTCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 150B513912;
	Mon, 27 Feb 2023 09:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 704TBVFy/GPMSgAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 27 Feb 2023 09:05:21 +0000
Date: Mon, 27 Feb 2023 10:05:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230227090520.h5od3lutqkfu35ez@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
 <20230223145336.lulowpv3vlr65lwu@carbon.lan>
 <63b276e4-a7eb-f493-fdf7-8dc343aaff50@riseup.net>
 <20230224085725.girihudjbjjhbxm2@carbon.lan>
 <f8ba7be0-37f4-0c5f-373b-2dd3a3a54715@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ba7be0-37f4-0c5f-373b-2dd3a3a54715@riseup.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230227_010524_513146_3BBD2996 
X-CRM114-Status: UNSURE (   8.92  )
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

On Sun, Feb 26, 2023 at 01:48:04PM +0300, Ivan Rubinov wrote:
> I run arch linux on live boot without my patch
> kernel-log:
> 
> Feb 26 10:38:28 archiso kernel: nvme nvme0: pci function 0000:01:00.0
> Feb 26 10:38:28 archiso kernel: nvme nvme1: pci function 0000:04:00.0
> Feb 26 10:38:28 archiso kernel: nvme nvme1: failed to set APST feature (2)
> Feb 26 10:38:28 archiso kernel: nvme nvme0: failed to set APST feature (2)
> Feb 26 10:38:28 archiso kernel: nvme nvme1: allocated 64 MiB host memory buffer.
> Feb 26 10:38:28 archiso kernel: nvme nvme0: allocated 64 MiB host memory buffer.
> Feb 26 10:38:28 archiso kernel: nvme nvme1: 7/0/0 default/read/poll queues
> Feb 26 10:38:28 archiso kernel: nvme nvme0: 7/0/0 default/read/poll queues
> Feb 26 10:38:28 archiso kernel: nvme nvme0: globally duplicate IDs for nsid 1
> Feb 26 10:38:28 archiso kernel: nvme nvme0: VID:DID 10ec:5763 model:ADATA SX6000PNP firmware:V9002s94

The duplicate IDs is addressed by NVME_QUIRK_BOGUS_NID. The question is what
happens without the NVME_QUIRK_IGNORE_DEV_SUBNQN quirk. Could you try with
NVME_QUIRK_BOGUS_NID only and post the nvme log output?

Thanks!

