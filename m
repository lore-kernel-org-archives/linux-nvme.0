Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEBCCD37AC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 May 2026 08:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x2v5YjErV6q1Y5aouXjRuEa35W3jsUQ6yV0xhv+Pavc=; b=02NBUPS/vW+Tu7OvpRlXP80n4R
	5J6JzwSZ1B8VqMq3ane1hI9bz+EDFaCKoEaIsnf2BGBQdTkPgJHH+DYAt804ZXaOA7kwqNjb7TgKP
	hP097ZSDll4nViP29HgmSBElpSMnErSSVBtzvor8RBWCX+kL4nI+tAPdhpLTiSW3WpUnrcFhItu8C
	uU8wtuhUoZkLdbTzVTZDJS6uzn0EyuTJqkZ13zEAh265lmRUeEI0GrtrXHAmVDlZ/gRTFJEdbAoJn
	0ZaUxjuXo1a7am48ne/S6j9T9CWvQ4Yh60FlKVaR+W9m3aAsaDJW8hNAGZupptxGcL7bZ6iAxHAHg
	ZhezRQow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLco-0000000ChFz-3cBS;
	Mon, 11 May 2026 08:04:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMLcm-0000000ChF6-0bCi
	for linux-nvme@lists.infradead.org;
	Mon, 11 May 2026 08:04:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 922AB68BEB; Mon, 11 May 2026 10:04:19 +0200 (CEST)
Date: Mon, 11 May 2026 10:04:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Shivam Kumar <kumar.shivam43666@gmail.com>, mlombard@arkamax.eu,
	kch@nvidia.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	gregkh@linuxfoundation.org, security@kernel.org
Subject: Re: [PATCH v3] nvmet-tcp: set and enforce a default MDTS for TCP
 transport
Message-ID: <20260511080419.GA29677@lst.de>
References: <DI4KADNWR1XG.ILIR3Q697X77@arkamax.eu> <20260508203912.320938-1-kumar.shivam43666@gmail.com> <d06002f7-2da6-44bd-a0df-d9f2ef87a66c@grimberg.me> <20260511063603.GB26080@lst.de> <cadabbaa-0958-4bfe-9a62-e3f84c146bb6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cadabbaa-0958-4bfe-9a62-e3f84c146bb6@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260511_010424_348058_E9D88B2B 
X-CRM114-Status: GOOD (  11.78  )
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

On Mon, May 11, 2026 at 11:01:18AM +0300, Sagi Grimberg wrote:
> Agreed, I think that rdma is susceptible here as well (perhaps also fc?).
>
> Perhaps we can have a helper for nvmet_check_mdts() that would accept
> the request after req->transfer_len was initialized.

Sounds good.

