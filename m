Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99227C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 10:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hBTOg25IsPxj0qWqx13dMLrckoNY7imS5h0ZNya05Po=; b=R7G6N+ax8JWRfXmiMcrZCh3cZp
	UO3yRjjNtKlIJUNtb8QOsvGQerSABUId8DDZNwyStLoO4xQ/w6X6QDXGjby7TvVwWe4fXZlLYfv4L
	qy8DLHvpt3Z/4mZIvEUQID6Oy3OoSsuUka/+Y6wT5ImiEc354kB2d2PsWiqFng1jTAt9vVZ/pvsjN
	kcNYU1MBkCDOgR4RB0OvjNgu6xmgaSqlkDosZJpnAxFrUnVpUGRmqdTjxgXV09Ll+XK7G8AHBa/yG
	8BlYxpcyKw1JB9GlIqJmgnAJ556nS71+DEoSmUa9wuQxLpkwLYh8ml9yjBtgB6NTg9JrLTnjhgJN6
	/gMQKBRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pp5BJ-00519z-1a;
	Wed, 19 Apr 2023 10:36:57 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pp5BG-00514I-1i
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 10:36:55 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6054D21987;
	Wed, 19 Apr 2023 10:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681900608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBTOg25IsPxj0qWqx13dMLrckoNY7imS5h0ZNya05Po=;
	b=MWDz91LRmEubYBZAiah6DeyOVOVtq8pKh2mzdW6z+gbPWzUtDnVK/VTHX0zWf1eAPkdFcR
	LbPBlHy9cBSR6pP18I7GyNKBjNj8blCHka4YGQMBjKADUm29R8yAUX7/lEyyXfj/7bkqqA
	Q+NMjYIoLXVGoNGIa0cXe0KX8jXEx2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681900608;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBTOg25IsPxj0qWqx13dMLrckoNY7imS5h0ZNya05Po=;
	b=IWiD+xzT5spCLdsQiQZE3mF6+D+NtBLOyoRVZjUbMy6J9Bsdd+AUlrx4edsrExAKbhUYRB
	OHyguUy4mLe/9NCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 527D81390E;
	Wed, 19 Apr 2023 10:36:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xOoPFEDEP2S3MgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Apr 2023 10:36:48 +0000
Date: Wed, 19 Apr 2023 12:36:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH blktests v2 2/2] nvme-rc: Cleanup fc resource before
 module unloading
Message-ID: <xwkb2nrwcc2ysgynznx6txhfjn73xy24qg5jvnye6r7k6jlw77@wwmiqgy6mooc>
References: <20230419084757.24846-1-dwagner@suse.de>
 <20230419084757.24846-3-dwagner@suse.de>
 <dd3850e3-045f-75a0-4980-9f44a05fd397@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd3850e3-045f-75a0-4980-9f44a05fd397@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_033654_723205_89D63A63 
X-CRM114-Status: UNSURE (   8.40  )
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

On Wed, Apr 19, 2023 at 09:41:28AM +0000, Chaitanya Kulkarni wrote:
> were you able to test this with RDMA ?

Yes, I've tested it with all transports (loop, tcp, rdma, fc)

> just want to make sure we are not breaking anything since we are changing
> the order of module unload and stop_soft_rdma() in this patch ...

Sure thing

