Return-Path: <SRS0=Vg0R=YZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FAKE_REPLY_C,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A004ECA9ECF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 22:44:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1700F20679
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2019 22:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Nc2qa/4R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLfWOnV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1700F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=uEVgRJgpy6kNp+jB4q9JMt4ds8izCjnS2DZ4qYdmcII=; b=Nc2qa/4RTsRK06
	ROgAccwOVlQRIYzid3ipUOiEoxp+T+tn3GBcls80rReqtBaoEH1gwHpnc6Z4CTVGI5BjlAmxkWqyx
	87vGpu3Pbgm1ikDW7KQ4bNFb1Qui/nWHHzBtCN0gRvY5UIfh47qFujyvbXCPDbA0hg0YemG1Pvnxj
	3U61lU13Kh9QldtKk5Tbm1E2ZhZ6rXm+GpZ6PwA5Hieul57fq/coQk3tALFaaWtWVdUqV00IdKLSm
	vctuLzXWhhgJFVGlTiU7nCAQi7a9gwBRpv4+Acg+koDW5ZuGq+AaVgd5mQoGsGwQd2D+P3qlwrVZR
	YX+7GPCyk3ceRcWUTv4A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQfeY-0008R0-Sf; Fri, 01 Nov 2019 22:44:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQfeU-0008Pw-Ae
 for linux-nvme@lists.infradead.org; Fri, 01 Nov 2019 22:44:19 +0000
Received: from localhost (unknown [69.71.4.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 49B6B20679;
 Fri,  1 Nov 2019 22:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1572648257;
 bh=jKdvO6K6agf1X5ZMKWmP5BbUA3Dp+9K9j78HOVQdQB0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=mLfWOnV1eB6Wls7fOmu5HwS2ta7iYqfF+lU4Naj8OH/ubYXaEr3/kLNgW57+ZJltH
 MHG42tXl03V3NabxM/fdpPL5bXs+Mb6BOmrlrLLyTlIHTeh05LbkbyHtDToOjdV8Gv
 a+K5JEZAErTjNeGslhGLkVraqB0Ds2UAoyE5QOhg=
Date: Fri, 1 Nov 2019 17:44:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] Revert "nvme: Add quirk for Kingston NVME SSD running
 FW E8FK11.T"
Message-ID: <20191101224416.GA225762@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191031133028.GA4617@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191101_154418_392811_55AD9111 
X-CRM114-Status: GOOD (  13.86  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jian-Hong Pan <jian-hong@endlessm.com>,
 linux@endlessm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Oct 31, 2019 at 02:30:28PM +0100, Christoph Hellwig wrote:
> On Thu, Oct 31, 2019 at 08:28:53AM -0500, Bjorn Helgaas wrote:
> > On Thu, Oct 31, 2019 at 05:34:09PM +0800, Jian-Hong Pan wrote:
> > > Since commit 253eaf4faaaa ("PCI/MSI: Fix incorrect MSI-X masking on
> > > resume") is merged, we can revert the previous quirk now.
> > 
> > 253eaf4faaaa is pending on my pci/msi branch, planned to be merged
> > during the v5.5 merge window.
> > 
> > This revert patch must not be merged before 253eaf4faaaa.  The easiest
> > way to do that would be for me to merge this one as well; otherwise
> > we have to try to make things happen in the right order during the
> > merge window.
> > 
> > If the NVMe folks ack this idea and the patch, I'd be happy to merge
> > it.
> 
> Fine with me.
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

OK, I'll ask Linus to merge this revert after my main PCI pull request
for v5.5-rc1.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
