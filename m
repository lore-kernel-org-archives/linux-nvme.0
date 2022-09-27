Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417C4C07E9D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C00BGGLi20992guAqVkpnbbBtcj5BjctoWY72ZzN5QE=; b=jiiAN3UI5xIjp2AF2nOJGlVcNz
	95TsNallGyc5xvpMc0gYXjpE2xY9ViI71KpgEmf2Gg05UkDQP8Dmd5+mzgI4xkiBQsD84sFbwPamC
	l6Pbez5Spk2jEtoBb9Dcc7Q2vMK12uVcmbzYvXnWpDuLBS5HtrzYIt3e1AIEM48fDhGiVgIEYaWqB
	fiZNyCVhMgzwuGR8cjSc9ixc10zg26x9mre9Kvcbd7C/qKNXblJig+jPj3rXLk20S8d+odskRtgoq
	LZRSoD5tcqj6K/mR+bSGMuDK+5zh7nouAELCRyn0Tu06vF6EIh/CSgqnIwSs7olynHacDB0sGgOsU
	QBq19iyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Ey-00AN03-Tz; Tue, 27 Sep 2022 11:59:08 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od9Ew-00AMyu-9k
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 11:59:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2ECA621ACC;
	Tue, 27 Sep 2022 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1664279943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C00BGGLi20992guAqVkpnbbBtcj5BjctoWY72ZzN5QE=;
	b=qt2xbHXVvZ/80ZoLQglOZA0xzc6YZ9CpUI+Xg2a99hEwhBB7x1727BSyqBu3Zwr+gGC6Vx
	bRfD6TYLWwsjKRv2db1FvGLQy5KQ6OBh7DpNGmhCxhXDah+IbCAeKm1YneDgtG7k3igJtM
	vDTp2QHK7zfk9ctfQXSqBzO2AO0lCy4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1664279943;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C00BGGLi20992guAqVkpnbbBtcj5BjctoWY72ZzN5QE=;
	b=+G6bTQ2TCkC4OlQn/hyYw2XvPO1Dv0dq6OyNGsv25pQkXLwdxAHXVH6+0WgMMYAB29uDu4
	ouesSAJVcnh5AHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1F8F0139B3;
	Tue, 27 Sep 2022 11:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4Z9gB4flMmNSeQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 27 Sep 2022 11:59:03 +0000
Date: Tue, 27 Sep 2022 13:59:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: "Belanger, Martin" <Martin.Belanger@dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Message-ID: <20220927115902.ggbahkb7emrko4js@carbon.lan>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-4-sagi@grimberg.me>
 <20220927075213.6idrtq4sbiobtr3m@carbon.lan>
 <SJ0PR19MB45442FA5051872B841C308ABF2559@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <20220927112254.ajch75fqqmbx63no@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927112254.ajch75fqqmbx63no@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_045906_495494_2983D8B0 
X-CRM114-Status: GOOD (  13.01  )
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

On Tue, Sep 27, 2022 at 01:22:54PM +0200, Daniel Wagner wrote:
> On Tue, Sep 27, 2022 at 10:50:08AM +0000, Belanger, Martin wrote:
> > > I wonder to we need to it to append the --host_iface argument as well.
> > Yes, the --host-iface should be added for this case too. 
> 
> Okay, I'll add them.

Patch applied. Thanks!

