Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BB7EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 07:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uJ5+krcFOD6uk8iA6AsYKB1pZuS84JL0MRygTgZC7ZM=; b=1pVDWz/fneyJK97p9O67xxp87F
	G9iGYhaVQGjmOs14VL/hCzwRPugCASAjvLb0pTgqU2ridF/siazHWZ1QCX6oZ7ERvtVsZsADIKXd1
	rIKFtQyatOKvUIiKEkGoHFyKhmeFX1K6n4mesdHVEaeUPyImW9uVZd8mugToh5kWmpSwCAi+k/EMW
	bm1m/Rs3xQGBbtkxkOXueU7I4gHJGiJ/mJCsxOIxSTsG0Tdbmd+jr04OM5KVMm9eSX83bTuPz8k+s
	2/e1ojI/ZoqHFwMZGJhbs4ONvDoJTEyI1PN/6hgpbGqH3us6+F6MXrLeLcWWRKRMutT+yuMfHWpfI
	9iW8KM5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osfly-00BlHo-BD; Wed, 09 Nov 2022 07:45:22 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osflq-00BlEe-Tq
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 07:45:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7DC9122470;
	Wed,  9 Nov 2022 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1667979913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJ5+krcFOD6uk8iA6AsYKB1pZuS84JL0MRygTgZC7ZM=;
	b=nMuD+BSsOGVFL/gnie16wJLFc0zYGJzvjsCJg7U6WyeSA63gIr607tpzdhMO1ri5vKYDhh
	JO5oHeC0Ba617ofDww3u83sp044KKV8nuwCM/baqpekTFSJzhqOw8y2YJt2biahVyE9ZKW
	azBG4Z76qDPf6EWLxDQGFID3siimQrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1667979913;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uJ5+krcFOD6uk8iA6AsYKB1pZuS84JL0MRygTgZC7ZM=;
	b=bGvGIEyMPwkC35BKC1febw2t0V/M5v0/F9v1pSU/rOnRk/8InkFi2rpzpThORhHFWtGLUW
	w/NltHxn8TXP2WCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4EC19139F1;
	Wed,  9 Nov 2022 07:45:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GtBBEolaa2MsPAAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 09 Nov 2022 07:45:13 +0000
Message-ID: <aa6e36e7-dff6-49c2-bff4-af924b8f2eb6@suse.de>
Date: Wed, 9 Nov 2022 08:45:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 00/16] nvme: rework dhchap authentication host code
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221109034420.1000086-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221109034420.1000086-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_234515_126622_4AA587C3 
X-CRM114-Status: GOOD (  18.97  )
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

On 11/9/22 04:44, Sagi Grimberg wrote:
> Currently the authentication code is fairly fragile with respect to
> mutual locking between secrets sysfs override, re-authentication, and
> controller resets.
> 
> This patch set attempts to resolve these issues by:
> 1. freeing queue chap context as soon as authentication completes
> 2. allocates a simple vector for queue chap contexts so there is
> no list/tree traversal to resolve queue chap context. queue chap
> contexts are 1x1 mapped to queues, which are stored in a vector as
> well.
> 3. flush chap auth_work from the ctrl dhchap work, this simplifies
> how we flush inflight authentication sequence
> 4. use ctrl dhchap_auth_mutex to protect only the resources that are
> accessed and modified via sysfs and the authentication flow (i.e. ctrl
> host_key and ctrl_key)
> 5. move drivers (rdma/tcp) nvme_auth_stop later in the error recovery
> flow to expedite failover and not block on I/O.
> 
> 
> Feedback is welcome.
> 
> Sagi Grimberg (16):
>    nvme-auth: rename __nvme_auth_[reset|free] to
>      nvme_auth[reset|free]_dhchap
>    nvme-auth: remove symbol export from nvme_auth_reset
>    nvme-auth: don't re-authenticate if the controller is not LIVE
>    nvme-auth: remove redundant buffer deallocations
>    nvme-auth: don't ignore key generation failures when initializing ctrl
>      keys
>    nvme-auth: don't override ctrl keys before validation
>    nvme-auth: remove redundant if statement
>    nvme-auth: don't keep long lived 4k dhchap buffer
>    nvme-auth: clear sensitive info right after authentication completes
>    nvme-auth: remove redundant deallocations
>    nvme-auth: no need to reset chap contexts on re-authentication
>    nvme-auth: convert dhchap_auth_list to an array
>    nvme-auth: remove redundant auth_work flush
>    nvme-auth: have dhchap_auth_work wait for queues auth to complete
>    nvme-tcp: stop auth work after tearing down queues in error recovery
>    nvme-rdma: stop auth work after tearing down queues in error recovery
> 
>   drivers/nvme/host/auth.c | 209 ++++++++++++++++++---------------------
>   drivers/nvme/host/core.c |  26 +++--
>   drivers/nvme/host/nvme.h |   5 +-
>   drivers/nvme/host/rdma.c |   2 +-
>   drivers/nvme/host/tcp.c  |   2 +-
>   5 files changed, 121 insertions(+), 123 deletions(-)
> 

For some reason I'm missing parts of this patchset (patches 1, 4, 8, 10, 
and 12); have they been eaten by my mailer?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


