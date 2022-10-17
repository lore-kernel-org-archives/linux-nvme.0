Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF2CC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 17:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xYhgbc1VGoEpaUqgDbmbEHHvoLPOYPAEsYOPrfR1zzY=; b=YNYKOyTsE5WTHYD+do7WukeUg+
	p84hiE7mAmXW8ZhnBB9jjQVh3lBf94WVRN47c+9thoUyC9R3czZLtuoyFDeXgGIRk9qT8S2z3zSIm
	j6QO67XDw/mBT3iWhzNLIV1YaXRDft1Q8vpn4Ppc0VUO7eQKwJHgt3QJgC5gXzbRD0duZ2nH2ip2N
	DFX6X/+eL4t3oc7La/TRI9LPpWrq+TABaTJ3xES3POI5Rv7RI0CKzVvKCefpMQrcZx1GsOZIh7eV4
	riJi973smLLjqJFzf3hfw3CMeJP0BoEK4DLifAAgCfJU0jaCG0/E79NTQYnwl4SwNYtu0NR8setEC
	vqQdQ0JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okU4H-00E3Dw-70; Mon, 17 Oct 2022 17:38:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okU4F-00E3C8-HH
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 17:38:24 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E55BA338FB;
	Mon, 17 Oct 2022 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666028297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYhgbc1VGoEpaUqgDbmbEHHvoLPOYPAEsYOPrfR1zzY=;
	b=wVLpOVCst6cCJwAl5eYOvvoEU/VR74Ojlya4azodyrsJWAaaxNr1Do5vgwGGqZO+jpnLUP
	xoOD+vYgxRojSP3Vv5AhIvahekFFpFuJPt0hW8HqEsje8i+FMXJDiHHAWepnd69jrjREuA
	nw5VMazth4Rc7ynDbrn9g1C1EOhNO7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666028297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xYhgbc1VGoEpaUqgDbmbEHHvoLPOYPAEsYOPrfR1zzY=;
	b=Yln7ytq/lIHelSmVfdZNANKbDGLSe8+/KMT2e5RhllCZuiXuLpGygykGJme+LvDGWtPtk5
	eJyz0SlQ+pLYj2AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D68C713ABE;
	Mon, 17 Oct 2022 17:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vjZeNAmTTWN0ZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 17 Oct 2022 17:38:17 +0000
Date: Mon, 17 Oct 2022 19:38:17 +0200
From: Daniel Wagner <dwagner@suse.de>
To: hch@infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Frederick Knight <Frederick.Knight@netapp.com>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: force reconnect when number of queue changes
Message-ID: <20221017173817.j7cjvxnvs2lcntea@carbon.lan>
References: <20221007072934.9536-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007072934.9536-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_103823_764228_1DCB5FD1 
X-CRM114-Status: UNSURE (   7.61  )
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

Hi Christoph,

Please consider to add the patch for the current rc phase as it fixes an
invalid memory access and I would like to avoid that the code fuzzer
army is going after us :)

Thanks,
Daniel

