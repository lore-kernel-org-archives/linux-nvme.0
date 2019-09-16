Return-Path: <SRS0=XVsr=XL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F7CC4CECC
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 08:03:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA491206C2
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Sep 2019 08:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UcG6mhxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA491206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wzeD7iqdqN1v0V6g364AFpdmKsLU2zyo83bDS+3EyWo=; b=UcG6mhxwvEkd70
	RaaY5LsP0skZtwdZgeL6uzJc9Vm5uI1draJmHW9L1oEXi+qlGZkpPYTduaNs5tc2BbmPhWQB2B/Sz
	cpK+tK1zD8YqyNl/yJFROKRJGU6aM6a+19Zp0y1o2LpIT+QC22EvmvSfJMeCPsviGoEVmqk/Ws+0N
	hqK3zOTJ9ZAFSB5Sp/VmNLJFJIVd8xUl4hNM9ZbRYqZBmjDQSpEL6Xx5Voos1hCgIx5z+ealoZlM1
	5/OzWozgmFNQXyodagRraUBPe54ybKBPd2ZpquESJNRAWy+7LW0K4Pbu1juEKSb5xP6D0b4+e/mtp
	id04/FIRc1QhKLn2fYHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1i9lyw-0005O6-Qt; Mon, 16 Sep 2019 08:03:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1i9lyu-0005NZ-Cg
 for linux-nvme@lists.infradead.org; Mon, 16 Sep 2019 08:03:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 169BA68B05; Mon, 16 Sep 2019 10:03:29 +0200 (CEST)
Date: Mon, 16 Sep 2019 10:03:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 1/3] block: centralize PI remapping logic to the
 block layer
Message-ID: <20190916080328.GB25898@lst.de>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
 <yq1mufei4zk.fsf@oracle.com>
 <d6cfe6e5-508a-f01c-267d-c8009fafc571@mellanox.com>
 <yq1d0g8hoj5.fsf@oracle.com>
 <61ab22ba-6f2d-3dbd-3991-693426db1133@mellanox.com>
 <yq1k1affx8v.fsf@oracle.com>
 <e59b2d78-4cf6-971a-1926-7969140d2a01@mellanox.com>
 <yq1lfurdejc.fsf@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yq1lfurdejc.fsf@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190916_010332_580718_4FFC098A 
X-CRM114-Status: GOOD (  11.41  )
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
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, sagi@grimberg.me,
 israelr@mellanox.com, linux-nvme@lists.infradead.org, keith.busch@intel.com,
 shlomin@mellanox.com, Max Gurtovoy <maxg@mellanox.com>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 13, 2019 at 06:20:23PM -0400, Martin K. Petersen wrote:
> 
> Max,
> 
> > what about broken type 3 in the NVMe spec ?
> >
> > I don't really know what is broken there but maybe we can avoid
> > supporting it for NVMe until it's fixed.
> 
> The intent in NVMe was for Type 3 to work exactly like it does in
> SCSI. But the way the spec is worded it does not. So it is unclear
> whether implementors (if any) went with the SCSI compatible route or
> with what the NVMe spec actually says.

Do we actually have Linux users of Type 3 at all?  I think for NVMe
we could just trivially disable Linux support, and I suspect for SCSI
as well, but I'll have to defer to you on that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
