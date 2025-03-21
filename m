Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FEBC35FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 06:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LU8jR4tLP8Gf5oT5m+dnLlCgFlJ9LL0a0GYTgOyh/0A=; b=bJuETPI44vVDFu86Hg1d9EZoJ0
	qtn9GiMcP8pKU6NTHBYd/4Is1MeAqg/qsMMleV8OLxhISvbZHcZBlr7K5R5DPFkNF8KyEzifahaBN
	8JNRwJFW3U8MI1s3QdgI2lXzaTvtw9GV2LAuJErbfQph4JskfWseu4F+Un5B7fl5QOF7fcKyUX4oa
	dSkftygqrgRgi+ggxvb46DczgOvrTxukou/H/r/TkcZBmJmfvmf1Snklr1IS7nASjZOG5LLLFU092
	VU4APRD7PomnbRqkjAfdKteW6dLzBteAxw21A40W4peMTZDG69kbYomiCEdXtUygnhRmC9izFQiXc
	xrltHDJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVin-0000000Dypu-3LCZ;
	Fri, 21 Mar 2025 06:19:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvVil-0000000DypD-1LZR
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 06:19:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E317768AA6; Fri, 21 Mar 2025 07:19:03 +0100 (CET)
Date: Fri, 21 Mar 2025 07:19:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 15/18] nvmet-fc: free pending reqs on tgtport
 unregister
Message-ID: <20250321061903.GG3198@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-15-05fec0fc02f6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-15-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_231907_499268_E4556608 
X-CRM114-Status: GOOD (  15.29  )
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

On Tue, Mar 18, 2025 at 11:40:09AM +0100, Daniel Wagner wrote:
> nvmet-fc: merge with f200af94ac9d ("nvmet-fc: free pending reqs on tgtport unregister")

What is this supposed to mean?

> +	for (;;) {
> +		lsop = list_first_entry_or_null(&tgtport->ls_req_list,
> +						struct nvmet_fc_ls_req_op,
> +						lsreq_list);
> +		if (!lsop)
> +			break;

	while ((lsop = list_first_entry_or_null(&tgtport->ls_req_list,
			struct nvmet_fc_ls_req_op, lsreq_list))) {

> +
> +		list_del(&lsop->lsreq_list);

Another case where I'd really love to help the list_pop helper Linus
flamed me for :(


