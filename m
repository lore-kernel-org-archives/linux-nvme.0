Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D178BC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 07:58:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 309E360FEA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 07:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 309E360FEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7xin8YcM8UXA1N0nCbD4BbyDBrLeWo+T/XKKPOETZ9c=; b=b86XDCBfssVFrkUxnQOJNwBQv
	yK+uH8mSJW6jGfqjKYUkeSdI2g1AXHtrIJ95M/QhBL0M0olfEqWOWmSfauHYz88xAAasMhaKDhYWF
	OTH/eP4kDc0f8OC4/Qc3m4dudLvyhd2zpHRoltZ4G76BzaHGwRd0lWa8hHvr3vPtmFKSaZ0NxZuTB
	icJl49M2n2KXX6egiYosxjUP1BnG4SxmdOzTUXMaE5cMpmvMazl0vq+66ZGzj2uZR3twlPgNBtl3b
	gqv5iFYTRAfj0FAVjdY+tyoRRWK9J8IYZ+a+nE2+zL1nW8j3Y0kfoJWPLp/8wMNixoTK0kN+uzIb+
	iLInXVV2g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWwsZ-00FIGO-Dt; Thu, 15 Apr 2021 07:57:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWwsU-00FIG4-Vk
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 07:57:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=JfcaAWiL9MX/KzgqZFMd5GxaGaNC7KsyrSBFfXwwLXo=; b=a1kwCEdvKlN38U7sHKkS9fE4uk
 rotZQQa9nYHqkt7AV7UgX7kIeArdfJxrGJWqTIKMWOx8ip/0bUfdyQrWCVA9F+DtYa+FShQpFX8fe
 +yDGOF5iBYwKVkX7KJwgKibVx4SFbPzitfZGmg+O34fsiKFgQD35AUp0TiKenfqTBJdxYbm3UCyh6
 wAQ98tdci7TPMZC+26DwFPO+R2qKgSd8N22DV3neZJYPo4vV0l5bT+sLATEAB9BNKz01mmb6WSs99
 b+ONhw/Ubjh2rb9Jml3X3IY6Tf2019n7T/AUVSV2nDbkAPBfWh3lIECqEq2VuoVDw5JdxkIg1G6LV
 U+Muwezw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lWwsP-008G8g-W7; Thu, 15 Apr 2021 07:57:27 +0000
Date: Thu, 15 Apr 2021 08:57:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hou Pu <houpu.main@gmail.com>
Cc: elad.grupi@dell.com, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH v5] nvmet-tcp: fix a segmentation fault during io parsing
 error
Message-ID: <20210415075725.GA1968645@infradead.org>
References: <20210331074856.46966-1-houpu.main@gmail.com>
 <20210331091314.48925-1-houpu.main@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210331091314.48925-1-houpu.main@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Thanks,

applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
