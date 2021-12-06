Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD9EC433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Dec 2021 13:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=drUCP0u2x3MDc5AsNUgqbjYS+31dqIY8f9IoxOx6DY8=; b=3ktsJzP7dCLMWR/5YSkjdixgt3
	uJhPzq2gjZDCZn9rWW/ppow1OO14ks+cbKaS6D0TZ8EzlV9ImPGDL22pVVvG7qrADG+QpEs8wBQ23
	jzxm+09rCiQ8FfEnw6pyqP+tNAwmKXKNVDPEqINRy71SCFwPVcjyr58POjLq6ZQvf3I0KJuhJEx0j
	0JfsHJuiQvb9vUwTRr1ZhBa0kllKddbKJGHZmzdoYCI70pPYKkWbBqt9Jlnu3fxetU9QavoxO74qM
	meJPsbtW4vxm+jgPOTuE/wOg5qWvGsvbnO+pzMB5A6brc0wAC5OMytqn4BOSRkaQs/lTlaT9A5Io1
	hugXgHkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1muEGX-0043b0-Mf; Mon, 06 Dec 2021 13:42:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1muEGV-0043aN-FC
 for linux-nvme@lists.infradead.org; Mon, 06 Dec 2021 13:42:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 149601FD34;
 Mon,  6 Dec 2021 13:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638798162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drUCP0u2x3MDc5AsNUgqbjYS+31dqIY8f9IoxOx6DY8=;
 b=gcKvEcexga3e1pPQcB6nfvS4wvYVwCrwwstOs+9EGoJjArLeYeHzM5N14FDJ673txJijFe
 LBL5dHuJa+0uSZl9Smt1Ct91rSJjXbu1iXiQ9YZUga69bRUSqhm89x++nYVhCKlUZpiKiq
 ADMbAt/w/8Kg40HNdduKogoE9ZJuarY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638798162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=drUCP0u2x3MDc5AsNUgqbjYS+31dqIY8f9IoxOx6DY8=;
 b=K7BzCCCBwqm8CuvXAk6rDaEfLhYFrEN9hBz23gKne5dvxI+LVi1O5dfdptZ+jhT1/ep8ff
 PWa/whase8cMhuAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0535813BB9;
 Mon,  6 Dec 2021 13:42:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Crg+AVITrmG0JQAAMHmgww
 (envelope-from <dwagner@suse.de>); Mon, 06 Dec 2021 13:42:42 +0000
Date: Mon, 6 Dec 2021 14:42:41 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvme: Add sibling to list after full initialization
Message-ID: <20211206134241.icrqtztqlzbwumtn@carbon.lan>
References: <20211111132135.19216-1-dwagner@suse.de>
 <YZfakf32dXVFhK5E@infradead.org>
 <a7f48220-8c50-3388-dd40-4f51081ec6ec@grimberg.me>
 <YZyDGRhyjYJu+9jK@infradead.org>
 <064b3972-dab4-c31b-b5c9-b0d9b1475ebe@grimberg.me>
 <YZ0UFxo/LV5V8laX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ0UFxo/LV5V8laX@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211206_054247_702764_2D13540C 
X-CRM114-Status: UNSURE (   8.29  )
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

> I'll drop it for now then.

Thanks, the patch is not necessary due to do the changes from
5f432cceb3e9 ("nvme: use blk_mq_alloc_disk").

Next time I'll make sure I mark the newest version of the patch as
invalid if such a discussion happens on a previous version.

