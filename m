Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DACAC61DA4
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nLkcgigmb+qH4vFgN3PZrZDXfkDD9YE0smdvZ9QUNJA=; b=weDUv2Uj2T6egGBe9rf2jMHOqs
	7hjcp2rBc28LYYAVwyhY/hPXTpXRRzxkbaajeTbBxc2BHLCK0CIrdWKJO6nOJLBTCR/tJJTBL/Cyo
	Wxe7ZgclcehlYEzwk4r2ftOjdGwm8ibPyJUogKqii+qh13Lxp0kXqDkzqYGoG7NW5OZZwpASZoMY+
	4AJ/QhhyDStPe7K1xswpqNb04pFNSdIP+XhEC+YOwnVdKUrAD9h99+Nm5wjobhvgfZ4/tqDELVXAx
	pJkQ+4ZzG/htJI58JPF57kEgCqLPm1mCytX/1uWSCLNAyQBdnfKaMTSfxJWaUeEVcrRJfwd2KivOW
	Rg7eHKgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4fl-0018IY-8k; Thu, 09 Feb 2023 11:01:01 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ4ee-0017i1-4b
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 10:59:54 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3BB2352F6;
	Thu,  9 Feb 2023 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675940389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLkcgigmb+qH4vFgN3PZrZDXfkDD9YE0smdvZ9QUNJA=;
	b=IgXC8c4wET6Mo5et6pn4/7FpREM4SF8Hcjoa39zGMBBGitU3au/tCikSWXKAraD0tKHJAA
	XTdYggaE8YMm3bVbSLD1c3alZLAROiCe9uyrNCTXvNHqYo5VkTgGg4HhtCfT3NNQQ8AGvH
	D7Z+WWLnz2hJGBOhtg93RMYqSWbxuus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675940389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nLkcgigmb+qH4vFgN3PZrZDXfkDD9YE0smdvZ9QUNJA=;
	b=QAGETcTeUBrPsJDLGed/F88DmikX9XDStMKhPEuBpN46hdLVC3pBrb8q0gDDhlcJfUS8fD
	UPeupHc5TI7woACA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CEA741339E;
	Thu,  9 Feb 2023 10:59:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 9lwdMiXS5GP7MQAAMHmgww
	(envelope-from <hare@suse.de>); Thu, 09 Feb 2023 10:59:49 +0000
Message-ID: <ca49bc5b-be11-cebc-d12d-88d0e1f9e32d@suse.de>
Date: Thu, 9 Feb 2023 11:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] nvme: make 'at_head' parameter for
 __nvme_submit_sync_cmd() boolean
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20230208151720.109130-1-hare@suse.de>
 <20230208151720.109130-4-hare@suse.de> <20230209052018.GA8510@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230209052018.GA8510@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_025952_457320_F4F7FC60 
X-CRM114-Status: GOOD (  15.02  )
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

On 2/9/23 06:20, Christoph Hellwig wrote:
> On Wed, Feb 08, 2023 at 04:17:20PM +0100, Hannes Reinecke wrote:
>> Use a boolean for the 'at_head' parameter in __nvme_submit_sync_cmd()
>> to improve readability and consistency; it's being converted into a
>> boolean anyway.
> 
> I'd much rather have an INSERT_AT_HEAD bit flag, going all the
> way down to the block layer.  The use of a boolean for this (and
> also some other things in the block layer issue path) is really confusing.

I do agree. But that turns out to be a larger and more complex patchset, 
which I'd rather send as a separate thingie after this one is done.
Otherwise it'll hold of this patchset, and really is an unrelated issue.

Cheers,

Hannes

