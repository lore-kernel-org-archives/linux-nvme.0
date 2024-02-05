Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34196C48291
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 05:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rKC62qjfruV5NOcc1w1kraA4hT54tNNGX8DXHpcIWs0=; b=tS+XLM2V1IMpSfGwk1TKZs9ZnC
	On/5XxPkbtE7/cn5XYhkMajxDx6isC1QpmF+u7CjGqi8cu83qMMXm9qrsOG0eTkRCyy+VIaa0RRBd
	+z7Utat8TGoY9l99Nn/h3nsUO82STM4yBFdnOjtuZenv0zm8EgY7bSbYeawsUUVMGhP8+QAEQMpES
	GxSG+Z8WuJ1yhNfj8hG0JmPCJPQHz2Ck2GZwH6DURKq1XB7JVCIQLZihxalIYK3s7x6usPA3b1FVK
	GrJkOR5gHwpBxWvNS1Bj8v6p9x71E2RkjQoIb96BCkyCfUAinL7GspLw9F8bCz8p4ChqQ7sEosaNi
	8UfKVRPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWr7b-000000022SR-0MtC;
	Mon, 05 Feb 2024 05:02:19 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWr7U-000000022RF-2DxJ
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 05:02:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A8D3F1F8A8;
	Mon,  5 Feb 2024 05:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707109328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKC62qjfruV5NOcc1w1kraA4hT54tNNGX8DXHpcIWs0=;
	b=OYVl7LOYCJjTD7BicOiS8hPydojKSSSGTXUIWnfKFtPKBOZUcmOainqev0dYPWfJcQpaeG
	vwXmh/V1ZLGGxUP/DcXCbwRrYZn9IQJNDKH6cGIigAl3AUEyZQuhsa/CnSYwb+DtL8mb9h
	40wjBogwrnj9KyigtKUx6oTgjsYCGiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707109328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKC62qjfruV5NOcc1w1kraA4hT54tNNGX8DXHpcIWs0=;
	b=KFlnzs0gVea3wWfkA/ci1cUx7C3Nfisj/eL/K9SJ7yu1j3IOhggpIlxXbE32Hy4wkYkZUQ
	O8Wv7JxQJgqqwTBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707109328; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKC62qjfruV5NOcc1w1kraA4hT54tNNGX8DXHpcIWs0=;
	b=OYVl7LOYCJjTD7BicOiS8hPydojKSSSGTXUIWnfKFtPKBOZUcmOainqev0dYPWfJcQpaeG
	vwXmh/V1ZLGGxUP/DcXCbwRrYZn9IQJNDKH6cGIigAl3AUEyZQuhsa/CnSYwb+DtL8mb9h
	40wjBogwrnj9KyigtKUx6oTgjsYCGiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707109328;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKC62qjfruV5NOcc1w1kraA4hT54tNNGX8DXHpcIWs0=;
	b=KFlnzs0gVea3wWfkA/ci1cUx7C3Nfisj/eL/K9SJ7yu1j3IOhggpIlxXbE32Hy4wkYkZUQ
	O8Wv7JxQJgqqwTBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 110E2132DD;
	Mon,  5 Feb 2024 05:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /5TfL85rwGWZYgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 05 Feb 2024 05:02:06 +0000
Message-ID: <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
Date: Mon, 5 Feb 2024 14:02:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: race between nvme device creation and discovery?
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OYVl7LOY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KFlnzs0g
X-Spamd-Result: default: False [-2.30 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A8D3F1F8A8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_210212_755433_AC8C99CF 
X-CRM114-Status: GOOD (  25.53  )
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

On 2/2/24 23:16, Daniel Wagner wrote:
> I am trying to figure out why some of the blktests fail randomly when
> running with FC as transport. This failure only appear when the
> autoconnect is running in the background. A clear indication we still
> have some sort of interference with it.
> 
> nvme/030 fails a bit more often then the rest, and it might just because
> it issues several 'nvme discover' commands, many other tests only a one.
> 
> When a test fails, it fails with
> 
>    failed to lookup subsystem for controller nvme0
> 
> which is from libnvme when it iterates over sysfs to gather infos.
> 
>          subsysname = nvme_ctrl_lookup_subsystem_name(r, name);
>          if (!subsysname) {
>                  nvme_msg(r, LOG_ERR,
>                           "failed to lookup subsystem for controller %s\n",
>                           name);
>                  errno = ENXIO;
>                  return NULL;
>          }
> 
> My current theory is when a new controller isa dded is not atomic from
> the POV userland and thus libnvme is able to observe a situation when
> there is controller but the matching subsystem is not yet visible.
> 
> So something like:
> 
>    nvme_init_ctrl
>      cdev_device_add
> 
>    // libnvme iterates over sysfs
> 
>    nvme_init_ctrl_finish
>      nvme_init_identify
>        nvme_init_subsystem
>           device_add          // nvme-subsys%d
>           sysfs_create_link   // subsys->dev -> ctrl-device
> 
> Does this any sense? And if so what could be done? Should we add some
> retry logic to libnvme?
> 

Hehe. Good old sysfs.
This is a common issue with sysfs, and we've even had a retry loop in 
udev back in them days to avoid these kind of things.

Point is, uevent will be sent out with device_add(), causing udev to 
run, running udev rules, and eventually call into libnvme to scan the 
device. But as you rightly pointed out, the sysfs link is only created
_after_ the event has been sent, so there's a race window during which
libnvme will fails to read the link, landing us with the scenario above.

While we could add a retry logic to libnvme, I'm not really convinced
this is a good idea; in the end, who's to tell how long we should wait?
A second? Several seconds? A minute? Several minutes?
Also not that sysfs_create_link() has a return code, so the link might
not be created at all ...

A possibly better way here would be to suppress uevents on device_add(),
and only send out events once the device is fully set up, ie just before
the 'return 0'.

Let me see if I can whip up a patch ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


