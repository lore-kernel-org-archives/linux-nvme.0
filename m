Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54554C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 06:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g+Tn6hQMmMVoDSse5E+uoxWPGX/TpjDjpzq0y4D+dKY=; b=xYvNvdo36ADpZgzswiymq/r6Ff
	oln+Z11fbp96nqYuf3qKgRGgiLG2a521g8RLEgNgaWY7nQN1vMXUN9xaQYq6Af+Y2iixEEcf6V65P
	yBaSdQ7ggeyIDuMswKSca9NSijmbiOngwGtdgLr0T3zJY3bH/VUMq9gqXRuFHDNBGsAQiw351W/Nc
	6hFvQ+I+Gghjp6GQh0j3ukESPGZMATVr97uUmLnm3KANmYkhlFvUT61b/v20BiYXkb//rFYoH3WO7
	U8NSLEGuuHow+eml1xQXml0UgtxXBCMUgSsRHv6APb+NjGQwqI2EP33Miedog7yTO4KX24TVvFFg0
	hX+ytH9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDh5w-005iji-12; Tue, 19 Jul 2022 06:52:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDh5t-005ihs-2A
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 06:52:34 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8CC31FAF9;
	Tue, 19 Jul 2022 06:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1658213551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+Tn6hQMmMVoDSse5E+uoxWPGX/TpjDjpzq0y4D+dKY=;
	b=jc8Nj4UBpDkpAJ8ygLkZdlCVg7YYizEqBXcYGln0x/JyevK26XKiP5pZAiJWAeK1fQCMcr
	JDEEehCtnt7c8UHwJKBBsAocqCFX2zc0DJr9YpVOltm4xnfLmV8m//hBHbMiR1VggZWBq/
	ckXb+1KitiUHrUkrMG4VI92SFh0XZvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1658213551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g+Tn6hQMmMVoDSse5E+uoxWPGX/TpjDjpzq0y4D+dKY=;
	b=loHbt1+1Mhwasq6R6lWuGN0kAVQcJFMTa56pmFAJtMRlfw3mjaw/4+kE3h76hKK1WBjmCc
	LZ9KaFpEdJD0UjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4AD113A72;
	Tue, 19 Jul 2022 06:52:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id FchQK69U1mKoHgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 19 Jul 2022 06:52:31 +0000
Message-ID: <c96380c1-8d12-e67f-b9fd-0e5f55b05a4a@suse.de>
Date: Tue, 19 Jul 2022 08:52:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: NVMe In-Band Authentication blktests status
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_235233_282210_BFE7B8B2 
X-CRM114-Status: GOOD (  10.80  )
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

On 7/19/22 01:33, Chaitanya Kulkarni wrote:
> Hi Hannes,
> 
> I just cloned the latest blktests and seems like we don't have in-band
> auth testcases in the repo (correct me if I'm wrong). Any plans for that
> to get in the repo ? as many are asking about the tests as code is
> upstream now so we can run on different transports.
> 
I had sent a pull request; let me check what happened to that.

Cheers,

Hannes



