Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E0FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Mar 2022 21:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQ7hQXKrcCfMYiAJJ2Vp/L1VmTunX+o/lAMH/6D6On0=; b=t75QCFcecNxZcYpmSR75PQibPX
	qOAtasZFbvfVvNOit4I8Oz6Guhc1HixivzKnyOAx4yV/Y6gTAfDpnDaQWsQoSl0o+UOC7prPgJA60
	9pHobKSEIxdQHZxuzq11RFIhuJ5ao5EA5ZrSyn9YE7YYdFJ2ODGBKmg66okySs6REhtm+MrGiMvuT
	hpLv1EpDu3TmK6fE1NSDZE2spGcFmtMQjBOXR2QwiJMDohcJIJKCb4KT6pIFiZIJGGgEDooAszJS1
	zm1cWrvtOMOI+8c6IQ4jktKjQxjyP4Q0Usn4VZJFd3ZQWtBqDFcD5qu15rJrU83iG0wVGJhvfYeyA
	qDB24sHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPWbe-004LmX-GP; Wed, 02 Mar 2022 21:33:58 +0000
Received: from mail-pg1-f169.google.com ([209.85.215.169])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPWGJ-004C0M-A3
 for linux-nvme@lists.infradead.org; Wed, 02 Mar 2022 21:11:57 +0000
Received: by mail-pg1-f169.google.com with SMTP id o23so2666070pgk.13
 for <linux-nvme@lists.infradead.org>; Wed, 02 Mar 2022 13:11:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=EQ7hQXKrcCfMYiAJJ2Vp/L1VmTunX+o/lAMH/6D6On0=;
 b=Vd8pkKGeqO1h1EqHE+Ue2addOfWXbb/i/KRlgQ31lSXuT4oQbkT1IHPVgYqfPs8N8F
 q3LZ6jY5tBQR0m8uKS3h0cfhsDEiQr+8HC8xLaqpNxP7eEOTpxwXZh3aUz7BZs3MMaez
 lKuAtEFW/4+ruPAbm7BhvwNHQ80VvC8dT+PAJsGVsqVVPMPztKKODNLD/84bNmIhb26a
 McuI4Mh/hD5zdKcqsUGMx/w2ZBHBg6zQJcuQt6q8pK7JWl3R0mCFiUmeTSRJpQqDSkX9
 f+7MdnzBC28LvZNl2gpQSLMflq24jAG17N4MWGAAzhHt4osMPu/Xg1KV8pPmmYzJFZkS
 aObw==
X-Gm-Message-State: AOAM530GYXIuBNS+v9UpVirdxd1nzf8S1ya8Y1d3LiQ6kg3MECwG1bnQ
 VPNKUlTjt71xZzbr9fr8E28=
X-Google-Smtp-Source: ABdhPJzRVIuKzFElwx57vxv3s3OLXXzLQAoXcmK4bLK3p0jluiwb9oCqlcNJgLPb6snR1ZvYxTecaw==
X-Received: by 2002:a63:18f:0:b0:37c:4671:a2ce with SMTP id
 137-20020a63018f000000b0037c4671a2cemr2311322pgb.429.1646255514362; 
 Wed, 02 Mar 2022 13:11:54 -0800 (PST)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a056a00194900b004e1583f88a2sm93138pfk.0.2022.03.02.13.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 13:11:53 -0800 (PST)
Date: Wed, 2 Mar 2022 13:11:50 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>,
 "Remzi H. Arpaci-Dusseau" <remzi@cs.wisc.edu>
Cc: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>,
 Matias Bjorling <Matias.Bjorling@wdc.com>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
 Hans Holmberg <Hans.Holmberg@wdc.com>,
 Dmitry Fomichev <Dmitry.Fomichev@wdc.com>, Ajay Joshi <Ajay.Joshi@wdc.com>,
 Aravind Ramesh <Aravind.Ramesh@wdc.com>,
 Niklas Cassel <Niklas.Cassel@wdc.com>, Judy Brock <judy.brock@samsung.com>,
 Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20220302211150.ibyvunpathxjvi6t@garbanzo>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
 <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
 <20200617182841.jnbxgshi7bawfzls@mpHalley.localdomain>
 <MN2PR04MB62236DC26A04A65A242A80D2F19A0@MN2PR04MB6223.namprd04.prod.outlook.com>
 <20200617190901.zpss2lsh6qsu5zuf@mpHalley.local>
 <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ab101ef-7b74-060f-c2bc-d4c36dec91f0@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220302_131155_405474_65D337EA 
X-CRM114-Status: GOOD (  15.96  )
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

On Wed, Jun 17, 2020 at 09:23:05PM +0200, Matias Bjørling wrote:
> On 17/06/2020 21.09, Javier González wrote:
> > As you are well aware, there are some cases where append introduces
> > challenges. This is well-documented on the bibliography around nameless
> > writes.
> 
> The nameless writes idea is vastly different from Zone append, and have
> little of the drawbacks of nameless writes, which makes the well-documented
> literature not apply.

Sorry for joining late to the party!

Just curious if we have any public information on analysis on the
differences between zone append and nameless writes?

If we don't then this sould seem to be new territory? I'd expect many
drawbacks might not be known yet. In new filesystem APIs we know all these
things will always creep up. Not that there couldn't be unexpected issues for
nameless writes once and if someone did try to add support for it in a real
OS. But if nameless writes is pretty much append, it gives me a good idea
where to expect some issues ahead of time.

Thanks!

  Luis

