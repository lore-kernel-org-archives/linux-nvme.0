Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67537C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGMt2FRNdYpOusS1gfNi6ErFVZdiJJ9ApWR45JCvixw=; b=G4wIHK2OPlCqQ/CmyxAhw7ITPT
	NxCc0P8jy4t6Fj4jkP9WmUitWvaeF9Mj8rEsmrf+/If6vYamLpC2v09YpDsch5kQdNYGC1x/SPLNG
	xTiN8tNuvNLjBhke0FhT9McrmEoXkLNaMilAPiZ1c/x4NcsIcN8fbjcuoYErSKurePkHLSc/ZjjEC
	vM+5csDC8EGySXCJKJerde04iscuK0TfbKG6MswMB+7ULNWNaM6JPASONQ/eGjBBaQIkIiObLyb7c
	oZEvVWsdWPfb2q1eQAVoRKbU+TZBYx3zv2CyhhjDWpOHZoi2K8GciPtsWRp6sUsVgp2gCqGcyh5Sb
	pann7luA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbx2-008bMv-PB; Wed, 26 Oct 2022 08:39:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbwz-008bM5-Vv
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:39:51 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 294C51F8B3;
	Wed, 26 Oct 2022 08:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666773586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGMt2FRNdYpOusS1gfNi6ErFVZdiJJ9ApWR45JCvixw=;
	b=habCXnyHAW98YTALkUOTtShCHkoQjtZEu+vw8UhLF0Rd1HD4F/N9UGTFLn4dRUqpnAqHyB
	ICUz5pbpiAO6yHo1JaaJJ1yhmEUI83L+InobJRnzB/3MH7i8IrIPMuBEZGRaQPZQlSG0du
	Az34pmynWMk2P5K4Ed/3xX5ylvYfWiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666773586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nGMt2FRNdYpOusS1gfNi6ErFVZdiJJ9ApWR45JCvixw=;
	b=hrpeGjEIBbssGCvQsQxgkVCt7DaahPgpxogRyi0hzqWLXcCpzRbStFdtm5VBtkdV4yMUZK
	N8VHjPfcZ88bQJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1770413A77;
	Wed, 26 Oct 2022 08:39:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id tI+XBVLyWGMKRgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 26 Oct 2022 08:39:46 +0000
Date: Wed, 26 Oct 2022 10:39:45 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Message-ID: <20221026083945.dqkhgq4jcbeogngh@carbon.lan>
References: <20221024150334.29215-1-dwagner@suse.de>
 <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
 <fb22c7e1-3731-f997-1896-024745082ad7@suse.de>
 <9f40e42d-7525-5644-6773-19e3b842f7f1@grimberg.me>
 <20221026071340.ocqe74c6fvv52sdg@carbon.lan>
 <202cf139-c8d2-5a55-ed83-d975c136cab2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202cf139-c8d2-5a55-ed83-d975c136cab2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013950_187543_E1D04527 
X-CRM114-Status: GOOD (  12.18  )
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

On Wed, Oct 26, 2022 at 11:30:50AM +0300, Sagi Grimberg wrote:
> > Given this, I don't think we currently need to touch this code. Though
> > the unbounded loop makes me a bit uneasy.
> 
> This flow only enters when there is a single request queued, so it
> should not be something that takes long. Unless there is a real
> problem, lets not add code that may produce one.

Okay, make sense. I just wonder how to diagnose this scenario.

