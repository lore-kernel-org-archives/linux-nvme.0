Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22213C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 16:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zoHYAXedNmzxY6RzHk4qnscGk+4jL6cWdHiYt+HJWTE=; b=QkHEsvWaPk4qWFVWBkID8nU6yf
	PKFmdcezu2+ORykTWBUsEhxjApq7ZgIz/AdRZyLwtXV7p06ikUtlo6Z2EAR2W27QBMulASDFZVUin
	1fSVA1JQz0HkZqKnGLSITNTF/GSRLAJLcVgrnr+n3Xg8ODsfBdUur0FVKJYYhoupu6Q7/VIENs2U5
	PWSqZGDs4WFNM5ON7OEA3oKrMHvumHRGFTuMSgmWxjysNKVUWBJB3+dySOeiVzphYoAMtCisvDlGq
	8ufAT2N7dWDPfMXl5LBortkoYkGPKl43yt+j8MTRhyTDr/gO8RMapj4L6w04m/HD9euvrt/DGx2aE
	JrHyn0Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olBhG-003nzO-Fd; Wed, 19 Oct 2022 16:13:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1olBVx-003diK-0w
	for linux-nvme@lists.infradead.org; Wed, 19 Oct 2022 16:01:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AF8822681;
	Wed, 19 Oct 2022 16:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666195308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHYAXedNmzxY6RzHk4qnscGk+4jL6cWdHiYt+HJWTE=;
	b=Jg5FKrAMZGpQJRM0EzIAwY1O0579B4jk6zLHkZKouyGC57RCTFoxbw83ZotfKYOUT28JG2
	u2GogqL93hxOFovYB8Tg3nV6ijBytpNtQ4s6vBHvalhOxCBticP3OOjyA0CRTa/Zi/sKVG
	B9O04vc2zU6TBvBt0zUfaBxFP1c2guc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666195308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zoHYAXedNmzxY6RzHk4qnscGk+4jL6cWdHiYt+HJWTE=;
	b=oGHJmLnw8N/j6OhIcku692DZvtKZFEgADh+GstBE7uUDbd2qtClQT298qSMgsC0ZTgqT+U
	gmT5pp5yNBsY0BCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6AD7C13345;
	Wed, 19 Oct 2022 16:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BMLrGWwfUGOaYQAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 19 Oct 2022 16:01:48 +0000
Date: Wed, 19 Oct 2022 18:01:47 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: Re: lockdep warning: fs_reclaim_acquire vs tcp_sendpage
Message-ID: <20221019160147.ij3nc44n5ppmzifp@carbon.suse.asia>
References: <20221019075138.ff2sfahovionh72v@carbon.lan>
 <c30b24b9-e80f-9e8a-5754-caa7dc7bfe8b@grimberg.me>
 <20221019093712.2d2g36wcwwcl7zat@carbon.lan>
 <20221019113517.wv27jqp7lyskfbqb@carbon.lan>
 <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96978c5e-369b-a010-f9b5-6b4675836e47@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221019_090153_392302_CA19BD20 
X-CRM114-Status: GOOD (  10.94  )
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

On Wed, Oct 19, 2022 at 04:09:39PM +0300, Sagi Grimberg wrote:
> > Still able to trigger though I figured out how I am able to
> > reproduce it:
> > 
> >   VM 4M memory, 8 vCPUs
> 
> thats small...

Just a test VM. But I think this is actually the key to reproduce the
lockdep splat. The fio command is eating up a lot of ram (I guess any
other memory hog would do the job as well) and forces the mm subsystem
to use the swap.

> What is vm.min_free_kbytes (via sysctl)?

vm.min_free_kbytes = 67584

