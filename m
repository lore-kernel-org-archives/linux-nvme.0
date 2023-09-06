Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 082EAEB8FAF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 11:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEhZLs28XrtzbeHNH5m9hWydfq2viKWA6DpN3YBcPKM=; b=ggSdzGXrdaA+ReyzhjH0HQnP96
	UPYvD7M1ZKUJLEA2GqR9/PmQ3SwgvN2GcgqNn5455wejvj7ovkGFXu9ad50HgT39LF7UP+jx5FKyI
	lHwqKd3SKTJ+O0s3nuT4SFgn6+cSDczcm4iV4HG9VuMiJIObRTqcfCXFDMJCF7afGFUglwtCXtvuk
	dSv1O03A7pwh2M701MTAaxw0tvMrHrbyVLq3Va2bFoixPRpQRyEf7q4/0OU7dM1bcsWzwQE8GZR7T
	473Ktcx14SLKl60MtGYzvL02HzFkOfpn17t/6pvCwLcWhpUxh3tw6Kp2vXcHwwkMVTzdDKimCeTyz
	xiRE/ZWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qdqWB-008asm-1t;
	Wed, 06 Sep 2023 11:16:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qdpOj-0083tZ-0d
	for linux-nvme@bombadil.infradead.org;
	Wed, 06 Sep 2023 10:04:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=eEhZLs28XrtzbeHNH5m9hWydfq2viKWA6DpN3YBcPKM=; b=hTH5EOge75xNM0EIw66vMZn0AD
	H2JOvtgyD4RrRNvZ5z/BE/ptq06A3m+jKhX0u6jWWXTssitN1jd5cdhJRVAac493Sz8oVTbg0DihP
	uJqkG+5oCEgfc1JA6Ux3gtufEH+Wbl2XGroV7/5L8nlGCf55kFrJSOpnAeCuyDBZFOY+b+zCDHF2e
	JAa8LSNZWpMm7RzSHrI4HniXGbSZIAj4L/2rSND+z+IYSbTQpn6HfAS5ZUCQ6vGm/9xdBMQZSEo0G
	uvZwEiWhFNFh9Xrkh5UyWyovHvjCpKlI9dP82V8FH087fi3bQb9e14ViO325hWayln2l6DFZhSP2+
	aEIAByjw==;
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by casper.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qdpOc-001M7c-Ab
	for linux-nvme@lists.infradead.org; Wed, 06 Sep 2023 10:04:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6E61E2243D;
	Wed,  6 Sep 2023 10:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1693994661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEhZLs28XrtzbeHNH5m9hWydfq2viKWA6DpN3YBcPKM=;
	b=F7hadKM5TmoR23+SN68/guBFiBn99xIXCC3GxZiAzUxGjVxuWijNHepogWbn+QjTkHUGux
	y3PNGIn1qFwjaCZpTWE7+jNUOaaRT0AbufoI9YtlX7TtvRhrRoYY919a0X6WUGnjL2o4Qa
	JMt0tJkMj7zvWUohgpRMr7Zcqi9Eruc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693994661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEhZLs28XrtzbeHNH5m9hWydfq2viKWA6DpN3YBcPKM=;
	b=CY027yRx9u7vMIqmUK7WtYJA66P8TO0visGHwQ/VwoM2rxSh3oy5W6TfTuj1InF80zQMqb
	3JUuR1OL1jFxMYBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5CB5D1346C;
	Wed,  6 Sep 2023 10:04:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 2Ot4FaVO+GR1IwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 06 Sep 2023 10:04:21 +0000
Message-ID: <0e3fe3f6-3d14-4117-bff7-093b1b2edde2@suse.de>
Date: Wed, 6 Sep 2023 12:04:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv11 00/18] nvme: In-kernel TLS support for TCP
To: Pawel Baldysiak <pawel.baldysiak@dell.com>
Cc: linux-nvme@lists.infradead.org
References: <20230824143925.9098-1-hare@suse.de>
 <20230906084840.3710977-1-pawel.baldysiak@dell.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230906084840.3710977-1-pawel.baldysiak@dell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_110426_552449_29E94794 
X-CRM114-Status: GOOD (  11.55  )
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

On 9/6/23 10:48, Pawel Baldysiak wrote:
> Hi Hannes,
> 
> I'm testing v15 patchset in extensive way and observing that it is not stable.
> I'm running it on two connected machines - one is used as a host, second as target.
> Once connected I'm running I/Os with dd.
> Eventually I got I/O timeouts from nvme layer on host,
> causing connect/disconnect loops and I/O hung.
> Does not matter if the workload is reads or writes.
> 
Do you have the kernel message log here?
It _might_ be that we're overloading the TLS stack, such that processing 
of individual packets is taking too long and triggering a KATO.

> Second test is connect/disconnect loops.
> On disconnect I've got ocasional delays due to nvme commands timeouts.
> The disconnect happens eventually, but first it need to hit timeout.
> 
Again, do you have message logs?

> It is not happening if TLS is disable.
> 
> Are you performing similar tests on you setup? Are you observing the same?
> 
Yes, but probably not as exhaustive as your tests.
Need to create the testcases for blktests, now that the cleanup from 
Daniel is nearing completion.

Cheers,

Hannes


