Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E26EE49A0
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Aug 2023 05:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BVsEL6nmxsm5sImPuZh6istdB2g6qSwClPclyJUG2CE=; b=uUoxsC60zsV5vJAvsNdnWeeCF8
	3o1q/czX+88OHjrsZWGxr9yz+g/7n16B035pV8u9Mkv3ksWL+rGdI4L2B0Rhtsk7HEg/aJRCIV83P
	OJuNRGORvcLUVAzTl9/SsDoaiSfVlOwSYma2sHwTMSL0IjEF9x8IRKZXWk8JPDRm45iWtfmNvPpp0
	Sw2FJEdia8CMUHNuNW4UVSCH8QqOH+9CcR0mDK4evBVy0K0M5+aqqrTgL4/3Ex8fN/vDHhIfID2jV
	se12KvrFcwr35/jOgWw9AvzVIsGg82ZDF1vZ3mxXFBe0MY7vb7crQUz8b8BYkJgjh6xmCnk1Hnywf
	+8k2/UwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXxua-00DD2A-2p;
	Mon, 21 Aug 2023 05:57:12 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXxuY-00DD0y-08
	for linux-nvme@lists.infradead.org;
	Mon, 21 Aug 2023 05:57:11 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28E8A22806;
	Mon, 21 Aug 2023 05:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692597427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BVsEL6nmxsm5sImPuZh6istdB2g6qSwClPclyJUG2CE=;
	b=x9vPvOQFSnEMOFkX/D7staROVPNyqnojEUH3p4rgPpMzhfWnB7MZAEGtPgb3u7YEXjAESA
	F9niEuxS1KsUBzNBj+Y/J3mFlE1nCuqozw0zEP0e226GulLXLGU7oG4Z8aPbFfZG4ANVDz
	NmFL38tuWDROC5nSy4N36RiVhTw1i6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692597427;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BVsEL6nmxsm5sImPuZh6istdB2g6qSwClPclyJUG2CE=;
	b=cmZ/5/j4KKOkdBSdxlQac4oKT/KvczSUpJZZmi3xRJY8t9Srj0dAsyh5TkaRRoexRis46A
	aKedYmidDpbyTsBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F9C813421;
	Mon, 21 Aug 2023 05:57:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MCDJA7P84mRrdAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 21 Aug 2023 05:57:07 +0000
Date: Mon, 21 Aug 2023 07:57:20 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Hannes Reinecke <hare@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH blktests v2 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <u2esnihohobu5jaxgz3xdfpjfvfrnmkklzajjrckdnr6g3i54b@qofopy4bhhlp>
References: <20230818141537.22332-1-dwagner@suse.de>
 <20230818141537.22332-4-dwagner@suse.de>
 <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_225710_247217_24FEC7EF 
X-CRM114-Status: GOOD (  12.41  )
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

On Sun, Aug 20, 2023 at 05:58:34PM +0300, Sagi Grimberg wrote:
> > diff --git a/tests/nvme/003 b/tests/nvme/003
> > index 71b82ce758a3..eed1f549866a 100755
> > --- a/tests/nvme/003
> > +++ b/tests/nvme/003
> > @@ -22,15 +22,8 @@ test() {
> >   	_setup_nvmet
> > -	local loop_dev
> > -	local port
> > -	port="$(_create_nvmet_port "${nvme_trtype}")"
> > -
> > -	loop_dev="$(losetup -f)"
> > -
> > -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> > -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> > +	_nvmet_target_setup --blkdev=device
> 
> --blkdev=device by default no?

Yes. I thought it is better to be explicit in the tests. I don't mind
dropping --blkdev=device if you think we should use the defaults.

