Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D4C77B7F
	for <linux-nvme@archiver.kernel.org>; Sat, 20 May 2023 04:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDDmTi4u7+LbkQVZgVfHugNxy8QikQCGce+np9i/BE4=; b=1P0JFSeid1jyp8nDiZSKwIwb+f
	6sJDCMhYk78yipOz+yru1mfyhdezNn3d6MgGhL1iEzXMHWbiNRWCO/9rcSBPSlyIaulfohu/zV9HK
	z8DdMaIWE5iC+ROXOXnTTSmuOpX18jw9ehyOGzAEoMCUAisKBRWCtfOxcHlcyhsX41vecqQoOo8jE
	VqUBhNNa0IKk7ixYQStIhRGYXrh7Wl6q7YUMLXzGukmL/wJO6jABTDWVhu18fBCDcqZAVXbAVbLbR
	0VbM++IEuA6/MFwKjRO3Ugmz1Dr8ChafDMs5y0QBKNr76MB+EvXbgCTK1ARRpiFtIviYoDNsblzrN
	iZ7+kp/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EN2-000hGo-1K;
	Sat, 20 May 2023 04:39:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q0EMz-000hG1-34
	for linux-nvme@lists.infradead.org;
	Sat, 20 May 2023 04:39:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7FD2E68CFE; Sat, 20 May 2023 06:39:02 +0200 (CEST)
Date: Sat, 20 May 2023 06:39:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/1] nvme-core : remove redundant check from
 nvme_init_ns_head
Message-ID: <20230520043902.GG31780@lst.de>
References: <20230517220915.7244-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517220915.7244-1-irvincoteg@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230519_213906_135845_D0A05D8F 
X-CRM114-Status: GOOD (  10.84  )
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

On Wed, May 17, 2023 at 07:09:15PM -0300, Irvin Cote wrote:
> nvme_find_ns_head already checks that the list of namescpaces
> in an already existing namespace head is not empty
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

