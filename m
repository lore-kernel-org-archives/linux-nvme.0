Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C6AC2D0F7
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:14:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E989206B8
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NpvR0hcj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E989206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cpO0XRlFHt0/kiM0kWyoH2A7ra7+K+taHdQm9l7GSHQ=; b=NpvR0hcjGhDJI0
	Q3dcjt3uYYs8s2Zb9TTVMZdLeI62mR4Van5v0pg90FVGmJLbolzFrd+1l70sVmLcFeaPr3GdJFEES
	BJ2QfN1ChdfL/pZAWH7/3KpEUbMsYyRhMLfFboyHyU0QfODBm4HqovKBzRzkDprD6nLbcybe7JR7z
	20kesUY+mSDA9gAGaxvjtDE9DSmvMqhCxaDt7eMdcfjPYXFpiMIabQN5UsWR+lSPAhaP80j+Cwdf5
	Je07Q7/9+gESaBIVuWpH+FhNqek5Ppte4NxOacTehDFKhu3RoJ9A6XNmZjNrMp4U5Kinbnr3Nv2hw
	RlY0XqKMqN31+L2glbTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYXXs-00049w-0F; Tue, 12 May 2020 16:14:16 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYXXp-000496-De
 for linux-nvme@lists.infradead.org; Tue, 12 May 2020 16:14:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9157D68C65; Tue, 12 May 2020 18:14:11 +0200 (CEST)
Date: Tue, 12 May 2020 18:14:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chen Zhou <chenzhou10@huawei.com>
Subject: Re: [PATCH -next] nvmet: replace kstrndup() with kmemdup_nul()
Message-ID: <20200512161411.GC6049@lst.de>
References: <20200508115906.165223-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200508115906.165223-1-chenzhou10@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200512_091413_610590_5E513342 
X-CRM114-Status: UNSURE (   7.59  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
 chaitanya.kulkarni@wdc.com, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 08, 2020 at 07:59:06PM +0800, Chen Zhou wrote:
> It is more efficient to use kmemdup_nul() if the size is known exactly.
> 
> The doc in kernel:
> "Note: Use kmemdup_nul() instead if the size is known exactly."
> 
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Thanks,

applied to nvme-5.8.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
