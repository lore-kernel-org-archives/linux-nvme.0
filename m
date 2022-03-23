Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2E3C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IznW8wrmCBZkD5BwAGQiSM8eU+KwdXLI6muGuQ/WvVM=; b=dTAP8CqAiWtMeqTGPy2Tl+RSxM
	6c1Kz0hfD6JOL1lB6LjN4T9aMOoDqFjxEUaAuWqwFSGgwZyxFIseUXga5y4NPJZ1Oy5DsoJI/fBUz
	qFfI6GMAE4CX3Vl0PKghTZ+KVPOSBunm+5Vu90JosBKCrb2mxgh3rZqaQfprAhpxQ2XrEEi4QVwII
	l20d5+c9ei8qERQ5lm5u3vOtlthZyQuHCv93Iy9+BgFUdTDM50mpdYF+aFIYDsvHl7nN/8N7FS/1c
	vT9NnwxNRHyltO4e0Z3xQSLrS17+yNy0nchH0j0oLEa/NwEYjW2q5Puafj7Y1hHFzhXdQKkOiPuvE
	5Vs2ZV8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWwE8-00D57C-Ix; Wed, 23 Mar 2022 08:20:20 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWwE5-00D55z-Qm
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 08:20:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1AC3D68BEB; Wed, 23 Mar 2022 09:20:15 +0100 (CET)
Date: Wed, 23 Mar 2022 09:20:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] nvmet: remove redundant assignment after left shift
Message-ID: <20220323082014.GB26611@lst.de>
References: <20220318013014.90698-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318013014.90698-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_012018_027124_C8722C9A 
X-CRM114-Status: UNSURE (   8.24  )
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

