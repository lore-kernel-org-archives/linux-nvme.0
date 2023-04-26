Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8321AC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 11:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CG7pBeDFk8SNNXPi51F4p2wZqCL8N0kfGWyPVLnuvkY=; b=x7vbKwCwJU5Fn5x9GcNAg9kfqV
	O2djulN4xksIC13tQmRVwleV26NPBgiQIOBNM/QzoWHPbOGVclf6MFGBnoxGnClmoO2WHxSe/Fwk2
	UHdQIVBasL0hsSoMEwYYaquQQWVLnbKOj9r+DaH14C91FImWGjmvLC7HXLTF6wf5IOjZzkzW5mccY
	jmpbG2UAc++wnszPeqWXzgDfJF7RI5lrG4+S6RwXVePl/9qAywAWH9SqSFfti+H1ZjIZWWYgc6GIs
	fkGaMFF8eWdgd5abZSc7dvXAFbKfH6Ao6LDW9tQy3TW+mOLmWQ3SghtpHMVfugILRhj3v9KDg+m7x
	XReeJjKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prdJE-003lId-2U;
	Wed, 26 Apr 2023 11:27:40 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prdJB-003lHn-2S
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 11:27:39 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3D9F21A11;
	Wed, 26 Apr 2023 11:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682508452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG7pBeDFk8SNNXPi51F4p2wZqCL8N0kfGWyPVLnuvkY=;
	b=LqM7ZfMhkQdlXkrs+IyCGQd73U8LZLO4LsTZgCGkBvcvi1HuYyi22PLaJvHJRLl4uh93G7
	BIpopSY0LVkPk4PIHEIs0SyiM32ybSMjGFhpQM6JTY+/ckEoHh8qjvzTRUwD/BKeqrqa+p
	R8rrwdhQTwKCXGxIhoa87RuWslul7Sg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682508452;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CG7pBeDFk8SNNXPi51F4p2wZqCL8N0kfGWyPVLnuvkY=;
	b=WirpFk+n7W6Fn+i49TMZGEkij8Gq4Ub//QijP6ulvC9clkB7oEM0g57vPtNAt39NYTfYtN
	jdWsmC+s01t7s7CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACA99138F0;
	Wed, 26 Apr 2023 11:27:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id izC9KaQKSWTDegAAMHmgww
	(envelope-from <hare@suse.de>); Wed, 26 Apr 2023 11:27:32 +0000
Message-ID: <4010e880-b346-8268-e56c-d25cbec4bb0f@suse.de>
Date: Wed, 26 Apr 2023 13:27:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/1] nvme: move sysfs code to a dedicated sysfs.c file
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, hch@lst.de, sagi@grimberg.me,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20230424211242.19614-1-mgurtovoy@nvidia.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230424211242.19614-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_042737_966202_FC5283F1 
X-CRM114-Status: GOOD (  15.05  )
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

On 4/24/23 23:12, Max Gurtovoy wrote:
> The core.c file became long and hard to maintain. Create a dedicated
> file to centralize the sysfs functionality. This is a common practice to
> separate sysfs/configfs related logic from the main driver logic .c file.
> For example, in the nvmet module the configfs interface has its own
> dedicated file.
> 
> This patch does not include any functional changes.
> 
> Reviewed-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
> 
> changes from v1:
>   - rephrase the title from "nvme: add a dedicated .c file for sysfs interface" (Sagi)
>   - add Reviewed-by signature from Keith
> 
> changes from RFC:
>   - Removed RCF tag
>   - updated copyrights mistake
>   - fix License copy/paste bug (Sagi)
> 
> ---
>   drivers/nvme/host/Makefile |   2 +-
>   drivers/nvme/host/core.c   | 650 +-----------------------------------
>   drivers/nvme/host/nvme.h   |   4 +
>   drivers/nvme/host/sysfs.c  | 655 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 662 insertions(+), 649 deletions(-)
>   create mode 100644 drivers/nvme/host/sysfs.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes


