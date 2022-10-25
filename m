Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58414C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EtB/jv1F20UUMEa3BGPhBgt5BbXyukInOKiqzUuHmHI=; b=ePj/2197y8WWiN1aavYi+IVtMY
	8DIiAzju4YLnNBkT7ZysI0/2rvdQ3PvgrEyewg8nQPDFoOfh0cEYd4NB1FKts4Y5LuykAP1VOi8tQ
	6cx/cLnTJT1yzN7ntTHDtZ+nkU+OSt+04lsVmbriSG9mIPBIEpNt2C6k9y0A71dcmJYrou/gph7Is
	2jmu5XZVJrAg49BGTPKQkwnjkS/PTQHqneWFgcN/iPz2n8435L/uGvKnelvOz1lerc5OlT8VA+p+c
	9Rq+gh+XEcPnV+De0MqhkkzaUk/4WCzMjozx7t3GNE0dA4I7hnHDkT7rbpHepZmi9W1W1+h/ZGULC
	Vm+K3W4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNfU-006S4M-OE; Tue, 25 Oct 2022 17:24:48 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onNfQ-006S2N-4j
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 17:24:46 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC73D1FA17;
	Tue, 25 Oct 2022 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666718682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtB/jv1F20UUMEa3BGPhBgt5BbXyukInOKiqzUuHmHI=;
	b=GMANHca3XUihImano+IRRIuXse4UThvuSe5e15ScwjiDi3aZv7GqXySlk3OxEuyveYZSPg
	HCzZ+bRa+uqqUxGtEG2RT0wXS2haf4YrNL3suAcwKJxO2ohO3qgb3yV2mnK62r9ZFMEVii
	sebWW6WQ5PtKZYM3oteHrzGHEhZmGAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666718682;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtB/jv1F20UUMEa3BGPhBgt5BbXyukInOKiqzUuHmHI=;
	b=A0w3xFrilC9EbPkwiRzC+ohU+VQhuUp0JpaiQ3RwH7Rsn4SgV4nX56Kghel+wrabec9Q8x
	j9Isn/fHzXFi7kCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FC7F13A64;
	Tue, 25 Oct 2022 17:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id uR5vItobWGOtNwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 25 Oct 2022 17:24:42 +0000
Message-ID: <dd16d623-db54-d6a5-9805-cddce7ca2702@suse.de>
Date: Tue, 25 Oct 2022 19:24:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5/6] nvme-auth: don't ignore key generation failures when
 initializing ctrl keys
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221025134330.1028352-1-sagi@grimberg.me>
 <20221025134330.1028352-6-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221025134330.1028352-6-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_102444_387628_24BD4581 
X-CRM114-Status: GOOD (  11.14  )
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

On 10/25/22 15:43, Sagi Grimberg wrote:
> nvme_auth_generate_key can fail, don't ignore it upon initialization.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 19 +++++++++++++++----
>   drivers/nvme/host/core.c |  6 +++++-
>   drivers/nvme/host/nvme.h |  2 +-
>   3 files changed, 21 insertions(+), 6 deletions(-)
> 
That was actually deliberately, as dhchap keys are optional, so wasn't 
sure if a failure in parsing/generating keys should count as a 'real' 
failure. But if you say so:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


