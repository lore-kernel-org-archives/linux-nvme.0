Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11DCECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 15:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUi8c/xwsd+hXZ4Lr/T+MRbL7l9v3R17IQVPGno5Zf8=; b=2CIh6p29g9+xvFMiydqSd8IRHk
	e1RHe6z6vRcBxlcZjvYi0aNeMYDH2Tr05vzrtrU/af4LRXZDLL0f7/38wEodw5Rlerim4u7PhZDDc
	OvQqaQKAayn+L3g8Ca6tvDKBuPu4LyAWQfgvm8U8nrb24TS7eJmm+S8ytx8QHggCVASHRNdWIRN9/
	jemz0Ivz6qR/Ewp5nk+wV7DCqt+9LcOa1mocC/dMpvm508TwyGGWOMLCV3GJipOrfWN1QM1qu3IOr
	CjgjqF2NsZAeS7PKgNTF4dkU5CGd2aMgyRmzg67GnqkQzK8Lxt3Kz6cC4vEhFtuGrFxZLm9bQfPnO
	LambFNyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4rK-00E5t4-CH; Thu, 27 Oct 2022 15:31:54 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo4rI-00E5s7-9P
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 15:31:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BE93E21BF1;
	Thu, 27 Oct 2022 15:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666884706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUi8c/xwsd+hXZ4Lr/T+MRbL7l9v3R17IQVPGno5Zf8=;
	b=Plkrm9IbmPJ5tZRHq2C41ddM4tJr9wnWjZBdIKr2YGwnuXph0yTgG4Fpoyw/SoSIBg90fQ
	ge2dfqiTCa6ZNynyAHE37+Vl8RYuy6lYt9XxxL2t6rCyAAKjzqeKkfQwQ3GjatX8PMn856
	STSddM6OLUQcVxWv0gEwTIy22Or6s6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666884706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wUi8c/xwsd+hXZ4Lr/T+MRbL7l9v3R17IQVPGno5Zf8=;
	b=QCgbBsuVtv740EskAgLrXHWrCMYMti6tqSpjhvp/tYtx3gb9DA3ybh49CAv0Dm00yt3Yuj
	+TvN5cIr0pmDXfCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA412134CA;
	Thu, 27 Oct 2022 15:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Fw72KGKkWmNzNQAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 27 Oct 2022 15:31:46 +0000
Date: Thu, 27 Oct 2022 17:31:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	chaitanyak@nvidia.com, joshi.k@samsung.com, axboe@kernel.dk,
	Keith Busch <kbusch@kernel.org>,
	Alan Adamson <alan.adamson@oracle.com>
Subject: Re: [PATCHv2] nvme: quiet user passthrough command errors
Message-ID: <20221027153146.rqjmlvs3hosrjfir@carbon.lan>
References: <20221027150417.1954662-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027150417.1954662-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_083152_515006_FE51FC37 
X-CRM114-Status: GOOD (  10.21  )
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

On Thu, Oct 27, 2022 at 08:04:17AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The driver is spamming the kernel logs for entirely harmless errors from
> user space submitting unsupported commands. Just silence the errors.
> The application has direct access to command status, so there's no need
> to log these.
> 
> And since every passthrough command wants the quiet flag, move the
> setting to every user's common initializer.
> 
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

