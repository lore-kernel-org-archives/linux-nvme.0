Return-Path: <SRS0=g+aI=DG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2BA4C4727C
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 16:51:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FD31208B8
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2020 16:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HssgrP3H";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xfBpBhZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD31208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=85oWcZfwpHHlINWEqMIdKahCDjE+Fbm6VaEHwHPEpfI=; b=HssgrP3HU64hoPstPeeDZ6yRR
	3nc+ebZGlk9pKEYzLNwri1aYib7RF9WS6Tloggj9My6dVHTcMvdE92eaiZiftmrYtHQoP/7M6HD4X
	18AWkQKy+whKaSE3b4mEO+vjERsP7vTGzn5rzy39B6cfEiuSE7dHqwJ0p0l87CHaOtFuHipfYb/5E
	0wv3ZHLR+g3UXX3eGQeemouXS2bDh5B5n8EOGQi6BAgj6NcQvWiinhTBOU016AlEkfcIRYfI59Egz
	VWVQnOErZYV9MZ9IG44bGoEdbETzMFs8CzkOojzuTzuSWHJtYWo0GUl6pjdliv6Vpo6Puf63imgcL
	IBqdtRtjA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNIqZ-0005rX-Vj; Tue, 29 Sep 2020 16:51:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNIqX-0005qu-MD
 for linux-nvme@lists.infradead.org; Tue, 29 Sep 2020 16:51:22 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 073B8208B8;
 Tue, 29 Sep 2020 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601398279;
 bh=YJQDmxRg6iISwCGiSd/m56n8diQQoWR/jBhMvEUxFYg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=xfBpBhZuKnE5eSIUDhmnvQdI+p26/tEYGtSv2J5AMgw+b6tw0c5XiW3fR1kIcrk8d
 xNBAVeLNm2pGvPrviQjMdvMLJ/2QwUZfyzviA94Lty7ooYmO4OU6mWkanqFPqRLycV
 cm8HmGcocYbPDcKQG1aS5mcnAam0RX7UevQ5akEY=
Date: Tue, 29 Sep 2020 09:51:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: refactor the nvme scanning and validation code
Message-ID: <20200929165116.GA477114@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200929_125121_805434_4919F2E1 
X-CRM114-Status: UNSURE (   8.81  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <Damien.LeMoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The series looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
