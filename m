Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C709FEB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 16:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yg5onB2OgXsiQiha5TtHJZjd//sUNSjRWGvbzA1U+FU=; b=Dm0AeKNwxJdcuSjxNm/4ZhT3Xv
	ggve9dR0ihkzuy9j3h0J3j2Cs0oXbogb3AnzHzdAGl/hXrLWcMnRduxUOoE4mxIPp5w89Ep1NqDlT
	65PDS7i91KybHQcBHPNFpdAMX5gr/3XWM3g+C0d6ew1I+c2F2gqMtgLi8nzcIsQ7FJiLQ6rx+CtUS
	nybYS7NH1Hb2OHzHcFYPAhrLobbM3D2MZ/o4+yODOocOgArlSC6C793j2BS9o1jYsj6VcIs0EEMvi
	nXZAGys0o8vOUX9SPATrKx/hMlIcn9RXhunCfTRehx5Umfvt+f6E8rUaPO4SSfb+U+MQbTYILLP5K
	sGoztv0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJce2-000Zgf-0F;
	Wed, 12 Jul 2023 16:24:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJcdz-000ZfX-1i
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 16:24:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 76F4761840;
	Wed, 12 Jul 2023 16:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B19C433C8;
	Wed, 12 Jul 2023 16:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689179085;
	bh=DF/+iyxPNYggGgJOjGMCIcXVlFOGAiZaFb413XL2+Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o7vtEPFSdExxbZFsHxCKgKOwqq5y2FFeHV2YaIQgvrT0FV00R26p/Qupx62U+Z8rW
	 24N+mJYTLsqUFyMW3jcdnUgQq/OgIDUMGJxIQDl+zKkFNRWpz6eP40ICqzO4TvDqfC
	 ez+RXV5qAUlZA2QY+URONfOObm8uHRdwE9HXNVZ5slSTDmXooTc+5pllQkLvwtf3Wz
	 OekBNabFCZwDbDqugJvsl+c52mQUgwPvBxvtQnFMkuxsoxYA8T5r0D9jSDj7zqhHpM
	 RTec/QJ4LNifvZ+uE7MnHidORnWS4FUvg3EeKiEh+zjb9/9L35ip3Qeaigwcz1QOpC
	 KJAPlRV9SRviw==
Date: Wed, 12 Jul 2023 10:24:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv2] nvme: ensure disabling pairs with unquiesce
Message-ID: <ZK7Ty43VK1y32k6S@kbusch-mbp.dhcp.thefacebook.com>
References: <20230712154004.360561-1-kbusch@meta.com>
 <20230712161327.GB28835@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712161327.GB28835@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_092447_625984_36D2B15B 
X-CRM114-Status: GOOD (  16.17  )
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

On Wed, Jul 12, 2023 at 06:13:27PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 12, 2023 at 08:40:04AM -0700, Keith Busch wrote:
> > +disable:
> > +	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> > +		return BLK_EH_DONE;
> > +
> > +	nvme_dev_disable(dev, false);
> > +	if (nvme_try_sched_reset(&dev->ctrl))
> > +		nvme_unquiesce_io_queues(&dev->ctrl);
> > +	return BLK_EH_DONE;
> 
> Just curious, do you remember why we do an explicitnvme_dev_disable
> here instead of relying on the one at the beginning of
> nvme_dev_disable?  This isn't new, and the patch should not be blocked
> on it, but it looks very odd to me an we'll need to either document
> it or kill it eventually..

You mean why not rely on the disable in nvme_reset_work()? Because we're
in our timeout callback and can reclaim everything inline with the
notification. If we defer the disabling to the reset_work, the timeout
workqueue will keep running for potentially 1000's of outstanding IOs
for not particular reason. Not that that's a horrible thing, but it's
just inefficient. This was one of the nice benefits of switching the
timeout handling from a timer to workqueue.

