Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7015C48291
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Feb 2024 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Jk9MZ7/MVzPl2zOhwft97UP+W4NemUDEn3mGPjemkg4=; b=KdQXj4p4G/3bFcvfaYyiiSrfVd
	h7o3L9MUsQo9wMTw42IC+jtzRl3P02Eoua/aJ5EtbRH2wirNuEY0QD3F/sOTO/uixqCDigoNfr/wc
	BNnXTEREYiLxcC31NdVOCIXIeSgvHFSrzd0WatcTBu6RorWZGShn03zim5WW+A9DvM3WZ9rAXGWAW
	qcz09MtpoS+rJWL9YRvqKiiNWcLnN2vSwJAvU50jCFnlY/198llJPFShtdMjezmI3tVqMnc6TfkV5
	HGD32uvfmGPEu0/5JeTz7pbUpcnfUEQZbK8sT03IIpMNFvDx6ztgPcYf52G+eymc1qeTlS0e54tSd
	eEUg0LMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVvHY-0000000BxLw-0YMY;
	Fri, 02 Feb 2024 15:16:44 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVvHR-0000000BxJJ-1RM3
	for linux-nvme@lists.infradead.org;
	Fri, 02 Feb 2024 15:16:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D1F0B21D13;
	Fri,  2 Feb 2024 15:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706886993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Jk9MZ7/MVzPl2zOhwft97UP+W4NemUDEn3mGPjemkg4=;
	b=vw+0tR4oeAI0JAYiHTNVv1biDXHgGGRCgFh2kyiWlUo+kKOCSR9rcyZyRquiorpAdXpl3B
	cpSViZvzufJiUQE8sGaKh3tvg3BGvQ0lV0ZAzeDK7wQ/DJy9+07piSZb7ZBUm+HNf+yF2g
	/lk4PSyIagPDpQSH4poSY+E1jNVLEDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706886993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Jk9MZ7/MVzPl2zOhwft97UP+W4NemUDEn3mGPjemkg4=;
	b=UrIVNoubhuKw0XV+VHEEGzRhx2axZ5Rrz/M6HO/co9WwBxw4b171doHqmBe2yVYxRpHUUk
	J0XzvW735jF3xRDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706886993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Jk9MZ7/MVzPl2zOhwft97UP+W4NemUDEn3mGPjemkg4=;
	b=vw+0tR4oeAI0JAYiHTNVv1biDXHgGGRCgFh2kyiWlUo+kKOCSR9rcyZyRquiorpAdXpl3B
	cpSViZvzufJiUQE8sGaKh3tvg3BGvQ0lV0ZAzeDK7wQ/DJy9+07piSZb7ZBUm+HNf+yF2g
	/lk4PSyIagPDpQSH4poSY+E1jNVLEDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706886993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=Jk9MZ7/MVzPl2zOhwft97UP+W4NemUDEn3mGPjemkg4=;
	b=UrIVNoubhuKw0XV+VHEEGzRhx2axZ5Rrz/M6HO/co9WwBxw4b171doHqmBe2yVYxRpHUUk
	J0XzvW735jF3xRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE0DA139AB;
	Fri,  2 Feb 2024 15:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Hd30LFEHvWUULgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 02 Feb 2024 15:16:33 +0000
Date: Fri, 2 Feb 2024 16:16:33 +0100
From: Daniel Wagner <dwagner@suse.de>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Subject: race between nvme device creation and discovery?
Message-ID: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[17.16%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_071637_571184_C254CEB7 
X-CRM114-Status: GOOD (  13.49  )
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

I am trying to figure out why some of the blktests fail randomly when
running with FC as transport. This failure only appear when the
autoconnect is running in the background. A clear indication we still
have some sort of interference with it.

nvme/030 fails a bit more often then the rest, and it might just because
it issues several 'nvme discover' commands, many other tests only a one.

When a test fails, it fails with

  failed to lookup subsystem for controller nvme0

which is from libnvme when it iterates over sysfs to gather infos.

        subsysname = nvme_ctrl_lookup_subsystem_name(r, name);
        if (!subsysname) {
                nvme_msg(r, LOG_ERR,
                         "failed to lookup subsystem for controller %s\n",
                         name);
                errno = ENXIO;
                return NULL;
        }

My current theory is when a new controller isa dded is not atomic from
the POV userland and thus libnvme is able to observe a situation when
there is controller but the matching subsystem is not yet visible.

So something like:

  nvme_init_ctrl
    cdev_device_add

  // libnvme iterates over sysfs

  nvme_init_ctrl_finish
    nvme_init_identify
      nvme_init_subsystem
         device_add          // nvme-subsys%d
         sysfs_create_link   // subsys->dev -> ctrl-device

Does this any sense? And if so what could be done? Should we add some
retry logic to libnvme?

Daniel

