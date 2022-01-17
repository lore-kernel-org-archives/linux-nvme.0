Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C93C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Jan 2022 15:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:To:From:Date:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jRTXyh/3PcUrp6Qv2KgWURQmS4fvKZoZnh1fGMl/KvU=; b=G5toJoPnYrLYQ+zzsTVJreUnqt
	1gw3jHsUUaPmq1LR/H5xND+Ftr+Po1L0yeafE5pSB4AiHn1iEGYFM5uMGSoikEV/m2xBGEHHxxbcJ
	oSK41+EbAplhbVCwqhPa5gJUIZaB9zmigtDWgUYmm5cZux9mzYzEP7iHfHN/q04cbxJ8trzQlcQUF
	tt0PUTQ1pQHi8YJl2/KWm6HThxOg5P82U9TYeJa1Wzv4tTU93TYdiZDrI4Yhrz6H6ZAwxTR1vcH3Z
	Xoj55ErJR95AVEssphZZ5YYczxb6ajInbveQsk6+4wTmeEplEiofRKHbLrlfKGpCD6AA8FFAK5Vl2
	jLnJMcaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n9TgQ-00FMiQ-VE; Mon, 17 Jan 2022 15:12:35 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n9TgO-00FMhY-0z
 for linux-nvme@lists.infradead.org; Mon, 17 Jan 2022 15:12:33 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FEE421125
 for <linux-nvme@lists.infradead.org>; Mon, 17 Jan 2022 15:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642432348; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jRTXyh/3PcUrp6Qv2KgWURQmS4fvKZoZnh1fGMl/KvU=;
 b=pX+/tMSyf2eeWT9eYrLzbRU6XMAH4GEXMSKizJjZ45ytTCgoRWQZIBLcRWIUSRJF7R/c6K
 LwNCX7m1B6bHx8eVigcv/vGXprKzDpvZDY+JCi3tzBmIXeBSykadI0FXq0maA95noEb+Kw
 nfCRDFT015s8s3l0FT6U7ly/KVtFZIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642432348;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jRTXyh/3PcUrp6Qv2KgWURQmS4fvKZoZnh1fGMl/KvU=;
 b=go3HJ6NcQkgQ+sbCNC7UKQH1cMBlqD0FyrcTu7ti6Ia3vPutmrabWVjnH8Cra4Mq74lYr+
 FeqkGbe3+UIHudBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F78C1333C
 for <linux-nvme@lists.infradead.org>; Mon, 17 Jan 2022 15:12:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4XVyD1yH5WFXNgAAMHmgww
 (envelope-from <dwagner@suse.de>)
 for <linux-nvme@lists.infradead.org>; Mon, 17 Jan 2022 15:12:28 +0000
Date: Mon, 17 Jan 2022 16:12:27 +0100
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] nvmet: add support reading with offset from ANA log
Message-ID: <20220117151227.m443fgxn6kks5awa@carbon.lan>
References: <20220110140539.25521-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110140539.25521-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220117_071232_255401_F41D9E1B 
X-CRM114-Status: GOOD (  13.57  )
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

On Mon, Jan 10, 2022 at 03:05:39PM +0100, Daniel Wagner wrote:
> Add support to read with offsets from ANA log buffer.
> 
> The controller claims to support extended data for the Get Log Page
> command (including extended Number of Dwords and Log Page Offset 2
> fields):
> 
> lpa     : 0x7
>   [2:2] : 0x1   Extended data for Get Log Page Supported
>   [1:1] : 0x1   Command Effects Log Page Supported
>   [0:0] : 0x1   SMART/Health Log Page per NS Supported
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
> v2:
>  - fixed lenght calculation and limit response lenght
>  - some more testing with KASAN enabled
> v1:
>  - https://lore.kernel.org/linux-nvme/20211229155302.16789-1-dwagner@suse.de/

Please wait with this patch. I think there is something wrong with my
calculation. I want to test some more just didn't have time for it yet.

