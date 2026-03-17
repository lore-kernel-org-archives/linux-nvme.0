Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65FD7F33820
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 09:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSuc8xjo+7Q8rtFOYaja7Hr7pRPg9ChuLKq3JH6Tx44=; b=zRSwxaq9y4Hlpqzc6F/ti0xVbT
	5YK6KcxShzmjKFGFmsvo/E0xiqSrOhL4uDvcpRDGaJp9DVfyzbPAmNaJj3ouaS0muaYsjF9NVj+l9
	61Niyro3TEzhh0A3BvpVoRf7eWOniekQVam+ks4CXe1CTW9EivxE9vuP90bhIezwcsYpVCDZQm5OK
	SlOXzPJad/w9EwTYDdK3wv1R1uLuU+1Wmna623OTFBUaFwA0HYZtvy7HuGBJUlBz01jsfCgpabAkY
	17TXBG4xAi3HiILHsrCXMLPP/hZXlD7oX7u6ZZAqeEKWJKr6dMFxVxV+E+ew+EhojT1HPr5A29ZYm
	ojdH6AJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Qh8-00000005ruB-1k0O;
	Tue, 17 Mar 2026 09:26:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2Qh5-00000005rtc-1UfE
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 09:26:32 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 558305BD9D;
	Tue, 17 Mar 2026 09:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773739589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSuc8xjo+7Q8rtFOYaja7Hr7pRPg9ChuLKq3JH6Tx44=;
	b=vjGanU1QPDM32hzAn7F905sPvAT4mihzR/2amLgoK0sEcJ7EhaE/s8uQc4nKMGmCswpo90
	pdtdHSaWxLz0XJD1SwDVsVeKWRT2BCG8R6Awz5DFV2hoUoqJg22MCpDyCib3WrFaosm+CC
	SwJo6W4Y+PrAGs3Ts4Quk0NiSoI9RVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773739589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSuc8xjo+7Q8rtFOYaja7Hr7pRPg9ChuLKq3JH6Tx44=;
	b=Ur13HWh7ZMOMabUC92q+3axkzUPtqS2jKEnfrJEhPh+G2qeQgEgeYQfVfiRxAQpfzbQdbY
	hlB8cpAnhOApCSBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773739589; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSuc8xjo+7Q8rtFOYaja7Hr7pRPg9ChuLKq3JH6Tx44=;
	b=vjGanU1QPDM32hzAn7F905sPvAT4mihzR/2amLgoK0sEcJ7EhaE/s8uQc4nKMGmCswpo90
	pdtdHSaWxLz0XJD1SwDVsVeKWRT2BCG8R6Awz5DFV2hoUoqJg22MCpDyCib3WrFaosm+CC
	SwJo6W4Y+PrAGs3Ts4Quk0NiSoI9RVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773739589;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSuc8xjo+7Q8rtFOYaja7Hr7pRPg9ChuLKq3JH6Tx44=;
	b=Ur13HWh7ZMOMabUC92q+3axkzUPtqS2jKEnfrJEhPh+G2qeQgEgeYQfVfiRxAQpfzbQdbY
	hlB8cpAnhOApCSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 465334273B;
	Tue, 17 Mar 2026 09:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4CX1D0UeuWmdJwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 17 Mar 2026 09:26:29 +0000
Date: Tue, 17 Mar 2026 10:26:28 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "Ballard, Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
Cc: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: libnvme API review
Message-ID: <93520cef-9e3a-4832-9bfa-a0f2c36246e3@flourine.local>
References: <d5b9ca7f-8fd1-48ea-a883-79e92d92ec7e@flourine.local>
 <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR84MB223598544C3E0EC5DA7FAAA09840A@MW4PR84MB2235.NAMPRD84.PROD.OUTLOOK.COM>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_022631_792543_676719FF 
X-CRM114-Status: GOOD (  25.42  )
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

Hi Curtis,

On Mon, Mar 16, 2026 at 03:34:39PM +0000, Ballard, Curtis C (HPE Storage) wrote:
> It looks like these proposed changes are intended to align better with the terms
> in common use or in the NVMe specifications.

I think I should provide some background here first.

The libnvme headers previously mixed NVMe spec APIs with library APIs.
This has been mostly resolved (though some further cleanups are
necessary, we are almost there).

types.h contains all the "payload" definitions for a command, while
cmds.h contains helper functions to set up a command structure. While
cmds.h is fairly clean and closely follows the spec, types.h uses
different styles. Cleaning this part up will be a major task, and I
don't have the time or the patience to do it myself. If anyone wants to
work on this, be my guest.

linux.h, lib.h, ioctl.h, filters.h, and util.h constitute the library
interface used to set up and submit commands to a controller.

fabrics.h (I just realized the table is missing entries) contains the
interface for Fabrics commands, such as connect and disconnect.

The tree.h API defines a data structure that connects various
"resources" such as subsystems, namespaces, and controllers—together.
The tree is populated by reading from the kernel's sysfs interface.
Consequently, while this data structure uses the same names as the
specification, it is not the same thing.

> That may be a side effect of the
> library authors generally using that to create names rather than being the goal
> since you refer to library consistency as the goal.
> 
> With spec and common use in mind, one proposed changed jumped out at me:
> | `nvme_subsystem_reset`       | `nvme_reset_subsystem` |

This is from ioctl.h, which provides the interface for interacting with
the kernel via ioctls. As outlined in the email, the proposal is to
adopt the nvme_VERB_RESOURCE pattern, which more closely follows the
kernel's naming scheme (at least within the NVMe subsystem). In this
specific case, the NVME_IOCTL_SUBSYS_RESET ioctl is issued, which maps
to

    static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
    {
        if (!ctrl->subsystem || !ctrl->ops->subsystem_reset)
		   return -ENOTTY;
        return ctrl->ops->subsystem_reset(ctrl);
    }

inside the kernel.

> The term in the NVMe specifications is "subsystem reset" and that term is used
> many times but I don't see any use of "reset subsystem". Most common use by
> those well versed in the technology also is "subsystem reset" though I have
> seen "reset subsystem" used pretty frequently by people who aren't deep in
> the NVMe specs.

I see. The problem is that mixing NVMe spec terminology with library
API terminology could cause confusion.

> I don't know whether there is a 'best' for this term. General software developers
> might prefer "reset subsystem" but mapping to the specs will be easier with
> "subsystem reset".

The only way I currently see to resolve this is by using a different
prefix for the library APIs (e.g., libnvme_) and reserving the nvme_
prefix exclusively for NVMe spec APIs. However, I am unsure if this
approach will reach a consensus here.

Thanks,
Daniel

