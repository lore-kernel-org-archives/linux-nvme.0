Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4151AC4167D
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Nov 2023 10:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4LND6pygnTiRuGktVfN0qPhX33LLpGay79d++fXYO8g=; b=siRNjIrbcwZ4cGh7eg7rLFW1s6
	VZH5LmchJLJUEijiRnjwugDRZC/O9Hbo3pixZtNFSWfG00D/58IA7ZOVSbb3DH0V3YKrCTZ8wvCwR
	+C1SSGTpKkWuiCwIiaopLEXVTIIAdZJ15gNP2WLDHUj10ssaDTy9ni8Wq6N+PURr73RPjW9xn5LmK
	fA7Ss2mw41KnhEZpG0JHquPJOnuW0PoNMd5/HBW47jwQSgG5ljuk1JpSfCyD1rCSIA8iixaaxuyuM
	AGXnZlAOf/fYFVjzidLsVsdQErT5nDkqBfIV3ngPW9nOwMOzU2MJkREuVMTRMs3musfpe/G5IVnA3
	paKOunZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8XD-007CFM-21;
	Wed, 01 Nov 2023 10:33:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qy8X8-007CEd-14
	for linux-nvme@lists.infradead.org;
	Wed, 01 Nov 2023 10:33:14 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2078A1F750;
	Wed,  1 Nov 2023 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698834789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LND6pygnTiRuGktVfN0qPhX33LLpGay79d++fXYO8g=;
	b=qRa/2X7F0+04i75mZxJSYU/ccJu7yvxsYkToFOd9mxFkxJgQ/q5Z69oe4wU3zHHDWE192n
	2E8b5KB1t+atv+4IrnV4hbkqlj3Kx6oKvwMy8Y2M89Grhukdzi+qY8yuxOsKH+cA/DtnpW
	RQMISgXB4dXtZ8kKfESP2TSxbou6ap8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698834789;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LND6pygnTiRuGktVfN0qPhX33LLpGay79d++fXYO8g=;
	b=fSCPunYTrUVc4h4OaOPu3mLpuu0hXreTUQhcHxQ9XgDGAxw6bbsD2QJ1onZF7MMvSV81pg
	/5hpAK3oIb+tKyAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC33D1348D;
	Wed,  1 Nov 2023 10:33:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 76X5M2QpQmUdIwAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 01 Nov 2023 10:33:08 +0000
Message-ID: <d1d179ea-ae0f-497a-a2af-f1c60cf90362@suse.de>
Date: Wed, 1 Nov 2023 11:33:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests failures with v6.6
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <6qycihftrxsdvuvpsvmkbe2swy5u2isrtu6jiyf3khzusdzilc@34kda7iutwdq>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <6qycihftrxsdvuvpsvmkbe2swy5u2isrtu6jiyf3khzusdzilc@34kda7iutwdq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231101_033310_512880_93A3F576 
X-CRM114-Status: GOOD (  12.48  )
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

On 11/1/23 05:09, Shinichiro Kawasaki wrote:
> Hi all,
> 
> I ran the latest blktests (git hash: 3f75e6241f6b) with v6.6 kernel, and obseved
> four failures below. They are all known for months.
> 
> As for the two other failures observed with v6.6-rc1 kernel [1], they are no
> longer observed with v6.6 kernel. Good.
> 
> [1] https://lore.kernel.org/linux-block/u4g3jh6dnowouthos3tdex2pflzo3hat55e5dc4j6pul3a3uov@y2axtbiura2q/
> 
> List of failures
> ================
> #1: block/011
> #2: nvme/003 (fabrics transport)
> #3: nvme/* (fc transport)
> #4: srp/002, 011 (rdma_rxe driver)
> 
> Failure description
> ===================
> 
> #1: block/011
> 
>     The test case fails with NVME devices due to lockdep WARNING "possible
>     circular locking dependency detected". Reported in Sep/2022 [2]. In LSF
>     2023, it was noted that this failure should be fixed.
> 
>     Also, it was found recently that this test case still causes failure of
>     following tests. Fix work is ongoing [3].
> 
>     [2] https://lore.kernel.org/linux-block/20220930001943.zdbvolc3gkekfmcv@shindev/
>     [3] https://github.com/kawasaki/blktests/commit/f540cbb0eeb66e2c76a88efbe65a2b59d55630fd
> 
> #2: nvme/003 (fabrics transport)
> 
>     When nvme test group is run with trtype=rdma or tcp, the test case fails
>     due to lockdep WARNING "possible circular locking dependency detected".
>     Reported in May/2023. Fix discussions were held [4][5].
> 
>     [4] https://lore.kernel.org/linux-nvme/20230511150321.103172-1-bvanassche@acm.org/
>     [5] https://lore.kernel.org/linux-nvme/5cb63b10-72ab-4b7c-7574-48583ea8ffd1@grimberg.me/
> 
Just send a patchset which should resolve these issues.
Can you test with them?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


