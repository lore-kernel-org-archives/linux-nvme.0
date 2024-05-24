Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FF0C25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 16:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjTqBqcJkDmgE6z7P7zNLO86msASsWUrFD/wOrvWbTE=; b=VXbAZglCMBIW6YPDs4eu/L4rfm
	qqZ9hF0rGoR1pGf30WqRYe7donW29HB2d7az5RRc7ixCcRwI+Nw539PkpKRXCBREhIuECiLAFdiAN
	WmheYSoX01Bf1xpVkpC2BLehERgoYMLpsTA8DRQn9TByuy9FOKM8uJYDt+h5MXoscyh6rhaN4YF/R
	9cxQlUFQSgWGwTsAcAQcdrrwhSPQT/ijbTvg4cw8++u9f1FelHA88kT0k0qMs1mr+HjOw2XX0Wf76
	Uf53o5a26FBdBRKdoWFZ3h3NZ23Ld4wZZv/t7yTpc283MQtbtLhF1TpirWh9VPezqGeMGrcYgD3sl
	ufZ1gLug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAXMl-00000009KKj-31wn;
	Fri, 24 May 2024 16:01:59 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAXMi-00000009KKD-0Q8E
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 16:01:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 48D5DCE13DF;
	Fri, 24 May 2024 16:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41A7C2BBFC;
	Fri, 24 May 2024 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716566512;
	bh=gpmn/L/CKIjmdBWM+e87XryHHA3qf/UV+ODH/mboJAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB2kUAORBi58asZ36d3lwq+uvSFUOAXiinqr9tfxAL0GoCBGUg1rO5yDzwj3xFU3g
	 BpfLVl2v/UIUaqM3dvcViU076dMWfBT9LTSwUeFR2JOucA2HpXGBmy0PSYTaMUptus
	 IQxjbumAE9DVU+JxWMt/dVRj6N1PALbox7z5lOG6Ji5zuJWBxFDg0+SapnpL1jjyi4
	 7TKYD03kNMkNbfOObxFyGT1ViLumE0994zijEO+uSY8OafiqEI5M+wBHYwVucTVqlt
	 QfsLFhNSsRg9VZKrURKayjAiUcW1+yOR+1mrqI45byuDOAaj51/b2R5XzVgYTw/fF8
	 Yn3IuSYcDK8gg==
Date: Fri, 24 May 2024 10:01:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kundan Kumar <kundan.kumar@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	joshi.k@samsung.com, anuj20.g@samsung.com, nj.shetty@samsung.com,
	c.gameti@samsung.com, gost.dev@samsung.com
Subject: Re: [PATCH] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Message-ID: <ZlC57Zvr1qmtEyEY@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240523113915epcas5p32626cec7fb138355e74415534a3ece36@epcas5p3.samsung.com>
 <20240523113149.29174-1-kundan.kumar@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523113149.29174-1-kundan.kumar@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_090157_096946_30152C52 
X-CRM114-Status: UNSURE (   7.46  )
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

On Thu, May 23, 2024 at 05:01:49PM +0530, Kundan Kumar wrote:
> bio_vec start offset may be relatively large particularly when large
> folio gets added to the bio. A bigger offset will result in avoiding the
> single-segment mapping optimization and end up using expensive
> mempool_alloc further.
> 
> Rather than using absolute value, adjust bv_offset by
> NVME_CTRL_PAGE_SIZE while checking if segment can be fitted into one/two
> PRP entries.

Thanks, applied to nvme-6.10.

