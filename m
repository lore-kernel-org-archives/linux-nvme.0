Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD94C07545
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 15:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=49+W0j3q9b3WYrkkDqthDI3LBTVYVb0KuDd8e/iN6eI=; b=o8L+KDdPpViXPgXjeh+6vbbPn2
	uLiiefl6fAmdhCa+nvBs9hmuheCJstvLWGkgyr04HZFOjjg6rG2fRGrtfjcWFza1jp6deh5cYtsw5
	p/2fVdNm4dtBXrjRC2+RHdZrAYYRXhHWZEuQYOkxjiewwNmhI4hnK8FPSgbm6j0GFEzqOjX8luGjl
	q1B6iHbMlkGJF+bzQXefdxKFZz4g9IjaAXj0EYLwdJ384dmQbqg3hsTHn2oWuPCd8kTYqnoCCkRW3
	eHLDq+LayUaxxKlzUnqcbm+s2bxhgm3tI8Yg6zozwCjYVOHjo5V1VwWKA36ytEs527SElBx93LpqZ
	EP31se5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvfNJ-00Ca5x-35;
	Wed, 25 Oct 2023 15:00:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvfNG-00Ca4d-0l
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 15:00:48 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93A621FF77;
	Wed, 25 Oct 2023 15:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698246040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49+W0j3q9b3WYrkkDqthDI3LBTVYVb0KuDd8e/iN6eI=;
	b=L7/9hlGNf998tFBj/dBm6BNxFOxNV3w3f3qq2dqqfNwdNaEQHM2CKl1cF5QvBl2gL0y/sv
	iUuLFD47dxRRTQ8iY0rDohXsnvjnvwzKX+9bcipt7bE8KXCorC9enM05rNOX7Lg5jT2wSc
	o44BVFQnZZxZ2SF8ofqkowgptoUXLj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698246040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49+W0j3q9b3WYrkkDqthDI3LBTVYVb0KuDd8e/iN6eI=;
	b=pdVq4gzFHLzP9JBdnp+urwhvykxNAPIXMtayaduVm8Py3KuBCm+p/0fSQq9oI37B86IYFr
	GrrY4YbAwlDY9XBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70C0F138E9;
	Wed, 25 Oct 2023 15:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 0QxRGpgtOWVtLAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 25 Oct 2023 15:00:40 +0000
Message-ID: <08007889-a2ed-4d71-8eb2-4731fd012f7f@suse.de>
Date: Wed, 25 Oct 2023 17:00:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: keyring: fix conditional compilation
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <20231025081253.113738-1-hare@suse.de>
 <20231025081253.113738-3-hare@suse.de>
 <2d945ecf-6313-488e-bed4-26d87df0f61e@app.fastmail.com>
 <4591215b-6ffa-4a74-8966-3ad0a3b9c239@suse.de>
 <24b5d8da-3804-4761-b480-69f1b5577fc0@app.fastmail.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <24b5d8da-3804-4761-b480-69f1b5577fc0@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-7.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_080046_428856_0C0F1E3E 
X-CRM114-Status: GOOD (  25.06  )
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

On 10/25/23 14:16, Arnd Bergmann wrote:
> On Wed, Oct 25, 2023, at 11:11, Hannes Reinecke wrote:
>> On 10/25/23 10:20, Arnd Bergmann wrote:
>>> On Wed, Oct 25, 2023, at 10:12, Hannes Reinecke wrote:
>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>
>>>> The keyring and auth functions can be called from both the host and
>>>> the target side and are controlled by Kconfig options for each of the
>>>> combinations, but the declarations are controlled by #ifdef checks
>>>> on the shared Kconfig symbols.
>>>>
>>>> This leads to link failures in combinations where one of the frontends
>>>> is built-in and the other one is a module, and the keyring code
>>>> ends up in a module that is not reachable from the builtin code:
>>>>
>>>> ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
>>>> core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
>>>> ld: drivers/nvme/host/core.o: in function `nvme_core_init':
>>>> core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init
>>>>
>>>> ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
>>>> tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'
>>>>
>>>> Address this by moving nvme_auth_init()/nvme_auth_exit() into
>>>> module init/exit functions for the keyring module.
>>>>
>>>> Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>>
>>> Your patch looks good to me, and I think this fixes a
>>> separate problem with missing the initialization of the
>>> keyring when the kernel has only the target driver but
>>> no host support, but it has nothing to do with the changelog
>>> I wrote above and does not fix the build regression
>>> I described.
>>>
>> Hmm. Can you send me the .config file (or the config options for NVMe
>> where there failure occurred)? I tried the configurations mentioned, and
>> it worked for me.
>> But apparently I didn't get the right combination...
> 
> Sorry if my explanations were not clear enough. The two
> broken cases can be triggered using:
> 
> https://pastebin.com/aVQ1UbTv
> CONFIG_NVME_KEYRING=m
> CONFIG_NVME_AUTH=m
> CONFIG_NVME_CORE=y
> CONFIG_NVME_MULTIPATH=y
> CONFIG_NVME_VERBOSE_ERRORS=y
> CONFIG_NVME_FABRICS=y
> CONFIG_NVME_FC=y
> CONFIG_NVME_TCP=y
> # CONFIG_NVME_TCP_TLS is not set
> # CONFIG_NVME_HOST_AUTH is not set
> CONFIG_NVME_TARGET=m
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> # CONFIG_NVME_TARGET_LOOP is not set
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> CONFIG_NVME_TARGET_TCP=m
> CONFIG_NVME_TARGET_TCP_TLS=y
> CONFIG_NVME_TARGET_AUTH=y
> ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
> tcp.c:(.text+0x1099): undefined reference to `nvme_tls_psk_default'
> 
> and
> 
> https://pastebin.com/jXQ71vn9
> CONFIG_NVME_KEYRING=m
> CONFIG_NVME_AUTH=m
> CONFIG_NVME_CORE=m
> CONFIG_NVME_MULTIPATH=y
> CONFIG_NVME_VERBOSE_ERRORS=y
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_FC=m
> CONFIG_NVME_TCP=m
> CONFIG_NVME_TCP_TLS=y
> CONFIG_NVME_HOST_AUTH=y
> CONFIG_NVME_TARGET=y
> # CONFIG_NVME_TARGET_LOOP is not set
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> CONFIG_NVME_TARGET_TCP=y
> # CONFIG_NVME_TARGET_TCP_TLS is not set
> # CONFIG_NVME_TARGET_AUTH is not set
> ld: drivers/nvme/target/configfs.o: in function `nvmet_ports_make':
> configfs.c:(.text+0x13b8): undefined reference to `nvme_keyring_id'
> 
> The problem is the same in each case: one of the two callers
> (target or host) is set to =m and enables keyring support, while
> the other one is built-in but doesn't use the keyring. This
> leads to the keyring code being built as a loadable module, but
> include/linux/nvme-keyring.h contains broken stub functions
> that lead to it still getting referenced from the built-in
> code.
> 
Ah. RTFM.

'IS_REACHABLE' is the keyword here; if we use that in nvme-keyring.h
things are resolved.

Will be sending an updated patch.

Cheers.

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


