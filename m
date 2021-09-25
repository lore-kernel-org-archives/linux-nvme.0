Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F57C433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:49:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC78461090
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC78461090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bUkoNKMd179w1dFe5lBt/Y3N6IphDq5F46kh7CxBgxA=; b=KfZR6/AxmSPFK8
	sww+adCQaN13kF4o7qWoFIjjCNqbahSZBKqEUxj8x3+7bl2dK6bOWi4ZGp7giF1UV9joGKidkV5FO
	u6upNYig4ULB0GVamWcngYludh7f2bnousrhzZP3mReDazRY18C6jZqlELgh0RyrakDQfSxgSOvX2
	dzCYaAuWRQe4kexX5eAdpFoySKBaTnOPzHtPRiVeKdaMJXp5LRy78CXG6cl7X/z4NpjNoo9SaHCQV
	oLIwntl9FVH3lzkD0l9cdYecoAzGlV4qd51FKwBMNpF+6Y1aKwiUITZm/dqze651ro0XldatM2VcY
	FsRuEq6uiIwwwSJtmwng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUEbI-00HECN-1V; Sat, 25 Sep 2021 20:48:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUEbF-00HEBo-TG
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:48:47 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6DC1760FDC;
 Sat, 25 Sep 2021 20:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632602925;
 bh=NggOH7O/zGplTburqq3IZcOMmY+4gej0SMCZZNCnimY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=goylx51MfdTmhiW2K8fU4jNFQL4dzr6tzJumETyia3nS4hy2sIH1ZGTi4dVIX84b8
 M4HqM48oHoJqbLv85egpScRQq3isO+N/eHEGAVBVvHoZgl6rKNoTCpajxRblPEkelJ
 eP2JGnF7As9iaiLDA+/6sKyuRqB52/0mrym1sMpUTVJeKR5Cmu1X+jbro+6R8YVRyz
 4fh35QskMDsEtMyUSBjmTNaLoz07rPlY2CpWHzU0348dSxXSlHrW7+9ungfAvMpe4C
 SKUc/0LY/X594U8D6EjqFJkK5Y3vHbDR8QDHt9yv5XIyB4+ccOkPH5sHdnw2iGLXoQ
 KvXi5q+zlE7SQ==
Date: Sat, 25 Sep 2021 13:48:42 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Aditya Garg <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <20210925204842.GD116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_134845_992641_E534C594 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 25, 2021 at 11:34:31PM +0300, Sagi Grimberg wrote:
> Exactly the patch that I was going to propose. The only downside
> is that we need to access the controller in the hot-path...

I initially had the same concern but noticed we already access 'ctrl' in
nvme_setup_rw() in this path, so I don't think we will be able to
measure the cost of the added check.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
