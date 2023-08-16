Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC17BC001DF
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Aug 2023 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6sKyG7pmNqgi6eGz+JdQnSC3feV2UCUViK6Z12J6spo=; b=K7fV1Tl04tDBn+Qd0RIkSubEfP
	gVu5vRtg1okFwDsNt+pc/30NW5Nt1rRLkDByhD3Fw8op5lXMHtHEhch5deodl9rcBFseu8CRmm63H
	bs22EIg5A+gjblbQWSpz7n0oXYyyqonbPuyVfMh9Djo2VSLZXHfKt/xN3WOFEnFLnJ6GqnudElyOe
	nGKEZzSdw/h9h9OzKp4KtN4+h4a+PJctz6G4Lf2u1d/xCMruixP3h8uaFIgxLJwG3+XNufLSNx/zR
	RarAIf3kfB8UeY8Y2uBG9HvhgsCdWCxj6nTEZXfMQcIcKpwEApcjsu8sXXvmnZPQMwR/Kr+7iv/tz
	dMxJkDrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWCsU-003beF-1M;
	Wed, 16 Aug 2023 09:31:46 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWCsP-003bcf-1G
	for linux-nvme@lists.infradead.org;
	Wed, 16 Aug 2023 09:31:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7D692191A;
	Wed, 16 Aug 2023 09:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692178297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sKyG7pmNqgi6eGz+JdQnSC3feV2UCUViK6Z12J6spo=;
	b=WZ4PRyHOlZ2TgjYP+EDYWHzP2I1VGz0nPyOBLVnX09XlvQUrNqGoN1VFpVE1cBvzTXPt9a
	9MbT3acHM6OysITkLAInhE8YwJsl4EEKyGTG/BTapu66or6dhtCFTI9FkCds77mAgcabRo
	0pgDRxM0zS4ee70PhrVK1+8sBUM4bd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692178297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6sKyG7pmNqgi6eGz+JdQnSC3feV2UCUViK6Z12J6spo=;
	b=aSwtdCnQ4/CNaHi+iCBy4oLJWfpXKwLzE7fThb5aa6MLdqHdXVGY8HgbUIiXTO01J0G65h
	WiSJs4V6huUnARDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B0215133F2;
	Wed, 16 Aug 2023 09:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id GKQRK3mX3GSNTwAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 16 Aug 2023 09:31:37 +0000
Date: Wed, 16 Aug 2023 11:31:46 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>, 
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH blktests v3 00/13] Switch to allowed_host
Message-ID: <6e3i34utxot67jod2opzksdufcnfypycule5kkrcfaezxxvyg4@ixifxnti4wqy>
References: <20230811093614.28005-1-dwagner@suse.de>
 <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098c6a6-50cb-8704-9041-03c431155dfb@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_023141_568995_7AC6D0E6 
X-CRM114-Status: GOOD (  17.09  )
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

On Sun, Aug 13, 2023 at 05:59:53PM +0300, Sagi Grimberg wrote:
> 
> > Addressed the comments from v2. I also added cleanup code to _nvmet_cleanup() to
> > make sure we do not leak resources when something goes wrong. I run into this
> > while testing and all tests after the first failure failed then.
> 
> The name of the patch series suggest that it switches to allowed_hosts
> where it does that in 2 patches 11+12 out of 13 patches. The rest are
> just bug fixes and unifications. It's true that any series will include
> fixes, cleanups and prep patches, but this is too far :)

I see your point. The whole series started smaller, but just grew over
time. I suppose if we agree with the general direction we could just get
the first part done (bug fixes and refactoring).

> I'll let Shinichiro accept as he wish though.

I am fine either way, just let me know what you prefer.

> The cleanups look fine to me.

Thanks for reviewing!

