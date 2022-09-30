Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D8C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1acYUCFtRvjEbuSd9HaBDYmbh3Oh302fy9BZmgl95sU=; b=I96clGVOyNixVFoWaw/5IHq/wv
	MeacOfYJMeky2VRLTgT+TIkjJVMvhCQ3y2pVVOUbxb5NNguao4Nltlm86akIycWroVWJVCHkP1eKx
	3BbNm62mKG/F3Z3Xs5pZ23aHdVfz+THm4dxFK34XXOUSKMw+PkQI9B5ql6b1R5HDiR+oBqzW6f4GD
	eehiSGZ3KJFf8LqzOUUu1pA3P4Mb/0rFCqmuGzQLto5H8yd4mS/uViXwruf3gbvwVNI5QgEJVdhLr
	hVpuSKlLDdpxrPw6R4DJL6qqJOTxqNIJFGbBUI5sOC91h7HONZBKAK9xttx6YrXjGFLmQcntUB9vc
	CmEt/vtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeIQC-00ARKW-N7; Fri, 30 Sep 2022 15:59:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeIQA-00ARJV-42
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 15:59:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 66BAD622A7;
	Fri, 30 Sep 2022 15:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A68BC433D6;
	Fri, 30 Sep 2022 15:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664553564;
	bh=oiMIJH/YyE90Kaik4KiVIajjTIr2/v8irSkheGdEvcI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q6VJGl/3uY+4RZD/9CcUG+zHtX+GYmeAeTjfqTQpLN3U3AD3SzvH6w6MkvcQ4LhUM
	 rcRd6vhiK12MB8p8Yj2SFvbG9y4Pk+xe6G5e/YWA9xzLsoI1tjAP3Oy8JbvharVyxn
	 DUGCrGaBon+uZsopwNDjtwOseNl3DXY2ya+ZcnEhlZY0silUmDRj+kfbuFsAv73TA4
	 DhCrUH9FmMZq7VVLGQZiFKezUvQQann7TwyOTvcJfXPQQvsQmR9C+hQIvDh5c1J4/P
	 IfDzCX+1nwGT1dbEtbQYOi4ryaTM/eYAN2KzrDBJ74dhcO/U78sDHKnMNiaQVkzFfN
	 +B0VD29TJGz2w==
Date: Fri, 30 Sep 2022 09:59:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for
 nvme devices
Message-ID: <YzcSWfgGDR5QXbr6@kbusch-mbp.dhcp.thefacebook.com>
References: <1663908549-118490-1-git-send-email-mikelley@microsoft.com>
 <20220927072101.GC16285@lst.de>
 <BYAPR21MB168828B36AA2022585AC7AA6D7569@BYAPR21MB1688.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR21MB168828B36AA2022585AC7AA6D7569@BYAPR21MB1688.namprd21.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_085926_220785_A9A5D626 
X-CRM114-Status: GOOD (  15.22  )
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

On Fri, Sep 30, 2022 at 03:47:48PM +0000, Michael Kelley (LINUX) wrote:
> From: Christoph Hellwig <hch@lst.de> Sent: Tuesday, September 27, 2022 12:21 AM
> > To: Michael Kelley (LINUX) <mikelley@microsoft.com>
> > Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-
> > nvme@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls for
> > nvme devices
> > 
> > Thanks,
> > 
> > applied to 6.0.
> 
> Christoph -- where did this get applied?  I'm not seeing it in either the linux
> or linux-next trees.  

The path for nvme patches to upstream goes through the nvme tree[1] -> block
tree [2], then linux mainline. The pull request from block to mainline
containing your patch was sent earlier today[3], and we typically see those
merged within a few hours.

[1] http://git.infradead.org/nvme.git
[2] https://git.kernel.dk/cgit/linux-block/
[3] https://lore.kernel.org/linux-block/e5c2a0e5-1a04-50b1-78f0-08d998a8d4e7@kernel.dk/T/#u

