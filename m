Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F33C4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Nov 2023 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ekxLl5mg6uyebw0+8QSXiYfL8qTfhDVbDhwInXfLUCs=; b=q6PegNajgTCx69YP3JVm7VbgIE
	D47W9jqRjHu4RNxAxWgUNvhATt9sNXibOI4Jw+6dthmhN8l4a/t5CqZoGPytKM1lD0DFMwcXPDYqW
	s3mNwt1Ilrxhb064Eal4+p/rIbzpzszlOaGpC752MEPqS17mhKWmRGaGI2B9rc14XT3HL83DC3qNw
	uoX3Uj/wxVqBMMn3qeWJjgkwrxCE5wSV70bYiynabd9IU6nyTkfBFJWhXsWZyz0inTyxUau2GmFY0
	1wwL0x8fL0HKklFZ4r844jcPx531d1wdtUADFsETdYWzvltMlA104lA6kjQEPiahhKjiQSIPfGVuf
	9JVkAzOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qyszW-00BNbc-0N;
	Fri, 03 Nov 2023 12:09:34 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qyszQ-00BNZx-2L
	for linux-nvme@lists.infradead.org;
	Fri, 03 Nov 2023 12:09:32 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CA291FD69;
	Fri,  3 Nov 2023 12:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699013362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekxLl5mg6uyebw0+8QSXiYfL8qTfhDVbDhwInXfLUCs=;
	b=tkveK/98j0/0draXLw8OIwF0WvNEDPyvfxcRnuavegSWlE8FdouNSqwS1LRsQIb5D5Of0+
	y0ELxBofh4mgL2JaDDeMS0yfhiiPekUigYUeoUeLDdMnuRx0nxL8M11uUOeB3ArmUXTF9B
	KZkdZR8AF5qWU8V6CM06T8qdmp0TIxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699013362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ekxLl5mg6uyebw0+8QSXiYfL8qTfhDVbDhwInXfLUCs=;
	b=dPRuMbCsrgZeA/flW50Cn19TW7Nu/uqqzqN4Nm/6Qn7BB+XbYRBmHtotYop5FARxZubDlO
	WaqOCBjMvNPl63CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 32B8913907;
	Fri,  3 Nov 2023 12:09:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PmEMDPLiRGUJTQAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 03 Nov 2023 12:09:22 +0000
Date: Fri, 3 Nov 2023 13:11:02 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <Niklas.Cassel@wdc.com>, 
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231103_050928_925459_5EBA5D8C 
X-CRM114-Status: GOOD (  16.76  )
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

On Tue, Oct 31, 2023 at 10:08:53AM -0600, Keith Busch wrote:
> On Mon, Oct 30, 2023 at 05:00:44PM +0100, Daniel Wagner wrote:
> > The firmware version sysfs entry needs to be updated after a successfully
> > firmware activation.
> > 
> > nvme-cli stopped issuing an Identify Controller command to list the
> > current firmware information and relies on sysfs showing the current
> > firmware version.
> > 
> > Reported-by: Kenji Tomonaga <tkenbo@gmail.com>
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> 
> Thanks, applied for nvme-6.7.

I've got negative feedback from one of our customer. I've annotate the
code with

	dev_info(ctrl->device, "afi: %#x\n", log->afi);
	for (i = 0; i < 7; i++) {
		dev_info(ctrl->device, "frs%d: %.*s\n", i + 1,
			 nvme_strlen((char *)&log->frs[i], sizeof(ctrl->subsys->firmware_rev)),
			 (char *)&log->frs[i]);
	}


[  124.824812] nvme nvme8: afi: 0x3
[  124.824824] nvme nvme8: frs1: 0.4.0
[  124.824828] nvme nvme8: frs2: 0.3.0
[  124.824832] nvme nvme8: frs3: 0.4.0
[  124.824835] nvme nvme8: frs4:
[  124.824837] nvme nvme8: frs5:
[  124.824840] nvme nvme8: frs6:
[  124.824842] nvme nvme8: frs7:


This particular firmware seem to interpret afi one based, while
the this patch assumes it is zero based


	memcpy(ctrl->subsys->firmware_rev, &log->frs[log->afi & 0x7],
		sizeof(ctrl->subsys->firmware_rev));


The spec says


  Active Firmware Info (AFI): Specifies information about the active
                              firmware revision.

  Bit 7    is reserved.
  Bits 6:4 indicates the firmware slot that is going to be activated
           at the next Controller Level Reset. If this field is 0h,
           then the controller does not indicate the firmware slot that
           is going to be activated at the next Controller Level Reset.
  Bit 3    is reserved.
  Bits 2:0 indicates the firmware slot from which the actively running
           firmware revision was loaded.


It's not clear to me if afi bits 2:0 is zero or one based. Bits 6:4
indicate to be 1 based.

Any ideas how to handle this?

Thanks,
Daniel

