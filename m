Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30147C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 15:05:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE43320671
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 15:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tuq1B+u/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE43320671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hfaeW1i9/bAY9hA+J4MT3KmuDQ/3yIBricZ+Yi6FZIU=; b=tuq1B+u/9V65Bn
	0lve/Q4e/NZkvXiYL9aJ+EsdhXc2QI1jTS9e5X2TUKp7KxjDYs5EkkmVq11jzw/BFbQ65IKPFuOVx
	BGaeQKMc5jwXL4ua6dawjEaNGr5RsmjwMi7VmbLFCafbo1g78EkNTQLmPQu9OFfo39VQ6TTdJrxlg
	DUk8lbG5yHwd3pCefvRhD9INdPrk78Ou6ETmDLIA+6nnOfCp8rj+MI3M5aNKks22Sp4VauNy1FFmX
	1fu4lQ6HwrkxtPyeDZ6gWJr2wngmCm+FvJ3dWWEu8CB1f0i92OZxNiyqX3JtFiWjYFEIAIIs2+HBR
	be2+zXEehk5PPaabTMGw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jahL1-0000TK-VP; Mon, 18 May 2020 15:05:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jahKz-0000T1-Qz
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 15:05:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0579D68B02; Mon, 18 May 2020 17:05:52 +0200 (CEST)
Date: Mon, 18 May 2020 17:05:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH V3 2/3] nvmet: revalidate-ns & generate AEN from configfs
Message-ID: <20200518150551.GB8871@lst.de>
References: <20200518043034.48277-1-chaitanya.kulkarni@wdc.com>
 <20200518043034.48277-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200518043034.48277-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_080554_024949_593C9435 
X-CRM114-Status: UNSURE (   6.17  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	if (!val)
> +		return count;

Shouldn't this return an error instead?

> +CONFIGFS_ATTR_WO(nvmet_ns_, resize_check);

Maybe call it revalidate_size?

Othrwise this looks good.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
