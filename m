Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B37B7C36002
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Apr 2025 11:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1VKQkf4zBdasI8ClqzDj/voMdjzkxPW2GOzgtjMwZY=; b=IY5dnhX9vz3g+/MmaynYC3TfVd
	Was4GruzrBQnPgUAkie7BFWI975BdF6bkTvKra8AbtO1JUiLMoR6cVkVIOaD7RPfjq9nDFV6BvWVs
	fCuS3bOaHi/VDjiI0RZmOsEZjLh5zLHXXBXShwadqZTeU/ulA/OffiZAJCLmGIslSIQ10juOaiLMB
	m/S58qKHQTCWdRhTImua/Y8ZvxRRzuHpSdFjgDk4LSWdheB63Ohz9PdmGhnySJhkKBU0LJVGGyvOF
	fp2Fh662+KtOIo3KwFRdgMd3YeR8GMpsmoVuvJuEGt5bgYiqhqYurbb9silvOwFYjjRMGcZei1NrQ
	Z/5bRa2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TFj-00000006wHh-0nMh;
	Wed, 09 Apr 2025 11:05:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2TFg-00000006wGz-1TlF
	for linux-nvme@lists.infradead.org;
	Wed, 09 Apr 2025 11:05:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BFDCB68AA6; Wed,  9 Apr 2025 13:05:47 +0200 (CEST)
Date: Wed, 9 Apr 2025 13:05:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] nvmet-fcloop: bunch of fixes and cleanups
Message-ID: <20250409110547.GA6059@lst.de>
References: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-nvmet-fcloop-part-one-v1-0-382ec97ab7eb@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_040552_558026_35E19533 
X-CRM114-Status: GOOD (  10.66  )
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

I've added the entire series to the nvme-6.15 branch.


