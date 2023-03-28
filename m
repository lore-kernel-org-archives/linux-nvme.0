Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C356C76195
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Mar 2023 00:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mvg5IlghdABXNWg+FE6eFR1rxRZxBfegp/+NCggD62A=; b=VSZspoMfEfe5I64Yg7kjl0c8xq
	4B5zqRk14DdEYqhLNUaj19LTpGoRmAxyAqMZGwp2JvV1l2tTDoTbtQnall6u+jpWZMYYWZonwfh6B
	jEk/HnLPuqk6Ivkcu/4C0P1PdaNF408zFlSczogXXk79ax/KKZhFj/tYvRCaDgmX1rTGEQ23mDvXC
	eH67QgcQUdPXFJr7JlGQ+Uc9bGhK/1VmdQlapdqutfvliolOugsxJPz3mzDhQ8ZzEez4mmnj8DC1n
	BoJHiYCOpq+YjitBCQL/CA0Gl4LIEz8OYbdAnSGjWa1+7PluNjpa+q2NdFncnuDO74uxFEnd3WslL
	uchJncsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxg9-00CksU-02;
	Tue, 28 Mar 2023 00:59:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgxg6-00Ckro-2f
	for linux-nvme@lists.infradead.org;
	Tue, 28 Mar 2023 00:59:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 254BF68AA6; Tue, 28 Mar 2023 02:59:08 +0200 (CEST)
Date: Tue, 28 Mar 2023 02:59:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 0/7] nvmet: use centralize req completion for log
Message-ID: <20230328005907.GA21639@lst.de>
References: <20230323075203.824096-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323075203.824096-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230327_175911_009168_5941BD1A 
X-CRM114-Status: UNSURE (   9.19  )
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

I don't get the point of this series.  It creates a lot of churn,
adds more code, but doesn't seem to actually have any real benefit.

What am I missing?

