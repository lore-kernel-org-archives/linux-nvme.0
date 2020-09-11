Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EA6C433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 05:32:39 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2105221D81
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 05:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iTb08+TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2105221D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DeOcsF2Y4ZPIT3pyeqyU98uKeCQY0GJQ6hJVI7rPwmU=; b=iTb08+TQ7zIeP+mRcU7OBcRK7
	BoxF9LozI6JDexCUES8a1vLmRmWcSzYvYhl0x+JrKgflU28J0Ok/Buy60VzeJTcC7c13W1V5LISLA
	qfFHsoeCYBpqrbLmX9bU2fEB0/CFtcJGoAzCn9tY+1XsnV5nbQfiilgDeI2RF7lqKrYTq4BLo8nSk
	QFQFPR1rxrEq4cLQ6by7jcfnKkVeAWuaNcmNJ0l0Y9ItaWP7cbb6kgqeMizxcqW/VRYqx2FFlUFBV
	qHpOdcOCmgmxJHMOAtReDU7SyeOiNdSgCwiEckwtcaV6Psh9qeu4dDqi0rWGxpsiFY2W5jh2ehx6Y
	7TWR4N09Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGbfl-000089-Ix; Fri, 11 Sep 2020 05:32:33 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGbfi-00007j-Se
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 05:32:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 561E367373; Fri, 11 Sep 2020 07:32:27 +0200 (CEST)
Date: Fri, 11 Sep 2020 07:32:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Milburn <dmilburn@redhat.com>
Subject: Re: [PATCH] nvme-pci: disable write zeros command for Intel 600P/P3100
Message-ID: <20200911053227.GA20950@lst.de>
References: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1599772730-23806-1-git-send-email-dmilburn@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_013231_042445_25D9E8FE 
X-CRM114-Status: GOOD (  13.76  )
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
Cc: kbusch@kernel.org, david.fugate@linux.intel.com, hch@lst.de,
 linux-nvme@lists.infradead.org, esandeen@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 10, 2020 at 04:18:50PM -0500, David Milburn wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 5e07d5628864..d31e298669a9 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3153,7 +3153,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_MEDIUM_PRIO_SQ |
> -				NVME_QUIRK_NO_TEMP_THRESH_CHANGE },
> +				NVME_QUIRK_NO_TEMP_THRESH_CHANGE |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },

That's one amazingly buggy driver :)  Wasn't it the one with the
corruptions with 512 byte writes as well that got fixed by the firmware
upgrade?

But yes, we'll have to work around it, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
