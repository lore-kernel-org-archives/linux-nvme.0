Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED45C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:52:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77009206BB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 20:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ho8BHai2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77009206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0FYRCY0QJjGDvi2ew52HX4UG70rTdZywVybZGlResJs=; b=Ho8BHai2wfXsLpjOgomJNgS0o
	B4wf2im3U1VC3iQkrpoduPoOLNTt+xBE+3y56gdsWmkpwTwElic0z2nUjA4klRdz/S/mGhdcjSxka
	fDSVmdaHsUOJxvfscIyYJ/DAgYgks4BR6Bz/1INZBiGJqZ3Op9ElreNW68DNyhcTIw9joEq3/y2CJ
	/b0e+7znWHtYXG4+18RmcSKxw/U/dC22E0p2StFItHtnIZl8Lv11Z88Krq4ZHD+jobjyoowkr6sd5
	RI9rlEO5RiO1UA/Skxh04+d8Rg1lQvni1VfIqcEP/PqwwCTcHkJiQ79qvJR3JMOkjJPBRb/GaeISY
	l6QNc1NEg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5ykJ-0004Xs-Lv; Thu, 05 Sep 2019 20:52:47 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5ykI-0004XW-2x
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 20:52:47 +0000
Received: by mail-wr1-f65.google.com with SMTP id h7so4284075wrt.13
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 13:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o3XAFZlSwvqRShai5GXTckpV9x85IprbqlbdmH2dFzA=;
 b=B1OFGnLYAiA9JXPymwsWaz6xAWbj+WyBCcw16aElKC/nxMKW2lPMwzxvnMsqMepGfH
 UEGqufvm0nCpRUTIFA3B82jeisjXfUNIWCNQQxeEfcQ3d362JFpofEwjOPT64nARvuCf
 fddY/XQAPUPzlaSbrjGbf1S9h8SOlg/SqC5VjNLgPGm4SItJ2vq2WXyC+uW2jHTpZjje
 hAyOzbFtAwdLFtbIlfcPwF1ITQkLPfw0n/Uy9F0AakYPa6gKJ1xz4rpET4IxorPK3Wej
 Pl7bN99bHd1QXP5ETGfM5REM4eux974I5b2/K56q8Mv3g/Qhk3jTH8YrmYVPgjVs8Io2
 0gtQ==
X-Gm-Message-State: APjAAAUWzvWIb3IF/zGwf0Vfpvxi1utwsKeYVpmA8Ko/1hwG3+FUoLFk
 +vBZtSafygjZxtzlLiPHGoH0e5Z/
X-Google-Smtp-Source: APXvYqw7fWpSR45UDDGyicWGQaRxX1KRznOmvLRir/OHV+VwnLFzdVgSOKrCaxvdCcxcTv0bVnw8yA==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr4473776wro.330.1567716764579; 
 Thu, 05 Sep 2019 13:52:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id u18sm1988516wmj.11.2019.09.05.13.52.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 13:52:43 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: remove PI values definition from NVMe subsystem
To: Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
 axboe@kernel.dk, martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
 keith.busch@intel.com, hch@lst.de
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
 <1567701836-29725-3-git-send-email-maxg@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
Date: Thu, 5 Sep 2019 13:52:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567701836-29725-3-git-send-email-maxg@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_135246_131230_38AD1022 
X-CRM114-Status: GOOD (  12.15  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: shlomin@mellanox.com, israelr@mellanox.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Use block layer definition instead of re-defining it with the same
> values.

The nvme_setup_rw is fine, but nvme_init_integrity gets values from
the controller id structure so I think it will be better to stick with
the enums that are referenced in the spec (even if they happen to match
the block layer values).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
