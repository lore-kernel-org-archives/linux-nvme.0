Return-Path: <SRS0=T4Lt=MV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF1CC4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 19:46:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3746604DC
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Jul 2021 19:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B3746604DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DXBw/oi7AhT/AEwuHM+6yCRhARnLyTe8zv8ks1Gb57c=; b=3lpXAstkOIJIUP
	r7JWG50E6ADWpTPy/Pgy4nsM0JfUJZxioXk1pyTIDqINSE7njfBLV6m77OEsxDJbMyhqy5E0lCChN
	RqlnvDrljiik2tFPWolk7LEBxmghpyDrBpOKwVGK2VmHCm+d7N5cdoYeCunM8RzPQoU3dGuWWsQdi
	eSIg0vwv5XC2CWkphQ4HVuKPy4G6SP5mZKO+ubRuiI/757Bbn/x8SqXlLHjuJPp+5pb02bQoGzAdt
	a++elom1loY2Zrxe3Gd/NNYMeq18j7vKCTeqYYyN8Mshgk9AHo94drpNc78cWjkej7AUWjddOgojP
	rG5qw02uxtwdiPnEql5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m9BzH-005gk2-3z; Thu, 29 Jul 2021 19:46:35 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9BzE-005gja-5M
 for linux-nvme@lists.infradead.org; Thu, 29 Jul 2021 19:46:33 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D0D531FD75;
 Thu, 29 Jul 2021 19:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627587990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjg2OPM93QfVh3WpuLziPBRNn/gd+10YhomITetolS8=;
 b=ngZe1+N5KU3Yi+UGTGli1u8KSY+SyefSdcymby71MLxkk55BHyxkwmLu4pG30BQY0DG57k
 pjc2metfnIgtBgFjIO6zTpBxQs1C8VMfcvzR4gNDeJ5F+IH3/m4UnwGfwk1FbACXe+W+KC
 FspufknBWfkUv7EskJEbb0Ji1P3jp7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627587990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjg2OPM93QfVh3WpuLziPBRNn/gd+10YhomITetolS8=;
 b=ix5iIjQbASyIK7h1YGvhGok8qc6yPBN7ofD3ftqGcjcho/NgxM+nAnde1GyzxxwVKVQoDT
 9FTgSTWD5TjMe1DA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BC5C913756;
 Thu, 29 Jul 2021 19:46:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 4xmlLZYFA2GxbgAAGKfGzw
 (envelope-from <dwagner@suse.de>); Thu, 29 Jul 2021 19:46:30 +0000
Date: Thu, 29 Jul 2021 21:46:30 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: invalidate paths during rescan
Message-ID: <20210729194630.i5mhvvgb73duojqq@beryllium.lan>
References: <20210729192814.78997-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210729192814.78997-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210729_124632_391386_99603F9B 
X-CRM114-Status: UNSURE (   5.45  )
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

Please ignore, screwed up the rebase.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
