Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEBDC4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rrjzUV/7i5e1UAM2vbTYut2T9Ghom4nn9qqDFXBNVmc=; b=4zURPSFEgo6aTgXGZFoSk7pgSu
	RDdmxPBz/jTYbI9YWs3o4LPLdWKg1u0y/Zyev7nGWYPmT3vJ97SmKfkFCIRd1pTyPvj8+waayMXYL
	LwWTGDxvPWxvnuMPnPBCrOImSqKM1+6IPhknE/9GaflrBSdd8bo8pyw8AitMPTPQ13YKXPkqD40zo
	4NZ7TDF+zrcxSsTN/XfnebZuidlafFUqK3L4e7ESLw+EFw+BMw1dr4KYuhDYv8xctTYi+5qWC6tS/
	YnmzQfdgUj5FMb08FoLI32biMdYN5eb8t7ZcnNI3UzeCS/upsqGR3RdT/qNxbRD0uSQnjuVohezXc
	38fbRTAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osey6-00BOl0-Gg; Wed, 09 Nov 2022 06:53:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osexx-00BOjR-Sq
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:53:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 37FB868BEB; Wed,  9 Nov 2022 07:53:39 +0100 (CET)
Date: Wed, 9 Nov 2022 07:53:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 3/3] nvme: Convert NVMe errors to PT_STS errors
Message-ID: <20221109065338.GC11097@lst.de>
References: <20221109031106.201324-1-michael.christie@oracle.com> <20221109031106.201324-4-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109031106.201324-4-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_225342_104650_A01D43C8 
X-CRM114-Status: GOOD (  10.09  )
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

On Tue, Nov 08, 2022 at 09:11:06PM -0600, Mike Christie wrote:
> +	case NVME_SC_ONCS_NOT_SUPPORTED:
> +		sts = PR_STS_OP_NOT_SUPP;
> +		break;
> +	case NVME_SC_BAD_ATTRIBUTES:
> +	case NVME_SC_INVALID_OPCODE:
> +	case NVME_SC_INVALID_FIELD:
> +	case NVME_SC_INVALID_NS:
> +		sts = PR_STS_OP_INVALID;
> +		break;

Second thoughts on these: shouldn't we just return negative Linux
errnos here?

