Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33608C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jun 2022 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hscfBD8FL5b+WOwnxVonBpLEsa0dvx6qUAdCIqwGO+g=; b=oxoytHYXe8HmVbSIWA2LsVcBVO
	LgKVvLeapaK0uI2NGNLSCdU327y0JJwuY0VSYRwJIisg1d2YqKYboK0OgTQIWH8UObRzG9SWR11YH
	H3yATumrtJa4ZSRvfGEI1qjYxJkaunaBMgh5BuC7cYTF+U1MyUc6qNumIotydx1FyIBSKi2efxdBR
	ZnvlPXKrtLokkISMMFcwuGU51KxG/uTkcp6W4TzWp5x4taYUxsfKrXaGAT8FZedWB8c9kY+RHuXyU
	RFq9pWqXsznlzryYB+avLo/RKaW5bhQkCd8uK3p4QeN3mogHi3pWeMe3mbZ70XUUFSEMGb4LT2OWY
	oM0TpP7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5R71-00Bd9c-Jy; Sun, 26 Jun 2022 12:11:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5R6s-00Bd6Z-9P
	for linux-nvme@lists.infradead.org; Sun, 26 Jun 2022 12:11:28 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4DA6221E9D;
	Sun, 26 Jun 2022 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656245479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hscfBD8FL5b+WOwnxVonBpLEsa0dvx6qUAdCIqwGO+g=;
	b=SWhhXn0JGopm4uojGNuLE4N/dqHzZTY85B4pibUmP0VRQa83SI7EtxanEn7rV+8BqPGcwO
	e/g8gMaBjOK0FSosXiSkj8ZsOxDX6eX5C13TIKbSq7zci4aO2H/JmtD0a8csl9EpuEBbv2
	iuZ8M4CcC2JYBMWpDwto9IzcUSNTAQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656245479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hscfBD8FL5b+WOwnxVonBpLEsa0dvx6qUAdCIqwGO+g=;
	b=CLVAd2je0FurgJF/5RxF30JXJtJUeOuZeF8FRbfXTFESe83Q8amVGBuDnMZFxyRiVWryu6
	+GmhzXjjDClBRJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 29C6513ACA;
	Sun, 26 Jun 2022 12:11:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EJjQCOdMuGJfJAAAMHmgww
	(envelope-from <hare@suse.de>); Sun, 26 Jun 2022 12:11:19 +0000
Message-ID: <f1e33a3f-c3e2-e6da-7314-f0a926dd98a5@suse.de>
Date: Sun, 26 Jun 2022 14:11:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCHv17 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220623061730.51490-1-hare@suse.de>
 <19c905e8-963e-5720-b18a-d050217d40de@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <19c905e8-963e-5720-b18a-d050217d40de@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220626_051126_545475_CF18FCE1 
X-CRM114-Status: GOOD (  26.20  )
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

On 6/26/22 12:17, Sagi Grimberg wrote:
> 
>> Hi all,
>>
>> recent updates to the NVMe spec have added definitions for in-band
>> authentication, and seeing that it provides some real benefit
>> especially for NVMe-TCP here's an attempt to implement it.
>>
>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>> to provide us with a FFDHE implementation; I've updated the patchset
>> to use the ephemeral key generation provided there.
>>
>> Note that this is just for in-band authentication. Secure
>> concatenation (ie starting TLS with the negotiated parameters)
>> requires a TLS handshake, which the in-kernel TLS implementation
>> does not provide. This is being worked on with a different patchset
>> which is still WIP.
>>
>> The nvme-cli support has already been merged; please use the latest
>> nvme-cli git repository to build the most recent version.
>>
>> A copy of this patchset can be found at
>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>> branch auth.v17
>>
>> The patchset is being cut against nvme-5.20.
>>
>> As usual, comments and reviews are welcome.
> 
> 
> This looks better Hannes.
> 
> Few questions:
> 1. When we set dhgroups, should we try loading dh-generic (host and
> target)? I forgot to load these and took me time to figure out why
> things are not working?
> 
Ah. Hmm. Yeah, guess we should (with the current ode, anyway).
But maybe it's possible to make the code more resilient and simply 
disallow DH groups if the module isn't loaded.
I'll check.

> 2. Sometimes when I setup a misconfigured authentication, I don't
> fail immediately, but block until an admin timeout expires.
> For example, when I didn't load dh-generic on the host:
> -- 
> [ 1618.030365] nvme nvme0: new ctrl: NQN 
> "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
> [ 1618.121852] nvme nvme1: qid 0: error -2 initializing DH group ffdhe4096
> [ 1618.123944] nvme nvme1: qid 0: authenticated
> [ 1680.738012] nvme nvme1: queue 0: timeout request 0x1 type 4
> [ 1680.738155] nvme nvme1: Property Get error: 881, offset 0x0
> [ 1680.738165] nvme nvme1: Reading CAP failed (881)
> -- 
> 
Curious.
Does this help?

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index af3a7845ee76..285a9d6fbf1b 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -740,6 +740,7 @@ static void __nvme_auth_work(struct work_struct *work)
         ret = nvme_auth_process_dhchap_challenge(ctrl, chap);
         if (ret) {
                 /* Invalid challenge parameters */
+               chap->error = ret;
                 goto fail2;
         }


> 3. Not sure if this is related, but now I see a new memory leak:
> -- 
> unreferenced object 0xffff8fa0c91d2080 (size 128):
>    comm "kworker/u8:4", pid 262, jiffies 4294949965 (age 1855.437s)
>    hex dump (first 32 bytes):
>      e0 a2 c9 96 ff ff ff ff 90 0f dd f4 a0 8f ff ff  ................
>      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>    backtrace:
>      [<000000009524c6a1>] blk_iolatency_init+0x25/0x160
>      [<0000000074c7283e>] blkcg_init_queue+0xb4/0x120
>      [<00000000747d5b28>] __alloc_disk_node+0xeb/0x1d0
>      [<0000000082cf1eb2>] __blk_alloc_disk+0x31/0x60
>      [<000000008e36f1d8>] nvme_mpath_alloc_disk+0xcc/0x1c0 [nvme_core]
>      [<00000000f81c9db1>] nvme_alloc_ns_head+0x12b/0x250 [nvme_core]
>      [<00000000eba12e37>] nvme_init_ns_head+0x255/0x2d0 [nvme_core]
>      [<000000006f769fbb>] nvme_alloc_ns+0x114/0x4b0 [nvme_core]
>      [<00000000cf38f67b>] nvme_validate_or_alloc_ns+0x9e/0x1c0 [nvme_core]
>      [<00000000db73ed81>] nvme_scan_ns_list+0xf7/0x2c0 [nvme_core]
>      [<0000000011b21727>] nvme_scan_work+0xde/0x270 [nvme_core]
>      [<000000000f7941ae>] process_one_work+0x1e5/0x3b0
>      [<000000008eb36ec1>] worker_thread+0x50/0x3a0
>      [<00000000e58a93ca>] kthread+0xe8/0x110
>      [<00000000e82e51e5>] ret_from_fork+0x22/0x30
> -- 

Hmm. Looks like a generic nvme issue, so unlikely it's introduced by 
this patch. We still should fix it, though :-)

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

