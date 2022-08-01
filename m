Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A30C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 19:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NF4AdhLoUbzaafh/OYUv1qQaXJcOwKQt3vUDkhwPQRs=; b=lQJWamJQl35ianRtNQqZObpesN
	2tqRbZXWo9/HX31D1biHdXF2PT6FLcNUcmyizt8ZMo4Lax68867afIbP3zF/z8d31zbts+IEngGL2
	mrqyqXAD4VLBNsZSSdV4ZF9Rh3NLwbknR/cLi8d3bJefiQi57Aafl51/QUddHVqwYFLpbiMi1epQx
	KwNqOElUqIaB5OxZgqB6eqeeuEMc3m9zw7esEui/awgdpQfxPhFJ5dkC5b1u/EaibdGdRjMXAbGMP
	P+pAf8hUjDuUaemLUIpnscWO4S526KUM+DALZdO0UcXHvWduv5yF0K1a2HjedVRgljpzxuhjwrVWq
	BcOSlLlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIb2N-009nYh-6Y; Mon, 01 Aug 2022 19:25:11 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIb2J-009nVQ-V4
	for linux-nvme@lists.infradead.org; Mon, 01 Aug 2022 19:25:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 96047B81658;
	Mon,  1 Aug 2022 19:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAAAC433D6;
	Mon,  1 Aug 2022 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659381905;
	bh=NF4AdhLoUbzaafh/OYUv1qQaXJcOwKQt3vUDkhwPQRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h9tLPfyPAWqSndYYkGTb0riclIWtYiwASg6iqWYAzotMmYwVoHJDLe6cQxUPoAyYx
	 zLhMNFY14pdur0uFRtbpHZO01XGQygtPQD5y89MPr/7fG9dDQSaOZo4AIofm9zNZ2p
	 l9/ho4WMqzEujTcGfAVd/ciCxL/Lg5RKrBSpkDCUzohJRj7gnnVeGkZuYF70ORVDL1
	 h6zQ1CZEk5yUtttjNWYBRPzF41pwVDMRtD0GynyFBCPHCjYihJG8u5zEWgSOwBeD6V
	 ALJC4oElQSYagG5ZdyA6oNdlCnEFiNeQ7MC/tOOP7ni2gM2sxnlr/Hwln4CLPjw82U
	 FKuG43p/fS9XQ==
Date: Mon, 1 Aug 2022 13:25:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Engel, Amit" <Amit.Engel@Dell.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] fabrics: parse nvme connect Linux error codes
Message-ID: <Yugojr3UKBpuxzlP@kbusch-mbp.dhcp.thefacebook.com>
References: <20220801184039.17593-1-amit.engel@dell.com>
 <YugeneJZJ/ZWPTV3@infradead.org>
 <CO1PR19MB488583421E310A494F86C5AAEE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR19MB488583421E310A494F86C5AAEE9A9@CO1PR19MB4885.namprd19.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220801_122508_166086_576B9A1A 
X-CRM114-Status: GOOD (  10.73  )
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

On Mon, Aug 01, 2022 at 06:46:33PM +0000, Engel, Amit wrote:
> Just wanted to stress the point that its not an nvme error but a Linux error.
> But I'm fine with just say "error: %d"

There's no risk of anyone confusing this for nvme status considering it's only
printed when < 0, so the updated text looks good.

