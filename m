Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73981C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsvLI1TVw+/R/ul1dKAOkjCF9KvuhCgyuKMu1dxGP8w=; b=ZB8btj/i6FaB+Gslp1brVokdue
	e1JBa2bidou8maFffzJZwPjdC51wKBhoA4V2e9tdoEnepk+Kk8FthqoqgBjHP7TQRi3+WCX0nGlTc
	0ZQGhfVyze/MhF/gZSyPW1SwU17uiu8EvO0qYQQoR2MUpdID0fPMwcWH6klunx+MAvse19tJEASP+
	53GyMyOXVYUvUdzT/475rZzNuWSDi5VysH/6NNrB36zdV4LVylr17B1B+eMJGMF9GLTm5BVM93qi0
	9foUvZNyZ8prO1CL3IWurcepmsrd+RMssn7APil1HSfNGrWyKgIYfawu9MSeqsPbWkW5QD9S3k7Mc
	jjXtrB6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8CP-00Gfpm-20;
	Tue, 11 Apr 2023 07:13:53 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8CN-00Gfp9-0s
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:13:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E00221A52;
	Tue, 11 Apr 2023 07:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681197230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsvLI1TVw+/R/ul1dKAOkjCF9KvuhCgyuKMu1dxGP8w=;
	b=zr5SFO/1NZ5nYXKFS0beXx5dEpYc3yA+Q4ujyA69xggj5FcqXEpVV8/CPbyTIlSQR2Bkim
	BrWK5yt0qtaJRxHxSOXcdsjrr+i3FDGB6/4hNKF7y6itrPAbnWsbmss8mqRRnVMHmM3Rtr
	sNMPX3A6CTvz/OuGRKLWShxFXq56vRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681197230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsvLI1TVw+/R/ul1dKAOkjCF9KvuhCgyuKMu1dxGP8w=;
	b=n1qCeuVQetWHmKAOQEFN2/NUd/XAWA0FHw2M8vGWSvu1Iy+HZmsCubJf/xQCx22tCrDwBr
	e+sKsJ4y04wkPFAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B14AA13519;
	Tue, 11 Apr 2023 07:13:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 3bsTKq0INWQpXQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:13:49 +0000
Message-ID: <9fa70d20-1d10-d031-1262-e961cf240810@suse.de>
Date: Tue, 11 Apr 2023 09:13:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 06/18] dm: Add support for block PR read
 keys/reservation
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-7-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-7-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_001351_982791_9FA280A4 
X-CRM114-Status: GOOD (  10.11  )
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
> This adds support in dm for the block PR read keys and read reservation
> callouts.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>   drivers/md/dm.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
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


