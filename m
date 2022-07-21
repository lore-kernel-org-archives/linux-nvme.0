Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED83C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 15:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=; b=rJQhCsLZmL3QGOprGYKeDUic8U
	k5XeBHPgzjftdzJWglzkCzeqpx05lSghgrWgWtwmtP5rGH6HZVNDcObtjZr9CrBLajaLJT8+KS2TP
	fH8KAbA8wVMB71DKIXQcLINjVMXLu/Eomsol3osUv21jyByBTu/HKVWbyu3+zQ94LeHruiYgbWguQ
	j0W7EWwwWgbIil9puX/8voNxadHucQFd8ZDhJiheJFDvO9al9eHUzNjMhVVOfQR2Xt2UIuMlbwcME
	9Ok7E35ZpyA+CUs6/HW16ZjjZVEty6b9dIzZBdr93wUT6jQ8fG/zsQHg3ScgvBt5gx1DT4Y10HqyE
	+UWnUtxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEYNH-009Hv3-B6; Thu, 21 Jul 2022 15:46:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEYMz-009Hij-Q1
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 15:45:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id B40D0617B1;
	Thu, 21 Jul 2022 15:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AC8C341C6;
	Thu, 21 Jul 2022 15:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658418344;
	bh=VDs/ubAyB01Bk9H5AnuMOTc54FSGl71vk6BJ6hTW0pU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eflk9JRlH0mR5v36BjiutQUIwF27g65dXET79Wrfi0zPfVOZ9BhZtXuyZXsgpX1O3
	 aT6lDucanr8w32O+UlFC14Q/+sUlR5G/QFVGi6oKQu1adD0MnnsN4RSTz/DfRdS+TQ
	 AMGlKAKMJzYY5SyP6TUkuUfPoJ0vbhCM/F9wPw0wHU1dEzAUnV7jZeFEZidlBN6s4m
	 8KIeGvBGMK64GRWw5AOVVS5lK//gl/PMBiP8TPEFDO/PuVCpvnvvjK9BQ9DcjIL+pp
	 16m16rCbXuxjABQg0hMfmtdHCL/6xgqdGHj6/GsdFyOoIBQDsUBH7IIyzrjN4FOqks
	 EzUQQjQblAbjw==
Date: Thu, 21 Jul 2022 09:45:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] nvme-pci: split nvme_alloc_admin_tags
Message-ID: <Ytl0pOTPSkDm8DoO@kbusch-mbp.dhcp.thefacebook.com>
References: <20220721062506.1712176-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721062506.1712176-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_084545_927216_29AC9674 
X-CRM114-Status: UNSURE (   7.73  )
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

Series looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

