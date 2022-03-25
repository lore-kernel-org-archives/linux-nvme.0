Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273E9C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Mar 2022 05:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=is2GF9NVqeFlcZE1eKoOK3DkFANP/SiIQIKCMjB0NPg=; b=UVaT8W9BCxzoUoPQpTMqB22upf
	P9qRfg6Ovm8T4XN4bnocV/YMFRjEuxOM1Q2ba5qd6/Z3cnWHIcdAPHmYCT+6eHIsl6UMsFbFWiWpj
	ipncY65nlP06eAw+1XNee3owoFpXbTy46UNuOfARoVVegtjJTt1pyRFXnQ/i92g/1B3LTxFPKaHDu
	Lol8f8IHGy0uSFcws19TmT3rRXlMWVbXdR3NmlGJ5jy0SCWjMhrqSvzsbaO0vGJl4J1QsXjND3oWT
	XUCo6gzATOsYMwBmg3nLfte/g4osdUYicqNwNz7+J5ZJUE7BgZ0XdDtfEdVEt7gHTSP2x439g7VDJ
	JdM5RmZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXcX2-0019VP-9e; Fri, 25 Mar 2022 05:30:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXcWz-0019U2-TS
 for linux-nvme@lists.infradead.org; Fri, 25 Mar 2022 05:30:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0F99268B05; Fri, 25 Mar 2022 06:30:30 +0100 (CET)
Date: Fri, 25 Mar 2022 06:30:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tanjore Suresh <tansuresh@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] nvme: Add async shutdown support
Message-ID: <20220325053029.GA5204@lst.de>
References: <20220324214251.3057957-1-tansuresh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324214251.3057957-1-tansuresh@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_223038_126212_276BF92F 
X-CRM114-Status: UNSURE (   9.67  )
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

If you only send me patch 3 of a 3 patch series I have no sensible
way to review it, sorry.

