Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4840C3DA7F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Aug 2024 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MosPvsDBr6sDmQ3PGh0QsjhygL8SN5h2UfyY6fUGFnI=; b=SiW+URJ929K5TbiSG0bmaKMQog
	vB/PAoJqepJwgu4djWZyosc24/p0HHFtsghFiboz6twKvPT3zvV/JRqN0Md1OVYruNxda1ZyQp0g/
	fhTqSJx2cMIBUYU9x0CuyEoRlbT0hJeHYYRn0EneMyt66P8GEXQm1fhcZFc2BajnRIokK8Z5JuCHO
	TLd0AS3Nd9LexT/2L+RbOBz/YtqkaNkVefgz0/qjuSLrx0F5tnjnS1jTPyLFpBa5gM/jGSdww72vg
	WAEsmuGXQzFlosVhLIIA5ENJy5eYLrarFvLPLvkTYtxq2i9TQK2ocW76rDE3gdkdpsrko5NVweVPq
	KxdiagpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seVv7-00000009Oif-1Zpi;
	Thu, 15 Aug 2024 08:33:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seVul-00000009OgN-3HfP
	for linux-nvme@lists.infradead.org;
	Thu, 15 Aug 2024 08:33:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0EA35CE11B7;
	Thu, 15 Aug 2024 08:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFF3C32786;
	Thu, 15 Aug 2024 08:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723710777;
	bh=xmuV7SBrKLod7Gy80/YSA4b+g/dPXWN6wrTUi8MLbYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqDajJqxkuEbNHKYpluKcidT9jgSov4JHgzIBZBMLkxTzlQafPUc6/L9d6D1j4Fpo
	 L5Gsve2ri5xtko7DTjQnGqR8O5tfKLFA2w8DF07J8g+Iq60C9t20+pZ3ZO67hqyE6k
	 Iwr7cGnZW3BwRVdcm+0s6+SofktLu1sgzbpogSig=
Date: Thu, 15 Aug 2024 10:32:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, keith.busch@intel.com,
	axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	xuerpeng@uniontech.com, hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5.15+] nvme/pci: Add APST quirk for Lenovo N60z laptop
Message-ID: <2024081547-unfounded-dumping-9d42@gregkh>
References: <722C75CD96F242C0+20240731071827.112255-1-wangyuli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <722C75CD96F242C0+20240731071827.112255-1-wangyuli@uniontech.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_013300_013641_9447471E 
X-CRM114-Status: GOOD (  12.71  )
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

On Wed, Jul 31, 2024 at 03:18:27PM +0800, WangYuli wrote:
> commit ab091ec536cb7b271983c0c063b17f62f3591583 upstream
> 
> There is a hardware power-saving problem with the Lenovo N60z
> board. When turn it on and leave it for 10 hours, there is a
> 20% chance that a nvme disk will not wake up until reboot.
> 
> Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
> Signed-off-by: hmy <huanglin@uniontech.com>
> Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)

All now queued up, thanks.

greg k-h

