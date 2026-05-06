Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C50CD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 04:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bti3PCq7I2z6IAInGB52i3NPv6FQnuIg+FAViSCz7Wo=; b=LY0RB5JkHIWrB94YTaAB7kncMF
	3mVuN/ZBrPjJL7y9ye4mW93nSuxa6VonH1mhZY4cApPwtUlb/JeTj+fM2EOzN9TeT7qgw2hUsixAw
	i1i60vXPRGeG+sQBOyz+KgKeVcO/6OUZ4S6+qfPDdF1sWSbgTd/H7KRnbopyDnR3KYO7kkq+no8PW
	isPlCoC5quV0B51PwEjfOYfwg6qthOXelN4E/7l885k4w0X4K3Fbnx1zatUmzEFOd7R8Zkmq9KokS
	zCXp/AmELVG5d8s6LADVp/rA3obNqTdrdfmS3W8TBCLpzG5OJ7uAJWJ2ghiI3+1KPGmXEZm51CnAh
	Wsa4a+AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTbH-00000000g9l-3RV1;
	Wed, 06 May 2026 04:11:07 +0000
Received: from out28-41.mail.aliyun.com ([115.124.28.41])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKTbE-00000000g9N-0ixj
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 04:11:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=alancui.cc; s=default;
	t=1778040655; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=bti3PCq7I2z6IAInGB52i3NPv6FQnuIg+FAViSCz7Wo=;
	b=oYx+m3CoSXXvJd8Yi9SYELYlLnT5x7RQlEZFlc7etyAd3eH03nAZYvs9bf+/x0JmqQh4LMiHGWgPaC0zb8fMrsk+W8uQkeDjUoST7/zkkf8fFKMBxLEbvE719hyaADuE2Mv6pPm8paDpcw6OtyPpMLvTZPYbeJgjnm1uTTSxOxBLFyQaxq1VnAc47IHWBafve6d2SC5cGlXe/3Iuzd0+rrmYQJYC5hRYSFDhMzdPLJSGPdOkAzRYayYK8ZigSkzuZk5XicIi1ZLF/TKFKlmpGfeeTF/bjc9BtNDx4TfMOXyTABrnLcf0nIMb6+KXVPx+dQrdSKnOswjJ4uRDq/kC3Q==
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2207384|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0121844-0.000737931-0.987078;FP=12808608934708234133|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=me@alancui.cc;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.hQY6Fr4_1778040650;
Received: from alanarchdesktop.localnet(mailfrom:me@alancui.cc fp:SMTPD_---.hQY6Fr4_1778040650 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 06 May 2026 12:10:51 +0800
From: AlanCui4080 <me@alancui.cc>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Non-SGL transport mode warnings are set to dev_warn_once will cause
 confusion
Date: Wed, 06 May 2026 12:10:50 +0800
Message-ID: <WnoIOFXJS021lstXkRDUYw@alancui.cc>
In-Reply-To: <1951542.TLkxdtWsSY@alanarchdesktop>
References: <4770779.LvFx2qVVIh@alanarchdesktop> <ade5iAP4y94z0JDL@kbusch-mbp>
 <1951542.TLkxdtWsSY@alanarchdesktop>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_211104_393648_AABC9985 
X-CRM114-Status: UNSURE (   5.62  )
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

Hi,

Is there any further progress on this issue?

I noticed through the AUTOSEL mail that you committed my last patch,
so I guess this is committed also, however I can't find any commit related
to this thread.

Alan.



