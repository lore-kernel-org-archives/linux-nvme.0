Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32079CA9ECB
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:45:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084982080F
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qmHwHlUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084982080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2SIzY9HfHc3a41u93sSoDMdqG0TQN5CAdp3eUsxe3d0=; b=qmHwHlUEktrZ7W
	4JDSkL6987L8l04bgHU6EYPodGYomuO4PRx5OrhptdWbWiwO3y6zDFAeP/BxtesqrYxxJEj9vzbYq
	3GxBBGrLLTqVjPNOYyDgwwRFwQbqtef6yZjZ1GFoLHXvqNrefSn9dkiG0G1B6Tv34S+AKF9AZflqd
	hsadofMNvHNzIhswWaeM7E1Rmj2CD5+pnUpnd9OecA6NGtVMR+Kitl8IWZXDuaJ6by3IE9I13Evrp
	T7sKAIJDaGmVFL5N9CBEPomznIkmy8UjviDWGN64BQXGEyHdlWUHYIzVuYvUCv5jf0apf1eQ/ERP8
	Q9vUWl1o/sbu5XusDYuw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQAlv-000114-0j; Thu, 31 Oct 2019 13:45:55 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQAls-00010c-FQ
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 13:45:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9B60A68BE1; Thu, 31 Oct 2019 14:45:49 +0100 (CET)
Date: Thu, 31 Oct 2019 14:45:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
Message-ID: <20191031134549.GB4763@lst.de>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e62b6763-0d1b-3359-6d3b-cb31e96bb862@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191031_064552_656357_D623A728 
X-CRM114-Status: GOOD (  10.05  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 Akinobu Mita <akinobu.mita@gmail.com>, linux-nvme@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chris Healy <cphealy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Oct 30, 2019 at 07:20:37PM -0700, Guenter Roeck wrote:
>> The nvme_init_identify() can be called multiple time in nvme ctrl's
>> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
>> should we need to prevent nvme_hwmon_init() from registering hwmon
>> device more than twice?
>>
>> In the nvme thermal zone patchset[1], thernal zone is registered in
>> nvme_init_identify and unregistered in nvme_stop_ctrl().
>>
>
> Doesn't that mean that the initialization should happen in nvme_start_ctrl()
> and not here ?

I think calling it from nvme_init_identify is fine, it just needs to
be in the "if (!ctrl->identified)" section of that function.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
