Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3CEECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 09:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNnXs2A3MvLukEVHhQUTxvuhJ4DfChZopwJYNrPskBg=; b=D71f3pMqXlKc9DOdjVft3FmbG3
	woWk+5nPr6CFdzXo502JXRF80kdJVq2SwZKlEK+Wdns+ISPJyFzv8BWIrR3h7htgcLr32rHMi0z1q
	hEiauwGjSb4deLQz6oAUHbC22iAJfVx4/V03QJxDMmIKcnUVB8yOqU1GY30GhuwMbeooPCMOYldbi
	HnGRd8fiQGZGc0SYeuqd8upkV9QVlOwlmYzUCbhkbndw+klZkteRva7C61iKsLISEwqgg3fz5PIYN
	RxekhwOXo5f2arjw6UgVfyEWAKt0xdwzhFi4SET8JMG2IB8QDDuS/RGKkGxG4v4u1Ag2M+0/JIkOD
	NN8u7hwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSau6-006dr3-E5; Mon, 29 Aug 2022 09:17:58 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSau3-006dme-54
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 09:17:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30C4233698;
	Mon, 29 Aug 2022 09:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1661764673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNnXs2A3MvLukEVHhQUTxvuhJ4DfChZopwJYNrPskBg=;
	b=pYnVX/QNUl8bsunt0svzOJyxYyUDWu+as9lQUoLCqyNMmKflnlGd9tvPuMqO0JZ1IfpaTV
	zUz4Zw7HcwjQrraOXtQHa53bwUR8UukK8ZV0i/OnORxhMHyv1QQzAN5rjk5DpDDt7OJgPk
	R68+S2JbPqxPL+GZYX/elomS++YP6QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1661764673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SNnXs2A3MvLukEVHhQUTxvuhJ4DfChZopwJYNrPskBg=;
	b=2BXocKDz7aFBqpsqu2aHSUWtjTOXjEP311VrpMBWyMZlWqczSpBc+c/fgJB5uXfEOF93Ce
	daKz+yNu1R6dQMBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 228B7139C4;
	Mon, 29 Aug 2022 09:17:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qky7B0GEDGNOJQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 29 Aug 2022 09:17:53 +0000
Date: Mon, 29 Aug 2022 11:17:52 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
	Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v3 0/3] Handle number of queue changes
Message-ID: <20220829091752.keztco4tonustfj4@carbon.lan>
References: <20220829083856.1850-1-dwagner@suse.de>
 <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8ee0fd3-45c2-7848-aa5a-6627c7672349@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_021755_375970_A11E7BF8 
X-CRM114-Status: UNSURE (   8.51  )
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

On Mon, Aug 29, 2022 at 11:07:00AM +0200, Hannes Reinecke wrote:
> One does wonder: what about FC?
> Does it suffer from the same problems?

No idea, I'll look into it.

