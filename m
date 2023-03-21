Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BC5C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JpJQIEbM7boV50nrhY6l6ljiNmsDyMuY7/tOQ4k3cco=; b=tzVF8xqEvqLLGg0/SenR3tfnMh
	sWR0sQY9hqJUnp121X3r6w6/V2GcI4se+X9CUs1cRjf2vgXVGQ0vNVzIWKc9b3LQd32VHvLYTxMl5
	xbphFeHx61EJ91RpmMZ3/H/N8hL0m1Yh6cR39uWoVW+ZPfbs7iEy8DUEn6KqGHT9XxniXL6byWRqd
	VSPXW66WSoB/5bGg62T/kghD3FS1PhKg404KmW06+i+OKmusDZBup+cWUNwfhXD4CDbEmpR2r+YT5
	g1VfLzaD8MjHuRSs3gwLpk9h5TLODF1L0Z5GY7iVZmvhB38jhbQBkBTIPvAajvQsgrfgn53gE8ikZ
	sW07SRzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peXza-00BqjO-12;
	Tue, 21 Mar 2023 09:09:18 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peXzX-00BqiQ-1Z
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 09:09:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C2C881FD6A;
	Tue, 21 Mar 2023 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679389753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpJQIEbM7boV50nrhY6l6ljiNmsDyMuY7/tOQ4k3cco=;
	b=qWFPqW89bFy1hlf08ApWUzg/fQlAs2C0qE3jC3OfaQE7ZpEFHog/x1nq7fDa0eN7sni0X/
	VXTX5zNplOIdrEQg1gHcH7vVlrY6cJy0aBxghS2GU5d5GxRjmc3UZ1YIQUmf/Ux1RB/Zz7
	J+LUPGtvshVCMg7LY6I3V5t157Fd37U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679389753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JpJQIEbM7boV50nrhY6l6ljiNmsDyMuY7/tOQ4k3cco=;
	b=8LcV3WcDY5kL1Yoetb3S0taP4M7T2WPfRppsvFlBWo/C0m2pqRV4f/qaAc3/Xf75ubfGw8
	2yCxlfCjLo9B/qDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1D6013451;
	Tue, 21 Mar 2023 09:09:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8vQPKzl0GWQ5bQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 09:09:13 +0000
Date: Tue, 21 Mar 2023 10:09:13 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <20230321090913.gwuvyuw76ha62hgb@carbon>
References: <SJ0PR19MB4544EF06560DC1D2B9D1BD09F2BF9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <ZBJFnEY664s1Hm/E@kbusch-mbp.dhcp.thefacebook.com>
 <32741f55-f5aa-cd59-351c-df87ee2b2818@grimberg.me>
 <ZBMz1FUB3qJGKXeW@kbusch-mbp.dhcp.thefacebook.com>
 <6232d774-bc94-fae8-bab9-7151fde4f719@grimberg.me>
 <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_020915_673846_2DCC73B8 
X-CRM114-Status: GOOD (  11.49  )
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

On Tue, Mar 21, 2023 at 10:56:21AM +0200, Sagi Grimberg wrote:
> 
> > > > Thoughts?
> > > 
> > > It still crashes in the same way with both patches from this
> > > disucssion applied.
> > 
> > annoted the __nvme_submit_sync_cmd:
> > 
> > 
> > [  210.019050] nvme nvme0: rq ffff8881122a0000 bio ffff88810d8cdd00
> > [  210.022653] nvme nvme0: rq ffff8881122a0200 bio 0000000000000000
> 
> Why is the admin queue created as a polling hctx?
> It shouldn't be.

Isn't this because we use NVME_QID_ANY as qid for the register access?

