Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79BFC7619A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1d30TW3PS5AZKmREIkNY88Ij0YfRYFBZCpnTnL2ftWo=; b=juI/AtUsAFnSQAJLSlx4EBOsd4
	ttLQDCFIgjvF18TwgUYcG1SrTKcUH7RklZeMTOo+70UjGfWw8LJe700h89yznk97ycKua/ar6iDmL
	UDkokxMsf5IO0FBew0nQkNbLu659SmgiiAlACn1TUdYAgmGrEgEY+DHv0c3zxselK3fkQ2ocJj3Jv
	qswfrzLmqLl/2ksx4f8VK3ZXQQcQeY3OEFJ9hFmUEj1aTZwAnijq0/kOuVmhSZ3IrZh9W9ycc2Cjm
	LMsQdzqN2kULIEqthDYpJKrPZvzHl4BTLZHaZPrKRi8FWke3qotWHV7MK5ptmhJaeg2IvsjPdPYuA
	5LPLwIig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8RJ-00GitS-15;
	Tue, 11 Apr 2023 07:29:17 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pm8RG-00Gisy-2f
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 07:29:16 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 647ED1FE07;
	Tue, 11 Apr 2023 07:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681198153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1d30TW3PS5AZKmREIkNY88Ij0YfRYFBZCpnTnL2ftWo=;
	b=FCExU9r+XAwv8kUnSoMYYU/Aqo1Z3hsr5jHRd5mRJhV7cKwdw2PL+qtVDrPtjJw45E/yOo
	tB3epH8Zugc7s+jT3BgYyizF5MVJx0p59E0/loSajO3l5StTvgxraIUEtnfe58mX/97QRH
	eoMsuChgdFUuROBPhXtfe7neJMMuvKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681198153;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1d30TW3PS5AZKmREIkNY88Ij0YfRYFBZCpnTnL2ftWo=;
	b=zXot1xhDMUh63sGIDz+hKoKcWlK1AvhHCoEipuduFXkGGJ4jMfkxcJ1YWnXiyOlLi/noFR
	h638K4Slhq3Hb4Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 055F413638;
	Tue, 11 Apr 2023 07:29:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id EvsIAEkMNWQ5ZQAAMHmgww
	(envelope-from <hare@suse.de>); Tue, 11 Apr 2023 07:29:12 +0000
Message-ID: <a85c34c5-d181-e175-5c7b-41cd2f9f465b@suse.de>
Date: Tue, 11 Apr 2023 09:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 12/18] nvme: Add a nvme_pr_type enum
Content-Language: en-US
To: Mike Christie <michael.christie@oracle.com>, bvanassche@acm.org,
 hch@lst.de, martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 james.bottomley@hansenpartnership.com, linux-block@vger.kernel.org,
 dm-devel@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
 linux-nvme@lists.infradead.org, chaitanyak@nvidia.com, kbusch@kernel.org,
 target-devel@vger.kernel.org
Cc: Chaitanya Kulkarni <kch@nvidia.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
 <20230407200551.12660-13-michael.christie@oracle.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230407200551.12660-13-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_002915_010918_62F0C4C5 
X-CRM114-Status: GOOD (  15.21  )
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
> The next patch adds support to report the reservation type, so we need to
> be able to convert from the NVMe PR value we get from the device to the
> linux block layer PR value that will be returned to callers. To prepare
> for that, this patch adds a nvme_pr_type enum and renames the nvme_pr_type
> function.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pr.c | 24 ++++++++++++------------
>   include/linux/nvme.h   |  9 +++++++++
>   2 files changed, 21 insertions(+), 12 deletions(-)
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


