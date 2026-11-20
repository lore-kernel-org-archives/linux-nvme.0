Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8AD60A2607
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=N5KXugBY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dDEjbcW/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8fHNiIKo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AoeH96Jr;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=CfKzjquU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3N7EAXncKH0sA4VsDCLzFX95jj/ZIvXGk/9mkj/eaPc=; b=N5KXugBYzfJlqz
	nfOUEiD10ODI/raOVl/hHQPgQBfigLMQx22AXBn3Re0uDSDKgJ022K+U0JO4pa7OPamB91Y0hj/kd
	dxxFBZAUzWlDPFHQOgZGm4miWFnLlBeWjh2OtFo/AEU1vwGWbL4lOflK6wBYUrQezPWj+AZ/UwClX
	XoFCS5ouKKxsvDryhRgzNSUTRNHCncxJqcRQo+gEVQl80C2d3ecv3iqHVpHD3m6mqLmLv9vZttrYx
	PEId4gGQAcv3T2C971m7+Paa3+jS7JfBgwrDqhgMAgIMyGTqq/OQ8roBLxf1Tf8JykFngovNYNKWn
	OIaFQi1sH1JxbcGEat6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMkW-0000000Eme0-08Ua;
	Fri, 20 Nov 2026 11:25:48 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMkS-0000000Emd0-05jR
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:25:46 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 61F1B22409;
	Fri, 20 Nov 2026 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N7EAXncKH0sA4VsDCLzFX95jj/ZIvXGk/9mkj/eaPc=;
	b=dDEjbcW/BND5lINXY+ao0zWkdRJJtOoBK7w0lia3T0SuTOYMLLdy3idIiRMcqKRMeXB4R8
	6WlO3PeAW0lM8e2rlCGWRkhxdksuYWPwmzbB16ePhZcLXh3bC+IcoPiGl1rvL6ZQAN3lwc
	yrkP2EXI6NPX05BWrCX52hIa33raAQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N7EAXncKH0sA4VsDCLzFX95jj/ZIvXGk/9mkj/eaPc=;
	b=8fHNiIKopCi6cDSNIpMaomXpEbMAaQEcEyZJOrCWJbvWDL70ER1eFuj+pnhEHocZW2CuyP
	55TcvjYY5BsEVAAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795173941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N7EAXncKH0sA4VsDCLzFX95jj/ZIvXGk/9mkj/eaPc=;
	b=AoeH96JrbbKfP8xYxo1pRHdrvpGnmsXjmBa3gk0RxbWf6lcf9y0j5tAFo7WD6u6gy/4dnF
	1sj+xWwt/roXXMvwUgv+bUnFY+OS4KBtvsch9BlacqOcTljve3GKXKQASku6xazQa7U3xH
	jlT28U3j0PgjZQ3REMNJTX/fjPjhuLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795173941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3N7EAXncKH0sA4VsDCLzFX95jj/ZIvXGk/9mkj/eaPc=;
	b=CfKzjquU/Sh5OJq7GOmzexAZnp4A+13sXpeGUr9C4tktUPbvEHxBSpBJ5ty8euQzQhK+gT
	C90Qd0qfVBxHaRAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 320E71342D;
	Fri, 20 Nov 2026 11:25:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vlsEAzUuAGt+bwAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 20 Nov 2026 11:25:41 +0000
Message-ID: <8fa5891f-aba9-47a8-9279-2fac66327edc@suse.de>
Date: Fri, 20 Nov 2026 12:25:40 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 0/9] nvme: make NVME_TARGET_CONTROL work with
 remote targets
To: Daniel Wagner <dwagner@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.29
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261120_032544_443182_A2DF7116 
X-CRM114-Status: GOOD (  29.13  )
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 10:26 AM, Daniel Wagner wrote:
> Hi all,
> 
> this series makes running the nvme tests against a remote target with
> NVME_TARGET_CONTROL actually work. The first six patches of v1 have been
> applied, this is the rest. It applies on top of the series that makes
> tests skip when a program they need is missing.
> 
> The first two patches are fixes: nvme/047 looks up the namespace again
> after reconnecting, and the nvmet target picks free service IDs for its
> ports. The third is a cleanup, nvme/042 and nvme/043 iterate over the
> DH-HMAC-CHAP hashes by name.
> 
> The remaining patches let tests skip instead of failing when the remote
> target lacks a feature they need, including the DH-HMAC-CHAP hashes and
> DH groups the target doesn't support, add port and host key support for
> remote targets, and add a NetApp ONTAP target as an example of a target
> that can do less than nvmet.
> 
> Tested against nvmet in a second VM, which also exported other
> subsystems on its own ports, and against a NetApp ONTAP array. All tests
> that can run against a remote target pass, except nvme/077 against
> nvmet, which checks attr_qid_max in the local nvmet configfs. Against
> the array, nvme/061 and nvme/070 fail because it refuses the reconnect
> after a subsystem is deleted and doesn't support Identify CNS 07h, and
> nvme/068 because the host runs a 6.4 kernel. The tests that need the
> kernel target still pass with the local target.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> Changes in v2:
> - Drop the six patches that were applied.
> - Fix nvme/047 to look up the namespace again after reconnecting.
> - Pick free service IDs for new nvmet ports.
> - Pass the TLS option in the argument array instead of an unquoted
>    command substitution; quoting it would pass an empty argument without
>    TLS. (Shin'ichiro)
> - Check the features with =~, with an SC2076 exception for the literal
>    match. (Shin'ichiro)
> - List the DH-HMAC-CHAP algorithms a target supports, iterate over them
>    by name in nvme/042 and nvme/043 and skip the ones the target lacks.
> - Put the fixes first, then the cleanup, then the features.
> - Depend on the series that makes tests skip when a program is missing.
> - Link to v1: https://patch.msgid.link/20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de
> 
> ---
> Daniel Wagner (9):
>        nvme/047: look up the namespace again after reconnecting
>        contrib/nvme-target-control: pick a free service ID for new nvmet ports
>        nvme/042, nvme/043: iterate over the DH-HMAC-CHAP hashes by name
>        nvme: skip tests that need a feature the remote target lacks
>        contrib/nvme-target-control: list the DH-HMAC-CHAP algorithms
>        nvme: skip the DH-HMAC-CHAP algorithms the target doesn't support
>        common/nvme: support the ports of a remote target
>        nvme/rc: change the host keys on a remote target
>        contrib/nvme-target-control: add a NetApp ONTAP target
> 
>   Documentation/running-tests.md                     |  49 ++-
>   common/nvme                                        |  88 ++++-
>   contrib/nvme-target-control/README.md              |  72 +++-
>   .../nvme_target_control/target.py                  |  19 +
>   .../nvme_target_control/targets/nvmet.py           |  12 +-
>   .../nvme_target_control/targets/nvmet.sh           |   7 +-
>   .../nvme_target_control/targets/ontap.py           | 397 +++++++++++++++++++++
>   contrib/nvme-target-control/tests/test_ontap.py    | 357 ++++++++++++++++++
>   .../tests/test_target_control.py                   |   4 +-
>   tests/nvme/031                                     |   1 +
>   tests/nvme/041                                     |   1 +
>   tests/nvme/042                                     |  12 +-
>   tests/nvme/042.out                                 |   8 +-
>   tests/nvme/043                                     |   9 +-
>   tests/nvme/043.out                                 |   6 +-
>   tests/nvme/044                                     |   1 +
>   tests/nvme/045                                     |   1 +
>   tests/nvme/047                                     |   2 +
>   tests/nvme/057                                     |   1 +
>   tests/nvme/062                                     |   1 +
>   tests/nvme/063                                     |   5 +-
>   tests/nvme/rc                                      |  58 +++
>   22 files changed, 1069 insertions(+), 42 deletions(-)
> ---
> base-commit: 79c32fb31b7bca6a4383b749030128683cf6b6b4
> change-id: 20261104-nvme-target-control-f0b239e68b29
> prerequisite-change-id: 20261117-skip-missing-deps-30b4084698c4:v1
> prerequisite-patch-id: 9478a4106d922c8432a4d297dcb18ed68a9c8d61
> prerequisite-patch-id: 635fcb82ae72c78b84ad593a58d82315a166724d
> prerequisite-patch-id: 528ad89bda84f0b0d9cbc0d38b6e1384332f86cd
> prerequisite-patch-id: 2758a16b44a326eea5113ff4967e6093ad42e71c
> prerequisite-patch-id: 9acbf0ff52b0b46035e4635035662cd9d9309f77
> 
> Best regards,
> --
> Daniel Wagner <dwagner@suse.de>
> 
> 
Very nice, thank you!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

