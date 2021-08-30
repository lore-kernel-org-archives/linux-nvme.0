Return-Path: <SRS0=Glcz=NV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD121C4320E
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 15:50:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC85600AA
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Aug 2021 15:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FC85600AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zo9wXi7o772FF7/cF44isb1NQYAYhF6NXsOjHpS25N8=; b=FjDzmg0EHMOQDs
	mfF2vfODUGPQuj5e3p0U+zeVgep+0MpBFsjbzTW/dIggxtcP0nvG5dyEiUqAyjorIgPdZQgdseohw
	+qHnbXwydk4y0N5KOjDUoEDYgXPZQQGFPYdZxogCtoV+R5J9jO/2VSgd0RGIRUcaCRKMcSXrqFeP4
	pQRbdKU6h35MaTZ7KsK8LYKbcCtegzHXwn/aTc5wP0c1WxwmLLYK4FIpJa9Evj1prNqiO4a+47GQk
	kncXnyDK2KrKwgCSlmOGA29kxyuKNATLoCulRLFc2FMZaVaClE30UEYRMolhn9xMp6yIsokhLRLkk
	ShAVm/A1AWqsHNGQJELw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mKjYO-00HYa0-Hp; Mon, 30 Aug 2021 15:50:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mKjYJ-00HYZO-1n
 for linux-nvme@lists.infradead.org; Mon, 30 Aug 2021 15:50:31 +0000
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74F81220D2;
 Mon, 30 Aug 2021 15:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630338625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceX1dMxIClr9YSJ/0dIk11Ssam9+xQ+XyrlF6BIEsAg=;
 b=AG5kyUwBn8ctqnX2+iI3inK6/Izq07j4SRmFwCUAszezt1MfHKA3kmRMqFkj+Ekmm+gv0x
 8wf+zCSI5UOhyntCRY2tSlAMKxr++F8SgfO5HpD0/qzIT74mySuLyA8I+FxbzBbvaZJiHb
 uLjnhivX+znnreLH5KNzch5qWhng7MA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630338625;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ceX1dMxIClr9YSJ/0dIk11Ssam9+xQ+XyrlF6BIEsAg=;
 b=ESJGojnzI4LchpjfkAqI6xi0wYJFsjXPCKieciALPDwamE+MsndawpN+SIqOgJwdJiPcqO
 G1Lxi2xjvjImGTBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5F61B139B8;
 Mon, 30 Aug 2021 15:50:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id +v/iFkH+LGFqGwAAGKfGzw
 (envelope-from <dwagner@suse.de>); Mon, 30 Aug 2021 15:50:25 +0000
Date: Mon, 30 Aug 2021 17:50:24 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, yi.he@emc.com,
 kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6] nvme-tcp: Do not reset transport on data digest errors
Message-ID: <20210830155024.ekughhihfecbzzby@carbon.lan>
References: <20210830133626.139828-1-dwagner@suse.de>
 <462c31ae-446b-cc23-eb91-5e27ef04ec13@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <462c31ae-446b-cc23-eb91-5e27ef04ec13@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210830_085027_286216_B0C73043 
X-CRM114-Status: GOOD (  10.94  )
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

On Mon, Aug 30, 2021 at 06:38:28PM +0300, Sagi Grimberg wrote:
> > +	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
> 
> endian conversion a zero enum? looks weird..

I though it makes sense to stay consistent with the rest and don't make
it harder for the reader to figure out why this might not needed here.

And obviously the fear of the static code analyzers...

> But,
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
