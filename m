Return-Path: <SRS0=9Zwh=6G=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C8C5518C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 16:51:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F8921473
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Apr 2020 16:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="No6Xij8w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU1VW80f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F8921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=U5s1ianHcqfZ3Xi9+bmm4VwT/b4s3toH2k/qDMKXLjY=; b=No6Xij8wY/t49R
	qbpezsJ44ffZ9ZI3AxxprnlQtUppTGFI74cLm8ujecBURd7zVxU404MlUlHdY+N0FwMoJfOzQUKvv
	VavPTECo9KOo3KKOW1I2B5o3MeNBbnFigU/TliQPwBvB77SnMBR7D0cXUCssp5EJSWiGeEYaTIezm
	E4iESCWKt1u0S4tgiik1uiCyIfvC5wh8Vtg5NKy7atkdaCr5nH9UNtOUAuJiXuF7GvrTJGq8rcjMz
	GfW6Pwjom/YLWbqfN+tnPAkc7Tkv1uMndtax5Hw2oH+CUpfoWe8qxpGdV7iTkbtZUaNkrBCz2AAvO
	Il5/3GkYMycJhDKgkxvg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRIaz-0006R9-AY; Wed, 22 Apr 2020 16:51:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jRIaw-0006Pm-6r
 for linux-nvme@lists.infradead.org; Wed, 22 Apr 2020 16:51:31 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id CFBC32098B;
 Wed, 22 Apr 2020 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1587574289;
 bh=40K3/UJmJs7QhgN+AoEyMlWfIj1bQbGwf3Ppu4hdV2M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=DU1VW80fhRJc6CtCs4ezhV62kDJaRL0aKEL/APabhkUM7O5uIF9FG1QtUQDuYnvmg
 8zuipc404leZoEcpGinpzB5p/p2L5/sn4h6YSfACoyD3gMI11U3b5Tustx73vfpnVw
 o992j5/gVBViHweJvX2SIyhgBpBAHH42vYjtKgfg=
Date: Thu, 23 Apr 2020 01:51:26 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 05/10] nvme: don't directly update multipath queue settings
Message-ID: <20200422165126.GB14788@redsun51.ssa.fujisawa.hgst.com>
References: <20200409160908.1889471-1-kbusch@kernel.org>
 <20200409160908.1889471-6-kbusch@kernel.org>
 <960c5445-139f-d17a-9efe-ba50d761a4f7@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <960c5445-139f-d17a-9efe-ba50d761a4f7@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200422_095130_271269_E93912EC 
X-CRM114-Status: UNSURE (   9.71  )
X-CRM114-Notice: Please train this message.
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Apr 10, 2020 at 12:45:57AM -0700, Sagi Grimberg wrote:
> 
> > Use only the stacking limits to update the multipath disk. Setting these
> > directly overwrites the stacked settings of other paths.
> 
> Um, but update_disk_info does more than blk_queue_stack_limits.
> 
> Can you explain more accurately what breaks here?
> Who will register integtrity on the mpath disk? who will set capacity?
> 
> Maybe I'm missing something...

Ah, you're right. It's only the limits like max transfer size, discard
granularity, etc... that need to be properly stacked rather than overwrite
them with the last path to validate. This patch needs a bit more work to
split those parts out.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
