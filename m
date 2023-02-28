Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69D0C64EC7
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Feb 2023 09:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wwL3nn9Aw022p8qnjODaNOj/yEXTtuNp7h01L/L5CSU=; b=2pSOK2RrnuGo5gTW/eYIXj1ncJ
	q1ZKWbl+RE9BBxb3wnECQYh/xmaEGE2aotgc06H/W3xKShKP7PbPKqCg3Kj0TarFWsCBNQ24zGxtu
	Rw5YzEus6cjUWxV5dz10Mn32EG17wIfIlteY5e+dNQdXYmteIMnwf2L2UoSpVpeeb/zYEcStLLOaO
	ieF+eRxQc6/Z494joEj+BzzkeXwBNPRHgGMuDXOFsxiQ0sTRS3N8ywkXzhnbyFpMaqs6pDLvof6i+
	slCXXFtQhFKxpkcJ3ZE/ZlrpNoTUcmiGf5yHeEITX2tXlUgh5e3lY4ZX3k98kgDDntWANM7HQ6SiT
	cTYiJZiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWwh4-00CZ5l-SB; Tue, 28 Feb 2023 09:54:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWwh1-00CZ56-Oc
	for linux-nvme@lists.infradead.org; Tue, 28 Feb 2023 09:54:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E310921954;
	Tue, 28 Feb 2023 09:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1677578077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwL3nn9Aw022p8qnjODaNOj/yEXTtuNp7h01L/L5CSU=;
	b=izDPWa9JvD3VqmYx9Rtn1f7R1kbkAqc3ijYOG6dFQA20/oa5Pes2HnOXBWHAkJhoTBoUZS
	Uf8JF8hheACAQ3yxe70Kd2Yw4zByseSkcmLkuV3efJt++yaxk2paW50HkPU4Es/OU4w7ck
	gcNUbL3YqSeLGFw29erIHYApIzwWP20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1677578077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wwL3nn9Aw022p8qnjODaNOj/yEXTtuNp7h01L/L5CSU=;
	b=UkXhVNtsaLolY1xRGxAqITsIUv7iKttH0ul/Ar77OuOiP2EGzPR4DpdUjk4uBDOlP2Z0YY
	DX7gK5h7nUC7ssCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D68791333C;
	Tue, 28 Feb 2023 09:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id arlSNF3P/WMAQQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 28 Feb 2023 09:54:37 +0000
Date: Tue, 28 Feb 2023 10:54:37 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
Message-ID: <20230228095437.tmqoxtk3e3bvdepb@carbon.lan>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
 <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
 <20230223145336.lulowpv3vlr65lwu@carbon.lan>
 <63b276e4-a7eb-f493-fdf7-8dc343aaff50@riseup.net>
 <20230224085725.girihudjbjjhbxm2@carbon.lan>
 <f8ba7be0-37f4-0c5f-373b-2dd3a3a54715@riseup.net>
 <20230227090520.h5od3lutqkfu35ez@carbon.lan>
 <4a7c105b-f046-3054-a1fd-9441af48b491@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a7c105b-f046-3054-a1fd-9441af48b491@riseup.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230228_015443_989694_A7372244 
X-CRM114-Status: GOOD (  16.21  )
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

Hi Ivan,

On Tue, Feb 28, 2023 at 12:10:31PM +0300, Ivan Rubinov wrote:
> With this patch it works nice.
> 
> 
> Signed-off-by: Ivan Rubinov<linuxkernelpatch8234@riseup.net>
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d839689..3f4da40 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3480,6 +3480,8 @@ static const struct pci_device_id nvme_id_table[] = {
>      { PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
>          .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
>                  NVME_QUIRK_BOGUS_NID, },
> +    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
> +                .driver_data = NVME_QUIRK_BOGUS_NID, },
>      { PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
>          .driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>                  NVME_QUIRK_IGNORE_DEV_SUBNQN, },

Right this is exactly what went in:

5f69f009b7c4 ("nvme-pci: add bogus ID quirk for ADATA SX6000PNP")

> Kernel log:
> 
> [    6.852254] nvme nvme0: pci function 0000:01:00.0
> [    6.855936] nvme nvme1: pci function 0000:04:00.0
> [    7.071947] nvme nvme1: failed to set APST feature (2)
> [    7.073201] nvme nvme0: failed to set APST feature (2)
> [    7.094109] nvme nvme0: allocated 64 MiB host memory buffer.
> [    7.098544] nvme nvme1: allocated 64 MiB host memory buffer.
> [    7.125205] nvme nvme0: 7/0/0 default/read/poll queues
> [    7.128853] nvme nvme1: 7/0/0 default/read/poll queues
> [    7.137040] nvme nvme0: Ignoring bogus Namespace Identifiers
> [    7.140688] nvme nvme1: Ignoring bogus Namespace Identifiers
> [    7.142240]  nvme0n1: p1
> [    7.145537]  nvme1n1: p1 p2

Thanks for double checking. The NVME_QUIRK_IGNORE_DEV_SUBNQN would be necessary
if you see something like this in the log:

  nvme nvme1: ignoring ctrl due to duplicate subnqn (xxx)

Obviously, the absence doesn't mean that these devices do not suffer from the
problem but we usually don't add quirks on suspicions. If the above error
message pops up we can still add the quirk. So all is good after all.

Daniel

