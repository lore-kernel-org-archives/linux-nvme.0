Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80BAC433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 10:11:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C8D2613BA
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 10:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C8D2613BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=y1Se0lwwtdZzd0tT/hb3Zmq5Hwh3eeWq5LblYd+Q0qg=; b=p5Q7tfnhrRtsRIBK79jwJ4y+8
	gftnCH1n8yw1adbD8l8op4x/OgYFy29sqXUHW+qZnKyJsyzOXHxIDKPhv+qyyYYBry5ceLclzaJy7
	D4018235W0BwDX6W8GL+MGAfSQSFJjMPZXIS3XoAsEe64c6RNfuTzRAE1hVCmpDnOMOsnGmm1FgzA
	uEwsbJ7RiuDg7NMTbOj/FI5Vp3A58lq83dyBiEUZ+VW1z2kTDEefHJFt/q5d2npLxOLY3QaYxZQJm
	4LB1pk6ZG7truaDNNCwH4WUTYD8YzZ8MltofwtuJQVKrkMkygSoVPc6d7td5kJ6ntKsKpjbb8WBH/
	g2LsMgMBA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWG0r-008qUN-2W; Tue, 13 Apr 2021 10:11:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWG0n-008qTd-9Q
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 10:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=fl/1ZMD5qUl9dS99/bWbzPXDS8YstzPHeTCXNiOwIGs=; b=a3KjvYRKPasH0k8bEWwke6yKQt
 wGRG1wUJL0PnJpR+1xe80FmkFEew0DwCmKeNDzH5eByY6C03c2TN14xyiK7bWY+1xIIEJBO1TQMPn
 gPlTzQOKsb/T5PWU8vGFhvyhS/j0NqOZzKEw+Ve3kKhbcJg5U5wk7ld9kD2RUkAu3daaYedZEQG39
 6zVDZ57yRhZnjWzF8mt19oAcfiuz6zPVa7xZgkwOgcQ91cuVvQPDS9jEKbhh+qpYmMcFjwAXaK7FL
 vjnqCTa8726WXZFIaVy9cphcZD+Fnn5O6Hf6Nq9CAx2AfMDHmftxJy5xe8PSx6zky6U0ne/6uAS3u
 5I/4b/8A==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWG0k-006uvI-Fg
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 10:11:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71BA4613B2;
 Tue, 13 Apr 2021 10:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1618308669;
 bh=/D/oYhNB0J0V0t5MY6qpxHqiR8LW5iJBR05naXme4xc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=LnhjtBAmw/hUajpQgwxwyoNef5Rg/zWYFPdcE25qbmfEBHxP6nr3GxxTtRW2oN7wg
 xBx34SZ3722MvK1R6uSsIoB+0U5KTg2dUbdCTZYjrQdhdaS4JaN5nL0e/BYS1LTHIC
 ilHHpcTOgn6xbx5ASVJ83OlkrvOF5CL8tkUmJZVM=
Date: Tue, 13 Apr 2021 12:11:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Prike Liang <Prike.Liang@amd.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org,
 Chaitanya.Kulkarni@wdc.com, stable@vger.kernel.org,
 Shyam-sundar.S-k@amd.com, Alexander.Deucher@amd.com
Subject: Re: [PATCH] nvme: put some AMD PCIE downstream NVME device to simple
 suspend/resume path
Message-ID: <YHVuOwc4KlF6Qvg7@kroah.com>
References: <1618308289-12929-1-git-send-email-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1618308289-12929-1-git-send-email-Prike.Liang@amd.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210413_031110_566554_57D15B05 
X-CRM114-Status: GOOD (  18.58  )
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

On Tue, Apr 13, 2021 at 06:04:49PM +0800, Prike Liang wrote:
> The NVME device pluged in some AMD PCIE root port will resume timeout
> from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> This issue can be workaround by using PCIe power set with simple
> suspend/resume process path instead of APST. In the onwards ASIC will
> try do the NVME shutdown save and restore in the BIOS and still need PCIe
> power setting to resume from RTD3 for s2idle.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> Cc: <stable@vger.kernel.org> # 5.11+
> ---
>  drivers/nvme/host/pci.c |  5 +++++
>  drivers/pci/quirks.c    | 10 ++++++++++
>  include/linux/pci.h     |  2 ++
>  3 files changed, 17 insertions(+)

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
