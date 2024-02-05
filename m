Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A85C4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3jizDX+94mxDl/9RzCbJlDl7+0MFNucb2DAAEw92bk=; b=pzRUzexYGyUfzCufMhJjp8vqQM
	LZIqKPPMpkXuGXtwWyuiaR5GtwdBbsXaODjX22nG/GvUWCQ9x6IRWdtFFIm2x+4Q0ZY3ydM6IIIFC
	GZ7vYrZk7J471ktkEEgSHkzhbWCL5TG9/WjRAGIwQ+GqmFp5igPpzGeli1hahemimoTMxkpy6Yoon
	wV/ADNW2Bq1OPvdxZFHmiUb9oB+E0u0sbCDHMR6mmr6Zywawx7kcq7Fvr+TB3qfbqI2h+TXfWE19P
	JXIQdgS4GS7kxoz/md+srDuS4/Kfgje/SSqur1wTOwDJpyrMfUOUWgrJmPchIf8efyZrCJT3yxtLh
	8bfJh6qQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWtrF-00000002MxG-3wcs;
	Mon, 05 Feb 2024 07:57:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWtrB-00000002Mw4-1tzs
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 07:57:36 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BCF4522007;
	Mon,  5 Feb 2024 07:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707119850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jizDX+94mxDl/9RzCbJlDl7+0MFNucb2DAAEw92bk=;
	b=zhCMagsmrZ7BaND9wlHPThr9o1n5YYp1a8V1MADpGV23O3fzheQZm2DQaLl6ANduUpKBaZ
	yzBFKAzby5HH1PoCq/ixN8oAOMMpsKdCrvJH/hldXjj3moSl+UyO79tLx6vwP/RR2ww1k+
	38/9XdsvK2MulhI70wGnypIhClKHg6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707119850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jizDX+94mxDl/9RzCbJlDl7+0MFNucb2DAAEw92bk=;
	b=vhGkmilOJ+vxnbNG6y5zcEGhvG1+Vjp2WMjBvbFyfuVkCKvXCTWA3MNkMKccRgnO8a9usz
	8kikNiKqqdMSwlCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707119850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jizDX+94mxDl/9RzCbJlDl7+0MFNucb2DAAEw92bk=;
	b=zhCMagsmrZ7BaND9wlHPThr9o1n5YYp1a8V1MADpGV23O3fzheQZm2DQaLl6ANduUpKBaZ
	yzBFKAzby5HH1PoCq/ixN8oAOMMpsKdCrvJH/hldXjj3moSl+UyO79tLx6vwP/RR2ww1k+
	38/9XdsvK2MulhI70wGnypIhClKHg6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707119850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3jizDX+94mxDl/9RzCbJlDl7+0MFNucb2DAAEw92bk=;
	b=vhGkmilOJ+vxnbNG6y5zcEGhvG1+Vjp2WMjBvbFyfuVkCKvXCTWA3MNkMKccRgnO8a9usz
	8kikNiKqqdMSwlCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDC71136F5;
	Mon,  5 Feb 2024 07:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fyowJeeUwGUsBgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 05 Feb 2024 07:57:27 +0000
Message-ID: <c8b6b6dc-91bb-45b2-a911-e23cbea28a8e@suse.de>
Date: Mon, 5 Feb 2024 16:57:24 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: race between nvme device creation and discovery?
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
References: <i4bmvgd3u7shgizqgtdtssdz5v3wc76l6bcce6fcbvoft32gzk@rztzeut4azvj>
 <e0e89568-d3af-4d4e-9652-59d04f2c1977@suse.de>
 <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <5pquzxdvemeeahharuoyh72njlx4unrshwxbtkpg63tk3aw2lt@ugv4guf7hkpz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.09 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240204_235733_674243_18BA9A09 
X-CRM114-Status: GOOD (  20.82  )
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

On 2/5/24 15:47, Daniel Wagner wrote:
> On Mon, Feb 05, 2024 at 02:02:04PM +0900, Hannes Reinecke wrote:
>> Hehe. Good old sysfs.
>> This is a common issue with sysfs, and we've even had a retry loop in udev
>> back in them days to avoid these kind of things.
>>
>> Point is, uevent will be sent out with device_add(), causing udev to run,
>> running udev rules, and eventually call into libnvme to scan the device. But
>> as you rightly pointed out, the sysfs link is only created
>> _after_ the event has been sent, so there's a race window during which
>> libnvme will fails to read the link, landing us with the scenario above.
>>
>> While we could add a retry logic to libnvme, I'm not really convinced
>> this is a good idea; in the end, who's to tell how long we should wait?
>> A second? Several seconds? A minute? Several minutes?
>> Also not that sysfs_create_link() has a return code, so the link might
>> not be created at all ...
> 
> Yep, retry logics have always a smell too it. What about the idea to
> add some sort of ready attribute to the controller sysfs entry?
> 
>> A possibly better way here would be to suppress uevents on device_add(),
>> and only send out events once the device is fully set up, ie just before
>> the 'return 0'.
> 
> I don't think this will address the problem. The blktests runs completely
> independent to what udev does and it's blktests which observes the
> missing link not udev.

I thought something along these lines:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 85ab0fcf9e88..3ed706f595fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2845,6 +2845,7 @@ static int nvme_init_subsystem(struct nvme_ctrl 
*ctrl, struct nvme_id_ctrl *id)
                         goto out_put_subsystem;
                 }
         } else {
+               dev_set_uevent_suppress(&subsys->dev, 1);
                 ret = device_add(&subsys->dev);
                 if (ret) {
                         dev_err(ctrl->device,
@@ -2869,6 +2870,10 @@ static int nvme_init_subsystem(struct nvme_ctrl 
*ctrl, struct nvme_id_ctrl *id)
         ctrl->subsys = subsys;
         list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
         mutex_unlock(&nvme_subsystems_lock);
+       if (!found) {
+               dev_set_uevent_suppress(&subsys->dev, 0);
+               kobject_uevent(&subsys->dev.kobj, KOBJ_ADD);
+       }
         return 0;


Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


