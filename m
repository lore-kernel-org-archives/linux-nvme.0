Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D106FEE57D9
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Sep 2023 07:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rW9s1cga0xhpNbTYkt4TJtVYhZxGSBW5rMvvsZ8iBLo=; b=oGSCkEVrDE+hFkx2Qh9Ei0PxzV
	PpUphRt4FmQrQ74kgbOVLbIR3uxaa+2AdV3jDzgtZz/SyCoZAsoOxEGPDmnBy0295w4r4E1C71HzD
	chQvjUr3gU7xvTwsZjCBjpE2/XFI4xX6lZPocXO2Z75371oDLcoQ2XwLFtFiAN82miN7/ClWDulJe
	2mYGdZ8ByZx5oAWImmKNOP2CTVTh4DsL+lPgidcv6FJbG0RN+60E0DlcsaIfVL+71pFEuTHewqA29
	VUNAZGIj5ExgYkDPe0L2oBMl+5E/VCy66lDgWSPm1TkfxwtnVIS63nEfXdgOsMba4nTMWPkF5aWvg
	F8DRnSUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeViK-00DEE7-1r;
	Fri, 08 Sep 2023 07:15:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeViI-00DEDo-0Q
	for linux-nvme@lists.infradead.org;
	Fri, 08 Sep 2023 07:15:35 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6C6E218E1;
	Fri,  8 Sep 2023 07:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1694157332; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW9s1cga0xhpNbTYkt4TJtVYhZxGSBW5rMvvsZ8iBLo=;
	b=PoDvXcxT2Pa+mxSTO0f9p7ES8yFNU8k3CrsBA5bvXN2NSPyI0M8mvs2fmFpplMooSElJbm
	o2dYNo+aeoXo9BfJee0zRT7EfgV2ZHQnepsmTwLXC//GiCrPxzkmwnDaSnNgccbsSjmURF
	ejpe+r1/AMZhpRoYe6a5f6U8/ZFLY58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1694157332;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rW9s1cga0xhpNbTYkt4TJtVYhZxGSBW5rMvvsZ8iBLo=;
	b=TY/mbj4gfYLWZJtx/yh+4MImqmL45Dl+/tFwDSPcZKNMxJx7/oF3yOf5GY4hrQlVm2ZYpi
	9QlLKZ88lZZcfBAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BEC3E132F2;
	Fri,  8 Sep 2023 07:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XoteLRTK+mTjCAAAMHmgww
	(envelope-from <hare@suse.de>); Fri, 08 Sep 2023 07:15:32 +0000
Message-ID: <065d800d-8c6c-4257-ade2-9ffa92c36735@suse.de>
Date: Fri, 8 Sep 2023 09:15:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvmet-tcp: add new workqueue to surpress lockdep
 warning
Content-Language: en-US
To: Guoqing Jiang <guoqing.jiang@linux.dev>, Yi Zhang <yi.zhang@redhat.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 linux-nvme@lists.infradead.org
References: <20230726142939.10062-1-guoqing.jiang@linux.dev>
 <CAHj4cs9LppxseFzZe-fj7tDaeKd0x8t8Wr-aYcjXAU-8FyfoiQ@mail.gmail.com>
 <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <a403c942-5b1c-c7f7-243b-81545f7f83ad@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230908_001534_332204_0E95F936 
X-CRM114-Status: GOOD (  12.71  )
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

On 9/7/23 10:12, Guoqing Jiang wrote:
> Hi Yi,
> 
> On 9/7/23 14:41, Yi Zhang wrote:
>> Tested-by: Yi Zhang <yi.zhang@redhat.com>
>>
>> Confirmed below issue was fixed by this patch:
> 
> Thanks a lot for the test!
> 
> And I had got another similar lockdep warning about nvmet-rdma.
> 
Please note that this issue is fixed by my patch 'nvmet-tcp: avoid 
circular locking dependency on install_queue()' send earlier to this list.

Can you please test with that one to see if it fixes the issue for you?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


