Return-Path: <SRS0=dHSS=OF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF49AC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 07:55:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C33B1610FF
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Sep 2021 07:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C33B1610FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7qLrFW0yzRphYXATLZ5u419fHXce2vvcea0tS0tZS+g=; b=EORUE1N9MvRf/H
	FXTCweeO3d+NFo+2Sic5n2C7XKnTCpfgTI4p3C7CmAjB6Uo72B0DAJoQ1RpyFIjsCtx+MOs2bUoSp
	I20Vj/B9W91fVMCa1eGdMRYyGJvwTjIClDnUPp27CXQiNxsLbhlRe7EwlSaHhSTfCSPJNE41fbMBZ
	zDERLfyL2Z1CRqUBNehI5/5JRV0we1Xf6nSLMnoDDzI+o4w5fPFcoVvgHDfvq5Hp9OapJeNgnG/Eb
	ZvpGAueLx58IRxt/nvz7j4zi593WoRNrjmh60pW9vDJUxPO8Ia3Zqt0NC5bdYGROeUxH6azkPkuLL
	fNi7qLWEagp75TA+9XfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQPl4-008NaA-Bc; Wed, 15 Sep 2021 07:55:06 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQPkz-008NXn-KT
 for linux-nvme@lists.infradead.org; Wed, 15 Sep 2021 07:55:03 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24EE32214A;
 Wed, 15 Sep 2021 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631692500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tIta2I9XsXZcxTWSHaAC7NHANPAr0ZPeLNepZ3aW9Lg=;
 b=rI1PEFSs/PUrf2oumXj3vZDGm+ltc0tNMU4uzKp3U/GU2iOf1TC7Y72CmwBYvk9YgMh00d
 Eq3ajMXzv386ClWpr9o4aYX042chvIMiXmc+PCOyi5gxsgb1SA6bzVHep5h5HuoIF6wtci
 1YozgA75XPtvBL1ONbdChK3cLfOIlWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631692500;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tIta2I9XsXZcxTWSHaAC7NHANPAr0ZPeLNepZ3aW9Lg=;
 b=xJmi+WxpS10EZ66ojlThwqq8+WfAE+5Yv0MpbU9X2jy2o58GrnEq/b9+vuq+IFk1nxOUEQ
 fa2v4Eeh0uGIHmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B93213C21;
 Wed, 15 Sep 2021 07:54:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iLLwGNOmQWFwJAAAMHmgww
 (envelope-from <dwagner@suse.de>); Wed, 15 Sep 2021 07:54:59 +0000
Date: Wed, 15 Sep 2021 09:54:57 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC v1] nvme-tcp: enable linger socket option on shutdown
Message-ID: <20210915075457.sdj3oq3bhn7itqop@carbon.lan>
References: <20210903121757.140357-1-dwagner@suse.de>
 <YTXKHOfnuf+urV1D@infradead.org>
 <20210914084613.75qykjxweh66mdpx@carbon>
 <a79bf503-b1d5-8d18-5f02-c63e665e2e07@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a79bf503-b1d5-8d18-5f02-c63e665e2e07@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210915_005501_884094_1D528D1B 
X-CRM114-Status: GOOD (  14.42  )
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

On Tue, Sep 14, 2021 at 05:20:46PM +0300, Sagi Grimberg wrote:
> > During testing the nvme-tcp subsystem by one of our partners we observed
> > this. Maybe this is perfectly fine. Just as I said it looks a bit weird
> > that a proper shutdown of the connection a RST is send out right after
> > the FIN.
> 
> The point here is that when we close the connection we may have inflight
> requests that we already failed to upper layers and we don't want them
> to get through as we proceed to error handling. This is why we want the
> socket to go away asap.

Thanks for the explanation. The RST is on purpose, got it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
