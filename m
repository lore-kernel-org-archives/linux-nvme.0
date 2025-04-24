Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FE5C369C2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 17:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwMkd6IzlTDQ+1lfNCaC4p1OkY4T0a173IGDkvK7yK8=; b=ZNAhJ94c/lECQAqCaKtK4/IX6r
	6Wg5l/FDZAfL/K/045IAjUxTcyuIER/wpV5Uw8WwkFZ1S4VsVGNMpouPmumO8e8tSNWVziBlYH/SC
	Dm+zXAddVHGuQ/O7gFOulEmMwnJBdCTTOzftEC/Q6U5SMIY1wTv4aBYF188r2lc1K2SI6zqE/caCg
	Tp+pwwq5mF/2VxMnJ/BxUJL6lTWR0wE90SIWDvIKgcHvhQvr+t8QzehhlyKTS/XUTqY3GjmaxOWEq
	wZ61ZrK9pqxbPQ8rULzraJ3YLqMHqXKNsgRYWu9dTSa4GLZsrPpimXoTG6sJR1E/ZX+cAmfgaOH/H
	BD3p0dqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u807Z-0000000Er49-2aK4;
	Thu, 24 Apr 2025 17:12:21 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7wfW-0000000EBay-3lp5
	for linux-nvme@bombadil.infradead.org;
	Thu, 24 Apr 2025 13:31:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=wwMkd6IzlTDQ+1lfNCaC4p1OkY4T0a173IGDkvK7yK8=; b=g7cBd+lcr2FSB1nO1CIyn5RHOX
	GCNLgA0V2aMWW2WSPE5ATvmejlDz2EngvbNkJhCcaG4vQM+o7FRW3mnSLVfgCzPaqK7esTggSMt1i
	CQAobZ+vD4YcIehdR1MT+5gOdtaWoKK+XImmW47329dYKBW54lfm/O7PcDgo30Nc2MbXaTwcgHipR
	lMfZvj3FIQmxRuRidLSvGioYq9/4THQBMP2dTmOzChyCb51hgwi0c8y5GxhMaJxr6ob370ccnJjGM
	sOvGO7Cc/5V3ccBB52iQZEUjrNnlwk4KL2izd9OAKY5rMEjynuJkSHAw1IOVExCCfHqNDy1uQUhb7
	2G3d/NtQ==;
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u7wfT-0000000BncF-1ct3
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 13:31:09 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 96EB92118C;
	Thu, 24 Apr 2025 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745501463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwMkd6IzlTDQ+1lfNCaC4p1OkY4T0a173IGDkvK7yK8=;
	b=oamdnDmWbeU9iCapZPSekRNVC7805Qhl87Tc/KOyw0a3sh8X+No444RKiREa6wnsP4EkTJ
	VUxlWFT5+3NNEYf8hCKxKoG492hx+4SkRygsHY5layoqwxlYmbBAcyZNKXVXnK0SKDVdCg
	spVZD+7hZZKoXIsHAlp9HiFci5mcxzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745501463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwMkd6IzlTDQ+1lfNCaC4p1OkY4T0a173IGDkvK7yK8=;
	b=2BMl419IQETA5T0hAsiuPTlTNsjo61tTOj7KTDC4XLYt1C16t/e+631n++/W1uSjZz2jlv
	bK3junB2EZDIkPAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ciFmy9ri;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J8dw8a3J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745501462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwMkd6IzlTDQ+1lfNCaC4p1OkY4T0a173IGDkvK7yK8=;
	b=ciFmy9rig5M8SVo1xfLiEhzWN/O/FAHKmk2iUTFnk42iNjK+3E9XFF6Z+3EintAbzWOLS/
	rQu0AEcErnokhcC+zCazN4qPgYkAHZnVMSa2EtqZ7/yn+GhGEzIRGGPrqosIWG/uy4V78P
	34JQBfN5T1/9pDBiUXsAfsCMiyBjMj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745501462;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwMkd6IzlTDQ+1lfNCaC4p1OkY4T0a173IGDkvK7yK8=;
	b=J8dw8a3JSdIgqjAN82jAhKgYO/iRXY1ZFKJquf2OzpUEkan7SOJRLbQ9YfcGrFY99f5+NE
	N9umnV7YZ53hKGAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 851731393C;
	Thu, 24 Apr 2025 13:31:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TY2wHxY9Cmi1YAAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 13:31:02 +0000
Message-ID: <e5691965-230f-46b6-a431-fbadee837a30@suse.de>
Date: Thu, 24 Apr 2025 15:31:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] nvme_auth: kmemleak observed with blktests nvme/tcp
 nvme/062
To: Yi Zhang <yi.zhang@redhat.com>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>
Cc: hare@kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
References: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAHj4cs-05=-TJAyTVNcf4R9GbnfKVRrEkEVZXEhUACts+WYQYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 96EB92118C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250424_143107_680508_4548310B 
X-CRM114-Status: GOOD (  15.67  )
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

On 4/24/25 14:53, Yi Zhang wrote:
> Hi
> I found this kmemleak when running the blktests on the latest
> linux-block/for-next, please help check it and let me know if you need
> any test/info for it, thanks.
> 
> # nvme_trtype=tcp ./check nvme/063
> nvme/063 (tr=tcp) (Create authenticated TCP connections with secure
> concatenation)
>      runtime  8.748s  ...
> WARNING: Test did not clean up tcp device: nvme6
> WARNING: Test did not clean up port: 0
> WARNING: Test did not clean up subsystem: blktests-subsystem-1
> rmdir: failed to remove
> '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory
> not empty
> nvme/063 (tr=tcp) (Create authenticated TCP connections with secure
> concatenation) [failed]3-51e60b8de349
>      runtime  8.748s  ...
> 8.261srnel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349':
> Device or resource busy
>      --- tests/nvme/063.out 2025-04-20 21:27:21.084101153 -0400
>      +++ /root/blktests/results/nodev_tr_tcp/nvme/063.out.bad
> 2025-04-24 08:47:10.951187723 -0400
>      @@ -3,5 +3,4 @@
>       Reset controller
>       disconnected 1 controller(s)
>       Test secure concatenation with SHA384
>      -disconnected 1 controller(s)
>      -Test complete
>      +WARNING: connection is not encrypted
> WARNING: Test did not clean up subsystem: blktests-subsystem-1
> rmdir: failed to remove
> '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory
> not empty
> WARNING: Test did not clean up host:
> nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> rmdir: failed to remove
> '/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349':
> Device or resource busy
> 
> # cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff8964e25a4180 (size 32):
>    comm "kworker/13:1H", pid 576, jiffies 4295435801
>    hex dump (first 32 bytes):
>      f1 c3 44 62 7d b7 12 57 34 f6 0d 61 33 f6 d0 63  ..Db}..W4..a3..c
>      5d 27 ff 34 d4 2f da 08 04 9c 32 f2 e4 fe 4f a6  ]'.4./....2...O.
>    backtrace (crc 6e2b0dcd):
>      __kmalloc_noprof+0x379/0x4a0
>      nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
>      nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
>      nvmet_auth_reply+0x39d/0x3b0 [nvmet]
>      nvmet_execute_auth_send+0x488/0x550 [nvmet]
>      0xffffffffc07f04f1
>      process_one_work+0x25b/0x6b0
>      worker_thread+0x19a/0x350
>      kthread+0x11b/0x260
>      ret_from_fork+0x30/0x50
>      ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xffff896560245800 (size 32):
>    comm "kworker/0:1H", pid 560, jiffies 4295437983
>    hex dump (first 32 bytes):
>      22 92 b5 6a 0c 4c ab 38 fa 6a c4 f7 32 91 ff 4f  "..j.L.8.j..2..O
>      b2 e8 ab 92 52 c8 99 fe c8 f0 1d 53 cb b8 3d ff  ....R......S..=.
>    backtrace (crc 2f0a5d3c):
>      __kmalloc_noprof+0x379/0x4a0
>      nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
>      nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
>      nvmet_auth_reply+0x39d/0x3b0 [nvmet]
>      nvmet_execute_auth_send+0x488/0x550 [nvmet]
>      0xffffffffc07f04f1
>      process_one_work+0x25b/0x6b0
>      worker_thread+0x19a/0x350
>      kthread+0x11b/0x260
>      ret_from_fork+0x30/0x50
>      ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xffff8965c134e300 (size 64):
>    comm "kworker/6:2H", pid 2766, jiffies 4295441704
>    hex dump (first 32 bytes):
>      bb 40 af 2e cc 9b c9 cf b6 a9 f1 c8 63 12 be 3e  .@..........c..>
>      82 75 8f b0 c1 af 3d ef 9b 5e 88 2e c1 ac 0f 85  .u....=..^......
>    backtrace (crc ac0b7882):
>      __kmalloc_noprof+0x379/0x4a0
>      nvme_auth_derive_tls_psk+0x180/0xde0 [nvme_auth]
>      nvmet_auth_insert_psk+0xc8/0x210 [nvmet]
>      nvmet_auth_reply+0x39d/0x3b0 [nvmet]
>      nvmet_execute_auth_send+0x488/0x550 [nvmet]
>      0xffffffffc07f04f1
>      process_one_work+0x25b/0x6b0
>      worker_thread+0x19a/0x350
>      kthread+0x11b/0x260
>      ret_from_fork+0x30/0x50
>      ret_from_fork_asm+0x1a/0x30
> 
> 
> (gdb) l *(nvme_auth_derive_tls_psk+0x180)
> 0x13a0 is in nvme_auth_derive_tls_psk (drivers/nvme/common/auth.c:789).
> 784 put_unaligned_be16(psk_len, info);
> 785 memcpy(info + 2, psk_prefix, strlen(psk_prefix));
> 786 sprintf(info + 2 + strlen(psk_prefix), "%02d %s", hmac_id, psk_digest);
> 787
> 788 tls_key = kzalloc(psk_len, GFP_KERNEL);
> 789 if (!tls_key) {
> 790 ret = -ENOMEM;
> 791 goto out_free_info;
> 792 }
> 793 ret = hkdf_expand(hmac_tfm, info, info_len, tls_key, psk_len);
> 
> 
> 
Can you try this patch?

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index e7d82bc32f41..1ed606892a8a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -669,6 +669,8 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
         if (sq->ctrl->tls_key)
                 key_put(sq->ctrl->tls_key);
         sq->ctrl->tls_key = tls_key;
+#else
+       kfree_sensitive(tls_psk);
  #endif

  out_free_digest:

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

