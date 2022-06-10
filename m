Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCA4C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 12:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=130B3kkD/RZIkOCrcmz351BczRa1xYiEzwjuOf+BIgM=; b=sMyb03n9lHuVOkN5xStz3WEFag
	A3m8jrxFwuicEZupnlGY5yjryriz07cn//EmS6Ol+o1ysRP69f6bJO2A8VSa3hDMlK4Uv6IoMOjds
	4z/lwR3daXoe+Gw9HMWKfgZiwTIV+3wMoz13Uh4y01SwhWVdcm2wZp4tUpG3cQBgffhPzfWZQQRiQ
	cEH6K2h67sFV8lrLgxC1FIq2nvJaVme3J9eEjBXWTqWf7VPEU01OIGj9BNOWNkCdOzLI5oc7+6NbD
	KjClLVb61GLwPl/nZP09mRlagdJ/6JZXypdbEOl5D7jlIVsHpSwdKXbtcyO3q0KWjVCin3TPXZ3qq
	OehXzGNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzdOt-0085T6-E3; Fri, 10 Jun 2022 12:06:03 +0000
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzdOq-0085Qf-Qu
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 12:06:02 +0000
Received: by mail-lf1-x132.google.com with SMTP id c4so10457643lfj.12
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jun 2022 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=130B3kkD/RZIkOCrcmz351BczRa1xYiEzwjuOf+BIgM=;
        b=E7/lo+IHcf40eLTK2hdrDgSXpWYiZZx33aHPtjRfBkJ5+KwfnypczseU/evZGlMKHS
         wdTE0F34tV97mzUPq5NeVhXM8MGKNDBzKJRqNxzmLH5Fkefsa11QkIiGc5mF9mPxTCOx
         C+ak6qQvMLINN6c9cGRExCq3uqQv/bk7BG7ngLnSjX07nA8OvXGW0m3CSXJ8zZP8TsSo
         K4Cd7JXgGA4jLI008NOD7MlPfKROGzPol5DFWMQSdInu6sh3kh7V2Mr1SqJB4KvCZPHo
         eTmor6XZKpk+inF5sIf5xfDX5iOeAUVxRn58Y2TR0+bXwQLBc3itmURO3u+UJk7JFdWg
         NlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=130B3kkD/RZIkOCrcmz351BczRa1xYiEzwjuOf+BIgM=;
        b=ownPhOqTezuaLYm0cRYaMpbaEZspp2HuIYlGtiLCiqeMDOHqdTyzI9SlKKNp5sbcG8
         5FwQZWehTru1rLadrQ9PlTtPUVORkDRYTSTQZqpZPfCZ3AxmfCtoOJ/d04bbsc4oYb38
         DFYWB2EMstyAmYNJ0bvhFW+dt3RyHGnAgW4DVzESLz5I1d81HigIfkSYQZb/wwLTpVA0
         11Gdj/qUFr7hBvPwqLG81lQYymKDbuPl8GW1Rk1IcVZ4rPEaPgos9jZnwi9dO+hy4TMQ
         m3CALESBYYIIv25cCAaI1zDl0nJmne22VIt360T+O2OPUZMXIrJj6nhsE4OptBs4R0Q3
         HbtQ==
X-Gm-Message-State: AOAM5338yp9qizSm96Ap4559TvSAeANDcF5VLkkMS45AZNXU/WOXEDPc
	mxDtp9ekJzVpoVjKX8EuTVk=
X-Google-Smtp-Source: ABdhPJyewHpKPtRT9Pz2gZdCnPyd60KQ0mno5fKFPbEcrCwStmYLat3hyEHndZKfU4T/we0GvsOTMQ==
X-Received: by 2002:a05:6512:3183:b0:479:3e62:2cb with SMTP id i3-20020a056512318300b004793e6202cbmr16934264lfe.459.1654862756109;
        Fri, 10 Jun 2022 05:05:56 -0700 (PDT)
Received: from localhost (87-49-45-7-mobile.dk.customer.tdc.net. [87.49.45.7])
        by smtp.gmail.com with ESMTPSA id o18-20020ac25e32000000b00478fc1eca9bsm4690143lfg.131.2022.06.10.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 05:05:55 -0700 (PDT)
Date: Fri, 10 Jun 2022 14:05:54 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"R, Monish Kumar" <monish.kumar.r@intel.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <20220610120554.ry7w37jbf3g6w3p3@quentin>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610061449.GD24331@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_050600_950261_2E5661FE 
X-CRM114-Status: GOOD (  14.32  )
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

On Fri, Jun 10, 2022 at 08:14:49AM +0200, Christoph Hellwig wrote:
> The 970 seems to actually be very slightly newer than the X5.  What
> I suspect is that they actually are the same m.2 SSD or at least a
> very similar one and Samsung decided to ship it in the thunderbolt
> attached versions first.  Maybe one of the Samsung folks here can
> confirm.
> 
> That leaves us with two plausible theories:
> 
>  - the problems could be due to an earlier firmware version or
>    ASIC stepping
>  - the problems are due to the thunderbolt attachment
> 
I have forwarded this report internally within Samsung and I will post an
update once I have more information about this issue.

Cheers,
Pankaj

