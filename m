Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F214EECDFA1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 23:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCcDTnEjXwV4ONMO8R22Tttn5N2SiMvCiEJ+UmmgsbE=; b=TFxgKx1rhjtNnuaAsGmO7aGmt/
	jH+Bbi6DbZC/jI6RLl91MQ/FUfmygWBhNP5L47KZHBJXtAVRuBu/udjKNOMhpvpI+T9xGv6pxdR63
	1jSKqhcjeeh5igyffr6EhvYwMFDF17hLRsdM4gB+tQnc1xdKMsaaDaf0v4KEMlWz/Ohq/PRDl2Baz
	vkZa6w5QjeWdSDDSOq0AEm5AEwq8MC+zPiUR21HgsAr8dcohkgfogwQVxuTLOfK+yJ+f988/vToKs
	SSyYE0bzzzgIbllQCVGalSGBIKym5e2ayb8NBo8ODv+1QD1kZIYw1+YFAoCFEUmv72XW3gO17A/BG
	+3r0wh0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onTEC-007YAw-6a; Tue, 25 Oct 2022 23:21:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onTEA-007YAJ-4R
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 23:20:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A3E5E61BEC;
	Tue, 25 Oct 2022 23:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE70C433D6;
	Tue, 25 Oct 2022 23:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666740057;
	bh=gO/ynOO7i2b5Qqhbc/HkiA7PIk+9ylGQ51MJQUxPP2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qj4K39Qg/LnS2s5Q/ft8SG3WuAZqA305YbqfmLUr9wn/n7J4uV3uXLD90/E9FCFJy
	 Ce4caosJT9jMRtc7SbKlUYx3PzU6rDUyVlD3zkdoSAhEd9vcAuazOdlmrhoUvcGUqI
	 rW3yFIe09smk3l88+yaDLp7xvopugAqcsbSrx+f+1aMSuYGu2v12s2SOjdvOP9r+bb
	 0Q5j1aXyXaPll48qX38PY1FOCWJ14uWfkIOtDad05v0xiNXwy+BjStTSK9JOWff8I2
	 jkqsOOxTV3QBdafE61CKsN8GkSy8TdYGxsjjfJY58ru1OHMZA7EVWMtIuCNfRiwX74
	 a1qxbgKcpyb/w==
Date: Tue, 25 Oct 2022 17:20:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
	oren@nvidia.com, chaitanyak@nvidia.com, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/1] nvme: use macro definitions for setting
 reservation values
Message-ID: <Y1hvVpQcK1hxEKS2@kbusch-mbp.dhcp.thefacebook.com>
References: <20221002082851.13222-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221002082851.13222-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_162058_225770_6C742956 
X-CRM114-Status: UNSURE (   9.83  )
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

On Sun, Oct 02, 2022 at 11:28:51AM +0300, Max Gurtovoy wrote:
> This makes the code more readable.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

Looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

