Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E40F5EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/EGH713J2ziKAzyOkNilfz8/zPpxaQhAAZH84cXzWBY=; b=JXbs/DyX/UM4/Kic9kjt5qPQAB
	B3rOOA3QqLgT6QWksoDkeE7IfBIzpywQHgLSksD1/g0dbYR4cRYmtXnQpkaHGEa4iiXMhXjVtP+1i
	RY/Sg1XekLEVHrmoK9Cl7L7mfYzPGm6n0S1k/Zg7PLYTiiXkZobu9dVfIhdz2qUQWUDwx8087sT0b
	i83Dbsuoi3qRK2+1fdRAsLYXf4S+7hDP8geVu7hg3GvkA/sgLYvibvXKVv7tok0ZH+gUUBdRrS9KP
	cgA/3DgYwuCC69tbTMlh08ZYJg3HYr1se2+kmMLwEk+ijB1ecXn3uU+GOspa1n6/YDuA/EFlCDVhR
	DNFguvRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYHL-005oLA-0Z;
	Thu, 17 Aug 2023 08:22:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYHI-005oKN-2G
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:22:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 37476210EF;
	Thu, 17 Aug 2023 08:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692260567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EGH713J2ziKAzyOkNilfz8/zPpxaQhAAZH84cXzWBY=;
	b=GQPbqN9EFWWPst1KJI7D0F/Yeit9yvIgs7hrfY5W47tsQMIGsiSXSegD8Zd2ErGDwZSKxB
	FYQh5CcGGt5tjOQ1QXR8/Jry4v8lrgLAYxmKzakrXoXp6gEMGP80VPGXdBvUvjD9FbDBqj
	MiyVMFQUYx2faFRNP+SP3Nuv3abj76o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692260567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/EGH713J2ziKAzyOkNilfz8/zPpxaQhAAZH84cXzWBY=;
	b=30M/TwPol8ZLihjY3EvQgBq3Jthr1rYi3i6qzFeR2RfZuRsXwUmGcDjRa2eOhbHgw7WnbI
	TEeUxL9ZuYlJf7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 253A91392B;
	Thu, 17 Aug 2023 08:22:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id h9AiCNfY3WQoUwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:22:47 +0000
Date: Thu, 17 Aug 2023 10:22:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v2 00/12] Switch to allowed_host
Message-ID: <wko3lfszmhyczqav7bks5cb2bsttfnq3uhjrqk44ayahtfozvs@s3ug7d7jnhor>
References: <20230810111317.25273-1-dwagner@suse.de>
 <xpoocad2nthor6naxp35h5qiz3oqxpijp5qds5qao6aguh6fp5@6fyygawm7kfq>
 <2u7xe3szftmoeicayxahqt6r44lgkwl6owvmlkjpby4mqvu6hh@pq2gfkgw6p6e>
 <glfjkah5e54ymq75lp46akttuqrsccigb445nchcpe4ahixzxk@5al3wjxify5d>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <glfjkah5e54ymq75lp46akttuqrsccigb445nchcpe4ahixzxk@5al3wjxify5d>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_012248_887998_1F06A8A2 
X-CRM114-Status: GOOD (  14.82  )
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

On Thu, Aug 17, 2023 at 02:55:25AM +0000, Shinichiro Kawasaki wrote:
> On Aug 11, 2023 / 09:00, Daniel Wagner wrote:
> [...]
> > BTW, what do you think about removing nvme/006 and nvme/007? They are
> > basically doing nothing anymore except setting up a target with either
> > device or file backing. We exercise this code now in all the other
> > tests. So this is bit redundant IMO.
> 
> I think the test cases are meaningful. They confirm that target set up feature
> is working good. When other test cases fail, we can refer nvme/006 and nvme/007
> results and see if the failure cause is in target set up or not.

Fair enough. If I want to cut execution time I can just exclude those
test from the run.

