Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B18DBC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:51:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F355364FC1
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 10:51:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F355364FC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=/rxW8oc6RBpUO6lpG70oHkIJC92L++lK3qEGfzoJClc=; b=dJh2eYU7pt6wjERvUwYQLkvVx
	U84eSO28ggxUAB7NAkKnqbi5mv0XRvLcBiGpdbsiI4+8Dq5EN/t7A70No/eCU5tm6WMLHAzvrmKJM
	4tgTi6gEW2wh9XQ+2VzcLO5Mrn9V2MaY3/UAxosEtgu6WYcelAEiwuOl7cv93Dr7oaH0D77PjOtxx
	TMmxooqJtvwo217D6AR8NGmFq0uMrNjdhkn73DHfpr7zsWS+WYdNSLJDEtMkYZZVpNT5uxhRdTK97
	8jr0WQYAK2++1TbFwO+6o5QvZQtp23cDdsy0a+8J3uqGd3Q+tof+RMiTKtv1PbD5DRkUdL+ELSG7v
	onS5R2RRA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKIuR-008shE-OY; Thu, 11 Mar 2021 10:51:15 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKIuN-008sgn-S2
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 10:51:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9997168B05; Thu, 11 Mar 2021 11:51:10 +0100 (CET)
Date: Thu, 11 Mar 2021 11:51:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: Re: [RESEND][PATCH] nvme-pci: add the DISABLE_WRITE_ZEROES quirk
 for a Samsung PM1725a
Message-ID: <20210311105110.GA16485@lst.de>
References: <20210310120641.1633-1-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210310120641.1633-1-dmtrmonakhov@yandex-team.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_105111_962308_F0E61541 
X-CRM114-Status: UNSURE (   8.46  )
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

Thanks,

applied to nvme-5.12.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
