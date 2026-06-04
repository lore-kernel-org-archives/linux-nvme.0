Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E214CCD6E57
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jun 2026 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h86ne8y5u3N9ZFf8Smc95PVrrE6CVW9lOultviEFDuI=; b=oyWIhqLLR5Ohgi9o+t6jV0FdAr
	AK6SrUx2M9mOBCLsAVOCJLTSNC4TuPnnOnXebjlQt00ATmYcdfJMVxgzu5f0RP3A50T7juUg2F1tx
	ZYx/fQcSJrKxfOOdKYXn6epk7VuMM7J7xwxTTJOzO40s5o/WCnTrdwlxIIFCYaS29QKBuO43YwE02
	a/Z0SvhjE8i6I29KZVuzyTTnhPKJwJFvpQAReeBH500QsCKZvNwAu1HQT+yHZmcczTldRuNf7EJ06
	exIQ9CBb7C/pKvPNaqMDttaBdJtto9zUD+BAPfDzT0UKGWoKxyzjH3vZBhszZTv53FQJC2RxUx25W
	ul5vnSwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV3u4-0000000GRqM-2qIs;
	Thu, 04 Jun 2026 08:58:16 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wV3u3-0000000GRpq-1qdl
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jun 2026 08:58:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 83F68601DF;
	Thu,  4 Jun 2026 08:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8D91F00893;
	Thu,  4 Jun 2026 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780563494;
	bh=h86ne8y5u3N9ZFf8Smc95PVrrE6CVW9lOultviEFDuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CoVZZXdSiQaBHY3510XDMq7hQQnxz9xHQ4FBRCqVRJSE26cGa/wyIza2/BHLsIrSe
	 8PorHZaSA2DVFRe4LGIFitYlNE03Do2M7LbwDQaBq3f9DxRMd5jr8zm3Qo0q/1khPe
	 d/kiHC1nEn7y0lgapkg0yUEk6ZrUgHx+rZrQSNvAkCgt3foyWTjxQNi3bvLEg+yruG
	 rv0FftYUoT+u3F304kkZBvIi91JRO+wyfSuCHtbVnYeyEb83GUe74KHj+VRILavSIU
	 qcZszWv0Dt0vj4q+FPDUi0ysOVIMMQaV7eb2+aW/DlScClH+AGNHiP8YMGPe08b1nb
	 tnikB35zshnbg==
Date: Thu, 4 Jun 2026 09:58:07 +0100
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, dwagner@suse.de, hare@suse.com,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	chaitanyak@nvidia.com, venkat88@linux.ibm.com, gjoyce@linux.ibm.com,
	wenxiong@linux.ibm.com
Subject: Re: [PATCHv4 0/8] nvme: export additional diagnostic counters via
 sysfs
Message-ID: <aiE-H8RAeUPoGphJ@kbusch-mbp>
References: <20260516183709.269937-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516183709.269937-1-nilay@linux.ibm.com>
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

On Sun, May 17, 2026 at 12:06:47AM +0530, Nilay Shroff wrote:
> Hi,
> 
> The NVMe driver encounters various events and conditions during normal
> operation that are either not tracked today or not exposed to userspace
> via sysfs. Lack of visibility into these events can make it difficult to
> diagnose subtle issues related to controller behavior, multipath
> stability, and I/O reliability.
> 
> This patchset adds several diagnostic counters that provide improved
> observability into NVMe behavior. These counters are intended to help
> users understand events such as transient path unavailability,
> controller retries/reconnect/reset, failovers, and I/O failures. They
> can also be consumed by monitoring tools such as nvme-top.
> 
> Specifically, this series proposes to export the following counters via
> sysfs:
>   - Command retry count
>   - Multipath failover count
>   - Command error count
>   - I/O requeue count
>   - I/O failure count
>   - Controller reset event counts
>   - Controller reconnect counts

Thanks, applied to nvme-7.2.

