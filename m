Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51705E77188
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2025 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzakdUEVyveiS47ojJKozEiWbxBg7PvuUp1agbqXzUk=; b=1h+5xxq33HpJFOWFNqs6sN5e8t
	gs9sjAMotCdv2wzxHL6uZnnZSr3nIvW7gY7ka2VJ0bKjWY1dZShvwhjfUL8M6CL7o4LvWiXELL+75
	uYoBPkcKzENyWBH3cwZ3Nivr5ToCLfUsCmngkrPsAg7rAISFQn0q94hS6YVP6HeMUOnJNUy5/dljO
	RFIifAEWHvvKwcmwsCtwrsVtEqpij0MX1bwTsl4wn3iQT79ZTMIPh70cCdTIkfVf5voPJjhSfJd3j
	tr4X6fyV4I6v4e85dH85gkMrWlDn3NrorzXrO7y4jX49YD4crgZ8nG0aav4LyhBHsvAyf1/fHze4D
	2RQ3mH1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTFM-00000007yhB-3Ifn;
	Wed, 08 Jan 2025 10:25:08 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVTBa-00000007xfV-3xPB
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jan 2025 10:21:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 76D2AA40D77;
	Wed,  8 Jan 2025 10:19:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAA48C4CEDF;
	Wed,  8 Jan 2025 10:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736331673;
	bh=JFHL9CU+SvxdU55U39KRsBzQCKSkGxUcXFDn7BoFcMY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nFYrl7fp4fSPfIdVuMpJVBP6b3YldyaJpmtL8UGYeBOMd6X2fQZZKxcTko0MCHdEJ
	 jH+d4p+hrcpoLhM/023ELdse4fADysYzrU4Z1ABYpmpZi4cPVVGCnwlcjgpi+VvKJj
	 dxY8a/ceS4/CCMOQe2Z0kfi3cYBICxBW6R6rSgk7+6thjO0oVE0vCMDT4weAOb5gbw
	 PlnE5uQCecncE61izjeK/LRIhERUBfol6ssf6s3WOok59Uqvw/oQ6KSKZkaBmCHckz
	 c794gfsJc4uTMT+CqG5cQKseRKYv1Sfh7V3wFWlLsVnKTaew/CCMnZpmKNZicaqh4j
	 06hM49PLKaXRg==
Message-ID: <f3ca343b-0ff1-417b-b2ff-7ea166fb82b2@kernel.org>
Date: Wed, 8 Jan 2025 19:20:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] loop: fix queue freeze vs limits lock order
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, linux-scsi@vger.kernel.org,
 usb-storage@lists.one-eyed-alien.net
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-11-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250108092520.1325324-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_022115_049095_AA2C5391 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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

On 1/8/25 6:25 PM, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper and document the callers that
> do not freeze the queue at all.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

