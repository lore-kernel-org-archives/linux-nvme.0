Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1C1C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SSAJDdMzVrkNY+RUZWcnYI/jXA0BbPfAn5/l62DandE=; b=LicuhDA6zVpxeMHrm+lxUNZnVF
	TpEHJk/GryES5UDasnfn+KK0HZJkh475OyCxTp3q1kTW/oST6/7OelaLsszdjsP2P75NTtuIrOlLa
	V9zWATtivucH8FwBz4CaRX3Zv1LN+X8KcxWU3TLhEJRffE5PgeVDiEEWe51H0y9DfNe789otPCc/+
	9f3E9JYUrzS+DuZrLfe+d9t4ZEq1c21G9rrASHUYSvGY+taw/cznypusfA+FKTEwyHMIGBJIyudDM
	3YJK6gzrRs2H69mPUHsNat/bvJUKNFEOQk20HmbhsGRsp3quz3zAghpnnaDtR7sK4YQixGFg91ead
	tywczecg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qypvY-00B0kK-0S;
	Fri, 03 Nov 2023 08:53:16 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qypvT-00B0jF-0W
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 08:53:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586081FD6D;
	Fri,  3 Nov 2023 08:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699001586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSAJDdMzVrkNY+RUZWcnYI/jXA0BbPfAn5/l62DandE=;
	b=CFCiOPi/1etiaBsO3zhP4hRqNOSOVw1KKqgaYm0y4YWa6kkE8qlnkqWF8SK1erGJ6NnUxF
	5i/kROBTJ2TbWg+Sr13y1+EsO2EFHHoYL5SMNoAhs0J7HpTiNl6Y3zFhGzyUqPz/QitAlZ
	NYaIiT+fAactN4OpI+XHbaLV7YXMDNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699001586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSAJDdMzVrkNY+RUZWcnYI/jXA0BbPfAn5/l62DandE=;
	b=lF13yqz6byLm3RglNFEt8BcqiEosN18n6OYQCRiIiob4gDasHccZXjPGggUB31fd8vLqzx
	SR6yGZ3tQzo6iODA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3BB081348C;
	Fri,  3 Nov 2023 08:53:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id qDgADPK0RGXaYwAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 03 Nov 2023 08:53:06 +0000
Message-ID: <69b6f873-f8a1-482b-a739-b47da6e98cec@suse.de>
Date: Fri, 3 Nov 2023 09:53:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet-rdma: avoid circular locking dependency on
 install_queue()
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231102141903.66515-1-hare@suse.de>
 <20231102141903.66515-2-hare@suse.de> <20231103082305.GA17096@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20231103082305.GA17096@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_015311_356776_46B0EC79 
X-CRM114-Status: GOOD (  13.17  )
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

On 11/3/23 09:23, Christoph Hellwig wrote:
> On Thu, Nov 02, 2023 at 03:19:02PM +0100, Hannes Reinecke wrote:
>> nvmet_rdma_install_queue() is driven from the ->io_work workqueue
>> function, but will call flush_workqueue() which might trigger
>> ->release_work() which in itself calls flush_work on ->io_work.
>>
>> To avoid that move the check for any pending queue disconnects
>> to the 'install_queue()' callback. This replicates what the tcp
>> code is already doing, and also allows us to return a
>> 'controller busy' connect response until all disconnects
>> are completed.
> 
> So what are hosts going to do when they see NVME_SC_CONNECT_CTRL_BUSY?
> 
> I see no special casing for it in our host side code.

Retry? The DNR bit is not set, so the default action should be to retry.
And the idea is that this condition is a very short-lived one anyway.
No?

Cheers,

Hannes


