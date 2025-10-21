Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77114CCD1A7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 06:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsDJS2u9b96ncBr1BtDZ4VooYCagXDtyD2reZrymCWs=; b=kK/UwFoFwTrEEA+zjTUwwuqMUd
	R7oN5PtDriF97ORNaf+sQaQpv9ArZF76jR29WWC616QmLFPMLVKX1Qzphlud3FdTa7PyqCvsNeRQB
	hyuX1OBbTYgW5SL82CqbvM6fwyXIZBvxrXM492bqOyJaF3DMMA+Fk2ieuFdfm+uyjtkF94Q9dczGA
	NUczTcjF/c3VOcebYR0N87K2cLNoS+OOa9XZmZfzGDiQLAECo3axv58FxqQqeOt1EIYuAdTpM9ydp
	aNEIckZ1pa9aoPYAkmAj+zrowZ/beqTFxbe7LWVCMlsA+k5VDnB2WrqxwM8ZKIhKJlV/NGB5Ui0Gf
	uNCd379A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB6BL-0000000FxOu-2awy;
	Tue, 21 Oct 2025 06:49:19 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB6BI-0000000FxNu-0hOt
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 06:49:17 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E89D9211A8;
	Tue, 21 Oct 2025 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761029349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsDJS2u9b96ncBr1BtDZ4VooYCagXDtyD2reZrymCWs=;
	b=XfWGsNjlGs62zN8dIv3oktTkZzzUo74gqnTkW2ntLHI+eAMaJLrFlj3L5glquGBLgJeLV4
	H6AVQeMwnXQMCc2eZfTTqBnALJjNsrdevXn18BIJdmGhKYeTOlU05fSMAJwppGda66WGcq
	fu0+iZ171l6iehKINhhzfp3e6dysry8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761029349;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsDJS2u9b96ncBr1BtDZ4VooYCagXDtyD2reZrymCWs=;
	b=5JTNcAA96eC/6XlRq3Jkk3wcpAFYO17utQ+Bc0xxxhtI7FOZOqF1SmDkcQBpkH6hC3paGO
	3zCrLzxRVmh4uDBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1761029344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsDJS2u9b96ncBr1BtDZ4VooYCagXDtyD2reZrymCWs=;
	b=kMg7KtnVgQ9Y21VYP6uVTZfi6Sgtu6qKWL72TvLhZ2e/scQVMMpnlCpFUN0bECNo6o2T26
	2XYQfawOYIGqnW3AKaJR8Cge7hT6JDLKbRH2ZelljrlievSHCi65iST55sGkCM1g5mW36g
	JyUk4PjGfR9CdF84BvMKvYD9zR79pkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1761029344;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tsDJS2u9b96ncBr1BtDZ4VooYCagXDtyD2reZrymCWs=;
	b=BnE4KwcZZ9W9sRAkiN7UcfdtNxgppepHLf/TIq+VTYk5LurW4O5kyCEBoc75YWqX2yXVx2
	LqhPAUS8OdPXGcAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F947139D2;
	Tue, 21 Oct 2025 06:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R5s5FOAs92hnLQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 Oct 2025 06:49:04 +0000
Message-ID: <cbe94630-f2f2-405e-a04b-7fd2aa2c312d@suse.de>
Date: Tue, 21 Oct 2025 08:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-auth: update sc_c in host response
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Martin George <martinus.gpy@gmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 hch <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hare@kernel.org" <hare@kernel.org>,
 Martin George <marting@netapp.com>, Prashanth Adurthi <prashana@netapp.com>
References: <20250908172457.5512-1-marting@netapp.com>
 <6xoxbezgcnv4bfaevi3pdpesfelia3epxiddk47azho7y5mnhr@ykmlqgnrbl3w>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6xoxbezgcnv4bfaevi3pdpesfelia3epxiddk47azho7y5mnhr@ykmlqgnrbl3w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[wdc.com,gmail.com];
	TAGGED_RCPT(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_234916_568037_086BDBA9 
X-CRM114-Status: GOOD (  18.89  )
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

On 10/20/25 10:50, Shinichiro Kawasaki wrote:
> On Sep 08, 2025 / 22:54, Martin George wrote:
>> The sc_c field is currently not updated in the host response to the
>> controller challenge leading to failures while attempting secure
>> channel concatenation. Fix this by adding a new sc_c variable to the
>> dhchap queue context structure which is appropriately set during
>> negotiate and then used in the host response.
>>
>> Fixes: e88a7595b57f ("nvme-tcp: request secure channel concatenation")
>> Signed-off-by: Martin George <marting@netapp.com>
>> Signed-off-by: Prashanth Adurthi <prashana@netapp.com>
>> ---
>> Changes in v2: set *buf to sc_c as suggested by Hannes
> 
> I ran blktests with v6.18-rc2 kernel, and found the test case nvme/063 shows a
> new failure symptom. I bisected and found this patch in the v6.18-rc2 tag
> triggers the failrue. Actions for fix will be appreciated. FYI, I attach the
> blktests console output [1] and the kernel messages [2].
> 
>    To be precise, nvme/063 fails even without this patch as I reported [3]. But
>    that failure was due to lockdep WARN. This patch introduced a new failure
>    symptom. I think both the two failure symptoms should be fixed.
> 
> 
> [1] blktests run console output
> 
> # NVMET_TRTYPES=tcp ./check nvme/063
> nvme/063 (tr=tcp) (Create authenticated TCP connections with secure concatenation)
>      runtime  2.922s  ...
> WARNING: Test did not clean up port: 0
> WARNING: Test did not clean up subsystem: blktests-subsystem-1
> rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory not empty
> WARNING: Test did not clean up host: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> nvme/063 (tr=tcp) (Create authenticated TCP connections with secure concatenation) [failed]01fb42-9f7f-48    runtime  2.922s  ...  3.908s resource busy
>      --- tests/nvme/063.out      2025-08-26 21:28:52.805848674 +0900
>      +++ /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/063.out.bad      2025-10-20 17:42:12.097662643 +0900
>      @@ -1,7 +1,3 @@
>       Running nvme/063
>       Test secure concatenation with SHA256
>      -Reset controller
>      -disconnected 1 controller(s)
>      -Test secure concatenation with SHA384
>      -disconnected 1 controller(s)
>      -Test complete
>      ...
>      (Run 'diff -u tests/nvme/063.out /home/shin/Blktests/blktests/results/nodev_tr_tcp/nvme/063.out.bad' to see the entire diff)
> WARNING: Test did not clean up subsystem: blktests-subsystem-1
> rmdir: failed to remove '/sys/kernel/config/nvmet//subsystems/blktests-subsystem-1': Directory not empty
> WARNING: Test did not clean up host: nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349
> rmdir: failed to remove '/sys/kernel/config/nvmet//hosts/nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349': Device or resource busy
> 
> 
> [2] kernel message log
> 
> [   59.957999] [    T950] run blktests nvme/063 at 2025-10-20 17:42:08
> [   60.146451] [   T1059] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [   60.168784] [   T1060] nvmet: Allow non-TLS connections while TLS1.3 is enabled
> [   60.179760] [   T1063] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> [   60.321134] [     T80] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349 with DH-HMAC-CHAP.
> [   60.329310] [     T89] nvmet: ctrl 1 qid 0 host response mismatch
> [   60.329914] [     T89] nvmet: ctrl 1 qid 0 failure1 (1)
> [   60.330650] [     T82] nvmet: ctrl 1 fatal error occurred!
> [   60.331254] [   T1073] nvme nvme5: qid 0: authentication failed, error -129
> [   60.333179] [   T1073] nvme nvme5: failed to connect queue: 0 ret=-129
> 
> 
> [3] https://lore.kernel.org/linux-nvme/ynmi72x5wt5ooljjafebhcarit3pvu6axkslqenikb2p5txe57@ldytqa2t4i2x/T/#u

That's because the target side needs the same fix. I'll send a patch.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

