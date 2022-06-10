Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18E4C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nJoujj8pvDXyA4qV3ulg2sZFvMuG1kKmp7viCgMiOFk=; b=ZfjWRc28Z0HduCLjScnDcUV42O
	a8eqProKroHgNK9kdc3yLGWamwh5EOuk/9Kb8iUxGRNCbdnY74N55O1QzxLFM0zO8doIfbTB6aKtu
	VVDQo35DurBzmMqiTOHZPpRKmpXMzc6MpGj08ebqpDPmuOZlUof9oM6InW3o1jhZi7iUFdDEMd/pt
	hMh/LQgXjiNxnBf7GhqyHSoAsDctHlDC3KjolFiXRxqJqbZWCfrUWunGVkGlSPb48C0rNBT2BU39F
	/3Y7mH7Qa+EzQO4UDlBg3sU7wiL2Y2jUB3U8R2uekM5WQPtFFfp58dwaKe7YKwZIxE29Axyi6+WLR
	ix1SWt4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzfN7-008Xjs-Jr; Fri, 10 Jun 2022 14:12:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzfN4-008Xj3-9N
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 14:12:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8DFE61E0F;
	Fri, 10 Jun 2022 14:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE97C34114;
	Fri, 10 Jun 2022 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654870335;
	bh=ERiyAvgO2+Dj9G6N2M7yzPrHT0Qo7PRmp+XZaOqdrLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OZD4Eepdw+//DhJzQRHV8e48vZBlnFDeMn6MjKNKWGXWW6nXjp8ERVz5u/uMA4g8B
	 rn88KBgAx0e2FajKEl1ehGqKWe31mvW8s5ko9SvuzQPHviAOOSmqpGtYAeXq4p63sb
	 2KcxQxk8qgrISl12ZjeXfq1+aigk9ciO9IPyIqSqzPYyoCirtHoE2mYVcpPmRXQESu
	 zi8ZJzoDtzj7C4G97i+Js4umRYW2CvLCCdVrk6UO57YPhkSm1UKP8/B5TW3apYA3Kq
	 FMGRuJ4bKLuYeL/RdlmTXDug5f/1QyxMKQc8ZxCKaOBWtzKYQTxo2EFRwYoF1NWnQ4
	 piQN0QpfbdKmw==
Date: Fri, 10 Jun 2022 08:12:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Alan Adamson <alan.adamson@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <YqNRPEpZgT8Xn9Nr@kbusch-mbp.dhcp.thefacebook.com>
References: <20220411050533.GB13927@lst.de>
 <20220411055455.GA14480@lst.de>
 <C85067CB-3909-4B62-A86D-467827EBF96E@oracle.com>
 <20220420073641.GA6859@lst.de>
 <26796ED5-859F-4844-B1D1-7C2FF5126E40@oracle.com>
 <20220608075252.GB13027@lst.de>
 <F8EC1673-8434-4294-ADAF-96238E65A7AE@oracle.com>
 <YqDy0BIgLbAVRw2u@kbusch-mbp.dhcp.thefacebook.com>
 <20220609035323.GA31248@lst.de>
 <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ACB62F8-BFC4-45A3-9886-E05DB45248D5@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_071218_405135_3BCBD046 
X-CRM114-Status: GOOD (  16.49  )
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

On Fri, Jun 10, 2022 at 12:27:24AM +0000, Alan Adamson wrote:
> +static u16 nvmet_passthru_override_id_descs(struct nvmet_req *req)
> +{
> +       struct nvmet_ctrl *ctrl = req->sq->ctrl;
> +       struct nvme_ns_id_desc *data, *cur;
> +       u16 status = NVME_SC_SUCCESS;
> +
> +       if (!(ctrl->ops->flags & NVMF_CLEAR_NS_DESCS))
> +               return status;
> +
> +       data = kzalloc(0x1000, GFP_KERNEL);
> +       if (!data)
> +               return NVME_SC_INTERNAL;
> +
> +       status = nvmet_copy_from_sgl(req, 0, data, 0x1000);
> +       if (status)
> +               goto out_free;
> +
> +       cur = data;
> +       cur->nidt = NVME_NIDT_CSI;
> +       cur->nidl = NVME_NIDT_CSI_LEN;
> +       cur++;
> +       cur->nidt = 0;

I don't think the above is correct without setting the CSI value. It's just
going to get whatever the controller happened to return at this offset, which
may be a completely differnt identifier type. I think you'd actually need to
search the descriptor list for the NIDT_CSI field and then copy just that one
into what gets returned.

And the "cur++" is just going to move the pointer past the descriptor header,
but doesn't include the descriptor's total length, so setting cur->nidt is
going to corrupt the actual descriptor. You have to add the previous's NIDL to
the cur address.

Otherwise, the rest looks fine.

