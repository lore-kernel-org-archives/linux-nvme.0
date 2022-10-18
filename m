Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D765FC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=epD9zoFrpIyVSzNY8t3b4BYOHP8xlG0FNYA3H8Aueho=; b=EZT5NBDS2i4N3mXpndPEIgTxYI
	K91D1b7qLjzVdTxVcZFzAjOJRqr/ACn17RQZ3hkxqbSFXGG1pGvjspvmo5aHrm1wmK7BqGZDhniah
	y0lzo5WUoNfJ9/g4H6KIdcqY6Tyh1GeazdSNVzWho44qqPOXl1Y1zEWo1rWI7AQu1UWEOSofErA+f
	qkfC76ujvPj9K9b+ziO4VjyR7VUZajxrMuiEuxK5h0tJ1fBzlRTgP1tipwDhZptozCd/mUUUqVX63
	Zj6NGAJNTPADFRiWn94dOBjWpM1hDS4YmpMuihUfQqzXX+opwGWz07jMYc6ESO2XIlFS83VhLHYIL
	ayjcP6qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoSJ-007alI-58; Tue, 18 Oct 2022 15:24:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoRZ-007a6G-U1
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 15:23:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1AA5A68C4E; Tue, 18 Oct 2022 17:23:47 +0200 (CEST)
Date: Tue, 18 Oct 2022 17:23:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me,
	linux@roeck-us.net, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Message-ID: <20221018152346.GA23173@lst.de>
References: <20221018145808.681327-1-hch@lst.de> <20221018151421.jeqe2bi6nyj3afzi@mobilestation> <20221018151625.GA22639@lst.de> <20221018152148.ok3fmq6vuu4kbd7q@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018152148.ok3fmq6vuu4kbd7q@mobilestation>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_082350_162178_DFF2986C 
X-CRM114-Status: GOOD (  12.35  )
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

On Tue, Oct 18, 2022 at 06:21:48PM +0300, Serge Semin wrote:
> Just to clarify. Are you saying that you have already got a patch for
> the sed-opal driver which fixes opal_dev.{cmd,resp} buffers being used
> for DMA and takes the Jonathan Derrick note into account?

No, just the nvme patch.  For sed-opal please just resend it standalone
to the linux-block list and the maintainers.

