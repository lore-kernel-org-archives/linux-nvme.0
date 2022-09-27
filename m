Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85738C6FA86
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PwyEaJ8LbFarKQUoz59b0NUNWwqpR1JEefrDADrWxiE=; b=zR3WpPnCA+9DG/Oxamh/gJnZNp
	5Q/xxVFF1XvyS4weqZCU32q7LHyOVOFBuPUeP6EC7wVUiYUgqyBGTxIcHrGLnbVLG0Edkb8wFHEti
	rc5URWd/+VLL3FeDVIBdxZ/uJ8AiCaD49r9tJtaOBOBvQtuSriTrpfgqd8qi9qz2REQqbXNes/7zE
	ALL3tx7wicfnRJSQnMPapcQJZzqP6K9It3jfHeb198a2WaAS1m3gbFSjBgRzni0wg3SZQpT1lRV91
	xe9bUjdKsNVCLq5+xdtSJW/mRirZ1ET3awHBNhy2uGMNS+hEHUx935VC0Qt4Tmd46P7C/7LBtDOGx
	bSfyGlDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od53j-008nYN-N8; Tue, 27 Sep 2022 07:31:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od53h-008nVn-9u
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:31:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B2E5968AA6; Tue, 27 Sep 2022 09:31:09 +0200 (CEST)
Date: Tue, 27 Sep 2022 09:31:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next 1/2] nvme: add the permission-policy for
 command control
Message-ID: <20220927073109.GA16831@lst.de>
References: <20220926145430.81658-1-joshi.k@samsung.com> <CGME20220926150439epcas5p160506693c35f94eec80f26e34027988f@epcas5p1.samsung.com> <20220926145430.81658-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926145430.81658-2-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_003113_506264_08545E48 
X-CRM114-Status: GOOD (  14.48  )
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

> +bool nvme_cmd_allowed(struct nvme_ns *ns, u8 opcode, fmode_t mode)

This adds an unused function, so I think it should be merged into the
next patch to have one coherent change.

> +{
> +	/* root can do anything */
> +	if (capable(CAP_SYS_ADMIN))
> +		return true;
> +	/* admin commands are not allowed */

Empty lines between the check would be nice for readability.

> +	if (ns == NULL)

	if (!ns)

> +	/* exclude vendor-specific io and fabrics commands */
> +	if (opcode >= nvme_cmd_vendor_start ||
> +			opcode== nvme_fabrics_command)

Odd indentation here, this should be:

	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)

> +	/* allow write cmds only if matching FMODE is present */
> +	if (opcode & 1)
> +		return mode & FMODE_WRITE;


> +	/* allow read cmds */

	/* allow read cmds when the device permissions allow access */


