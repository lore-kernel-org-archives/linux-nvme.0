Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 847A4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 07:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejEbZFGKGnj4GAk3zDdvFJP0ZJ5Ly348xD0Adi7r1Ew=; b=MY63hRFU/qQqLqbF6YUeRoFXg5
	3vAIt22F90bezGKwbdBTw2VfTCdebzEvzfAZwQtSeBGVIH+XxqtksRqAxcvqSAgx9f1SAkNHKSiIz
	/avV0by7Frwp3OdbFeFNZqBAj5Y5Q0VK3R0XO0udgWFjiZIH4Ro6788vPOA5KbFdPL1OvFSHHLnMJ
	QdwIoxcRN0Hn2T4ueRDK+UpjkKAOj+ng+27/3oGAm2RhPBMte6hBNSV5X/8n6QkT/kzPlJLsxhblA
	gZrow24jK2NYp+HGvCwXzfOH390ZHWjuUCH7aqaJGSYPaQWhtPV8cs2ifTHYIXbZwBkDEv2Zp7YgX
	aJ5Uzg7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntlus-00AFnp-EN; Wed, 25 May 2022 07:58:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntluq-00AFnC-IS
 for linux-nvme@lists.infradead.org; Wed, 25 May 2022 07:58:49 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A7BA219E8;
 Wed, 25 May 2022 07:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1653465525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejEbZFGKGnj4GAk3zDdvFJP0ZJ5Ly348xD0Adi7r1Ew=;
 b=aBSH+ri1g0d9VgKsOob0kq2w/zX5sFfaUeBLLwmxszjll3XKiZUyOkTwL60uvhlrozhde5
 aJtl98h16yFoS/b0zsdk230N6SCoF9rxUmmngyuwEyiPCFclwLfgEoHkNeue3Oqyz0G2uv
 GyyMcKk/LH+XUhquCr7508cNPxtUgS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1653465525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejEbZFGKGnj4GAk3zDdvFJP0ZJ5Ly348xD0Adi7r1Ew=;
 b=umTVvSo+zvyAcVdoui/wmhexOt3ssOJ4eRs8zZ04zEqVckxtEn7Ry1AxjNi5mJtNRjesS7
 z55Yn1fSighSa1CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BB4A13ADF;
 Wed, 25 May 2022 07:58:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xKTjBbXhjWIhJgAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 25 May 2022 07:58:45 +0000
Date: Wed, 25 May 2022 09:58:44 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org, Martin.Belanger@dell.com
Subject: Re: [PATCH] nvme-tcp: handle failing req immediately for
 REQ_FAILFAST_DRIVER
Message-ID: <20220525075844.7qk5wn3vbiltadhw@carbon.lan>
References: <20220407092540.66227-1-dwagner@suse.de>
 <eef5eda6-f00f-b879-858f-80f7ce44a362@grimberg.me>
 <20220407122054.reywmgnysnhryvg2@carbon.lan>
 <129b9f99-fd4d-1920-dee8-652e774a3b57@grimberg.me>
 <20220407133806.xawe6y5v5uec4vzi@carbon.lan>
 <48363e60-d506-b1bf-cb3a-db781290f285@grimberg.me>
 <20220407135353.uupdcx2jbk37qtpx@carbon.lan>
 <20220407150155.sryxcqrv25wt3irp@carbon.lan>
 <adb47490-e13a-1c18-c6fb-23a233471796@grimberg.me>
 <20220411112217.vihnysakkzawmrvo@carbon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411112217.vihnysakkzawmrvo@carbon.lan>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_005848_796936_027F7443 
X-CRM114-Status: GOOD (  20.06  )
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

Hi Sagi,

On Mon, Apr 11, 2022 at 01:22:18PM +0200, Daniel Wagner wrote:
> On Mon, Apr 11, 2022 at 12:58:09PM +0300, Sagi Grimberg wrote:
> > > > I see there is a shutdown_timeout which is 5 seconds on default. Seems
> > > > not to trigger though.
> > > 
> > > Obviously, the shutdown_timeout is not connected to the register
> > > writes. So we would need something like:
> > 
> > Looking at this, its probably not what we want...
> 
> I agree. We just have to make sure that we fail these register
> read/writes on transport layer and don't requeue them.
> 
> > I've inspected the code and I don't think that we should check
> > the return code at all, we should simply fail the request. If
> > the io_work context is running in parallel with the the error
> > recovery handler we have a bug that we need to fix.
> > 
> > How about this?
> 
> Yes this would work fine for my case.

Do you want me to post this patch or are you going to post it?

Thanks,
Daniel

