Return-Path: <SRS0=AClc=25=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D74DC282DD
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 20:31:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52DFD20643
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jan 2020 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAwDdmLJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9QeDYB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52DFD20643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=l6JTtroYUQjkeu2FCD9OLIIfccBEn9ct6HyNQb/Y/Fs=; b=YAwDdmLJVEa/Nw
	UIR9TGKUE6MqVtg/cw8YjD8w8ezRSleXwlulprMDlO4nEJzld4yOoU+cy5iUYNOP5JqEthBFO9jl0
	BQHJeDLOGPUgzYHN23sDBxMGVpKx1dNjHXfBxSYBsOPkCrTZ0fAyWnPa1EdFeaujjP756s5WTrvIA
	kh4IDxEGADU2Z6LFdJaITDOu2Z9Ihaqdp8VdpLPpEN6OLjAt4OnbxA0mFKGuToC6Z2om5G1vHExXb
	3QXstMnOQ2QNLx06bj+3kw/DgBdE5I++KpHyEyMCw/zzTVyGNvZ3VJgdZDfisdGOZuokwbQqA98tD
	fPlQgbm9tQ+7n+p7Sgjg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipHza-0005KT-6E; Wed, 08 Jan 2020 20:31:50 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipHxD-0001zX-Ub
 for linux-nvme@lists.infradead.org; Wed, 08 Jan 2020 20:29:25 +0000
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 799FC20643;
 Wed,  8 Jan 2020 20:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578515362;
 bh=4aVaL3GoEVlniUVTRMP7sOLyUvUYpviSYUtaFV5qyhM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V9QeDYB52ewmiqMefM4WgSBQorVa7UE2YNaxpIdpPgmi5+fiozAMK3rtgYr95hxst
 fG3OE8/hJ3saRSONtY90k987jWrvdH9v5FqeTZGx7qPQClNCjfQ1IPmVpcdCvD0Tug
 aABTSHTcaCKDO2+aio0Ns2aF7ObxckKG04iVnc0w=
Date: Wed, 8 Jan 2020 12:29:20 -0800
From: Keith Busch <kbusch@kernel.org>
To: wenxiong@linux.vnet.ibm.com
Subject: Re: [PATCH] nvme-cli: improvment critical warning format
Message-ID: <20200108202920.GA1020894@chuupie.wdl.wdc.com>
References: <1578505175-15002-1-git-send-email-wenxiong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1578505175-15002-1-git-send-email-wenxiong@linux.vnet.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_122924_015989_65E2BE0F 
X-CRM114-Status: UNSURE (   8.90  )
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
Cc: linux-nvme@lists.infradead.org, wenxiong@us.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jan 08, 2020 at 11:39:35AM -0600, wenxiong@linux.vnet.ibm.com wrote:
> From: Wen Xiong <wenxiong@linux.vnet.ibm.com>
> 
> This patch improves the critical warning format with smart-log.
> 
> Signed-off-by: Wendy Xiong<wenxiong@linux.vnet.ibm.com>

I merged the concept into the master. This patch looks like it was done
quite a while ago, so it didn't readily apply.

I also changed the keys for json output. These should idealy be single
words without leading whitespace. Please have a look.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
