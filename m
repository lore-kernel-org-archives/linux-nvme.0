Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D480FCB604
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2026 14:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1eCPTgTnx4r+8iC6mMqYLj751KALWHbdnq8W6foZuI=; b=QTnqw1doJZ1VFrOnK+tAO3pEGm
	+O7ykOFhDgX+G5pkt9rqB+oHWD9sDKIAa17reUy93Xuw+N6jk0PwKCiYScVtsEmnLEi1fA7AwD6eu
	piv/hMkJGnZlStzJ+AEqCU3Nw/7dlRkr5iquluwDADCX4NMJ7BKPhaEiztv+4opt4qu/r+fw0uxuR
	WPZ8/IoXu0fzSWGTJ2cFaBN084LYw64OmrmDRORH0Sd1czvsEwuH2okaGkUxwO1zyewEqWa6n2B/y
	IDK1ZTWCvCPAJwwXiTpz/EdMOAV414aLmXOdm9TkiP6t9Djbc8Bvot0OEEDi+tAf1mVcUy6cyTq7H
	f5HjNwXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyWZE-00000003yY3-3utK;
	Fri, 06 Mar 2026 14:54:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyWZC-00000003yXb-372S
	for linux-nvme@lists.infradead.org;
	Fri, 06 Mar 2026 14:54:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ACEE968BFE; Fri,  6 Mar 2026 15:54:09 +0100 (CET)
Date: Fri, 6 Mar 2026 15:54:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: Re: [PATCH] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with
 SC_C
Message-ID: <20260306145409.GA18945@lst.de>
References: <20260306041806.2321074-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306041806.2321074-1-alistair.francis@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260306_065414_924121_DEF95465 
X-CRM114-Status: GOOD (  10.89  )
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

On Fri, Mar 06, 2026 at 02:18:06PM +1000, alistair23@gmail.com wrote:
> +	u8 dh_list_offset = 30;

Can you add a symbolic name for this while we're at it and reuse it for
the dhchap.dhlen assignment.

> +	if (chap->sc_c == NVME_AUTH_SECP_NOSC)
> +		data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_NULL;
> +	data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_2048;

And please add a local variable pointing data->auth_protocol[0].dhchap.idlist
to make this somewhat readable.


