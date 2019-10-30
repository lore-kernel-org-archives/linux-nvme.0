Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C4ACA9EAF
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 06:36:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F7520874
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 06:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="inpJU2DW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRPlrkCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F7520874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uzPl3+Xj/WmVfKprE6BLqm+Vfpjr94FDy17pkzCVzFE=; b=inpJU2DWN6hmZ4
	6QmK92dKpUDAI9NgFZyIk9x6jgcnR0SE3gmLqDtGoR7K/zB5fZc1kjh7QGlkkTuQTjNK3QdmHBa2n
	gZYTjeREzgh7ruiVPMm0IlW8h/L9EVEUTMyv5iePktEUKigIn04pgm1xtgz2FHhuxqDQ376GAGtBc
	dVjqQiKV0iIjmGJYMafm9rpGEHJKEgJMN77lpj35aQhFsQJF+q9ckYWMSSHPnRmIm6UlCJjN+0JNg
	Tjc7obTvwVcl3u31fZtOTs3iuO8Ct2s+pTtVvDpMtFeS9pV8Wtr6LtPTpRjvrRZZ4B2551IiQdXEx
	3MUtOJhTYrs/3qBc4wlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPhaZ-0004Ck-Jj; Wed, 30 Oct 2019 06:36:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPhaX-0004CJ-5i
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 06:36:14 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3475F2067D;
 Wed, 30 Oct 2019 06:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572417372;
 bh=ye+9uTcDFHfW4nG0kg+9QlIaQGEYdj9xh87zTZYlUwk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RRPlrkCeoOTCZI4vuUlCau2Uujy3hLqPtXwlWBgWnWsmBVeBAHhzEnP6r7GjnAVie
 IUItHgHHNk4Rk20C3s1Nodhd9fFIx65Z4XcurjcLU4hICUtoeX4b/uvAahdhueg/nk
 kZ9sHhWagswid0IcxqPMc7GaOcYrfcLQ3NdQ7N0c=
Date: Wed, 30 Oct 2019 15:36:09 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH] nvmet: allow block device to use buffered I/O
Message-ID: <20191030063609.GB16863@redsun51.ssa.fujisawa.hgst.com>
References: <1572409583-3109-1-git-send-email-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1572409583-3109-1-git-send-email-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191029_233613_234050_1570C1C3 
X-CRM114-Status: UNSURE (   8.17  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Oct 29, 2019 at 09:26:23PM -0700, Chaitanya Kulkarni wrote:
> NVMeOF target already has a support to execute requests in the
> buffered I/O mode with file backend. This patch allows=A0block devices
> to be used with file backend code so that buffered I/O parameter can
> be set for a block device backed namespace when newly introduce
> configfs parameter use_vfs=3D1.

Is the fs overhead so bad that we can't just remove the bio based nvme
target? It seems low enough that having a single path to optimize is
worth considering.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
