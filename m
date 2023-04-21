Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6206C7618E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8LMGs8OgZhTiQIL7If/TwogM3aMQ0ZAQ/vhVCy32mQY=; b=pzD6beAE2sJFzwW4mbhCLxWx2X
	hBnkAkYzIXDKgyeoZTl/rv+6KmLBI43qW3hLJA4BRu++SyHB1gATR+cc3oW61FPhFJ6AgjvQxFEfr
	SYl+PzUWVeGXWt9LspBzaOSynuqrrH0aBrIk2/SIr9EE5NTZ8mP4P1K68o5gJ5a6wY2RHkfI2b1gC
	dfWFh/bC6QizBuykOZXEJaeiqwwRTVAifJZdrJ/PEocJWRqidd9xwb7p7Xec+ExejzZ818p0qNrMd
	MKD/LDNCAL9Fwg6y8sM8R2unTjwKSDUoww9m7frMkL2jWvZV4r8NFtqVP0ABxZ6Zic26JY7d5gPT6
	7RB+IhWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkGt-009pGN-1B;
	Fri, 21 Apr 2023 06:29:27 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppkGr-009pFf-1P
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:29:26 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 090FA1FDDD;
	Fri, 21 Apr 2023 06:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682058564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LMGs8OgZhTiQIL7If/TwogM3aMQ0ZAQ/vhVCy32mQY=;
	b=0inpvk1NXaNGsFqI8R/9/QqQkeZZEbDsL9KIr++c78m4EuQ7tD6emwfIYogouqsqqHwOSZ
	NKz61VnyEgMrGsV/unZt4UPyQSGellfBsYod2flI/r/VVzMbAPUFntR9ulS0H0FC0DICVz
	TIAF5wILUW8QAp5GqumcIgBMr1KnNHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682058564;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8LMGs8OgZhTiQIL7If/TwogM3aMQ0ZAQ/vhVCy32mQY=;
	b=EfWmB8SfH3AIi4iI+n1CZoyVVOUXfMb7WAZeu0Lpv6l2M8enbwqPTSDkrU9jYajhPYl+hS
	ZNjfhzlMstLZtADg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D960B1390E;
	Fri, 21 Apr 2023 06:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EF8hNEMtQmREcQAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 21 Apr 2023 06:29:23 +0000
Message-ID: <72ecc5fc-0ff4-5592-3293-f4204633fc8e@suse.de>
Date: Fri, 21 Apr 2023 08:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH REPOST blktests v2 4/9] nvme: Use runtime fio background
 jobs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>
References: <20230421060505.10132-1-dwagner@suse.de>
 <20230421060505.10132-5-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230421060505.10132-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_232925_616065_C8C8E3B4 
X-CRM114-Status: GOOD (  14.58  )
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

On 4/21/23 08:05, Daniel Wagner wrote:
> The fio jobs are supposed to run long in background during the test.
> Instead relying on a job size use explicit runtime for this.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/032 | 2 +-
>   tests/nvme/040 | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/nvme/032 b/tests/nvme/032
> index 017d4a339971..81e074cc11bc 100755
> --- a/tests/nvme/032
> +++ b/tests/nvme/032
> @@ -39,7 +39,7 @@ test_device() {
>   
>   	# start fio job
>   	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
> -		--group_reporting  &> /dev/null &
> +		--group_reporting --time_based --runtime=1m &> /dev/null &
>   
>   	sleep 5
>   
> diff --git a/tests/nvme/040 b/tests/nvme/040
> index 04bd726cd309..8d29f905adb5 100755
> --- a/tests/nvme/040
> +++ b/tests/nvme/040
> @@ -38,7 +38,8 @@ test() {
>   	# start fio job
>   	echo "starting background fio"
>   	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
> -		--group_reporting --ramp_time=5  &> /dev/null &
> +		--group_reporting --ramp_time=5 \
> +		--time_based --runtime=1m &> /dev/null &
>   	sleep 5
>   
>   	# do reset/remove operation

Wouldn't it be better to let _run_fio_rand_io pick the correct size?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


