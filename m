Return-Path: <SRS0=6U9w=JQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B53C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 06:58:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 099D96101C
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Apr 2021 06:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 099D96101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6EqexGSPX6F6oLb8mfpfO+oxkSF32yloclnAiz7Tv2k=; b=DSC3Zs+ZVfaOkbBFu59NcxfhS
	RdsuIf/lLzocS44EUw8ByU4qADhIc/POuvAIO/bLqA3CZ6tZicJ7jYyeGDJ7jDSSaoUJhwimhHPyO
	kIevFsYchq/9JQzP9NI382C8S//zTBliuUYCB5hLxTwhtceboVhEmB0SgHeLY7BqZLEdsdkWm3XrZ
	g+en2bKr8TYtsropkD64eRdISjuRFfxcLsIJCOXztJmUItpqsPAH41LYdbI+bMt5Z7Bsm97VGQwVD
	QHaqM3foF10P60Bt9F2jyTtJcicI/V7pMd+rrd00rYv1jv6ywWhUJf4T+lFW9nXHHp90SsDfYR+Yl
	/MCUpBrNw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYNrF-009HFb-HA; Mon, 19 Apr 2021 06:58:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYNrD-009HFL-2z
 for linux-nvme@desiato.infradead.org; Mon, 19 Apr 2021 06:58:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:Cc:To:Subject:Message-ID
 :Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=NED6jjF9FTGvqZjiOiGlzkrUtxsIiQuMqxjuwK5DjQ8=; b=VAY/awS6p6siSAlYaUy69QgWDo
 ouS0U+ZZhR+CckWn0P7WvY6b70U2eVL6fiydyC0GSDIA1sNaCfZ1i1+ittr3lzypGIbltA2dcVZaq
 oY9ZwpRLbrToUi2aY9li+r/vNl1ai3xAkmGzxrZcZSlc+pqLqOJwBaCePtOstJO8S7t6CD5mA0dPj
 k9kBEZvdBI996grZe84jRhkZ4EqtT9IfqcDBZ2KnsS6uupwKqtGZJsk9jcGkPutucWNtXdHZ/gKDT
 rHpWRx//3NRElw27oMHkOCHkpuk1ocsMScYIxMGA537IMLIHRPNDAJhlaJXt/AbRTOXn7wQPJ24wG
 KNsFfEzw==;
Received: from youngberry.canonical.com ([91.189.89.112])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYNrA-00B5um-6w
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 06:58:05 +0000
Received: from mail-lj1-f200.google.com ([209.85.208.200])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>) id 1lYNr5-0003FW-Fp
 for linux-nvme@lists.infradead.org; Mon, 19 Apr 2021 06:57:59 +0000
Received: by mail-lj1-f200.google.com with SMTP id
 q17-20020a05651c0551b02900bdd1e782edso5862181ljp.3
 for <linux-nvme@lists.infradead.org>; Sun, 18 Apr 2021 23:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NED6jjF9FTGvqZjiOiGlzkrUtxsIiQuMqxjuwK5DjQ8=;
 b=QUBZw8JrbA1FNn9r+42Tw+t0NXPCynHAdYFhPW74Jz0q/FkTpib3X1Dzoc1MRRz13F
 vcbsHVlCQKAR8G5zNJAwIVNxmO0RkGgkuIErNsK4R9EPRlTz1QAwYPNPfgw73vHWZ7zL
 vS0XZHJGsm6hiUhK9rnblk+ioVI1cthaOZURhYW0wjigP+bWft3WrJqYGq1dvZaKOGE0
 SN2iGBIl3wNRnVv5xvk3bJjl19QnQvK1/IPkI6EMOyjNdxy0Yc0hyPWRsMlJt3v8+ple
 yTMFrDpjbngqhaA3rPRPoiRSir7liB9EN+uvN2veWPo2YviA0MHczROlzDw9WNNVGxmB
 NDzQ==
X-Gm-Message-State: AOAM531uVn+rtpaYIXMVvoxOgLDWlftKIvhzdslOf5yLZoRjz49IpRZu
 jnRMcQYWYDSW8bQvwsUY0hN5kBVQExkMoXnEaBWvSJY5W+EYeG2IdZ2MnHHXvsKerPslw+e2ZdY
 gvQmiFUwj+bvAnjyfIsgQ3NMJ3lH/TlBkY7ojG3RQHhXn3Y4626ScxLQABUfC
X-Received: by 2002:a2e:97c6:: with SMTP id m6mr6276936ljj.403.1618815478916; 
 Sun, 18 Apr 2021 23:57:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymqqDsD4BR0a12QO0hOs762glaPCScP1aUjakoJbCxpHe65YTQsfDj47rcBPva+aKEpAhhlP3dFqKpvkuEwk0=
X-Received: by 2002:a2e:97c6:: with SMTP id m6mr6276920ljj.403.1618815478670; 
 Sun, 18 Apr 2021 23:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
 <20210419065027.GA19201@lst.de>
In-Reply-To: <20210419065027.GA19201@lst.de>
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Mon, 19 Apr 2021 14:57:46 +0800
Message-ID: <CAAd53p4r45fZ4ewCko_Q-mO92omBZkEiPpyyc2SYRXH+6WpEKg@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports
 it
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, 
 Alex Deucher <alexander.deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210418_235804_661447_DEBA254D 
X-CRM114-Status: GOOD (  12.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 19, 2021 at 2:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Fri, Apr 16, 2021 at 05:13:44PM +0800, Kai-Heng Feng wrote:
> > On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
> > because their SMU FW may cut off NVMe power during sleep.
>
> We're already have a discussion on a proper quirk for thse broken
> platforms on the linux-nvme list, please take part in that discussion.

Thanks. I didn't notice v5 was sent the to mailing list.
As of now, AMD folks are also reviewing this, and I believe this
approach is less quirky.

Kai-Heng

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
