Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10552C77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b2qUHxbFNWuVEA2GFkOYquFZaX+TXj0U5db+f7oebUc=; b=RRmW7+bPkryc05Jn34jJlnYUBt
	E5u4uGTMW7xhvdG/PKfdOF/yFpmsxr8EFX5yLzMafzh4WO/7CgGjUUAeRoUupXATCZkbzFzKSiCV+
	Ppb1+F7fCbXUu5zBuJUJ1ESX+x/JkhYpEZSKQO8Udb3xTkcS7qFb3lO24ghucWgWWSdIFAfALBtZB
	uSjIJ5DAIUKWC/yX/B7JT6a6F+NcYO4ndQ1KA5BIDPWhB5Hu7mIVcC2XMf7362M2v+EvX/GUeG74l
	pbcNQhlod1YMlmyQuiHa+2uhvVuTtjS9y/Ic7ryIYAGt/RglkYAm/Vxc6ASYiMKBIZ+rlxq1R0PdH
	gNs5NswQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poo1d-002jrM-00;
	Tue, 18 Apr 2023 16:17:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poo1a-002jpQ-0f
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 16:17:47 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50E3821A73;
	Tue, 18 Apr 2023 16:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681834662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2qUHxbFNWuVEA2GFkOYquFZaX+TXj0U5db+f7oebUc=;
	b=YprVtvHJtRcqjlb3CsUw2yq2ICBKIMjhBhRuz0tFbup2qCvM5Ywz1qUmcgSSLHy4ffJKti
	QPVjiXbxBgVO02PXo3Rc0Yke5FyuchVzvW9vF14UdYg4Vem2xful+Ro260ioOiYODQuGLE
	FjSaZcciQgN60rDLszBPTMWiEMyQwLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681834662;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b2qUHxbFNWuVEA2GFkOYquFZaX+TXj0U5db+f7oebUc=;
	b=H/2rgK6FudddyhQ9P22occLyWHJ43icsOXCK30w75uiWE++dPUKrrlBZDKldFoK37CqXz3
	cZ4ZlCGz/2W6w8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 410D613581;
	Tue, 18 Apr 2023 16:17:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id owDcD6bCPmSMHwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 16:17:42 +0000
Date: Tue, 18 Apr 2023 18:17:41 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests] nvme-rc: Cleanup fcloop resources in reverse
 order
Message-ID: <wdecxjd73uaser6l2274rvgz6q4xr7ytcljor3zyggbebjf3w6@kt4mfriults3>
References: <20230418123252.3725-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418123252.3725-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_091746_384681_C2EA4A6C 
X-CRM114-Status: UNSURE (   9.76  )
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

On Tue, Apr 18, 2023 at 02:32:52PM +0200, Daniel Wagner wrote:
> We need to free the resources in the opposite order as we allocate them.
> The deleting the rport first will also free the other resources. When
> we try to release lport and tport they are already gone.

I found some more ordering issues with fcloop resources.

