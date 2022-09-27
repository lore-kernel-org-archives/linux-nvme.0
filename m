Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3EFC6FA83
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 15:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ZPUKQrk+v21SuK8oN7edgeQ+nbRk+63zCIVLhKspKk=; b=Cfc2T9ufGOiFtp4ug9ojvAX5gE
	0O8b/XASQAxKQA5c6QYd6OkVBTUaY4evc0J1wo0d1GAmO/U7h9J53H1I3iYaNuYha8qq3leBIv9YO
	8Hvmetf/v105YGAb9r9qI7lXXOy4BNzySrOLIoGo5+FDzm6AqfBlqWK1w+7UCynQbtrgw60bQ5+82
	MF7FaZDDk/X38Gs+xV7lPerQlhKmePHA5i8nm3IuFdMCbklWgztVNYbQ6PGBkluH4OOObF/XRa4tn
	pnVl2CbFXNIYOAM/FyqCajzt2Zr+IVY0PKfHl6iq8CEk167Nuc9V7Ng71xHbv3HtnfETjxk4a2WeZ
	/LEZ/WIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odC57-00BMgH-Sr; Tue, 27 Sep 2022 15:01:09 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odC55-00BMfl-Ax
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 15:01:08 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 410281FBA1;
	Tue, 27 Sep 2022 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664290865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZPUKQrk+v21SuK8oN7edgeQ+nbRk+63zCIVLhKspKk=;
	b=X+Xvj6Xb10b+6rxnL72JijOLl7bkmzvnEDEaP50ZTxR++lStACvR+dOi/+zGqRT7yQlG6H
	DVGqJkM1Pb4iogePA0/c3MJtkCg8+rdj8tICauRX0OoL6+Lry1Xu0LLPGJDcxNvZma9LLv
	LQguque7WNZiDJYGtKTSdOHmYHoFsyg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664290865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ZPUKQrk+v21SuK8oN7edgeQ+nbRk+63zCIVLhKspKk=;
	b=i0JynhvMv/2iheHA0lbjJXHJtY6fQw0Ph3UKSaq9eY+Ck6upuTC+SY0OiJI7klRSGYHyWM
	PdpKDBm1X/JfWfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3453C139BE;
	Tue, 27 Sep 2022 15:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id /oG9DDEQM2P/TgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 27 Sep 2022 15:01:05 +0000
Date: Tue, 27 Sep 2022 17:01:04 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH v2] nvmet: force reconnect when number of queue changes
Message-ID: <20220927150104.fb5u4c2zdl726u4k@carbon.lan>
References: <20220927143157.3659-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927143157.3659-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_080107_540543_B65F2CF8 
X-CRM114-Status: GOOD (  16.19  )
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

On Tue, Sep 27, 2022 at 04:31:57PM +0200, Daniel Wagner wrote:
> In order to be able to test queue number changes we need to make sure
> that the host reconnects.
> 
> The initial idea was to disable and re-enable the ports and have the
> host to wait until the KATO timer expires and enter error
> recovery. But in this scenario the host could see DNR for a connection
> attempt which results in the host dropping the connection completely.
> 
> We can force to reconnect the host by deleting all controllers
> connected to subsystem, which results the host observing a failing
> command and tries to reconnect.
> 
> Also, the item passed into nvmet_subsys_attr_qid_max_show is not a
> member of struct nvmet_port, it is part of nvmet_subsys. Hence,
> don't try to dereference it as struct nvme_ctrl pointer.
> 
> Fixes: 2c4282742d04 ("nvmet: Expose max queues to configfs")

The ref is wrong should be

3e980f5995e0 ("nvmet: expose max queues to configfs")

