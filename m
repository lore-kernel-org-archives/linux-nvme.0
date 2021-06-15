Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4635C48BE5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 20:46:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 874F3610EA
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 20:46:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 874F3610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4j+ZUBifmKdHz3+tfKtmtgG/j9sNaYCZLYVzAnMuPwo=; b=gx1cI3KDQB9Lpw
	LbkMMVdzF66bbkpPXF5+iExPaPzilvyC90M7Q+xCPDqpb7i7Cnjd0+FGWBI4QKLFn0mmEd7Rl9FUS
	/v8ddcsymBQitlmcn1aqVlTITmvURC/LkXPAV46IvzLNg7CGlhRIvyesHwPeD4BO87OgYGa4ys1Ew
	FJNBFbLNQ85AScsScuZseEm2HNIVeYxS77M4E1LDRSzmK45Eg0R1PHBIJb0L3ySXupCwSTW+wUTx6
	+Bvj+oc3LUj/B/XjcLLVIKdu0yjlZj153wBuOdMSzzFcDru18q5bZHGPdLGIK9kqTLx93LlnoX1B+
	JFRNg4kzUFwgkjsL5x5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltFxA-002tSv-Oy; Tue, 15 Jun 2021 20:46:32 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltC6z-001Qrd-JT
 for linux-nvme@bombadil.infradead.org; Tue, 15 Jun 2021 16:40:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=5FZF+nzoNs+2s8HLmIhZRxBAxRnewEbVFUS3EyR6jG4=; b=ayNVblkvYkptYlBsxiypW3MK5U
 INBoDtLgCDwajQCTCfQe70EhAuIvPoA/EXXihlYhonBCYyHAWfBA9u/sbsRAuzU1y0s0/eLxqgDbS
 uhqg0H0XHP+0sGfjaF8MXcf8rUQZ2Bxrc6VHrryNgxaW2A69clmmqxdxwYDhSXJGmNuP5K06tDM3J
 HK4wIMtfd4HEcY6aXZYe/OQVCM16Y0L86YqPrWBPTPEyTCLaXEaAg1fd+PrhHtkda4JuylvDlVUQm
 vtarMpVuQeI2pejeDNeorMoPG9SuXSoTGXoWgy8i5MBWjvbnHlOUHbOGS7GfQQufbUjfBTQFXj35f
 PqgKvtSA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1ltC6U-0071YF-7G; Tue, 15 Jun 2021 16:40:02 +0000
Date: Tue, 15 Jun 2021 17:39:54 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Casey Chen <cachen@purestorage.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: Fix multiple races in nvme_setup_io_queues()
Message-ID: <YMjX2qpSQCjVkToL@infradead.org>
References: <CALCePG0up2GK_ihFnLxHuUS4Zn0kfSAC2x1U4Vm_6BQw3Deo5w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALCePG0up2GK_ihFnLxHuUS4Zn0kfSAC2x1U4Vm_6BQw3Deo5w@mail.gmail.com>
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

The patch is so wrapped that it not only doesn't apply, but that I also
have a hard time reading it.  Can you resend it using git-send-email?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
