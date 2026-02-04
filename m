Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC089E83EFB
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Feb 2026 09:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDisSZlhx0D+fIV/tN2cJV5hL1duBDnKhYIi7RLdi5A=; b=SfoRnpXk11m18jI/UFtHr3xQUY
	qzT/69ajBAj4qS/HAj/KYJt1ndUjfDc1oOTvwXppV8u3uVAsbcqQnYzSRSBrVrcGNx8wEOrF1QBeW
	ZGb3Hi4Kd9z395Ev2sNjyRPN6iX7b8EmaYROyqSDo0wE6xOivqk3R1N3c/Uk2/OoryyvtURNGskup
	vKxVyg9GQ9ttJvdEGohHm9qIxlh+Tc3ObRAc5BZEFurZLbGegMZ/bm4UWBTXY3mEI8nXXtMrstsfi
	PySsKEK9e5TatzqU/0TAO03krNbAgSy1VqVbVYj/BM47432pZxhtVsDLr5qb8gSDhBlvYTbUAsxcb
	nRtSg4tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnZER-00000008DM3-3oqc;
	Wed, 04 Feb 2026 09:31:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vnZEL-00000008DLX-2fst
	for linux-nvme@lists.infradead.org;
	Wed, 04 Feb 2026 09:31:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3A3CF68AFE; Wed,  4 Feb 2026 10:31:16 +0100 (CET)
Date: Wed, 4 Feb 2026 10:31:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
	dwagner@suse.de, hare@suse.de, jmeneghi@redhat.com,
	emilne@redhat.com, mlombard@bsdbackstore.eu
Subject: Re: [PATCH V2 1/1] nvme: add support for dynamic quirk
 configuration via module parameter
Message-ID: <20260204093115.GA30821@lst.de>
References: <20260202173857.759565-1-mlombard@redhat.com> <20260202173857.759565-2-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202173857.759565-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260204_013125_817855_BFCC678F 
X-CRM114-Status: GOOD (  15.00  )
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

> +static int quirks_param_set(const char *value, const struct kernel_param *kp)
> +{
> +	int qcount, err, i;

qcount makes me thing of the queue count.  Given that this is the only
count, maybe just drop the q prefix?

> +	struct quirk_entry *qlist= NULL;

Missing space before the "=".

> +	char *field, *val = NULL;
> +	char *sep_ptr;
> +
> +	err = param_set_copystring(value, kp);
> +	if (err)
> +		goto exit;

Just return directly here.  Then you also don't need to initialize
val.

> +
> +	val = kstrdup(value, GFP_KERNEL);
> +	if (!val) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}

Also here.

> +
> +	if (!*val)
> +		goto exit;

and then use separate out_free_val and out_free_qlist labels
to avoid the need to initialize qlist.

> +		if (nvme_parse_quirk_entry(field, &qlist[i])) {
> +			pr_err("nvme: failed to parse quirk string %s\n",
> +								value);
> +			goto exit;

The indentation is a bit odd, usualy this would be a two-tab alignment
or after the opening brace.

> +
> +	nvme_pci_quirk_count = qcount;
> +	nvme_pci_quirk_list  = qlist;
> +	kfree(val);

And once you have the out_free_val label, it can be shared with
the regular return.

Otherwise this looks good, and the parsing is much more readable
being split up a bit like this.

