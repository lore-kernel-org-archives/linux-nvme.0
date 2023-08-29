Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63A6C6FA8F
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Aug 2023 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xm1QfAqeVrkwZ2x4xh5AS28T2hBtt8g8cbiFI4BlrEs=; b=W2+qIjb/F92CF0TxQUTh6SPayF
	1DSXn4S0eiejHbSFzxVFMbbgqXpdFKsf5Nqsq4Zub69NUaHOmtSwAUhZgM61vnXJeq0CEimzNkHye
	1OwAE3JsEDLMIScdGR59qu1jb8sYBpTr1KPQmRRTe19oKQZFc0DF3BAgk9GH9wvD0Zo+/4iKetqBf
	1kzNcpbmYAzWMteGs3/4hxMPsSYdvfvu5drhmk+OTawmZg95sXiGLZ71YTb0JRKcihroE/D/SaFyF
	nhjiYXb3sMM2vk80ILoQxq850V59DPQmj5SBI4Irf1hwJcNVHxTo8e68SLb3yIF8wJZJv8YhMKJov
	puy+wBUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qaymb-00Baxn-1Y;
	Tue, 29 Aug 2023 13:29:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qaymY-00BaxP-14
	for linux-nvme@lists.infradead.org;
	Tue, 29 Aug 2023 13:29:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 588466156E;
	Tue, 29 Aug 2023 13:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085BAC433C7;
	Tue, 29 Aug 2023 13:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693315760;
	bh=PYxl11sm6UkhUKQLwVmHDsyfeNWtoD2yqEHqumWd6V8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiE9VDERyErOCPh2HI5Fddv811rm3zs0V7HZPvM3bfLqn2773m6m3KngqSWVOUpM/
	 o57geYRFjrFcc5jC569bU/Ly2RqGjDtJQqTtD+yrH2QqSyc/BmF0jwSLinDWSDXWDl
	 S4MdEuiGL+uau0RCrCi48nSw/ncMHV90uQKJ9hXQYA080/ard8uYqhpWiFBcVw+INJ
	 owHujqGv7eDrs2hkwt+TvyQUGqv+9o/sxtx5PgK2tQ+UjHXIX/40ENhwFhgD/qRKZH
	 ShbRo4gKffKfP9934mtlfPHVJc449lwVIAWYdJ/5B1Lx2O9Or9+86ktoUWMPweQ0Ze
	 hWDnv+GZkm/2g==
Date: Tue, 29 Aug 2023 09:29:17 -0400
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Guangwu Zhang <guazhang@redhat.com>, Ming Lei <ming.lei@redhat.com>,
	Oleg Solovyov <mcpain@altlinux.org>
Subject: Re: stack smashing detected with 'nvme sanitize-log /dev/nvme0'
Message-ID: <ZO3yrfZofuKK0XGz@kbusch-mbp.dhcp.thefacebook.com>
References: <dckvq3ohgqdkxg7wz4vslf36gaivgldl742vew67oyh2buj5nr@7ypn5ydt6kss>
 <20230726131643.GA16186@lst.de>
 <zopmb3355u2vorlkvas3gqb53azp7qtb7yq2kyc3reezlyqtcy@iev3wkvzumsq>
 <ZON+qrAwuO3eQB6G@kbusch-mbp.dhcp.thefacebook.com>
 <20230828092038.GB30603@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828092038.GB30603@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230829_062922_429562_2ED5D96C 
X-CRM114-Status: GOOD (  18.71  )
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

On Mon, Aug 28, 2023 at 11:20:38AM +0200, Christoph Hellwig wrote:
> On Mon, Aug 21, 2023 at 09:11:38AM -0600, Keith Busch wrote:
> > I don't think we want to bounce to kernel memory for the device to
> > overwrite it. I suggest just change nvme-cli's stack allocated santize
> > log to a use page aligned and sized buffer.
> 
> That assumes it actually overwrites it in that case and doesn't just
> have a PRP parsing bug when there is not enough alignment.
> 
> We should be able to find out by enabling KASAN and then requiring the
> larger alignment before re-running the reproducer.

Good point. I assumed it was a simple buffer overrun regardless of the
starting offset, but bad PRP parsing sounds plausible.

If you don't want to enable a kernel with kasan, we can just align user
space buffers with padding at different offsets and see what happens.

