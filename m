Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DF6C76196
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbBHR6DcbfG4L/fA0YlFdf3ObyJR3FjaiMe8e+n6Lp4=; b=dbVLmnYxzt80asdT4inWAsBAsp
	Jpeh9HjULV2o9oOano+GElfTlJaruYWuIIOyfIdABAbcGfSN3+kGaEhHVVR1RLT6g+ZG/o8iITkUq
	qy7IfAd7xlVLM7vAPm6apmDBTKS1pmK/iUnJy37TDjPtBlBnjeVv9hCJmdOmOdq+1JftgzequPUXr
	Gby9O6p4cuMVDbq+gG+QIT85FSl1RfBR87JDR+pwUigBcSWRbjM+9vqLX9abAOZiYjy/tNe9ThwFR
	zxlA9kKj+EqSy2Ye7kqFoYuaVJh2jz2OmMfUao3eZS+2acFHZRAMGchE2cHY9aPji+Xnmd6bjeKzL
	cTTmycxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkK7D-006dc8-2w;
	Thu, 06 Apr 2023 07:33:03 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkK7B-006day-1v
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 07:33:02 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D15ED1FF8C;
	Thu,  6 Apr 2023 07:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680766376; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbBHR6DcbfG4L/fA0YlFdf3ObyJR3FjaiMe8e+n6Lp4=;
	b=xpq+mzIBGnBuGG9EXl9zyQkS0oNEg20BZy4PvTItyDOfHmuY7ELw6iQXo4NmFuRdhljwAF
	w0DWtfvV9+uTMLHS9vKHr4S1rxSeZa7j7stS8Oow1yl76CMDluGDZwVk8mcQ2eFYCWPA96
	83RnBfNHGHSj8AdXr8SzZ/W+5oMGcnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680766376;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dbBHR6DcbfG4L/fA0YlFdf3ObyJR3FjaiMe8e+n6Lp4=;
	b=ukujNXwSAcFbQMBb9y+2NkolcVtsvh69iCQ3N4NBYzBz/i3vnHiFcqoHfur6joJNXFhi+a
	/7aNzDdrGlqsKLCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C226D1351F;
	Thu,  6 Apr 2023 07:32:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id S9ZZL6h1LmQ/RgAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 07:32:56 +0000
Date: Thu, 6 Apr 2023 09:32:56 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, 
	James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v5 1/4] nvme/rc: Add setter for attr_qid_max
Message-ID: <spido7j7kjpylnnjxx6dzex4fizyhfu7mhjzzvxi5eaibzziln@6oram2xhcg3l>
References: <20230405154630.16298-1-dwagner@suse.de>
 <20230405154630.16298-2-dwagner@suse.de>
 <9bde6907-20b8-1e19-8b5c-e26f62f2f9e4@nvidia.com>
 <2w3ki4ntl5m2farwokvepbgtcvd5piywv3cmdyzp4s6su6fngc@55wsvekrge3c>
 <f83b0c8a-3716-5154-9c5c-3989bcf2d320@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f83b0c8a-3716-5154-9c5c-3989bcf2d320@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_003301_798660_B7CFB594 
X-CRM114-Status: UNSURE (   7.22  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 06, 2023 at 07:05:45AM +0000, Chaitanya Kulkarni wrote:
 if there are functions in rc which are only testcase specific let's keep
> those there, we can always do cleanup later ..

Sure, works for me too.

