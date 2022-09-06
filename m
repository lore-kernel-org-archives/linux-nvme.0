Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA1AECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 06:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mq96mh0X1mkrRZ8hx6qwVVNZzLjA5B6LWMrAZRWCMpo=; b=oCoeotWncwFwjrVrIksiZb5eZO
	TPFqq17SJdwEv1hEjcLrp0iAu9NHX7SLWaPZIAHFMrmD+FF8zuKigAcT6Sx3uiZYQ6dYcY1UY9F9v
	kWO5ODDYMa5yHh9eR0b0z4aZM3A6ugmODkk85uri0hOhKbTLzkP38p43VBlu9eehvabDlMboUL1yo
	V/iFZyiAiPPHlLuRASnn6/L3nyVSU7/F1dzKh4dfo5P3gSS4hanfulDZW0nvFQjEynePePB+2Eaqi
	K0XZn+VXbm7dArmo8VR9DoAu8LByMYjm/Ojc71yXInpFfoVZOG3uZ+Zjjpdx9wXv0sEs1DhDRqxou
	h3BKEZPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSEq-00AU3i-25; Tue, 06 Sep 2022 06:39:12 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVSEm-00ATyT-2t
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 06:39:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BAD363375A;
	Tue,  6 Sep 2022 06:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662446343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mq96mh0X1mkrRZ8hx6qwVVNZzLjA5B6LWMrAZRWCMpo=;
	b=c1/6Xn3KlYNBmt3jltoyjpaflfyI6okF1vofqmYUvfo0AQF/8iEt7InIcneqLwlSLSL+tk
	ZM9CFz9Fcj8eri+mSFNn7e28HTEX6ZhhPcD8WOuAQmG0QVnsHWz8xviGkBEPWyCa/IPmqo
	5MgJc4pUc+G7/q6Y6y60BlXfo7JT8c0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662446343;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mq96mh0X1mkrRZ8hx6qwVVNZzLjA5B6LWMrAZRWCMpo=;
	b=Su4XGXofyKuUBLBNC9plW/WnBM1FGPVmaLH5AIUO3yvFT4POoysUQs13w7stQx/q96Cttm
	S3TPVDsr17SFzRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA63213A19;
	Tue,  6 Sep 2022 06:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 5XBvKQfrFmM5JAAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 06 Sep 2022 06:39:03 +0000
Date: Tue, 6 Sep 2022 08:39:03 +0200
From: Daniel Wagner <dwagner@suse.de>
To: kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [linux-nvme:nvme-6.1 9/10] drivers/nvme/host/rdma.c:989:50:
 error: use of undeclared identifier 'nctrl'
Message-ID: <20220906063903.snht3lkixtdt2tkq@carbon.lan>
References: <202209060308.61PnxPmE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209060308.61PnxPmE-lkp@intel.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_233908_322985_3D8F31AB 
X-CRM114-Status: GOOD (  14.15  )
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

On Tue, Sep 06, 2022 at 03:05:51AM +0800, kernel test robot wrote:
> tree:   git://git.infradead.org/nvme.git nvme-6.1
> head:   9951e3d984c9bf324bb7d486f42ec82727e3d777
> commit: 1de8b481a31490d6b0217ac78b87f54bc9bfb65a [9/10] nvme-rdma: Handle number of queue changes
> config: i386-randconfig-a015-20220905
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git remote add linux-nvme git://git.infradead.org/nvme.git
>         git fetch --no-tags linux-nvme nvme-6.1
>         git checkout 1de8b481a31490d6b0217ac78b87f54bc9bfb65a
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/nvme/host/rdma.c:989:50: error: use of undeclared identifier 'nctrl'
>            nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, nctrl->queue_count);

Argh, my devel setup(*) obviously didn't compile the rdma bits. Do you
want me to send an fix on top of this or do you want a new version of
the patch?

(*) my main devel machine was out and I had to re-setup it and forgot
to update the config file accordingly.

