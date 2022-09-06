Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E3EECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 08:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E8sxmFsMTC8da6/otIfVCeM9K3+G8GUZIXfiXdp/ZBw=; b=u/bbQXfdQcCMXhlzOtbnAaao4g
	iB2Bu9gYrQvL44iDLdVdbsa95E8g+VhoyPlb0LXB74lJrzvm/9wOoy0XBoIaz8E1PNJEtWYTAqprT
	ucYDvgCxov0fcORAzR736lyWhQVlR+UIovFDvODKeNIQv8UlX0rx1FRidFyXfQ604ZwNLb81S0rr7
	uQfR3PGw+EXrEPph4MtPYS9tuipnTIEPqjouCz1Hyjwhj4vAjAas+hDc9zwLfSSZStI4YyKF2Qn+q
	Xewfx/KP8YLaFFPW+yhAWp0SGVpkdVtCqVzU04RD6gqz1jmgYqTOdOikE8smns40U39p77uV3jv8a
	qUTZSxaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVTlo-00BB4f-2b; Tue, 06 Sep 2022 08:17:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVTlj-00BAzu-KF
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 08:17:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8239D33952;
	Tue,  6 Sep 2022 08:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1662452232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8sxmFsMTC8da6/otIfVCeM9K3+G8GUZIXfiXdp/ZBw=;
	b=opDlnYL8BQGiMV1mfwu3i6NciY0CQjsoEhm5tDJY/oIxnPafk3dXSS66m5axpa7YbK19uR
	eBVuGKqqvxTq5G7cGXHiXM8CFoT6CtuggtL5skVh9cH2XHyPbeBuduuelPGC7r6KkAA3PN
	BetM9t/7Et4ODbSWuRX5c3yqWdXfGkU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1662452232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E8sxmFsMTC8da6/otIfVCeM9K3+G8GUZIXfiXdp/ZBw=;
	b=1D6UHK2FO4kvJf/gsMK7KyvPh2mtpZfozw1wdp+mb59SHeELgRBSq9ozos099yHUiej41H
	C4Og5u7f7gjTaEBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74C6513A7A;
	Tue,  6 Sep 2022 08:17:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id KFpnHAgCF2ORSwAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 06 Sep 2022 08:17:12 +0000
Date: Tue, 6 Sep 2022 10:17:11 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
	kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [linux-nvme:nvme-6.1 9/10] drivers/nvme/host/rdma.c:989:50:
 error: use of undeclared identifier 'nctrl'
Message-ID: <20220906081711.dmkw66d2iqejkika@carbon.lan>
References: <202209060308.61PnxPmE-lkp@intel.com>
 <20220906063903.snht3lkixtdt2tkq@carbon.lan>
 <20220906065142.GB2190@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906065142.GB2190@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_011716_108078_3D62D65A 
X-CRM114-Status: GOOD (  13.14  )
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

On Tue, Sep 06, 2022 at 08:51:42AM +0200, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 08:39:03AM +0200, Daniel Wagner wrote:
> > Argh, my devel setup(*) obviously didn't compile the rdma bits. Do you
> > want me to send an fix on top of this or do you want a new version of
> > the patch?
> 
> I've fixed it already.

Thanks a lot. I'll fix my setup in the meantime.

