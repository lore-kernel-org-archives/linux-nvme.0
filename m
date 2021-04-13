Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C81C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 15:57:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1A5610C8
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 15:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1A5610C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PobE7D2NoI0THrmrtazpWgbaGI9KJpp5B+JFGsH8dDQ=; b=VUuPAcEUnpAZFmuBzPQjrxIqM
	suvLXTAjOQkj6GMaqShv0a99MTEOH9iqTqPxbng4cauQdzIGA5mD/xsCwdtbq4LmSUUPprPNqjjf5
	Xl3HYtXqjJ/EUB5ggNKQ29Z3iwehJO2kc2uV7u4XHoKG7GmXkJ25CwAMs/nhCENN1U4ViO2AY1ToM
	m07Of/PoNE1Yo7/ZxVoGNAVLkJF4yAXjrAe0Ubhi2qxjTy3WO7PsZQCVvhWts/AYLiBNyR2q8Fy5K
	9lRYO3p0PHj7Qdc9hnt6OdFK6cmxnWkKpI9bST5AadpvSubBOSIJ/djerv4FyJX8hdvhOq+peBrIL
	MkJKAk7RQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWLPY-009ivz-7O; Tue, 13 Apr 2021 15:57:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWLOn-009itS-Io
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 15:56:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=na1Wr+UddoqteY1PW44J5UqsiQXXRQvO9/9AwEIe/ow=; b=MRMKNN1NbWXd6VEz8O9v2uWdtl
 N1vjXFKWYmFxyICGBVmyOrqQfZXy8ZqRoNLHE93f2xK9D743audnKR0hBlB1b7oRgBPBiORHMFYQe
 GSBGmLk6KtUsEUEiTY5D5mhGqTtP9lrACRFu+5TTYvSg57TxPjvti8HXquosvOsjmi9iZq/sR+VDM
 6VJb1YKg/LOZYJAtizBU1xwMPHM1Gs3tJNjxHmktailQCdN8ibsruLjKa7fh7tB6GTwK0wZ6J3fxx
 dWaFJu1p/0vEZ2wkeAZrOoJHIlTiHR1w2K7l3MZV/kPvYR+ffPLq6M+dzOw7/qgeZvoJvSBRPiUQH
 e7XjkSFQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lWLOh-005wZe-O9; Tue, 13 Apr 2021 15:56:16 +0000
Date: Tue, 13 Apr 2021 16:56:15 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, gregkh@linuxfoundation.org,
 stable@vger.kernel.org, Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Message-ID: <20210413155615.GA1415050@infradead.org>
References: <1618308289-12929-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618308289-12929-1-git-send-email-Prike.Liang@amd.com>
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

This is still not split into separate patches for the PCI and nvme
parts.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
