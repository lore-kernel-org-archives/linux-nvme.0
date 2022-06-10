Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A1FCCA47B
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 08:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4cfo9iam47eZXOMjXmG76u/SVRl8up5whCEXthHYRiw=; b=QA+kwi1elXEp0ax2SjXpVkfS92
	eQHaBNpAtgU2+h6a77N0Aj97pJJHBhlA/E6AXa7rksPUmNDq55GctAMT+2W1iEpFdir+FpR/P+2zu
	Si7HRrjbsw5mHbTefmTTr9hLRZOwSUWPw5VrVmk6F9iRmf66ArVJlhcMwDbRBLh7pj1AWl6lJgA2n
	5EwGlue5J1ZtSuRD0x6BQ8wvGFsUtSul3HBPkXxUdWrMJZPJY1np3niSqgGE5yo4zEN86CwyuSq7a
	B36BD3CXZWzSQSPx02KHrfftcXuAqC0nppsglBQK2S7pAAPnwrtu0UOKHTryXE2NWpl76xPIDQCTm
	jNNhYTHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzZff-006fg7-9O; Fri, 10 Jun 2022 08:07:07 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzZfe-006ffq-6T; Fri, 10 Jun 2022 08:07:06 +0000
Date: Fri, 10 Jun 2022 01:07:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <YqL7qr6p1qDImkni@infradead.org>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
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

On Thu, Jun 09, 2022 at 11:53:30PM +0000, Shinichiro Kawasaki wrote:
> Failure descriptiion
> ====================
> #1: block/002: Failed 3 times with 3 trials.
>     Known issue. It is suggested to remove this test case [1].
>     [1] https://lore.kernel.org/linux-block/20220530134548.3108185-3-hch@lst.de/

It's a little more complicated than that.  The patch mentioned there
isn't actually in 5.19-rc yet.  But even the current code doesn't remove
synchronously, so it could happen (although I don't see it).

I'll send a patch to remove this particular check, the test case itself
can mostly remain.

