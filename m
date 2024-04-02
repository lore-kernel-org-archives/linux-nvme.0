Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B277ACD128D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pLp/onB6sLsiSlSmVVAuFoBFniHxkJJmMURR3yhGYMI=; b=hL6BdC0MHWQPhxmOIk3MnSp1wD
	M/871053lCjz6FU463L/UpbegcmCODLGKV7WFHnvwf1wXmJdnboIqYs2L9ZUYOxHIcxtlQxHUEBfG
	aBan9kRwaetcE5nKN8CEvKMrY0dR9//lt6ciRa9xlojyVj93yAmRjhoqo5z3Vqsb6aUGFyMV++yXP
	9YQ+Q4Rh1v5HZlm0iDTz450SOHYolNIJOYv81UYCMDDeqgNr+VIN3b6jD2jRq6/ml3RtN6XxhSZqf
	psKKTwE8Ukb53rQC71XGu85PMbggUDUTbju7wzPzHelW5x5TKgeFgD+u9f0aZ8nifwm4nhYZCZudU
	1/aks5Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdgB-0000000BBab-2c5X;
	Tue, 02 Apr 2024 12:55:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdfy-0000000BBTv-0ZpU
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:55:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51F6C68BFE; Tue,  2 Apr 2024 14:55:34 +0200 (CEST)
Date: Tue, 2 Apr 2024 14:55:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-fc: FPIN link integrity handling
Message-ID: <20240402125534.GA31497@lst.de>
References: <20240402093031.146342-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402093031.146342-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_055542_506100_A79F1999 
X-CRM114-Status: GOOD (  17.34  )
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

> +static struct nvme_fc_rport *nvme_fc_rport_from_wwpn(struct nvme_fc_lport *lport,
> +						     u64 rport_wwpn)

Pleae fix all this whacky formatting.  Avoid the overly long lines
(in this case by just having the return value on it's own line)
and use two tab continuations instead of wasting most of the continuing
line.

> +/*
> + * nvme_fc_fpin_li_lport_update - routine to update Link Integrity
> + * event statistics.
> + * @lport:		local port the FPIN was received on
> + * @tlv:		pointer to link integrity descriptor
> + *
> + */

What's the point of this half-kernel doc comment?  It doesn't really
add much valye for a local function.

> +static void
> +nvme_fc_fpin_li_lport_update(struct nvme_fc_lport *lport, struct fc_tlv_desc *tlv)
> +{
> +	unsigned int i, pname_count;
> +	struct nvme_fc_rport *attached_rport;
> +	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;

The casting here is pretty gross.  Sounds like the FC code should use
a union or better fix fc_fn_li_desc to not duplicate the tag/len
fields?

> +	u64 wwpn;
> +
> +	wwpn = be64_to_cpu(li_desc->attached_wwpn);
> +	attached_rport = nvme_fc_rport_from_wwpn(lport, wwpn);
> +	pname_count = be32_to_cpu(li_desc->pname_count);

... and if these were initialized at declartion time thing would
get a lot easier to read.

> +EXPORT_SYMBOL(nvme_fc_fpin_rcv);

All nvme exports are EXPORT_SYMBOL_GPL

Also please split the patch up into nvme core, nvme-fc and
driver changes.

