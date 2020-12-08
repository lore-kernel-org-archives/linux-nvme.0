Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142AC4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:04:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 469A723AC6
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 14:04:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 469A723AC6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lTXgRi7SHEw06lkNHBlHqp3VD2fwMBhmy3jWuYn7TPY=; b=QSzfcFtOVoMxb6OyYZ+jzIZ2K
	Gd8YRo/Z07xGzx9YcMk2RR6rkMUlsXT/nz2/lwYReDh1j8Hr/enn18NQ4ZeYR9vdauKusdISQ5aPf
	NGikAlgNDM+iJ8YSnH2ZA0MWYQCN+hb5fjOB8vVgW4vlYY6p64//AeaGN63Z2cd1KheDqE+ky9cEi
	zHi3PKJNtQv3z/Sa+aXbaihXXL/o3NWJejM/2zkyWF2Yt4pUSHm1+kZ01iibEKz/36l2G5+L5co+w
	xzADMxmXK02OeLg+H1rVoLqqXCPt3IMrTINMtIQRWy6LSrlHRv6BFDQgYjFk+LU07FcQNebSnHvYK
	G3fRF3tqA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmdbi-0002RL-Jy; Tue, 08 Dec 2020 14:04:46 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmdbf-0002QE-Vd
 for linux-nvme@lists.infradead.org; Tue, 08 Dec 2020 14:04:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4F6666736F; Tue,  8 Dec 2020 15:04:40 +0100 (CET)
Date: Tue, 8 Dec 2020 15:04:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gopal Tiwari <gtiwari@redhat.com>
Subject: Re: [PATCH] nvme: Added QUIRK for Samsung PM1725a
Message-ID: <20201208140440.GA3730@lst.de>
References: <20201204161657.16421-1-gtiwari@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201204161657.16421-1-gtiwari@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201208_090444_130524_089A359E 
X-CRM114-Status: UNSURE (   5.91  )
X-CRM114-Notice: Please train this message.
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
Cc: kbusch@kernel.org, dmilburn@redhat.com, hch@lst.de,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-5.11.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
