Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595C1D111A6
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 21:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yD+Cpr7S28K99HYGJEOreBrsZymLymWB6lpHo+wDaYg=; b=fPdICb6zHUMGXkxIqCteUzDrnt
	E5OzTpuUn4rCzq846kC1OWVOF939vBpEZyQfXJU/ftovNo0H39OU6+x3W5XGaxHjYuM3y3XibUAhP
	d7L5xLMg5CGnKNaTPKMLl645ypqvZQw+Jp6h+bj+rQKxoutaJvYiBp32JyMMEiK/eEPcZv12QHhHb
	0g5acU0X02Xs06+PbpRO/QrvYK2NxWhW9ynD7svtdXYnVRZLy/VO82L4Fuooy/OyNMVibvk8/c5yx
	gg+95FoIIK16/uUmvujpMM4X8BWABvLvvb14o8WW7JfQFEZ+5gqEA6i6BrU9COykr8S11RkLnZ7mr
	fYrjZtlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vONKC-0000000FgJQ-1ZxI;
	Wed, 26 Nov 2025 21:45:20 +0000
Received: from out30-74.freemail.mail.aliyun.com ([115.124.30.74])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vONK9-0000000FgJ6-2a2Y
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 21:45:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764193514; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=yD+Cpr7S28K99HYGJEOreBrsZymLymWB6lpHo+wDaYg=;
	b=rZdxQ2dNr7Iv6uPfTAmbUgwyBz2pdDNGlFmMQIP8sonxePiF2Kn+8niTBdomNcOWOf6mV2SBQ+Ngb/9ogY6MgVTnV48jINuk5VCfMr19p174sE3Y23mk3nlT3tye+dKRu+kC4lt7pYN2hEQUY0bULm5yqDbX79mOsTdHelqZ96U=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WtUEZ.R_1764193510 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 05:45:12 +0800
Date: Thu, 27 Nov 2025 00:45:08 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aSd05K1Mkx8ZEARF@localhost.localdomain>
References: <aSdiqVR-o6yNav6I@localhost.localdomain>
 <aSdoeEX_L2-3ccpF@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSdoeEX_L2-3ccpF@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251126_134517_970161_53F8AB57 
X-CRM114-Status: GOOD (  11.43  )
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

On Wed, Nov 26, 2025 at 01:52:08PM -0700, Keith Busch wrote:

> Is this simpler check not sufficient?

> @@ -1566,7 +1566,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
>         for (pos = 0; pos < NVME_IDENTIFY_DATA_SIZE; pos += len) {

Alas size of ns id header+data may be 4+1=5 if .nidt == NVME_NIDT_CSI.
`pos` may be not aligned to 4 (size of `struct nvme_ns_id_desc` header).
It can be NVME_IDENTIFY_DATA_SIZE-1 here.

And when cur->nidl (i.e. pos+1) is referenced later, we'll get a problem.

>                 struct nvme_ns_id_desc *cur = data + pos;
> 
> -               if (cur->nidl == 0)
> +               if (cur->nidl == 0 || cur->nidl + pos > NVME_IDENTIFY_DATA_SIZE)
>                         break;
> 
>                 len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
> --

