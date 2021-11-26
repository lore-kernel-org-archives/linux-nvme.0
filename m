Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B802DC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Nov 2021 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=32krK+5IZRVcImILCQvnifbT6UmWl9R+l1re78H/mC4=; b=HL42RwnhWD3Rf5LtfJOSXkfBPN
	GgE7nWAWOtZu/L/FysduOFarEYr6W044OEpTIBq2QQTp6lbJr8xap6VN7egkiJdC/KxrkTv7hp7Vi
	woskGtizLwmvBkFIxjvqBSEUi66W5dZdwBApq8itW2jWtfqbl6hridgpuuaOZStRPTFH19s6tQWoH
	I5cZtvG6yRhE6y3r/HeuV5QIclfkR4X0eNYESxl0zT6lfMCw2ggOh7hGcYL2SGGJdyp6WAcNcheNt
	xLwYw1+2mQ6rYihOq78l30HZFsdWACtjXTimDra/Q3Pg8ZCfGVE5RG8Owl9hXb9LXdo4wcGNcpv82
	Q56dd0xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqejb-00BG6i-E5; Fri, 26 Nov 2021 17:10:03 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqejZ-00BG5x-A8
 for linux-nvme@lists.infradead.org; Fri, 26 Nov 2021 17:10:02 +0000
Received: from [192.168.126.80] (ip98-184-250-31.oc.oc.cox.net [98.184.250.31])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J11T20VG8z2s8g;
 Fri, 26 Nov 2021 12:09:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1637946598; bh=GTIWo+vkIgU91xH2aEgvdisvV1t6NuTWucivVzjGD88=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=FR3wRs4snD+sJVhgRXdkjCuO9pDOmRfuJPuD+thdDNttOZ8iYz/py2bPQPPOQtqTx
 6QaR2l5VRmHVqyMjL3+Qc9WpAZt86i3nkzQxKb0bT7YWJtjbjshd7i01543vKu55RY
 yQ0c0RSK4B4YUC/Vm63AlW9UbtFE9ck0stSLTrp0=
Date: Fri, 26 Nov 2021 09:09:56 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
 "Kenneth R. Crudup" <kenny@panix.com>
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
Message-ID: <143c4f76-658-887f-5c8-f454785ac99c@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
 <903be817-4118-f34e-1b35-a0108045590f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211126_091001_439667_B5C1D6C2 
X-CRM114-Status: UNSURE (   5.27  )
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
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 26 Nov 2021, Jens Axboe wrote:

> Can you apply this on top of 5.16-rc2 or current -git and see if it fixes
> it for you?

Applied and trying; fingers crossed!

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

