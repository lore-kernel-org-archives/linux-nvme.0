Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFBD2C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uz23gX9yRzgNChoXSyelNu69H6MG7ucyuOP9CRH2gxs=; b=b/7oZD3pAo5M3ggNE1jvNZEekz
	K33idaV966tcSVzsLLRByYS+yK13y0ZgFGVg7GjNsMCtaLBl/XwX2CdAx7Bn6ZRU7olZh9fNbvn01
	8nlC4atpseXTiSwCGpIrEX8bvcbzLit6f5EBAfv9ShDg5J6HnQzNciv8lWG86codL3ouYk3rpV71Z
	pZesLFI5bmFSmun+bIvz5e519vqjhElJA29NDxSBrdQpH6GLrQZqiqUKZZ3XKSOuOPxkJMrcMuDLU
	NeZNWrWgrCoh71pyaHiTe6Ge2NqpYIyBZIa5fM1HGWuPO/SX89NjXgZJhGPGKN0CuxCChxEBQesKx
	Yh2ZdVWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osexG-00BOGv-TH; Wed, 09 Nov 2022 06:52:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osexA-00BOFn-DU
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:52:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B28FB68AFE; Wed,  9 Nov 2022 07:52:49 +0100 (CET)
Date: Wed, 9 Nov 2022 07:52:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] scsi: Convert SCSI errors to PR_STS errors
Message-ID: <20221109065249.GB11097@lst.de>
References: <20221109031106.201324-1-michael.christie@oracle.com> <20221109031106.201324-3-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109031106.201324-3-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_225252_614338_6106C79D 
X-CRM114-Status: GOOD (  10.49  )
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

On Tue, Nov 08, 2022 at 09:11:05PM -0600, Mike Christie wrote:
> This converts the SCSI errors we commonly see during PR handling to PT_STS
> errors, so pr_ops callers can handle scsi and nvme errors without knowing
> the device types.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

