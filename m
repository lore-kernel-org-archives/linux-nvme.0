Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D4EC6FD1D
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 07:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nJtx41FyGgHM+6hjAK3L/TO3nY7Ve91/FoYf6szNSI=; b=LyhaXG9BlhiR3jtnewRlM6CaRd
	4hKmGuWMSSQbRiy9wyZT7+A5GKC7sX7uatG67nNjE2o8PwIKxlYafZC21CJcTWLcFoABJsXeU37sh
	h/xGohTyRdRMmX6knfCjj6aUV6OeiF07Lccdr8GE8N5BvEcTGib7E9PNk0ma/sPYKWAsIzedx7Pqc
	J9M6pY6Wzb82Y+6eUddODwRAUEaaerlgqpP+kIWeVJnXEWQn86PqjJb8kFd1GkHql/CVlUGxwqOYp
	aPnJnIsxlUV1N9u5oDhIDatyihRbYRiJsjX1/C4QqAtNxHhDy7BOSmSBpQE4ifvvRfMhJyMNc7psU
	7DsTWeIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peWIU-00BVql-1k;
	Tue, 21 Mar 2023 07:20:42 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peWIQ-00BVpz-30
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 07:20:40 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 307631FD6A;
	Tue, 21 Mar 2023 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679383235; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nJtx41FyGgHM+6hjAK3L/TO3nY7Ve91/FoYf6szNSI=;
	b=nzu2p3ULsnyuKU73YvIEGpuiTpoWxowigVNFgFMnHlnefNd4SIqftdSVxDDwUH57FWDBtP
	jr+C4WiDlMVdKwoMYCNPHQbmoxUWjUQdiHt8JRkqUdR4exv/ALRJqfQtT1VT/NDg0uoG4H
	ysGWfAbduWzEtZd8TRThLFaqSDM3d0U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679383235;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2nJtx41FyGgHM+6hjAK3L/TO3nY7Ve91/FoYf6szNSI=;
	b=qkHRGLXoYGx0K/vw41pwFexIBe1rGH+dIEj+ShevKXzpkNYY/loEQkOdAsJQUs5V7Q3ajL
	zkmVQhHZQ6FFnyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16F5113451;
	Tue, 21 Mar 2023 07:20:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id vPCQBcNaGWRuewAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 21 Mar 2023 07:20:35 +0000
Date: Tue, 21 Mar 2023 08:20:34 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Martin Belanger <Martin.Belanger@dell.com>
Subject: Re: [PATCH v1 1/2] nvme/rc: Parse optional arguments in
 _nvme_connect_subsys()
Message-ID: <20230321072034.drd6nhkpop72yqac@carbon>
References: <20230320152204.g27a6jqbb65xmb6r@carbon.lan>
 <20230320173806.12784-1-dwagner@suse.de>
 <20230320173806.12784-2-dwagner@suse.de>
 <a46e4e5a-69e2-509c-2c20-7ea01bf94f50@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a46e4e5a-69e2-509c-2c20-7ea01bf94f50@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_002039_113374_BA39A908 
X-CRM114-Status: GOOD (  10.66  )
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

On Tue, Mar 21, 2023 at 05:16:25AM +0000, Chaitanya Kulkarni wrote:
> > +	set -- "${positional_args[@]}"
> > +
> >   	local trtype="$1"
> >   	local subsysnqn="$2"
> >   	local traddr="${3:-$def_traddr}"
> 
> can we please have all variable declarations at the start of the
> function then add the actual code instead of adding in between
> different variable declarations ??

Sure, though the assigment can't be at the beginning, we need to
go through the parser step first.

