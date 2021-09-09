Return-Path: <SRS0=/7z5=N7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED75C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:48:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A1DE61167
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Sep 2021 14:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6A1DE61167
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rJdcPReHbWns2wCPUqd2bsjP3pyqzLmNnZJkXiJXRfg=; b=GM704d4EmAV+OX
	yu3quOaSh43OjZNt5mO15LJrZugeHCtcry0SoI4fvRfe9/Qe/2yQWcVMqRv66OZ/X57LXRCttaz2w
	lbAmUbvWb9lBAzG8MUl8ynl2DzbmGf1nBvQ3YbWFZIAgfkpSqmEiptIB/ZrIPfoQJm9hs8Vg1ddDY
	6G2bnqS7uiu+tQugFD0HVh1mvllneN9tuRuQSyFq46jcaquW3zbLn47uiqbV13j0Qsa+dJxGwDSHt
	/Jz6Hql29dXNYkbJty22PPr/iiCL99DRYtAPirGAINiw9LWXfOhi4kyk8gQ789MTypaRC14KQJ+wC
	cvUxAdkVvbrzj2YNx0/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mOLL7-00ABWs-EB; Thu, 09 Sep 2021 14:47:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOLL4-00ABW9-Id
 for linux-nvme@lists.infradead.org; Thu, 09 Sep 2021 14:47:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAEF0611B0;
 Thu,  9 Sep 2021 14:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631198862;
 bh=Dz/OOUamLZNNHgporcJbIVgfcdT9MPY39TSGUVp8YKg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IlXZ8ig5LFKt5nySMsmNqcvj9N0NGiSHlJnSyYkoEaErTynyQqibuV7k3LT1w7vjo
 H0jy+qQtpWi3aBvryvheZhPM008LNRfdXPofGsBN02tQitwSDwNgXSr6dUMu/AgvhY
 9ducIeaNn6lyD0/sbi/V90SDfoUb2XNzbkfWCkuWcOxrySPn+v46yC56akSRA9Iv7s
 Wez8eeyovNqtcFHsOtV63plqtlMc11iwD5Mrkrjia0QwNVL8vPRys0EDwklvJ3gYhA
 V4kb5ksdiUCKkPSg5KREYd1NZca/zeqf0cxrvV6EOoD/zyty+fWsniBq3ag3gEz+e7
 DyIaOdMZPO1Kg==
Date: Thu, 9 Sep 2021 07:47:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20210909144739.GA2464330@dhcp-10-100-145-180.wdc.com>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210909_074742_670822_3C7DED04 
X-CRM114-Status: GOOD (  10.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 09, 2021 at 05:50:21PM +0800, Jiapeng Chong wrote:
> From: chongjiapeng <jiapeng.chong@linux.alibaba.com>
> 
> The error code is missing in this code scenario, add the error code
> '-EINVAL' to the return value 'ret'.
> 
> Eliminate the follow smatch warning:
> 
> drivers/nvme/host/core.c:786 nvme_configure_directives() warn: missing
> error code 'ret'.

Nak, the code is correct as-is. Returning a negative error for this
harmless condition will result in disabling the controller when we can
proceed just fine without directives.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
