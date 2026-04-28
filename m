Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FD3FF885A
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 07:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p+Zw6kMbEJwbaX/6Vrnq1AIdHS1K3lW+Eb8qxELrAGE=; b=YtKJxvVldslwuKQjRIAKRnA582
	i87aLCaBwO7G8Jx0FXz5P9YnJZUG3IU7y9Y7/8eTtcOgj/Zfl2gQq1TLdPhUm08eQ81WPKvcC78CC
	5gLIQtLed84wRBOgEzB5tx+rtecPHPHCOzi8y/OvlH0WbDsnaMr6Bm0RmXP/lyZEzSuIHORxNaDvc
	mljuC8VlgzgjRJh4/f6T/+GOXNki+zd+R5JGkggv/8LqZpIQkqdrzP8BO/4BM4YzULVUspDjnHp9i
	POcy6rf0on4RJOg/FK0jt6LWPSj8VPrfMe7c9iMtIvAXdsQjH7Hw/9qoIsG/9Q/O6FVAx6bXQz0P0
	wMlw0FxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcoM-00000000lKa-0wvo;
	Tue, 28 Apr 2026 07:24:50 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcoH-00000000lIn-2DsL
	for linux-nvme@bombadil.infradead.org;
	Tue, 28 Apr 2026 07:24:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p+Zw6kMbEJwbaX/6Vrnq1AIdHS1K3lW+Eb8qxELrAGE=; b=mzak8JizOiF2Vwt/hZIxUvmeBN
	J0rKzPpjRaTUBXJ6enQnrB2SK6gZx/oMArTq60ip38a3G+9aL9HjDx9D5G1JbUhUqEu6bDF3goiaB
	qMXkxa30QgDBuvja5fxYypHdcTRDBBpzHcLfS31NNjKqRa2Hq9Q3jFrt2iT6hvWM0G/f5EP4+DSI7
	PRL2uvOqsOFjQrANndnVdUYFTbm11Us6r3VROWbr/zEkIbNGehi4tzU+vxaNKFRCb9npqz6ObJXoG
	YpfqsAfcXFbB0HpatgPyTUWQ/GhgqNM5yEJClrreL10ZxgLXpxbY6v9/7zw7BOuEdV/ZB+Jwp9/bB
	kSNeloNw==;
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHcoE-00000002Eu3-1eEO
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 07:24:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2945741AD2;
	Tue, 28 Apr 2026 07:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064D6C2BCAF;
	Tue, 28 Apr 2026 07:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777361080;
	bh=s5kpur2x5Tpa99eqjwjmAfYfW4fARvsO8IVb2qcAh1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HDaiKFdHMXUq7xW8j8wuSJTnJVfrbE1kZCBN7duxv0OJKWUpNmA2cNj5v/N7VBZwq
	 fGvzHFDGslK1Fj8E2/cwg26J6DL6TQGPDLf0ETQuOT4/4Xbj3YC+OOZfyZ6vgFtAvg
	 FrUW8A3QOFR4YGi2koIyZITKUohnllFU1NSa9rQlLRTUdpIHbm5edebroEOo4Ke8xc
	 VuWw7+7kISl8S8ePAMtEwNW3mkJfBz0jOXIvdtbPAPwus3ZQrwdT74/7ytQ6dDlJ0J
	 JjScVTZr9a/ig4liApmsoTDcObi52nO3LvCVQRdPJ3K8hyRmoNXcjI70jUmHjcdk/9
	 iv0cpN2W6t4SA==
Date: Tue, 28 Apr 2026 08:24:35 +0100
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@arkamax.eu>
Cc: Chao Shi <coshi036@gmail.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reserve a keep-alive admin tag for all transports
Message-ID: <afBgs0f8Et3jqijM@kbusch-mbp.client.m3-hotspots.de>
References: <20260428022911.1288485-1-coshi036@gmail.com>
 <afBYFfZJjiDDvlLv@kbusch-mbp.client.m3-hotspots.de>
 <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DI4LPUI48MRH.3GC5TVZLMICXN@arkamax.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_082442_688354_FEACD872 
X-CRM114-Status: GOOD (  10.54  )
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

On Tue, Apr 28, 2026 at 09:15:10AM +0200, Maurizio Lombardi wrote:
> The spec 2.0a, at section 5.27.1.12 Keep Alive Timer (Feature Identifier
> 0Fh)
> 
> says:
> "Keep Alive Timeout (KATO):
>  
> This field specifies the timeout value for the Keep Alive feature in
> milliseconds.  [...]
> The default value for this field is 0h for NVMe transports that do not require use of the Keep Alive
> feature (e.g., NVMe over PCIe). For NVMe transports that require use of the Keep Alive feature
> (e.g., RDMA and TCP), the default value for this field is 1D4C0h "
> 
> To me, it sounds like for nvme-pci, keep alive isn't required, but could
> be activated.

The spec says the support is subject to the Transport binding
specification, which does not exist in the PCIe transport spec.

