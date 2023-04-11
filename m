Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDDC1C77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SPSNpXpwASg9ps1jT6Cb6mKP0qWkEuqI9+sOkcM7ltk=; b=wA0t1Sf42I6EDdItOoak21Ylca
	apjA+egTa2GjexL6/wwJo3spNX3szfgV4kVh3GiPTQ6GN2gc22lRFZesJF/K8RjwxeE/6N22b5U2O
	fNCUDkA7mcuPWt5ffBExpPJvR0v348zwCyWwgYslOd2v/nOu840zA22YtCE1zIGm/7wWe97yzevDg
	gH5DI1q2y7+N2GnpR/A2DiuH6H4dMWM53vfWkti1/XZPahjcMi1lRePhr8BrU7N1X97bE7QUndUW6
	pESYBId/mdFOO54wtkNQboHsKbNOq6Ei7xXGsjooK/WkyvB0qb1YjWcsGfusL5TMtPpRsoo9xxLPN
	m/4WvOvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8V0-00Gjej-2x;
	Tue, 11 Apr 2023 07:33:06 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8Uy-00Gjdd-0N
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:33:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A55CD21A53;
	Tue, 11 Apr 2023 07:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681198382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPSNpXpwASg9ps1jT6Cb6mKP0qWkEuqI9+sOkcM7ltk=;
	b=QECtZ0gLP71tRjQrhL+xxkHIQ1SrU2NEOU4bDw6kKya6dsmF6Qz3KBY6OLohxqEgalkW7I
	iv5X/g1jqsWXyLmBgnO3lkBhXcYgQ7CLkyKJ7GK4Uw3ZDD5Pse2XZ4Z6UuSx/naVWjZyFN
	NLUaZiHNCg6wPmJeyBHustl+3EQXeio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681198382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPSNpXpwASg9ps1jT6Cb6mKP0qWkEuqI9+sOkcM7ltk=;
	b=2qPDOcLDnylVHsq+2/I1336pm59RdNEK49xKH2xdDsri2rhBz9+hVLzDZx8erIxHJ4QX4j
	FfIT59hP54y+gJAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B6E413638;
	Tue, 11 Apr 2023 07:33:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 8qLpDS4NNWRCZwAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:33:02 +0000
Message-ID: <dd421619-fad1-1c73-384d-25529a4c8886@suse.de>
Date: Tue, 11 Apr 2023 09:33:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 18/18] scsi: target: Add block PR support to iblock
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-19-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-19-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_003304_298930_DF5DBCAE 
X-CRM114-Status: GOOD (  12.93  )
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
> This adds support for the block PR callouts to target_core_iblock. This
> patch doesn't attempt to implement the entire spec because there's no way
> support it all like SPEC_I_PT and ALL_TG_PT. This only supports
> exporting the iblock device from one path on the local target.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/target/target_core_iblock.c | 271 +++++++++++++++++++++++++++-
>   1 file changed, 266 insertions(+), 5 deletions(-)
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


