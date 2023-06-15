Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C892EB64DA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oI5Ov5oLGA7KuyFwkEzDeO1r/Z1IJ+FGWr3qf0+vA/E=; b=vV8+vgbJOR4KeEzHrfDKrB3sF8
	I9kSCJd4O2gYVdjILonduytdaNdF9OgRYyEKO0eSo+ZiIrQwbcVgVXaTy5aBePGTH/opxlZpGZDPW
	3J50Lxtl5HfbfT+g4bbUMCAghuOlZrm5fCafoSVkbqsuKamBa661HGyMs9YwWpuDScQWk4tL4NtEC
	ibBP4lYe07gwsk1Gk0yUZH8lHnogF67kPnb++D02QTTnsjAf8iBOykQ5N/GUdVYzWv1ZrzG8sHglD
	sCsHOEsRqxm3MO3loNk0ydW5rKXVgr7+y86PKKlTxCKfS5/wnOcSzEq5e3HTsLIhKW///js7f7fbd
	QylBC7oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9rjk-00Fkz2-0T;
	Thu, 15 Jun 2023 18:30:24 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9rjh-00Fkx3-1i
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 18:30:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0409C60DE6;
	Thu, 15 Jun 2023 18:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CF9C433C8;
	Thu, 15 Jun 2023 18:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686853820;
	bh=IWpeb4Kgm1UamkNtsT5+DO7vNDUGgUuD0Dyst6XKCz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iTmnYVDX+9wbjvHsbaVRPyrv7MPXOPRDHzBhk9XOtcxMnlW9qUfRnHR6k5Wt3ToGj
	 i0n8EumMCCHjTpq7p2c0CT33nIZnNnjJvinpRpaZEGtYA2OWoE1iFypxj+ksGr2jnh
	 YsIvrP6/vk9xb2bPZ+XHmNmZvDCpWdpPBL8vHgNtZ5TUOAYja2UfEE8VsTnx6Dyvpy
	 oeuxHmKCgDLYCAPP3PYqtrtlUO8hEexjRAu6Z3FJIH345Jw7DhXeuyl/i0yfnINOY7
	 EgDX8QB9/b5KlWReXOCgYvYIBohwpl4MWc8evhDJAhAbZQcDCzUZwYctnAdQaRWn/D
	 NOzgh+NknLiJw==
Date: Thu, 15 Jun 2023 12:30:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, leit@fb.com,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: Print capabilities changes just once
Message-ID: <ZItYuVb1vKk9qfX/@kbusch-mbp.dhcp.thefacebook.com>
References: <20230615094903.1341683-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615094903.1341683-1-leitao@debian.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_113021_617291_B29FC002 
X-CRM114-Status: GOOD (  12.13  )
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

On Thu, Jun 15, 2023 at 02:49:03AM -0700, Breno Leitao wrote:
> This current dev_info() could be very verbose and being printed very
> frequently depending on some userspace application sending some specific
> commands.
> 
> Just print this message once and skip it until the controller resets.
> Use a controller flag (NVME_CTRL_DIRTY_CAPABILITY) to track if the
> capability needs a reset.

Looks good. 

Reviewed-by: Keith Busch <kbusch@kernel.org>

