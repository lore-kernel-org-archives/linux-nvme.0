Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35454C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jun 2022 10:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=znEIzE4EgTWOiFZf5Cm3kxNmUH6IPbVNQv1UUuyV/Hc=; b=TX345Ds3ZUVsMkZ4N822KBgxhy
	Bk7H3n2QotjzMS+p5CU9ggc+2P0NPqXEIGyg1iGqNDfm2QNjXEP18zFzwdEEVS9n+Sc1lue0FTU9c
	aaRNiOhSF0YW/T2jvtBLEjiT5pnUCrqFVlOv/EmGzh3FuJ45lq9OHXOr4AdsEF0EZwP9IS3S9D+8M
	/RT2f6COafhCybihHnyl5by++kW6Tlx578Aht5UEhphMKD8xcOA1e1BFEYICM7zVvAif+M3WsUEFl
	dItnt0vKUNvnousxJAmkhSR/p1URdUqqzt0B7V9cgWD8dEVMKWXu2gRZhgsms0I2B7oOFPXiBaaQc
	UTh74lrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QIQ-00Dqcv-Im; Wed, 15 Jun 2022 10:30:46 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1QFn-00Dpfv-8k
	for linux-nvme@lists.infradead.org; Wed, 15 Jun 2022 10:28:04 +0000
Received: by mail-pj1-x1036.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso1605601pjh.4
        for <linux-nvme@lists.infradead.org>; Wed, 15 Jun 2022 03:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=znEIzE4EgTWOiFZf5Cm3kxNmUH6IPbVNQv1UUuyV/Hc=;
        b=qV9h/UpNmydq91H3mP6CVU6NclHsJYkwfhKtoANC/6Tu2zBT/yPUPmiRQaF/d90inO
         tLv2mruFsa6BwzQwqBzSb2nHAcMM6DnbKRwhwxKDO7XOk7s6jDF5FQCSFAz3pJTuJYEl
         p2TF12/VNwu5xzgYtkfUEeoSclxn2LgsBLG7z+Rp6npZcXpPOUXF9pjLz4NSabazZOe+
         2wDQv+4nzLsoXymU0D+hO3piw8G3YSlQbtdeFRfSvTR/V4Hady+iSnrLrgyJxXL4sPPD
         T+9JSIndQ/pgJqevcyDY0DpGxLlZyJNy2NOiPEZ151KZXZSntI6fZMjO2fYbx554bdOz
         iwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=znEIzE4EgTWOiFZf5Cm3kxNmUH6IPbVNQv1UUuyV/Hc=;
        b=hQSznYhca6gKIFPoyG8CdVSlOiMUEcYUHxJZxadZvXpn3bHfU7m7/1fJhhxO8oNyd/
         /U/Or02wEl0wzt0pFKTg5F6l6V0My76C1zmZNlHmZnj6QAd9tHG2gsmTBjofrsWXnsxt
         MxsI2wtSKpu2IqLXxb7b/cO9kaZZNzKn3NwBOcG+u/cGQoVBHp4LL3Wfut8w/rrw/cF2
         /ZHIlRrsOV2Elqotkxh2fzpPdNg8eW4uksgXWQGMl59wC/0qfMsyLqmW2y5mmOuqp2zt
         5KW2d0tT6/A8sdXwXVnU/bu5GjxAPTBgU3hv3u25Qnp690hINxJRvEdoJfX3Fw9c6cZS
         mXxg==
X-Gm-Message-State: AJIora8EaRkouYYSdtnh1afl7N5OJzfXX+XsAURiSZOtKTCdLtcTNxMi
	rlRDAArU2s1WR1boHb9yl+A=
X-Google-Smtp-Source: AGRyM1uylrZN/TnBR+RkyEvlG9LSFkRtn1a0pXgqvgeKkHmp20cQHxemz9ZiU5FVzwHH9jENOzszIw==
X-Received: by 2002:a17:903:41c6:b0:164:1050:49ac with SMTP id u6-20020a17090341c600b00164105049acmr8762042ple.138.1655288881189;
        Wed, 15 Jun 2022 03:28:01 -0700 (PDT)
Received: from localhost ([122.183.153.161])
        by smtp.gmail.com with ESMTPSA id g2-20020aa78182000000b0051bf246ca2bsm9407279pfi.100.2022.06.15.03.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 03:28:00 -0700 (PDT)
Date: Wed, 15 Jun 2022 12:27:57 +0200
From: Pankaj Raghav <pankydev8@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"R, Monish Kumar" <monish.kumar.r@intel.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Yi Zhang <yi.zhang@redhat.com>,
	Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"Rao, Abhijeet" <abhijeet.rao@intel.com>
Subject: Re: 2 second nvme initialization delay regression in 5.18 [Was: Re:
 [bug report]nvme0: Admin Cmd(0x6), I/O Error (sct 0x0 / sc 0x2) MORE DNR
 observed during blktests]
Message-ID: <20220615102757.ugvs6vdxf66nrmyn@quentin>
References: <CAHj4cs_iC+FE8ZAXXZPeia1V3ZX7zRbeASdOP_8c7DLiFozNfA@mail.gmail.com>
 <Ykyf5Zuz1W8yHhNY@zx2c4.com>
 <CAHmME9pwz4q0m-pSUy7ReWu4nNzxySNcYZrqyDZiTuGxHN=1NQ@mail.gmail.com>
 <CAHmME9o-orF52HzkT80054e3Op5fLOcTHb-KHpvvU7H3FpAJ7A@mail.gmail.com>
 <SA2PR11MB5115DCE45778910C96813CA1C3A79@SA2PR11MB5115.namprd11.prod.outlook.com>
 <YqG/pybFg0P5yQ9a@zx2c4.com>
 <20220610061449.GD24331@lst.de>
 <YqMMo2Dv9SZRtR7B@zx2c4.com>
 <20220613135549.GA1714@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613135549.GA1714@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220615_032803_432007_C6E2B9E9 
X-CRM114-Status: GOOD (  14.70  )
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

Hi Christoph,
On Mon, Jun 13, 2022 at 03:55:49PM +0200, Christoph Hellwig wrote:
> It all appears as PCIe, but the pci_dev has an is_thunderbolt flag.
> 
> Thanks to both of you for the information.  I'd like to wait until the
> end of the week or so if we can hear something from Samsung, and if we
> don't we'll have to quirk based on the model number.
Our FW team has started looking into the issue. They said they will try
to come up with a solution before 5.20. If not, we can add this quirk
based on the FW ver. and a proper solution can be added by 5.21.
> 

