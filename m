Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8174C36010
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Apr 2025 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2xzrag8PpFsUkdIvm095lyDSn8ZGOggrglYLt0nVWWs=; b=LnVBL/8sP2pZ6D7Pig2vo2fVWd
	AmtyUZ0IEC3XmkySbzoALSP9pMrttipjT0nU5Tunm5QdI6R/FQweKOSHfw+QPiqCvLAEYCVEpEsg9
	xUjBSta/8euLBIrJsz7k02VXJ0sOFt1237KsmU5ablLf1jrdQQ1MnLQUYmijIwPsCz0L+USCAPNIM
	LtEndT4+YUvAawTBQzfXTKurEC3Cr8SpLXe3jFYP4ex8QN3arnbZY/BYpg9jOEhXoBmnVTPjfXJVj
	68VPpZdkvoZp4FuUdF8Hyp7jZBiZAnffyY1MX/ksb/GXdYfxiqiP6MF9oOMMyPk1u+q40YPr8cC+x
	kV0qWEGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1q1X-00000001KoY-05nG;
	Mon, 07 Apr 2025 17:12:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u1nyc-00000000r6j-2wdu
	for linux-nvme@lists.infradead.org;
	Mon, 07 Apr 2025 15:01:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8430D67373; Mon,  7 Apr 2025 17:01:25 +0200 (CEST)
Date: Mon, 7 Apr 2025 17:01:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Meneghini <jmeneghi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	loberman@redhat.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH v2 2/3] nvme-multipath: add the NVME_MULTIPATH_PARAM
 config option
Message-ID: <20250407150124.GA12900@lst.de>
References: <20250322232848.225140-1-jmeneghi@redhat.com> <20250322232848.225140-3-jmeneghi@redhat.com> <20250403043526.GC22526@lst.de> <f949d227-b3ba-48dc-8dab-d527b82e1246@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f949d227-b3ba-48dc-8dab-d527b82e1246@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250407_080130_885144_C7DC88F5 
X-CRM114-Status: GOOD (  17.65  )
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

On Fri, Apr 04, 2025 at 06:28:10PM -0400, John Meneghini wrote:
>> So maybe invert the option to
>>
>> config NVME_MULTIPATH_DISABLE
>> 	bool "Allow overriding the default nvme-multipath parameter"
>
> So the question is: do you want the core_nvme.multipath parameter
> to be excluded by default, or included by default?

I can live with it either way.

> Keith and I agreed to call this CONFIG_NVME_DISBALE_MULTIPATH_PARAM.
> However during testing I realized that many of the default make 'config'
> rules would end up with CONFIG_NVME_DISBALE_MULTIPATH_PARAM=y,
> even if I set the config rule to "default n".
>
> For example:
>
>  make localmodconfig
>  make allmodconfig
>
> would end up with compiling out the core_nvme.multipath parameter and I
> don't think this is what we want.

Weird, how does that override the explicit default statement?

> How about something simple like this:
>
> +config NVME_ENABLE_MULTIPATH_PARAM
> +       bool "NVMe enable core_nvme.multipath param"
> +       depends on NVME_CORE && NVME_MULTIPATH
> +       default y

"default y" is the default, so it can be skipped.


