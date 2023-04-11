Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF58C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zrKJwUKKQqPwV2GMYE3vvKipc0Y4/zBPoyFnBRMPE5Y=; b=C5Go9/7EPv5PfMwRTQafeD9Oai
	E1QlMkgh4LmUptAIjq6x25EGlsECnIBv76ot68p6rH2LxOnlk1+kikM6FeYvb1retW5iX2Y1UFHdz
	vyoUP3y7ibCxfbV4FPG1Vz2erXtMxcKEDUiXP88rxTVEocvkPMA+rUCi/30I/rOziyNDr1SaLetAf
	rQGNlD4jZMwhmSjLJQBvlXLOYaqJu6sn1mPBFUP/4a+4veSt9SXPZlDxfU3YozEg+eP89oQCgLVnE
	oK6/qzlr0jAgbjZFoSy9wKLiincKZMkvP+ZqHNOpc0Lvdr/dRXZJ26Sg5OuTDi12leCXxVvaYdgWh
	iCS7AkRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8TK-00GjFH-0y;
	Tue, 11 Apr 2023 07:31:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8TH-00GjEF-2V
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:31:21 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 593CE1FE00;
	Tue, 11 Apr 2023 07:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681198278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrKJwUKKQqPwV2GMYE3vvKipc0Y4/zBPoyFnBRMPE5Y=;
	b=Q7qTB94wj3Gg/3rFS/TyqOMweHV6DVNY8f9a/7PDxK74NEJADGNmvOG3RLGuKJW7mhCP4Y
	A4szjiTISxfspLyeqN9VAYRSn0ky2pDJIssd5vF9K8TOg9FtGJFQK/r81vIlPBqNs+J/qh
	jV7EEWs6zdGRtusRQYNwY160B7FVLvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681198278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrKJwUKKQqPwV2GMYE3vvKipc0Y4/zBPoyFnBRMPE5Y=;
	b=JyQyzgRWSbw63ZHATm4TNpQfkxooqhNaR5VOVlFibWtHFYugP8dOZ85ZUQhu15it8YKX4r
	vb/3/FkJKatR9/AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3B2E13638;
	Tue, 11 Apr 2023 07:31:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 71B0OsUMNWRiZgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:31:17 +0000
Message-ID: <a78916e3-16f1-3928-8245-bb54532bcb58@suse.de>
Date: Tue, 11 Apr 2023 09:31:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 15/18] scsi: target: Allow backends to hook into PR
 handling
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-16-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-16-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_003119_959323_0A4736B1 
X-CRM114-Status: GOOD (  18.45  )
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

On 4/7/23 22:05, Mike Christie wrote:
> For the cases where you want to export a device to a VM via a single
> I_T nexus and want to passthrough the PR handling to the physical/real
> device you have to use pscsi or tcmu. Both are good for specific uses
> however for the case where you want good performance, and are not using
> SCSI devices directly (using DM/MD RAID or multipath devices) then we are
> out of luck.
> 
> The following patches allow iblock to mimimally hook into the LIO PR code
> and then pass the PR handling to the physical device. Note that like with
> the tcmu an pscsi cases it's only supported when you export the device via
> one I_T nexus.
> 
> This patch adds the initial LIO callouts. The next patch will modify
> iblock.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/target/target_core_pr.c      | 62 +++++++++++++++++++++++++++-
>   include/target/target_core_backend.h |  4 ++
>   2 files changed, 65 insertions(+), 1 deletion(-)
> Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman


