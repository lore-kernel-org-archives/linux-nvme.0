Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB3C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 20:04:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B9D60F6E
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 20:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 80B9D60F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BXCa4Hgjb7N/azmpSuce9GB3UWu59ZWOtvDasm6W5MY=; b=Rhr6ql3yGDKFBE
	v+kyunxmvo5ZBmt3bNiv7Mj5BRrNfDptFLxY85UTZWkh+JvZHbOKcpdI4TJ/Jf0IxBZA0Pn8iGUBI
	GlNY8kA6jBoM6LcRf0d6pbN61fx4etp9g0Lervt8YMyZXFpVYZTYF9yir32TV9YMippMAfsuPTqwx
	rAr11n8WF0dmUfTTPnJuNRpDFXDJz8+ggx7D787jGU19mSmyubGVF3TX4v2CjE9pQCxO0xmuVD7AQ
	2CXuKVZnXxQfi/o6R/GhbS1ibXzZCvdwektyh2Y0YA9Nj4v3Oj8YXG9BF9fLmHYgO4JNVYPzararq
	xarlVUpu3P+MxNwD2Ipw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUwr6-0046WV-3t; Mon, 27 Sep 2021 20:04:04 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUwr3-0046Vw-2h
 for linux-nvme@lists.infradead.org; Mon, 27 Sep 2021 20:04:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E20E960F6E;
 Mon, 27 Sep 2021 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632773040;
 bh=MFwe9PL5aTujNxjSa8SeN0kF/X9qHslKGfeh/sg2e/g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=opUZH7/j+/Z39awBPh3R9z63PgMl3jY7Jj+2/4b8JV/F+4keFj/l5KUe4/GV0eFRH
 ME/ZMXEO7KA9FsGRMUIJRG28HiEZYR1VEdyzYjxOg9vV/VAp+kSliMf402t/d7TqvE
 KVnisq3ndAdhFniRhLGabBXCzwPcp4lmANf33dmT3eG4nBMhJpiqA8r+XkYmT8ub5C
 FNyDvw7LqMEAWv5WyYrvkbA6HjQUWX5sWI6uRajKRRmPmni7h1mCuAZIXDirjIXcBc
 hYerj8nwaSNlkrdl0xqmm4m2wPET6Y+/ZI+oaPFc3ACb9Ne39AGWn6JPGZ6ycj+0X8
 XPWcjqUE1SbXQ==
Date: Mon, 27 Sep 2021 13:03:57 -0700
From: Keith Busch <kbusch@kernel.org>
To: Steven Seungcheol Lee <sc108.lee@gmail.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme.h: expend lbaf on nvme_id_ns, lbafe on nvme_zns_id_ns
Message-ID: <20210927200357.GA387558@dhcp-10-100-145-180.wdc.com>
References: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGrZSEyrdJaZkHX9fPse0bv3d1x-HU7vvPQeg5JyR++_hOs8bQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210927_130401_165088_B586E9D8 
X-CRM114-Status: UNSURE (   8.52  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 26, 2021 at 01:34:10PM +0900, Steven Seungcheol Lee wrote:
> lbaf, lbafe used on nvme driver
> Base spec:
>     NVMe-NVM-Command-Set-Specification-1.0a-2021.07.26-Ratified
>     NVMe-Zoned-Namespace-Command-Set-Specification-1.1a-2021.07.26-Ratified

In order to ease the driver maintenance burden, we typically don't
update spec fields unless the driver has a real use for them. If this
patch is part of a larger series that eventually does make use of these
new formats, please send this update when that happens.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
