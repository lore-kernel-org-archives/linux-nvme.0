Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457BDEB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OG2008PZjL0H9Xg+EBwGxKiyxoGstQ6drRqgvSMoZ2U=; b=lbbYh3kJ0FKmtIfgJsLEVX4yl8
	lFgA2wXjLuQ9D/qzLRqNr4MiI7YaOPU9q502hi68mgP3QSw6sm6jEpC2zte/8mibydxa1BkityjQV
	UhRIDiRWliyH5BJgp4Vtn+Vmx0NhzB5CH19K47Uv5iko6gn4mvG72uDbguwzy93V0VhYBJ6jNn3mU
	ZAH3xlA1rMQ3fO7TxbZZWD5Mev0wSv/xwzA32BaK2/jcIQMjXM+GQEM+IWMngidINyDnTHbDGJv9z
	u32gBE9OUQBCVnIBxgcRYxjmEt4iQNbPOCuTrPE2XAWnHcE1xt/o1sk1ex9G7stwChtzoCpxsnbJF
	zwbT2+1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBfOK-00Bxsn-2x;
	Tue, 20 Jun 2023 17:43:44 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBfOH-00BxrE-0X
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 17:43:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A1D99218A8;
	Tue, 20 Jun 2023 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1687283015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OG2008PZjL0H9Xg+EBwGxKiyxoGstQ6drRqgvSMoZ2U=;
	b=kbcXvQY3RYkvHnWKVwTn/IOquzAhVGCwkxaHFRltVx4zdu2RSAoWrw2p+EZy11f/MGfN1r
	4eLvz6nq62gzJhTaj90TBCRqD64KBe2lz0G0sFyADOOZR5Mf3D+04GJD1n3uS9qHwnrUNv
	djkQPlcCOkPR51gY4VirFwy6/y4IgJU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687283015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OG2008PZjL0H9Xg+EBwGxKiyxoGstQ6drRqgvSMoZ2U=;
	b=u48D7GdjcIHgrGOBrltXSNJBzLd2ps3OZRfiXjdf1s5zps8A+KWCquFl5mRopZQ90pDxSq
	ZKMKjsI4r/h/5uDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 93D2F1346D;
	Tue, 20 Jun 2023 17:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id wQgWJEflkWTsMgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 20 Jun 2023 17:43:35 +0000
Date: Tue, 20 Jun 2023 19:43:35 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <vbbbnzcm6r4jzcc54crix7kjsg647w57te7t2weu7vhuwxg54n@u6cwcn62bfbd>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_104341_358488_A4D179BB 
X-CRM114-Status: GOOD (  17.53  )
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

On Tue, Jun 20, 2023 at 05:07:43PM +0300, Sagi Grimberg wrote:
> 
> > When the host has enabled the udev/systemd autoconnect services for the
> > fc transport it interacts with blktests and make tests break.
> > 
> > nvme-cli learned to ignore connects attemps when using the
> > --context command line option paired with a volatile configuration. Thus
> > we can mark all the resources created by blktests and avoid any
> > interaction with the systemd autoconnect scripts.
> 
> Hmm... is this hapenning with non-fc as well?

I haven't seen a problem for TCP or RDMA yet but in principle it should also
exists. I can do some tracing to see if we have also problem thern. Two of the
udev rule match on the subsystem and the event type.

> > +_nvme_cli_supports_context() {
> > +	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
> > +		    return 1
> > +	fi
> > +	return 0
> > +}
> 
> Not a great way to check support.

Yeah, agree, it's a bit dodgy. I'll try to figure out a different way. Any
suggestions?

