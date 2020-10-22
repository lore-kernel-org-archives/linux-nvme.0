Return-Path: <SRS0=3deH=D5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A70BEC4363A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 18:45:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED29924630
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2020 18:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="07TLHoLv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="lq05AoxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED29924630
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:Message-ID:
	From:References:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=k/BGc7M6G3aFuu3Tb05yujA7crW8QN7V7KTqZpIEF94=; b=07TLHoLvTsapW9hHCNRqoM5PQ
	/H2yy5kzv+sIvxOYjkw116fkzAkvMLaqVW2RGdJWBVp7eZ2qpZO7F/m1HGGA0BxwOnLECTzbd4ffQ
	YxHCQAgevQ3Lg7AdZCtoB+dnqPFThd5OEzAJSwJkkRocme2dcdLnRTH5PbKJirbfaLTz2LG5ahFg4
	3ffL02lSR+LrpFvVzu1vAPvkLX2EIHNMW4mkL5379ogfV+al6l1iS58EMyvKwGlGfrLVqYD7W5fDL
	KmaVz/l6vcso9LzrLpM55aGax5KQGmtnNmAfd09xV6e5HWGZFPvFApDiJ/VZHfG1mDBh1RM67rk99
	QBsfaRDqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kVfal-0007u4-15; Thu, 22 Oct 2020 18:45:39 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kVfai-0007tc-Gh
 for linux-nvme@lists.infradead.org; Thu, 22 Oct 2020 18:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uf6C3j/ocrBTm97iqgRtQoheYZQH4nzs9ZR+u0LyQS0=; b=lq05AoxRq5ysREPtYrPSKtt+zZ
 IiorJvq1mo/HpX8T89V7Nb7wfbLJ9rBkb/cKdr0iPL3Jn+727NrDZeVoUxsYiiz0dVZjydHb4q+/w
 ZtVALKjISZkAdX0RdP4UNqc0tVK/iPwPzNSDv7LwCrL6ANRr05UISlOl3WWm+w+Tlzxx0Gj1j2Sty
 T+/3ZsL7GHq4Bm6o/XdDcgXK+SpoGXvPiKkAEjfI7cvh3u4LyuNDrYfCF5CrYSm7HtMbtjLbvPhGe
 CCZ/nsQ4kzykeOcvlWPsPUj0JAslOxvgXdTVNPJHkpeotI5iLuu2xXy+XuCG5r6BblFAsV1FdrEXv
 6KitHdtQ==;
Received: from s01060023bee90a7d.cg.shawcable.net ([24.64.145.4]
 helo=[192.168.0.10])
 by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <logang@deltatee.com>)
 id 1kVfaa-0002PY-K8; Thu, 22 Oct 2020 12:45:29 -0600
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20201008164024.12546-1-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <29f3dc94-50c3-1548-034e-09c5394ef781@deltatee.com>
Date: Thu, 22 Oct 2020 12:45:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201008164024.12546-1-logang@deltatee.com>
Content-Language: en-US
X-SA-Exim-Connect-IP: 24.64.145.4
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com,
 sagi@grimberg.me, osandov@osandov.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH blktests v3 00/11] NVMe Target Passthru Block Tests
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201022_144536_562769_23035D8A 
X-CRM114-Status: GOOD (  11.14  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On 2020-10-08 10:40 a.m., Logan Gunthorpe wrote:
> Hi,
> 
> This series adds blktests for the nvmet passthru feature that was merged
> for 5.9. It's been reconciled with Sagi's blktest series that Omar
> recently merged.

Bump. This has been around for a while now. Omar, can you please
consider picking this up?

Thanks,

Logan

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
