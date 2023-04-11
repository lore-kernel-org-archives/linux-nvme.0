Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC02C7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hIv2vG5w9hfaCZjWlbUL2svVpK6lOBaKheLWbccNi1U=; b=YP17ypIQh7QcRQxie774oBZy6b
	dEJIUqeXCb/QvvQ6fc9+SYBAeynTjx34k5e921Y6qAVTKvBMUSgE+op2Dsi6zrqQjRZ3Zx4nsv4y/
	N59ad9oGYnm+VnuVV8AZkjl7XL3g3esAMEUq7lHtZYGlYPZLBqYlvDDWeFr69UB/5EQNz3JUT2f6L
	Nuj9rVY2aFHenyRrXBwj2wK7PQWoE7W5AcDo3jeyLWdgjjkkMWAAFrqP3BeFpimVtVjWwE03lh40O
	FbkWs1ZaTeOhVlHIsHxUrvLBAFH+vK+xWpnt1Npn1iZ7P4sPbTRTQ5nWiWH2hN9JVnHMSsbscViaz
	QfBIWTNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Tn-00GjNY-3C;
	Tue, 11 Apr 2023 07:31:52 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Tl-00GjML-1W
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:31:50 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FEAE1FE07;
	Tue, 11 Apr 2023 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681198308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIv2vG5w9hfaCZjWlbUL2svVpK6lOBaKheLWbccNi1U=;
	b=UVyo3R10+PKqHuGhRsDwz0rgc+YXaZGe4bjzL+j0k5aa14eT3SfBeftt6rVRu0Jl7xW8cy
	ZjWCZrRHmxRorF0p7Nvvab7SzNNp/7pEjPWkzEmEPGJGaQvN/3JAjwkV1AR3av+UiHFeDF
	lFCwvSLnVpvM16Kdu1ApYgrILJ9resE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681198308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIv2vG5w9hfaCZjWlbUL2svVpK6lOBaKheLWbccNi1U=;
	b=csj9N70qIqWK0Xku20t6ctogY7OEcV2Zqjvd3YaMUSO92NvB7bCU8spiDYD2ZSGmlqUT0x
	k357NLZ7xNTwvZDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D75D013638;
	Tue, 11 Apr 2023 07:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id aCIpM+MMNWSkZgAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:31:47 +0000
Message-ID: <5152a029-c690-70a1-c9ba-161af9a8bf4d@suse.de>
Date: Tue, 11 Apr 2023 09:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 16/18] scsi: target: Pass struct
 target_opcode_descriptor to enabled
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-17-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-17-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_003149_647208_4FCEE4A8 
X-CRM114-Status: GOOD (  12.05  )
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
> The iblock pr_ops support does not support commands that require port or
> I_T Nexus info. This adds a struct target_opcode_descriptor as an argument
> to the enabled callout so we can still have the common tcm_is_pr_enabled
> and tcm_is_scsi2_reservations_enabled functions and also determine if the
> command is supported based on the command and service action and device
> settings.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/target/target_core_spc.c  | 40 +++++++++++++++++++------------
>   include/target/target_core_base.h |  3 ++-
>   2 files changed, 27 insertions(+), 16 deletions(-)
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


