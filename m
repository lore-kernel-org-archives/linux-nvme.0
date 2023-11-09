Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE5BC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Nov 2023 15:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7PMth1YYD4MVgW3ezlUn7IyqCk2zHlsXZPmD/vhq7q8=; b=pL87JtzIl0fTW5s2VvfrzgGRI7
	eimT6zvv7JfxxGkII1UFz+AQKyFyPIlA39b/MCzaNJJFEdd+sjNLur6mz6OaLpOikntTW6+AU0KIK
	qdeHKjZHo3q39LT3xloZYh0jlzZh3GmXWkmgf+ok/wAtcNYnDmR8/2Ovj9d0PiA+2e51TgYKfgFhw
	HhsLgzUakGFpJu0YSC0aMXpwRDKrFshBL50Qf3r5ooNB5LXSwbGSgrIC+ohlQnorNLgrTjz216YgL
	8JaKL85ZGXIWHyV5g43mkuZg+CHuPXDT4N7Y4fkAuZKQe16P4DA1+k9lJdHeWP0tdwWv1jgpcDDAe
	4BLcmsnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r16tI-006a8C-2g;
	Thu, 09 Nov 2023 15:24:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r16tG-006a7N-0V
	for linux-nvme@lists.infradead.org;
	Thu, 09 Nov 2023 15:24:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40FE467373; Thu,  9 Nov 2023 16:24:13 +0100 (CET)
Date: Thu, 9 Nov 2023 16:24:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	chandan.babu@oracle.com, dchinner@redhat.com,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
	linux-api@vger.kernel.org
Subject: Re: [PATCH 12/21] fs: xfs: Introduce FORCEALIGN inode flag
Message-ID: <20231109152412.GA1521@lst.de>
References: <20230929102726.2985188-1-john.g.garry@oracle.com> <20230929102726.2985188-13-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929102726.2985188-13-john.g.garry@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231109_072418_337613_E874DCF1 
X-CRM114-Status: GOOD (  13.71  )
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

On Fri, Sep 29, 2023 at 10:27:17AM +0000, John Garry wrote:
> From: "Darrick J. Wong" <djwong@kernel.org>
> 
> Add a new inode flag to require that all file data extent mappings must
> be aligned (both the file offset range and the allocated space itself)
> to the extent size hint.  Having a separate COW extent size hint is no
> longer allowed.
> 
> The goal here is to enable sysadmins and users to mandate that all space
> mappings in a file must have a startoff/blockcount that are aligned to
> (say) a 2MB alignment and that the startblock/blockcount will follow the
> same alignment.

This needs a good explanation of why someone would want this.


