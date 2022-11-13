Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C3BC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 13:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ceT1wZH9CpF2LWWnGAykZ0PuTfcJ8Qg5+FFkphp4orU=; b=SYgPKW1ROZQLOvnKeZ2gXDJ6Uu
	X1/th6aArYB1y6rTvhrFjy/6jnMfGxN5PXiPx6K9MJ0/+rEwwLVVDcjGsrQ502oYXD9XqpWqgYOdT
	WKvY/kj1zS5hVGxjjxN8CEYnAfQdb1HWmIjjJs58wKfNKU50tGm/d71tbEtE2GwmnzUdHi1/1azZW
	/Buh8CaFCg3ukX7eSfghdq3fipa8v7awzOsgcMoW4W3E9phl5LBXEvehMP3UQbOc7Nu5j+NpJdj8J
	3yExZl6CxTCBJKdiwaZI/GQIHKMbVNrnZFFb4C4a1VdcZkAQLE7pUEdR0fVnnM+KW+ciZ71G7EQpb
	KIMjWmWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouCmI-00BYes-B7; Sun, 13 Nov 2022 13:12:02 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouCmB-00BYcz-I4
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 13:12:00 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 514961F994;
	Sun, 13 Nov 2022 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1668345114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceT1wZH9CpF2LWWnGAykZ0PuTfcJ8Qg5+FFkphp4orU=;
	b=gL7ie/TLpL1vuvO3dC2ObOfWfXVIAYFzUHf+TahzUd1YFxBIhDvhJgrOF0Rq03eioXH44H
	nfOj94DqGHDgFjBoEnaiezMoAYpBTGgmZTgfSgVJtEtgKQ84JT0PDlv9S2pdE8i0I/+4KM
	b5RLdFqSgpjqhRGOw1c9lGJc2kgzZiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1668345114;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceT1wZH9CpF2LWWnGAykZ0PuTfcJ8Qg5+FFkphp4orU=;
	b=OVZtxEn+t8Pb7P2dqYhmmBv60PMpXBrOsxLcK7s64j6OvqPFPAKRqU8YlDCE0quvdSGQu5
	uSCppXeQofVVkgBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1B3A6133A4;
	Sun, 13 Nov 2022 13:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id CpbDBRrtcGO6fgAAMHmgww
	(envelope-from <hare@suse.de>); Sun, 13 Nov 2022 13:11:54 +0000
Message-ID: <da2dccaa-41dd-4a48-0ef4-7990f3236a3f@suse.de>
Date: Sun, 13 Nov 2022 14:11:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 12/20] nvme-auth: remove redundant deallocations
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-13-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20221113112424.1049834-13-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_051155_763069_C79F6C67 
X-CRM114-Status: GOOD (  10.06  )
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

On 11/13/22 12:24, Sagi Grimberg wrote:
> These are now redundant as the dhchap context is
> removed after authentication completes.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/auth.c | 20 --------------------
>   1 file changed, 20 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


