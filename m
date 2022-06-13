Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4900DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 17:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=ijHgPE/xYiUNWAE2leHDtXdHt+
	8bXB+8/RyylODLrNJBz+owvsO5pYOMVP8i9WbFp5VwhC/HCMtas5z+uNkrrxbMhGB7U2ULjGu5Q85
	LyelurgaTambzSEz3VgS3gLcAOjlg14wIH/AaRPWVwaQ0NSkeC+CTeIJNEZO8UgnvqlcRScbBOEtj
	jxWuWFoF/Z2V5DFmxAX/eItFwknabFYXGp89OXBUn3/vez+7I9+WPEqYX5lKKalRtVPdTzkHA5SWl
	cvM+e8zzzb9dcY+/QQHxTu+qpf0Kx0TWICxJ9r8qVNJPLSC15NO0dP4aCjZJ5T4G74dz3hzFU26l+
	IBcHheHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oJz-0053kP-KD; Mon, 13 Jun 2022 17:57:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0oJw-0053jV-GI
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 17:57:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BC0F268AA6; Mon, 13 Jun 2022 19:57:45 +0200 (CEST)
Date: Mon, 13 Jun 2022 19:57:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: add bug report info for global duplicate id
Message-ID: <20220613175745.GB15847@lst.de>
References: <20220607153029.157439-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607153029.157439-1-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_105748_715948_C8852DA8 
X-CRM114-Status: UNSURE (   7.43  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.19.

