Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0217AC25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 20:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gM5QZSuGR1yu39v/ATYUqIjts/KFOGABPj6deOWJI9w=; b=OsAgAJYvco+ypgTJiaDNiE5gkM
	l+OEz11aAhdiGowE6UZwkd3DD6CbRIXwpVb/K3HLydGo7qZpNSVYAIWhJwd7LoBuj3GvDfZloebiu
	7UY/fYG1U+j1YKlZrXsWuV07dWeEbbkJwZatDTobugm2I/Yg1NQXX8ExYZCn9GZjsHYhlGczY4j6D
	syCI4CD7ru41ll3PsKGJIxCvHiC+ZC5WT5+Ypuj1oHoG+StXfhqwUFJZDpCoYwsXHm7MAdUd6aq65
	WZ6xczHgj5NIWIJDco6jJPMIB4RPNguHH0DIUI3JjQUZZgcTnRbeERjQAKquZN/iK0e+Ad4bek0EO
	o9U0hVzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD9FK-0000000BQSb-2Hyn;
	Fri, 31 May 2024 20:53:06 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD9FH-0000000BQS1-3yYu
	for linux-nvme@lists.infradead.org;
	Fri, 31 May 2024 20:53:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 27DDCCE1CFD;
	Fri, 31 May 2024 20:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3998C116B1;
	Fri, 31 May 2024 20:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717188780;
	bh=4cBL8PSfoXNMyyPbVEeK7lNHzCvcgB6JG4qw7Y01ahA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiVCv2VEW7logfyH7AUWAz1GQbDMkNGm+EWQECnevkMqmbS9PlHF0zC5XktzwhXWq
	 hHEKU8rr05YfnrL0YzO/HaFNw7xc1r+fa6a3JYcqQ78CqUHIPDU7dwzd/hADkn+ZH+
	 +as+NV6Qc+fj1BZouJkS7IhQVqrWB8NcEJ/Q8X7HHY4Mo9uW/KoteGkBb47OLYSDjM
	 Ul1o/4bDWvMpDR+zKl807JXDEKtIllMDUikEUqT5XYtim/qQ6+oS+MvJk7cFfF+mQw
	 r3KCIbwL7ljVL7w7K0wfjbYZtnbXLWto39jlQRf6Myl0GhYdSlBW+G5mlYZ4BEVdkP
	 JNwAWPJnobmrw==
Date: Fri, 31 May 2024 14:52:57 -0600
From: Keith Busch <kbusch@kernel.org>
To: Weiwen Hu <huweiwen@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme: fix nvme_pr_* status code parsing
Message-ID: <Zlo4qfY5SFnAIkgl@kbusch-mbp.dhcp.thefacebook.com>
References: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530061646.52167-1-huweiwen@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_135304_191774_CD2B28D8 
X-CRM114-Status: UNSURE (   8.23  )
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

On Thu, May 30, 2024 at 02:16:46PM +0800, Weiwen Hu wrote:
> Fix the parsing if extra status bits (e.g. MORE) is present.
> 
> Fixes: 7fb42780d06c ("nvme: Convert NVMe errors to PR errors")
> Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>

Thanks, applied to nvme-6.10.

