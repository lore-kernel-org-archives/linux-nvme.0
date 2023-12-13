Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6DDC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iblK8PWifvXl1Cc+Cvnjk7r6XjhYOOAF9jHxgrH1saU=; b=KxSMlquFROYIwCo5oCnUWvc9Tf
	u/U5A96oW9s8lp9AjqAXEu7j2mv722CC2Y201jkxP3t/26MBolVAuvM5DIw20xUql0RsQPJRapEj8
	oE2hiYumy5TXi/WLjmctxu888ilE92rb1Py86ETnGcf6gWctK6tXR5mlrB/c4tXQKgfJb6sQX3rrl
	EqwPKTIJUs2UVYSJnw0MMXihSD0jyDPBd5JuJ23RS+TSIT+0pBVfPKTulqchgzVG8oU/gwie/MISF
	BqVfW+qaMhO+KN9dG7NEZZastXiwJW2WOmLGASZ7a2vIpjxlXqVB8w4eFysHN6mKuG/iGyd2UQE6q
	LPttpD4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKv2-00E516-2u;
	Wed, 13 Dec 2023 08:48:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDKv0-00E50P-2L
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 08:48:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7A2FF68C4E; Wed, 13 Dec 2023 09:48:35 +0100 (CET)
Date: Wed, 13 Dec 2023 09:48:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/5] nvmet: return invalid filed when check fctype fails
Message-ID: <20231213084835.GF6184@lst.de>
References: <1702449172-8920-1-git-send-email-kanie@linux.alibaba.com> <1702449172-8920-6-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1702449172-8920-6-git-send-email-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_004838_910025_DF074372 
X-CRM114-Status: UNSURE (   9.17  )
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

On Wed, Dec 13, 2023 at 02:32:52PM +0800, Guixin Liu wrote:
> Return invalid filed status code when check fctype fails in
> nvmet_parse_connect_cmd().

Hmm, the fabrics command type really is part of the opcode.  What is the
reason for you to prefer one error over the other?

Also s/filed/field/g or better 'Invalid Field in Command'


