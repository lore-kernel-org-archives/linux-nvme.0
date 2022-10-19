Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332B7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 06:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8nA8KP6KwplgUU4W81QvuhvHL4WNh+rmPGyDMOTrQ8=; b=vkp6oP6aM0FMJpZAou6azVsFse
	YNFqNISnTzvb2zN4x2VnbMBsmZx8zo6nEr6pQHJPVQekdtbdj45nJHdkJjT7GggINjwLSyrgrl42y
	RgYi+sKorpx1mT/XgdMPDHSfteUoINiuyObuQDpt8LzWVmOKNIu6SYJo1f+KDpOuDcszTQtTEsKyz
	FY0JOtD4YIr5NuJvvXmK+pKeNzQ3kfRZq8SejkuHsmxyQEb/3OWUMhguH34Yy4x8HsdzGeU5oe0yI
	gZbJDXOBKIkTDJ8E9EhMyWnkXNSI20qJ0TcwSJ2kFErW9zA8XBOnkC6USIO4V56zOS5viUajJvvuN
	ywMPKR/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol2nJ-00Fj4w-U5; Wed, 19 Oct 2022 06:43:13 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol2n3-00Fip8-W6
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 06:43:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 035B920226;
	Wed, 19 Oct 2022 06:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666161769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8nA8KP6KwplgUU4W81QvuhvHL4WNh+rmPGyDMOTrQ8=;
	b=KzvUqOc1OpxXmnAM1NJkzZBlHzvgL61W+U/B7+84hfQE7S5HW1TE3cXAwo1W64Pn89EIJr
	CWUcjWnHOzQbruDxQuU3QxMddFn/su75QVQI3WtCOAS7hxom/kpy3dpSte12o7KMkUygD4
	viH6I6Xmw9OCYaLDZCS6oV2QfWmxAN0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666161769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U8nA8KP6KwplgUU4W81QvuhvHL4WNh+rmPGyDMOTrQ8=;
	b=nI6yGe5k2KxqPevcddE4vIPJ9oo7SWQqtwgEIc8VfLKiS5scW1zKuv2VJWvbxiRc+VKU3V
	aNrQNlRXW+oQ/WBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8BC313345;
	Wed, 19 Oct 2022 06:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7ZTPOGicT2N6JwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 06:42:48 +0000
Date: Wed, 19 Oct 2022 08:42:48 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Frederick Knight <Frederick.Knight@netapp.com>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3] nvmet: force reconnect when number of queue changes
Message-ID: <20221019064248.e4hevscsushtu25m@carbon.lan>
References: <20221007072934.9536-1-dwagner@suse.de>
 <20221017173817.j7cjvxnvs2lcntea@carbon.lan>
 <Y07A8HxPj4cM7RVT@infradead.org>
 <Y07DIJf9BjHzPewa@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y07DIJf9BjHzPewa@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_234258_349210_02E8EE51 
X-CRM114-Status: GOOD (  18.79  )
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

On Tue, Oct 18, 2022 at 08:15:44AM -0700, Christoph Hellwig wrote:
> On Tue, Oct 18, 2022 at 08:06:24AM -0700, Christoph Hellwig wrote:
> > On Mon, Oct 17, 2022 at 07:38:17PM +0200, Daniel Wagner wrote:
> > > Hi Christoph,
> > > 
> > > Please consider to add the patch for the current rc phase as it fixes an
> > > invalid memory access and I would like to avoid that the code fuzzer
> > > army is going after us :)
> > 
> > I filed this under enhancement and planned to add it to 6.2.  Canyou
> > explain the invalid memory access a bit more?
> 
> I guess this would the minimal memory access fix?

Yes, this is the correct fix. Thanks!

