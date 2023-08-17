Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CF2C2FC0E
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmocHHvNgZSEHajeJTwl4x/GbVKpBHV2b0XjC5ZX+Fc=; b=oFPgNDagvUcQdk4x+l871c3IgX
	1PuXpKvrAbKBWJkTS80G5guny59NkK9HOHACfEoQcCVXDblpiDONbqQMTeEjiZn9Vsrmsoq9MpzVj
	V9YYuL7XnDQcujpv2W1Xav32oChvKQLGiJRT3uukJPVLZrK5r2g/Q58C4G36NfC6NfN0BGQqA1kIZ
	x812ExQ0UWKnPF04ojeZLsn2HU6qGv+nelP//XNthMqsTXMQuWQfOmSCSrkxbmhl8luJVATHapHq3
	93FlGM0xcoN0MvvJH2kJ363oq2NdcJp45vosd897yD9+8ZEk3/vpj6vA8f8fIXvt58C8wnFb1tXxl
	i3HwyJug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYJY-005odx-31;
	Thu, 17 Aug 2023 08:25:08 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYJW-005ocK-1V
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:25:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D2191F891;
	Thu, 17 Aug 2023 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692260702; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmocHHvNgZSEHajeJTwl4x/GbVKpBHV2b0XjC5ZX+Fc=;
	b=AuCz21+t7b0SH96ljESLfRcjEvH/pmmF/vfamLPSMFsQhoJ8iP/7stTQcnloeDTEUhU59E
	KmnTSSBP70NB03NrePyda77ebDHVMeyhjBr6GDHbw36uHanIla2Gg+JiN9gWom6PCB0BrR
	B+smquGO2ZhnwyL6npMdP0hDkuzTwKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692260702;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TmocHHvNgZSEHajeJTwl4x/GbVKpBHV2b0XjC5ZX+Fc=;
	b=3L9sn6D6nNu1JLyt0G7q4pvJhAtyFKqehmo1xIOqeu6/NbO0tCzBx1omKFBk5D7Sdo8pa5
	AZZamwf2USjNq8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29F2E1392B;
	Thu, 17 Aug 2023 08:25:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6dK6CV7Z3WQ/VAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 17 Aug 2023 08:25:02 +0000
Date: Thu, 17 Aug 2023 10:25:12 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Message-ID: <5h333eqhtw252sjw6axjewlb5bbb5ze7awekczxe3kie2lnhw6@manyer42khct>
References: <20230811093614.28005-1-dwagner@suse.de>
 <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
 <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
 <ky6hb7se4hd5hgvwd7uwxm6pxgznxo5jp4fjr474qf3pepoipo@g2g2wtb2hvn3>
 <ly6ksjwuh5jzju6hsvos35b7rmj43gpdyjbp23s4qoi3ups5eh@zx2s3bkznujc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ly6ksjwuh5jzju6hsvos35b7rmj43gpdyjbp23s4qoi3ups5eh@zx2s3bkznujc>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_012506_643013_62FC021A 
X-CRM114-Status: GOOD (  13.77  )
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

On Thu, Aug 17, 2023 at 02:58:58AM +0000, Shinichiro Kawasaki wrote:
> On Aug 16, 2023 / 21:18, Shin'ichiro Kawasaki wrote:
> [...]
> > I think the 13th patch worth spending some more time, and other 12 patches
> > from 1 to 12 have consensus. If there is no other voice, I will apply the
> > patches from 1 to 12 tomorrow.
> 
> I've applied the patches from 1 to 12. Of note is that I added "export" to the
> new, three def_* variables in nvme/rc to avoid shellcheck warnings.

Thanks. This one of the reasons why I included patch #13, to use these
newly introduced def_* variables.

> Anyway, thank you for the clean up and fixes!

You're welcome!

