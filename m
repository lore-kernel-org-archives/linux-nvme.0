Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFA1D116EA
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Nov 2025 19:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VAlptIlTrmNyDtwguekUJcn/mQ8zPoUeElwiD02khq8=; b=NgtUk1hlxVgplKC8NuJOthbu2B
	1pQKGlOJ94p9e43LiPUQoXhHn4mWQCArYiWwVcfruPbedhrvpVi+hCX8lEUybDoZ2d3MGnZnSEy7r
	4I2B9s1EMG99tZZRVGwRgR7N6w3IwPwInZIaE6/6qQp6rHHFrQURSaQ3Y3vMaY47PXbMeTwutFNF2
	4zpG3z/F9tQhSHT3x+XwLN2DgkXWS3378jUuUErmFFeeVpoUZjqA/s735s89OnIFvstN6j6FAVo0m
	TWHeD1o0OvaI5dm0wNzviXde6t3+rAXye1YB4DJjHIWyYVdj0WfU1dyrtIEJ2k8iVngVdRHoVaEbk
	BuKj/fag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPR4p-00000001lXP-2KcV;
	Sat, 29 Nov 2025 19:57:51 +0000
Received: from out30-86.freemail.mail.aliyun.com ([115.124.30.86])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPR4j-00000001lWa-1xzb
	for linux-nvme@lists.infradead.org;
	Sat, 29 Nov 2025 19:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1764446258; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=VAlptIlTrmNyDtwguekUJcn/mQ8zPoUeElwiD02khq8=;
	b=Y1RBnAvksFNRn66gORxRUaPsnVO1srnVv4mtpL3OLjGcIXNh86lF8lpoh/UwmfxXz6xMLj3R8hxFBeM2AdobuDptYKKtbZj5GIL/9ZKgLglyClpClHAHV3iwviLgSIVrFsq7SlRz7ZA12NSm4RKI3WOt8XkEwwnBP1wgIT2tOeE=
Received: from aliyun.com(mailfrom:ekorenevsky@aliyun.com fp:SMTPD_---0WtgOH16_1764446247 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 30 Nov 2025 03:57:30 +0800
Date: Sat, 29 Nov 2025 22:57:22 +0300
From: Eugene Korenevsky <ekorenevsky@aliyun.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: nvme_identify_ns_descs: prevent oob
Message-ID: <aStQImuBjWph8Ywd@localhost.localdomain>
References: <aSdiqVR-o6yNav6I@localhost.localdomain>
 <aSdoeEX_L2-3ccpF@kbusch-mbp>
 <20251127144916.GA9423@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127144916.GA9423@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251129_115746_017668_D38300E7 
X-CRM114-Status: UNSURE (   9.03  )
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

On Thu, Nov 27, 2025 at 03:49:16PM +0100, Christoph Hellwig wrote:

> I think we'll need a somewhat more complex check that at there
> is at least enough space for the len member.  But I prefer that
> style over a table lookup and magic name pasting macros.

Okay, simplified the patch. See v2.

