Return-Path: <SRS0=Lvqr=QB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EF6C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 13:38:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CFB960F55
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Nov 2021 13:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4CFB960F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RPZ52bT4dGMa1yg32eHCi12SCyzT9GM58BpZ8eE3IoU=; b=GOgq2i1UdFxkt673w8CUfHCkFo
	leOX9TV4RtMOFpy10zsZ45wop0DYM+FDVQJUB+KpPwkzcfWQg+EJn2XpwRIcagaBAi1R2bVjKy1dU
	m/cWVMPGWz5TdmY7gewz2jrAnQG+ST+zEHYl5fNmFgP6CRmc+W/CyOVVLZ+VwsP9lPGutzz9UGexT
	oOVt2+HPxI0yKBdwCjkgkW5xcm043LXSgIDhXd07h0yNr0GbSP/UoWPjUtiJFsdpVQPIb12ZLsIE1
	iV76M8bzCjJ60rMkPrB0b2mgjk3et9oQxLcfplZMn8LternMFao2EpjaDgH5LLfGLSbSt3enX1YMk
	buRRul9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmFiM-00DhaN-IA; Sun, 14 Nov 2021 13:38:34 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmFiJ-00Dha3-TO
 for linux-nvme@lists.infradead.org; Sun, 14 Nov 2021 13:38:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07D1D218F8;
 Sun, 14 Nov 2021 13:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636897108; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPZ52bT4dGMa1yg32eHCi12SCyzT9GM58BpZ8eE3IoU=;
 b=VOkP1F0lNYg2J9Svl0SVUTjfe58QZZTcVqcb/qBlTdizpz1yWEN6qcOteDvN0QyVDz6qk4
 gz0/zSBnZvN6j2IYfyDUgvYIozC/mPlHPOjaFQp3I+FfPx4y4zDjIxANzkJVuIbxR2dvIu
 Po8JevGVBa2IVV3ws6Kt3ORUep2PD7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636897108;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RPZ52bT4dGMa1yg32eHCi12SCyzT9GM58BpZ8eE3IoU=;
 b=7VaAsnWx9B/PNeQIpdX7Rr+QKACSjIxt8YOmsIjC2GAEPFVaXUT9EEX0IlVJ17j0CBaPXR
 t616R8YpZ5myMSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C55C513A98;
 Sun, 14 Nov 2021 13:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gNvULlMRkWE3VQAAMHmgww
 (envelope-from <hare@suse.de>); Sun, 14 Nov 2021 13:38:27 +0000
Subject: Re: [PATCH libnvme] Implement 'dhchap_key' host and controller
 attributes
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
References: <20211112130053.97493-1-hare@suse.de>
 <550af202-0a01-63dc-0c71-ee893d880cad@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <32923fc4-a5e0-2731-cc06-da2211e5be69@suse.de>
Date: Sun, 14 Nov 2021 14:38:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <550af202-0a01-63dc-0c71-ee893d880cad@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_053832_145646_535D6F6A 
X-CRM114-Status: GOOD (  19.96  )
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

On 11/14/21 11:38 AM, Sagi Grimberg wrote:
>> Implement a 'dhchap_key' attribute for the nvme_host structure to
>> support the 'dhchap_secret' connection argument, and a
>> 'dhchap_key' attribute for the nvme_controller structure to support
>> the 'dhchap_ctrl_secret' connection argument.
> 
> Hannes, can you add an example of a json entry to the change log?
> Ideally there is some sort of documentation on what is the
> format and how to populate the config file?
> 
> It is unclear to me how the user is supposed to work with it.
> Is there a dump config functionality like we discussed before?

I would rather keep the json functionality separate from this.
Yes, I know that we really need json functionality to make it usable, 
but then the same could be said for other options, too.

And the problem here is that we'll need to coordinate libnvme and 
nvme-cli updates to get the whole thing to build, so I'd rather keep the 
json update separate from this one.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer

