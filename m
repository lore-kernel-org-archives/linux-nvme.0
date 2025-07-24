Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AC9C83F26
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jul 2025 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KTCU83nZZxpmaXfoqaGuNovqBj0u4SCE2Ol0134E1Vc=; b=JISZZ7MObtu2Y4Zy8GHbcE6TJw
	6c9N/qGMgBs2RBYZy/i2KWPBX4mwc3eds68N+zP3/EwT6ljiNBSUKYWp0vVAzl8CiTZzw70eTVk09
	nRkv7wAcwd9ns76FcEFSYloSV/GU2d0FtjuSytOSnCXIqEs0jOZz8NsuVx5dh1KXaL09OM5NvDJgV
	hmMjJ/SfAJXItud4GE2mrGORSkI8tAkNORAdH9S909MDZqHnmsFZHI+1Qy+MKWLzWAGi9cE8K4RCd
	2GhKoWPT5avUhDJamhzn0681VRqr6ATCQaUT76LzEiDzhMQ6IObLQBe468qhU5dnHgS0g7th4IUFt
	RxlnRClQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uezW0-000000086gQ-2tEd;
	Thu, 24 Jul 2025 17:13:56 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uey0G-00000007tw6-2Z5v
	for linux-nvme@lists.infradead.org;
	Thu, 24 Jul 2025 15:37:05 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1498F1F79F;
	Thu, 24 Jul 2025 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753371423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTCU83nZZxpmaXfoqaGuNovqBj0u4SCE2Ol0134E1Vc=;
	b=vPUZgB7x5kDwP9XApXXvyTXFVECTNS2H2wPnNSgvGTzNWikcrx0vkMiVr2dPkYsJyKyMCb
	me435wN/qU0oXJcHWsjskwYCaTt5NhbodmmAMpofEjR/U1tVjD9PKcooLAFURz3gNofKAR
	ZKVzQVCo4RJxeI5J+aN5/kQpqxl6hUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753371423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTCU83nZZxpmaXfoqaGuNovqBj0u4SCE2Ol0134E1Vc=;
	b=Lv+cQVBOX6FSSN5DnLCb44QeryfEJ3sYRBfCt+1EnPVE2Fba5KziAhJN6iiSjmma15NKYr
	xmmdBUHAmIIt9gCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753371423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTCU83nZZxpmaXfoqaGuNovqBj0u4SCE2Ol0134E1Vc=;
	b=vPUZgB7x5kDwP9XApXXvyTXFVECTNS2H2wPnNSgvGTzNWikcrx0vkMiVr2dPkYsJyKyMCb
	me435wN/qU0oXJcHWsjskwYCaTt5NhbodmmAMpofEjR/U1tVjD9PKcooLAFURz3gNofKAR
	ZKVzQVCo4RJxeI5J+aN5/kQpqxl6hUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753371423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTCU83nZZxpmaXfoqaGuNovqBj0u4SCE2Ol0134E1Vc=;
	b=Lv+cQVBOX6FSSN5DnLCb44QeryfEJ3sYRBfCt+1EnPVE2Fba5KziAhJN6iiSjmma15NKYr
	xmmdBUHAmIIt9gCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03AD713302;
	Thu, 24 Jul 2025 15:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4YiXAB9TgmgdSAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 24 Jul 2025 15:37:03 +0000
Date: Thu, 24 Jul 2025 17:37:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chris Leech <cleech@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	Prashanth Nayak <prashanth.nayak@netapp.com>, John Meneghini <jmeneghi@redhat.com>
Subject: Re: [PATCH 0/1] NVMe/TLS connection issues to SPDK
Message-ID: <c9d10d02-3b13-4312-abfd-82e9dbca1b0f@flourine.local>
References: <20250721021718.1159879-1-cleech@redhat.com>
 <546f62d0-3f1d-4619-a668-d087da5b44fc@suse.de>
 <aH5gYzXAIGdsCBsn@cleech-thinkpadt14sgen2i.rmtusor.csb>
 <c523f9c3-06fb-4aa6-958f-e49e7c5477e4@suse.de>
 <c0af190a-3e46-4203-aca9-da1017d2fd2e@flourine.local>
 <CAPnfmX+pHz-i8YTydL362oq9ko6eihmaVV8ApMBisR-c8=acLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPnfmX+pHz-i8YTydL362oq9ko6eihmaVV8ApMBisR-c8=acLg@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_FIVE(0.00)[5]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250724_083704_794526_684AA3EE 
X-CRM114-Status: GOOD (  12.53  )
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

Hi Chris,

On Thu, Jul 24, 2025 at 08:07:03AM -0700, Chris Leech wrote:
> I believe Hannes has given a reviewed tag on the libvnme patch.  The
> discussion on the cover letter is about future work on the kernel
> side.

Ah, thanks. Trimming emails would help.

> If it would help I can capture that tag and then submit this as a
> github PR.

The PR has the advantage that a CI build gets triggered. Submissions on
the mailing list are usually in good shape. Submissions via GitHub vary
quite a bit. I’m fine either way. :)

> Actually, I think I might be missing an explicit NULL assignment on
> the declaration of *str to keep _cleanup_free_ safe?

For _cleanup_free_ to work, the variable needs to be initialized (either
NULL or a valid pointer) before the block scope is left. Otherwise the
free sees a random stack value.

Thanks,
Daniel

