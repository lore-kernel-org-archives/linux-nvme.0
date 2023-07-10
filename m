Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE5EEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dOPQVlVl/8vQ//n15Tk8y4R1eYRMJsmZsPzlZqEUlNs=; b=0cvMYzq+8V/8qZabvqFTKdj2JB
	DGDp4WOQu403YmAGLj5/9KEAfTwCkd6e+2islgdvrIE7iQtxI82CK9uQZTcrwVgt6UjXyaXHusqBL
	89szewpMGAsJ7P8LLHQmnWNd2DDcQD7+e/B6sb0akNjnvXvagY3x46CPyJVKIvbPKie7T4Xev8e3W
	dBuDX1+DqhhJw5m7iDtWLCFWlPy1uSdB2ODKtsC8/uocX9BglPtMCRj/nTGe154O5aJ7Wz7XZiwjO
	jdUgJzdgEbPB3bfxaQHcO6BvcNXh9U0IOL4R3k1xoUwA9g9f0PypXKqaoeSf1/Aov4cHZVXeYeeph
	KfCeIqlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qInzX-00BCdE-23;
	Mon, 10 Jul 2023 10:19:39 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qInzU-00BCci-37
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 10:19:38 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 547AF1FE4C;
	Mon, 10 Jul 2023 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1688984373; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOPQVlVl/8vQ//n15Tk8y4R1eYRMJsmZsPzlZqEUlNs=;
	b=Wp0QUbNf5XaNlRPlG0FB9Zz/3WpMnrs1+b8iNdyU95ruQBihKhwUs2PLtYeSAZOtTSK+PQ
	dF+kV5V87URc5OHxolj0z8nmgFGS2N/rPU+kqKb5kyMytUAObxYKCW3ywRqsRUMpqFqbjc
	E2Otgn39N453HG4U7uXxooZrh2mXB6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1688984373;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dOPQVlVl/8vQ//n15Tk8y4R1eYRMJsmZsPzlZqEUlNs=;
	b=M1y7Pko3BRJD16IVNvY+R0b+D274u+SqFXOje3G1Pjo7N8uHPwvWSI9RgeXKoNNg74OR1j
	UIidc8Nvqy7uN/Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4269513A05;
	Mon, 10 Jul 2023 10:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Hac1EDXbq2SPPwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 10 Jul 2023 10:19:33 +0000
Date: Mon, 10 Jul 2023 12:19:32 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Message-ID: <jdsoqllqmrqu5j5bt3fudkksmjskgs4ooodynm6yh3b4oc5scn@t3hydrmbb22f>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
 <9c07e4f6-2cf5-b53b-6b48-bd4df8798ee9@nvidia.com>
 <bz2s6nyjwl6l7yfrd4wtjdtousv23ypcdleckibps5lyjpwi4x@wqq6qqesevpk>
 <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39f9977e-b34c-f2dd-d356-8c78414a60d1@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_031937_168955_E6B40965 
X-CRM114-Status: GOOD (  15.07  )
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

On Mon, Jul 10, 2023 at 12:53:17PM +0300, Max Gurtovoy wrote:
 > > Agree on setting the hard coded values for hostnqn and hostid instead of
> > > reading the /etc/nvme/* files. This should do the work IMO, isn't it ?
> > 
> > Do you mean that nvme-cli will ignore the udev trigger when a different hostnqn
> > is invovled? At least for the well-known discover controller the hostqnq
> > doesn't work. Though not sure if I understood you correctly here.
> 
> All I was saying is that your issue would have been fixed easily by 2-3 LOC
> by removing the usage of /etc/nvme/* files that are usually configured by
> system administrator and use a default values for blktests hostnqn and
> hostid.

Okay.

> The usage of --context in blktests is redundant IMO.

Right, I made a bit of a mess with the commit message. Sorry about that.

