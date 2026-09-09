Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE30C79F8C
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2026 08:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zEWkKsVzREGRmxQQmEc+XrfzsTnwrOneefxUy3I9B4c=; b=K2J4iKRj3/RuuWWf90Zdhc9p0+
	+GwiplZLWGtNnBjtzPtrZNrPNAsySvMODGVzp3PDTOnzuQziewsvXY3N/94UmvhKwgG+0EhQM85YB
	vl0CyRv2nXaGZREoyEQZlGwaLsgF9ljmQXY9ea0r45PnwHo1QTnZDhY+Z+Aef2DMJgZmmFpN5nXHA
	sWNuMBPq5auRNB6D1H+AhNeNWNVi0wKv+o5f1s7b6lWEXPxzl5TGkWx3elfSiKNdEKPJ1bwLxECys
	u3r8jTLPiJsMIMdwbumwwwfhjhtWBqqT/BqTtUJw2mn7pWCCmdH51dZOsrZaHO1RXFfBroDm9UDn1
	MrQ7CSLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4DPr-0000000B4Wd-43we;
	Wed, 09 Sep 2026 08:12:23 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4DPp-0000000B4WB-07Sl
	for linux-nvme@lists.infradead.org;
	Wed, 09 Sep 2026 08:12:22 +0000
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so5231068a91.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Sep 2026 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788941540; x=1789546340; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zEWkKsVzREGRmxQQmEc+XrfzsTnwrOneefxUy3I9B4c=;
        b=qqtM/GAXmxYAi0cuWaUn5dVLYddPUXD6uspsAETEjB9Qbh+ud9fMytzdJltc8/y2ef
         PbNpfPllCU5LwyU7zObJ++ObioZk+fY4wz8aVbXWeMhhErYF18nk9zqnhrgyiJGMVsB+
         TQYUMURjmnZHBdaswWXuaypEDeAj8lNvMk1wdVt0mVUi5jHhe6gRicx7uaqaUGDv2dQQ
         YXJVMVyzNFcDHwCE/PuAk4PQKszAm0hpUKPrTKecFKMuGQA6UEboBYJWuOxZkekjfyvg
         m4YMPVFkhHYzXJ7vzeZpuLJtBVuxNTgyQSHgR3vCER22G0BEccnoWfL16Qpv9IL8Cdzr
         1ntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788941540; x=1789546340;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zEWkKsVzREGRmxQQmEc+XrfzsTnwrOneefxUy3I9B4c=;
        b=CPh3JR4h2fqdfU+melEnAqbvCR/250oNjvMMrVWj2oVj1ThRA7wEoL1es2vkzcvvPP
         C2VemIyLJIvtgf9uHqCol1uDRgss0PQ8YPSQ7jWLIHVzpZDWmd9gYOUho2Eqqa0AyrZ4
         CIjz03qvIbG2miMPur6pgvOpKjIrmwiAaKILlhCTIdeEunY0m8U+MQYXhvckWAhMxxBT
         0Fdkc2+kKMSP0mcUdS5V4S2GIsOlp/8Lu4OjYqKxz7F34EYlEgTJS30KVBu/7Lh2u9UK
         EpM43cIdkCqKcZGekmPx5prfj3NscpP87eEC8vMjrOi1gZhcgwyjEGkk1XxeJamF9Pny
         gXMQ==
X-Forwarded-Encrypted: i=1; AKwUvBy0sgszJ8AC2SgjJtXMMqGQJJ8+e1pLTxfyEazlpUzVYteb4gE3b1Bq/7vqcxnt4gBp7DUx4vJw7cED@lists.infradead.org
X-Gm-Message-State: AFuF++kQ1sTDnzPHTHg2/dXtu+QZtYz5oSaO/QmhuZeJnd6IL270rN8g
	QK0CoN2f0x9ocsrklghLJ3/KD4OHSHyClQhRFU2qbNOEAM/wcPtgEQJo5EtiI4+9
X-Gm-Gg: AYBFou0NFuCU+lUX/RPFy/xEUVbf09xkHOka4Oe/vQxE3FcPCbtPOxzXOhUqEtrS9e5
	Mo7CKPpAs6SqVpP9mepNCnsiZK0L5B0/zQY4vZ9ZMsTRZLh1Y2DOjBzDQsq89vINOsS7O1ogP6l
	k/CaGlMsHCkzjf3LZDSbtw1YCLNuROZx01t0jmrC7h0MfqurLqaWFYro2nZqHK80ry81BteHbf5
	D0mymJG7/2E2IcLofPx2qd5gAjAnhcj5BxPPVRMXxfiJ0Rd0JvjaXaJkeXEpPiR2nPTELPYrF3c
	bQ1+DuMFzc1org2q6RgI9vcOLbT3IVgba/R6b0tfIiqVui/+TuflJ83iN3NxzGBKesDa3PyHl10
	UPOGBh8/N7MaNqDEJr2lltEozlWI0KNzBcFQREeTRXSKiBDFlhnS2UtzqJm2yXTjxFR4AdcZPyu
	yT6b159lfFp54zgDWLCxVFAyVryQh5corDrWVyC/VE3h6ZWGifSNl/6Ba1qdkUI12FqNKJtVurT
	8he
X-Received: by 2002:a17:90b:5745:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39b0803accdmr42757422a91.12.1788941539547;
        Wed, 09 Sep 2026 01:12:19 -0700 (PDT)
Received: from user ([2405:201:c052:b00b:d05c:1c4d:3d4f:dff2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1434c745a09sm10336241c88.7.2026.09.09.01.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:12:19 -0700 (PDT)
Date: Wed, 9 Sep 2026 13:41:57 +0530
From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	syzbot+6c46a179b56c651c4c96@syzkaller.appspotmail.com
Subject: Re: [PATCH] nvmet: validate device_path before enabling namespace
Message-ID: <aqEUzUyPPkwFcT73@user>
References: <20260908193452.53347-1-pavankumaryalagada@gmail.com>
 <aqBonYN7WeEn26JZ@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqBonYN7WeEn26JZ@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_011221_235172_0C23A2CA 
X-CRM114-Status: GOOD (  13.05  )
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

On Tue, Sep 08, 2026 at 01:57:17PM -0600, Keith Busch wrote:
> On Wed, Sep 09, 2026 at 01:04:52AM +0530, pavankumaryalagada@gmail.com wrote:
> > From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
> > 
> > When buffered_io is enabled, nvmet_bdev_ns_enable() returns -ENOTBLK
> > without checking whether device_path is configured. nvmet_ns_enable()
> > then falls back to nvmet_file_ns_enable(), which passes the NULL
> > device_path to filp_open() and causes a NULL pointer dereference.
> > 
> > Validate device_path before attempting to enable to namespace and
> > return -EINVAL when it has not been configured.
> 
> This was alraedy closed:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=09d0c07bd9ce3b2f2d993f672698d32a17543c32

Good to hear this has already been fixed. I'll drop the patch.

Thanks
Pavan


