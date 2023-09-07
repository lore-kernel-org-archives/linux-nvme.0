Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1F5EC8738
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Sep 2023 16:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f+cQ2MfzLw1WADqz2zgRLT4sBwBSOkrxB3AhO4MOxPo=; b=rA7h4V/HESiqtRklxlSu64IvjC
	l6IErk3l6ppXnA/p9TXICEfeEaPDETDhzUayiII5sea18rfWy2c+ON46jMg144485MVCtf3MQCCl2
	njAusDms0nj51BF5zQjY10TU61dZMND12iGqa53Ft9QU0bPT7cAzDnqdIZpMenQV/APOUjalgrjhP
	ohKeo7ZMnrqhyWoB0HlfSxcYZDcDnx5ZVVbn2T5g5OtmdpVhqNVpkW1qjJRcQxUtGQ3jZQcsANJpg
	SOUokttk9fpdIC68D9mlCPItUgwj4FY1uXld1xpvI2qksmetyzAEhEcmwxxZmZjtUMlG2PLOu6hGL
	NqScb5jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHgz-00CNQL-0l;
	Thu, 07 Sep 2023 16:17:17 +0000
Received: from mail-qk1-x729.google.com ([2607:f8b0:4864:20::729])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qeHgv-00CNOM-35
	for linux-nvme@lists.infradead.org;
	Thu, 07 Sep 2023 16:17:15 +0000
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76dbd877cd9so62760785a.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Sep 2023 09:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1694103424; x=1694708224; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f+cQ2MfzLw1WADqz2zgRLT4sBwBSOkrxB3AhO4MOxPo=;
        b=NE4XoDwn9ZDlIIpFAhaiC1Y9WYeO2vIkzaVmDR+mdUpycDyifuB8ClsKl3WaCgJbri
         B+1cU0MMbv/OvvLERubpQeNyYoyasY7oV/G+MA222Zch2PXdKOx0Lz27OwuvsaZ/exz5
         nrtVmVFYX6AtqYRKKh43+0dQN7YtIcu46MdWTa3O8ZR78Bvu9rlNWoloNNXRdH7qMJJj
         H31PJ/+7UScX7Y8IWWzWt+o/fJqjPNLP5Ng/2pu0wpuytojqmLumYUpE6RC7eGOI2dwY
         APYbkbFMhIyvQwxrTI6A5SD0N4yVneKDT4ZbaL1hardZUrj5m8Skb5gv7xGewYBdc0Ug
         qZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694103424; x=1694708224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+cQ2MfzLw1WADqz2zgRLT4sBwBSOkrxB3AhO4MOxPo=;
        b=IbjHdKpllqxmlpxviw9Lht4CAAkQYoI25o3B331v/Ykf6NI4xTArdahQObBpdkHzwB
         nGcrbFP4FAOpy8i8Ny5rc2clqSoTEHPuZVeAY32A8g5WGoM9RwbdpekdqiDSY68Nls9Z
         vUrrRhpvsP+urXtrDWRjtL8XvRAw0EUPVgl2vAbskAJESlcDrNlU2dXZmq0VI9YTjkj0
         J815mFIhQLiyXPo/Wlj7j2hrt9FtHjj1b2Cvdb37o/xhR9V3H/25BWHWsazvlfuAkFCT
         YptFdfzgHSwhj0/R3cB9r1G5CxDv2fsnxD3gBVXSk2AcyNaxBOkrJL0KcuWlvmLSDcJz
         /fJA==
X-Gm-Message-State: AOJu0YwlOJ2fGlIn/WK3OCaKfNLY8Rwa++YuIqaGskQgMgCuMh2OrHdO
	OUC9/wDPfY+01lo2aZEnL58jTQ==
X-Google-Smtp-Source: AGHT+IHrBIJuqPG+mbaM+AQrOoCznnafSoTdOsbWiZnoHco2OnVxn+u9eZ14RDvzB35AV4+gpVJ7lA==
X-Received: by 2002:a05:620a:4511:b0:76c:9391:6922 with SMTP id t17-20020a05620a451100b0076c93916922mr27531022qkp.24.1694103424207;
        Thu, 07 Sep 2023 09:17:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-134-41-202-196.dhcp-dynamic.fibreop.ns.bellaliant.net. [134.41.202.196])
        by smtp.gmail.com with ESMTPSA id d21-20020a05620a137500b0076ef004f659sm5915009qkl.1.2023.09.07.09.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:17:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qeHgk-00174a-Vp;
	Thu, 07 Sep 2023 13:17:02 -0300
Date: Thu, 7 Sep 2023 13:17:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Daniel Wagner <dwagner@suse.de>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] RDMA/cma: prevent rdma id destroy during
 cma_iw_handler
Message-ID: <ZPn3fryQDQeckq4k@ziepe.ca>
References: <3x4kcccwy5s2yhni5t26brhgejj24kxyk7bnlabp5zw2js26eb@kjwyilm5d4wc>
 <ZIhvfdVOMsN2cXEX@ziepe.ca>
 <20230613180747.GB12152@unreal>
 <iclshorg6eyrorloix2bkfsezzbnkwdepschcn5vhk3m2ionxc@oti3l4kvv4ds>
 <ZIn6ul5jPuxC+uIG@ziepe.ca>
 <l3gjwsd7hlx5dnl74moxo3rvnbsrejjvur6ykdl3pxiwh52wzp@6hfb4xb2tco3>
 <g2lh3wh6e6yossw2ktqmxx2rf63m36mumqmx4qbtzvxuygsr6h@gpgftgfigllv>
 <sqjbjg7cwcpjx6yn7tmitx6ttxlb4pkutgfbhdgxa2hi4hy6wp@ek7z43bwtkso>
 <3wxdjvmamxdk6s26q4hnxjazuajrp7xynfq7okywc2uzgcdqf4@ydiglvla3k3u>
 <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs_mP7kmnKdm--tEkb_yE0saA7A_BBV21E1RQT8a+J7s0g@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230907_091713_995303_12D7ECBC 
X-CRM114-Status: UNSURE (   7.76  )
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

On Thu, Sep 07, 2023 at 03:47:03PM +0800, Yi Zhang wrote:
> Seems I reproduced this issue[3] when I run [1] on the latest
> linux-block/for-next with kernel config[2].

https://lore.kernel.org/linux-rdma/13441b9b-cc13-f0e0-bd46-f14983dadd49@grimberg.me/

So far nobody has come with a solution

Jason

