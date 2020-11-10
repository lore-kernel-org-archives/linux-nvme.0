Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E59C388F7
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 22:09:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BA0720781
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 22:09:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0M8VERFd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7eV344b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA0720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nf0NgXd+wGLxFflqYcbOKcCbrqg0CJwjDFe7prwntZQ=; b=0M8VERFdlSvX7x0Fc+PAIjbgL
	O9723kCUTCGoR+rckwP0DS+9AcuprK4WhsX0fUbTpODBlH46Go9n2oBWbe49aG3ioBe0+0puMtQGK
	p7ohVLxSsa8BeJDTCJCqF7Utg8bNDDocbOJuGjD7OLeGczQe05kuRagGjxYs6O8AgBqb1Su51lCqF
	vGQBrNLFAU8p2puUNoC8NTh8s5RYWRqxwzfa+MGE5ZNvrjQvS0qusiUGIbaeCUSzePmeibgGuEL+g
	JVuKSRw60ZS9hdBXQCU3UYdW+xt0RzyLZCaR3k+JzcA3AiL2WHq3UT8HOLdSi9v9b+odKqAxAkY0h
	Usk9MzMtg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcbpk-0004B2-84; Tue, 10 Nov 2020 22:09:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcbph-0004AA-Ku
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 22:09:46 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 77B7920781;
 Tue, 10 Nov 2020 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605046184;
 bh=b+SFQtqHEdQhbaPIOA83WMmw90NiKcsRwqBghRiSRzo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C7eV344bjcIhDYWUE+K3JesM5FFIc7SKCobWibaoWwbDwx/vNGdprniyL3Pw+hqIt
 hdOv0RXrmWwXvf1xzLXnDveeo3UOjQjqTHuRB5stiBMsG80hwGs86IEt/xMZEdZTrU
 RQ9m1ug2cQCR/kd/6pXuoO/ppJ0NkF89oNprGwP0=
Date: Tue, 10 Nov 2020 14:09:41 -0800
From: Keith Busch <kbusch@kernel.org>
To: javier@javigon.com
Subject: Re: [PATCH V3] nvme: enable ro namespace for ZNS without append
Message-ID: <20201110220941.GA2225168@dhcp-10-100-145-180.wdc.com>
References: <20201110210708.5912-1-javier@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110210708.5912-1-javier@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_170945_782327_F90E00E6 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 10, 2020 at 10:07:08PM +0100, javier@javigon.com wrote:
> -	if (id->nsattr & NVME_NS_ATTR_RO)
> +	if (id->nsattr & NVME_NS_ATTR_RO || test_bit(NVME_NS_FORCE_RO, &ns->flags))
>  		set_disk_ro(disk, true);

If the FORCE_RO flag is set, the disk is set to read-only. If that flag
is later cleared, nothing clears the disk's read-only setting.

> +	/* Refresh effects log page to check for changes on append support */
> +	status = nvme_get_effects_log(ns->ctrl, ns->head->ids.csi, &ns->head->effects);

That function just returns the cached log; no refresh occurs there.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
