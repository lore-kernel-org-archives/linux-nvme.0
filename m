Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAB6C54EED
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jan 2023 09:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TlIov0jXlmgYydIE80yw8Gg3LBOYwxYfEsZcw7ez+1Q=; b=1ZYroxtgWSMz9t86ekZMpN94Iv
	ZYCed7XMo/qcXLbgaJsFoMdTupjOPD9Ugwt0dyfjHrbUl48jKU8itqkJEu988dugSGLuDaFOhiaRp
	v4/SljgQX2G0XPOEui6snTsM8gHR57WNvs98UCH3DveRAhPvzyg+53bjR8oPurqzAasIGCktoZ1Wb
	TbV8ryfY32F0oBBULz9c2AMCsFG8HiSotFUGEpQCyBIji4LuTqsjaJAZPIWAMJSZYAtb+z+jiLv9D
	DMCaAT/QTmbncjTZhqoOf5v45rQS2gg5yZxYrhFs8EvWGzMvmWmStoep9t23swxKZLlP+tyumSB0b
	5j4RdZow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQlF-002xpG-5m; Mon, 30 Jan 2023 09:47:37 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMQlC-002xnl-7K
	for linux-nvme@lists.infradead.org; Mon, 30 Jan 2023 09:47:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD4AD1FE0D;
	Mon, 30 Jan 2023 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675072047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlIov0jXlmgYydIE80yw8Gg3LBOYwxYfEsZcw7ez+1Q=;
	b=KTro/ULo+18blSgVtBnRnI7tQyoKJF1IZzy61BKb/1KyRWrhTAXGRQkDoR1fl/8KnswBuL
	4Tm6ZRcby2QCIMTclxD/jpqA558wXtXoYaPV1gmfvUa+qbJLHvWzdxetv04Pusz3iP2d7J
	O1g5V70qRqTu9s5ewJF4rJvl5f5MMiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675072047;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlIov0jXlmgYydIE80yw8Gg3LBOYwxYfEsZcw7ez+1Q=;
	b=iT0bvM/vGOkrYOajS+9lCHOljX80jY7wSWjBy04lzvF+35ENNIFSSsdeo4Posiw3XbB1Ne
	9BplOulaUVHFA2BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF31E13444;
	Mon, 30 Jan 2023 09:47:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id y5FOLi+S12NEdAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 30 Jan 2023 09:47:27 +0000
Date: Mon, 30 Jan 2023 10:47:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Nick Neumann <nick@pcpartpicker.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: Option to never do BLKRRPART ioctl in nvme format?
Message-ID: <20230130094727.vngui7phl3cltb7j@carbon.lan>
References: <CADqNVToVWkJHSPbYqJRgnFjdMt3N_-UkCHZtHVTRhpGNThX3Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADqNVToVWkJHSPbYqJRgnFjdMt3N_-UkCHZtHVTRhpGNThX3Wg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230130_014734_447357_563DBE55 
X-CRM114-Status: GOOD (  16.11  )
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

Hi Nick,

On Fri, Jan 06, 2023 at 01:28:52PM -0600, Nick Neumann wrote:
> The nvme format command, as its documentation states, issues BLKRRPART
> ioctl after successful format.
> 
> It feels odd that after a successful format, the format command can
> still return an error code because BLKRRPART ioctl fails.
> 
> When initially added, the BLKRRPART ioctl was issued but its return
> value was ignored. Later[1], the return value started being checked
> and returned. And over time [2,3], cases were added where BLKRRPART is
> not issued.
> 
> I'm wondering if all of this, combined with apparent race conditions
> I've hit where BLKRRPART can fail after successful format, are a sign
> that there should be a way to do an nvme format without BLKRRPART
> ioctl.

I can't really say why BLKRRPART was added initially. The comment which was
added later on

/*
 * If block size has been changed by the format
 * command up there, we should notify it to
 * kernel blkdev to update its own block size
 * to the given one because blkdev will not
 * update by itself without re-opening fd.
 */

indicates we don't need BLKRRPART necessary. I would like to understand first
what's going on before dropping BLKRRPART.

@Keith, do you happen to remember what's the reason for BLKRRPART?

Thanks,
Daniel

