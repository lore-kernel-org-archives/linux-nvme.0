Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50491C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 18:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=ry3ZtMaOAdr3dJ+D/9yWKL/PLR
	uPmyoVN5GFvBSO4M41767wzhdUzwdrS2a4op7ZAO9q5FqFt5grYTj55bkU/qG0XtI04Uad5R3NSmy
	9n/iy19974u+drUJFDWjh/Y8niAXipOHe2f/JzVxjALMFhilg6KzI/DFxZDgUAzQ8kDrH2JFB5Bs0
	ImwL08rdcTrFa0DY90YbGQXg5zlUcXIsmezRFu/odG1cWgX7IL16KQJ7Y1MbIaEKlfFUM2SHJGNdz
	4mHG8qpD9mHXCuGmwV46zJQ33gWjn76kiKQr9cNEvYDN5BPjOjvFf7z7bVW9hv4l4bRgajag8D4SW
	ap7HHz5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nS12c-00A5Fi-Ah; Wed, 09 Mar 2022 18:28:06 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nS12V-00A59Y-Ji
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 18:28:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8FA5668AFE; Wed,  9 Mar 2022 19:27:50 +0100 (CET)
Date: Wed, 9 Mar 2022 19:27:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@kernel.dk
Subject: Re: [V2 0/3] nvmet: fix kernel-doc warnings
Message-ID: <20220309182750.GA13216@lst.de>
References: <20220309055927.11267-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309055927.11267-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_102759_848464_FC80D3F1 
X-CRM114-Status: UNSURE (   7.53  )
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

applied to nvme-5.18.

