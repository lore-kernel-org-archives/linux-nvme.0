Return-Path: <SRS0=jgW7=LZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7BBC11F64
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 11:51:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC59613D9
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Jul 2021 11:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC59613D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4EbO8k1B73OTnaMA4HAVkFm22t7kd5vmofBpbwTBY/g=; b=f9TeGuPbtXu1GT
	JJVdJY1FylXZtB3Beqnl6M6SV6c6Nri2YZOHR5xdj3yfCdML4vAgBPRQkzBQDu9/MTxMk63ozxIA1
	RIBiDx40lvhgh77LLyoKBJ5ELuQcqzDbypAGgoNt4DnmC2C/STRwKiGn/MC5igQeIeI1TmpLo79l8
	KhOnGYU7YLdSuGOuUhgVHD2U22NIgRT1zAKkdkou9dXyzS2qeXn40g35cv9mZgU1ktm92Id4ZzyPP
	9DcilUfPFbqOR7Bl7Ao4QigQMWoy3lKHoABXH5kRIz5T6PyjG8KiacbDPb/nmwXOTU9PWm+0qeMOp
	LV1XfMMnc4HXfRjJx6Jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lyvEC-00H77m-Ky; Thu, 01 Jul 2021 11:51:32 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lyvE7-00H76j-Jv
 for linux-nvme@lists.infradead.org; Thu, 01 Jul 2021 11:51:31 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 09EF422883;
 Thu,  1 Jul 2021 11:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625140284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niQsBSMi+GtprJ4MfU6xolrZ1bDfAKQlLa4xMMbR1Wg=;
 b=cHBSLohSygC1JaW3VY11Ovv79GbuNjma9X4m5JHoKqjipOPNovE3wWaVzr+yaoP6BXBc04
 AF3IWYdB83IHJtZAAZXn1/WdB5n74ZwuiVnpQjRalXjQpEShVg7gTBujjOq0Sr5Y0KAM0e
 QdTODmnrTa2nFdJUZ0J1VyxVcpOz3hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625140284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niQsBSMi+GtprJ4MfU6xolrZ1bDfAKQlLa4xMMbR1Wg=;
 b=9IkPC7+p2lbGrw7khQhEq5biS/Rx6qqYop6wdOLVDUD3KpBDFAA2/dkiuzcGHI5FxutFwe
 pbx6fo3Nssqs4gCQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id E394211CC0;
 Thu,  1 Jul 2021 11:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625140284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niQsBSMi+GtprJ4MfU6xolrZ1bDfAKQlLa4xMMbR1Wg=;
 b=cHBSLohSygC1JaW3VY11Ovv79GbuNjma9X4m5JHoKqjipOPNovE3wWaVzr+yaoP6BXBc04
 AF3IWYdB83IHJtZAAZXn1/WdB5n74ZwuiVnpQjRalXjQpEShVg7gTBujjOq0Sr5Y0KAM0e
 QdTODmnrTa2nFdJUZ0J1VyxVcpOz3hY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625140284;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=niQsBSMi+GtprJ4MfU6xolrZ1bDfAKQlLa4xMMbR1Wg=;
 b=9IkPC7+p2lbGrw7khQhEq5biS/Rx6qqYop6wdOLVDUD3KpBDFAA2/dkiuzcGHI5FxutFwe
 pbx6fo3Nssqs4gCQ==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id pfa+Nzus3WAXDQAALh3uQQ
 (envelope-from <dwagner@suse.de>); Thu, 01 Jul 2021 11:51:23 +0000
Date: Thu, 1 Jul 2021 13:51:23 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/4] nvme: protect against possible request reference
 after completion
Message-ID: <20210701115123.ir7huzzpifhsk7cz@beryllium.lan>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <777a99bc-b7e3-ce39-cd98-ab1196aebb2e@grimberg.me>
 <20210616170411.GA921268@dhcp-10-100-145-180.wdc.com>
 <5c0766d9-9507-b0c7-4917-4b936fd7a197@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5c0766d9-9507-b0c7-4917-4b936fd7a197@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210701_045127_848209_99A4FA78 
X-CRM114-Status: GOOD (  10.68  )
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

On Wed, Jun 16, 2021 at 02:05:16PM -0700, Sagi Grimberg wrote:
> Cool, Christoph, where do you stand on this? Can we move forward with
> this?

Same here, I would like to get this merged. Thanks!

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
