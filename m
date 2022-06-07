Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3437C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 11:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=FGOr6ZW+LuXWdIrxm6Lg7LwccqxRSi7+KGesQzK/UH4=; b=teTS5Lb6oZQ0UEjF3YiPqGqPDW
	+JzhJexiFJ5RzXF9gE7t7TkXi8p+mLxvkJwYHgIi1d4EsM1R9tNlsXvC1LYQFyw5ZsqQPGwY/pluc
	l7R36/V9fSWy6sNyN8lLm7c/7x3jRnQkaHehI7WyuF8aDKRQi5qd3GZUqGxb0Ep4siAvnXqz6vWtI
	sLISrh9iVm36pBKFpNpTC7bFwwO96FAEg5SBxaAwwpaSJRbzSIkpGMtIYAzF2xYpRa161e2u3CJBz
	QlR+AjKvhW7hy2Wx08C6Kq1lE8j8Pvn1sqmYe9Q+k/URLs0/6KhXdTgBQmMRZrw74PW0ke0dz3SJ+
	/fxnsDJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyXKF-0072jK-Dv; Tue, 07 Jun 2022 11:24:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyXGs-0071PU-H8
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 11:21:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8454F1F95B;
	Tue,  7 Jun 2022 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654600868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=FGOr6ZW+LuXWdIrxm6Lg7LwccqxRSi7+KGesQzK/UH4=;
	b=eUp730d3QK+N5oF2PUdNw3HUfrgQTrk6ZGXGMxNhgRQXJLrOkdO/IEC/E4NpnGJIKZl7XQ
	ZOODC6TGKg34qas5YGJJ8G8yuWStwAtO9K1B337k5aHDpCKRIJVb4OahZjBPFByfBIQswU
	nIsjEUJFfPj+UhTTaR5bQo64oTpvfKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654600868;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=FGOr6ZW+LuXWdIrxm6Lg7LwccqxRSi7+KGesQzK/UH4=;
	b=KiAMCoAjjaLSXvSefzY96F182jXwGpZvbBtq7cKkScktHsonp92lN4thTquRnbAAlaQfTX
	r4DwpJHkFU0Hk9BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A2FD13638;
	Tue,  7 Jun 2022 11:21:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id RaNdO6M0n2IRaAAAMHmgww
	(envelope-from <iluceno@suse.de>); Tue, 07 Jun 2022 11:21:07 +0000
Date: Tue, 7 Jun 2022 13:21:18 +0200
From: Ismael Luceno <iluceno@suse.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Enzo Matsumiya <ematsumiya@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2 4/5] nvme: quiesce namespace queue in parallel
Message-ID: <20220607132118.0bbb230b@pirotess>
In-Reply-To: <20211130073752.3005936-1-ming.lei@redhat.com>
Organization: SUSE
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_042114_782892_6F35696A 
X-CRM114-Status: UNSURE (   9.25  )
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

Hi Ming,

Has this patch been dropped/abandoned?

On Tue, 30 Nov 2021 15:37:51 +0800
Ming Lei <ming.lei@redhat.com> wrote:
> Chao Leng reported that in case of lots of namespaces, it may take
> quite a while for nvme_stop_queues() to quiesce all namespace queues.
>
> Improve nvme_stop_queues() by running quiesce in parallel, and just
> wait once if global quiesce wait is allowed.
>
> Link:
> https://lore.kernel.org/linux-block/cc732195-c053-9ce4-e1a7-e7f6dcf762ac@huawei.com/
> Reported-by: Chao Leng <lengchao@huawei.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
<...>

