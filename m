Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EB9606A324
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2026 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DN3+gQ3v;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F0LlMQ+R;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l/eKtV3K;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=F0LlMQ+R;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=l/eKtV3K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4ByMKIBvfZhDSrda5lB4kY7Ks7hcY9F8y/GUj0feuLo=; b=DN3+gQ3vpUXsqJ
	VTkfgxx2PJWkqb5tqdu7FsaB+g1yRyw+twQMwVT5u9hbS5YtdvfNNZt6aOh0Zre1vyAK0/anwgsBx
	15Z/Yj0W0AB1IS8kTz19y4yPhU/7Au7q7/uN5aTHMNmvYt5mLhzJhZ1ktovztC1u3JK9JWJfjCPcP
	rt6WQ0XzSK/kejXbd+ZQsf8cByHUOBzlgQJ18RpIOpCzqodQ5Cn4RHJHPPaY2ga0t63cr50ujP3MR
	SYewiHQX2ut07jxTHqY7L9AxRt5zsVcTL+ToL1I3JtAvSFwmqCycWLSRqKbpmBRU8OGECAzeuL7OQ
	FFV1XJZB2xXwfh6reYJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmGt-0000000FjK9-3dgG;
	Mon, 02 Nov 2026 07:15:59 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xNmGq-0000000FjJp-3QV0
	for linux-nvme@lists.infradead.org;
	Mon, 02 Nov 2026 07:15:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BDC11FB23;
	Mon,  2 Nov 2026 07:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793603753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ByMKIBvfZhDSrda5lB4kY7Ks7hcY9F8y/GUj0feuLo=;
	b=F0LlMQ+Ry/LOPWtPCvgLgX4MN2WjfogHaqNqSba867foFYSerbcufbg7EvPPZIEZhyaQBa
	Q1KV8nDRXYM8lcE/Hps8kjz6OCrUawP/3AkESyJ0UOXxZ/mGcwpsALicA9nOoEEDxkkdS+
	+4RZMZglO7DoG6cdxcLiLdtO8b4HEK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793603753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ByMKIBvfZhDSrda5lB4kY7Ks7hcY9F8y/GUj0feuLo=;
	b=l/eKtV3KKkKKPuJkLiZydrhy1LjmqEauFTQXhNWbktgfKwwjr03na2CTqMyb9nGZJi7Usu
	buwFuKhhDK+voFCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793603753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ByMKIBvfZhDSrda5lB4kY7Ks7hcY9F8y/GUj0feuLo=;
	b=F0LlMQ+Ry/LOPWtPCvgLgX4MN2WjfogHaqNqSba867foFYSerbcufbg7EvPPZIEZhyaQBa
	Q1KV8nDRXYM8lcE/Hps8kjz6OCrUawP/3AkESyJ0UOXxZ/mGcwpsALicA9nOoEEDxkkdS+
	+4RZMZglO7DoG6cdxcLiLdtO8b4HEK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793603753;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4ByMKIBvfZhDSrda5lB4kY7Ks7hcY9F8y/GUj0feuLo=;
	b=l/eKtV3KKkKKPuJkLiZydrhy1LjmqEauFTQXhNWbktgfKwwjr03na2CTqMyb9nGZJi7Usu
	buwFuKhhDK+voFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD8A7134B3;
	Mon,  2 Nov 2026 07:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +BvoHKg46GqcYgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 02 Nov 2026 07:15:52 +0000
Message-ID: <20efc96b-c57d-4bbf-8d3d-602b8c9e5828@suse.de>
Date: Mon, 2 Nov 2026 08:15:52 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme-tcp: parallelize I/O queue allocation and
 startup
To: "Surabhi Gogte (she/her)" <sgogte@purestorage.com>,
 Martin Belanger <martin.nvme.dev@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 mkhalfella@purestorage.com, randyj@purestorage.com, adailey@purestorage.com,
 Hannes Reinecke <hare@kernel.org>, wagi@kernel.org,
 shinichiro.kawasaki@wdc.com
References: <20260922200718.3941465-1-sgogte@purestorage.com>
 <20260922200718.3941465-4-sgogte@purestorage.com>
 <705f4452-3d07-4d91-9dcd-ea53b2cd75a5@gmail.com>
 <CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <CAMof9cU5s0ck20fcSAYSvK-xpcP5_Hv2BmN20Bh3btpLum7THg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[purestorage.com,gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261101_231557_005193_86E17169 
X-CRM114-Status: GOOD (  24.14  )
X-Spam-Score: -4.4 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/26 10:25 PM, Surabhi Gogte (she/her) wrote:
> On Mon, Oct 26, 2026 at 3:57 AM Martin Belanger
> <martin.nvme.dev@gmail.com> wrote:
>>
>> On 9/22/26 16:07, Surabhi Gogte wrote:
>>   > Similar to commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue
>>   > allocation and startup"), refactor nvme tcp I/O queue setup to use async
>>   > API, combining allocation and startup into a single parallel operation
>>   > per queue. This reduces connection and reconnection setup time when
>>   > there are delays in establishing connections, which is especially
>>   > important for high-core-count hosts.
>> [...]
>>
>> Hi Surabhi,
>>
>> This patch breaks NVMe/TCP connects with TLS. This is a different bug
>> from the pf_cache_lock one that Shin'ichiro reported.
>>
>> Test: one VM with 4 CPUs, nvmet-tcp on 127.0.0.1 with tsas tls1.3, a
>> connect with --tls and 4 I/O queues, and tlshd at upstream commit
>> a0bd51d.
>>
>> - Linus master 6b4b543fa187: 14 of 20 connects fail.
>> - Same tree with this patch reverted: 20 of 20 connects pass.
>> - Same tree with Daniel's pf_cache_lock fix [1]: 22 of 40 and 17 of 40
>>     connects fail.
>>
>> On each failed connect, one I/O queue logs:
>>
>>     nvme nvme0: queue 4: TLS handshake complete, error -110
>>
>> The tlshd that runs for the target logs:
>>
>>     failed to search 'psk' key 'NVMe0R01 <hostnqn> <subnqn>'
>>     gnutls: Error in password/key file. (-31)
>>
>> and closes the connection. The tlshd that runs for the host then gets
>> GNUTLS_E_PREMATURE_TERMINATION, which it reports to the kernel as
>> ETIMEDOUT. The other queues use the same PSK, and their handshakes
>> succeed. blktests nvme/062 and nvme/063 fail the same way.
>>
>> I can share the reproducer script.
> 
> Hey Martin, can you try the tests once with tlshd using commit 3a6658e
> ("tlshd: Link the NFS keyrings per handshake instead of at startup")
> or ktls-utils 1.5. blktests nvme/062 and nvme/063 passed with this
> commit. I believe that change fixed the keyring race in tlshd
> independently. If the issue persists, let me know the reproducer
> script so I can also take a look. I saw the same errors while running
> blktests with an older tlshd version from ktls-utils 1.3.1 and
> updating tlshd worked.
> 
Ouch. That will be tricky for distros. If there is a specific commit
which requires an update to ktlshd we need to have a way to identify
that; otherwise we'll see lots of regressions where customers have
updated only one side.
Please modify the patch to work with older versions of ktlshd.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

