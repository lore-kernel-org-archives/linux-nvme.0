Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A456CC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 11:35:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704F1610EA
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 11:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 704F1610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n3yX/EEsPXjwqe3PXeI/8E8Laj74O3Ao17bxZ5KwvtM=; b=qXIcYHPO33ysIoV2fueM5ZJyB+
	dOPH7N3qtdCcZTjgEMHXzkJNIQClNoTd3MNgtfqGfqOqoGsNy7RVJddEMiCbB3Y44A4gpmPIGcxW7
	WOXTJgBMfYEyly5TIeJvbAKipMMPOO6a+2EgldIm3CKER+AQjoSgVSQWVXTJwRQPs4KTWOnbC6Vqg
	uMRBD52QZMlfHKG4IV2+4/0zs6GyOR1opxdtwLiaK/d68exTtOvS8oFzi452ioOa67DPxK5za2MK9
	Bsg704sB62XSMEciNmlW2o9/6bETyR4FaeU6oPCkNQ/A0efmefh4bIUOon3bBwX+jqlAaebmPUMl4
	mjqWon/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maz0c-002s9D-Cj; Thu, 14 Oct 2021 11:34:50 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maz0V-002s62-LU
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 11:34:45 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 937F22198B;
 Thu, 14 Oct 2021 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634211280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n3yX/EEsPXjwqe3PXeI/8E8Laj74O3Ao17bxZ5KwvtM=;
 b=GR6FeOLNwBpESZHdSXQuBbE87Q4+7wdkvyCH3cXSE8p0Vp8v3QFNUJzhpVj3YW62gE7ydY
 8TxMHi86RlsqgFshCIDVG1WO+nFNNLK6gou5Ue7xyTEgniTk+ZDn0TW+Ym/dVLtOHyPB1/
 fukIwgtabYZVTzXyf6OZ/Ahdpaif/MI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634211280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n3yX/EEsPXjwqe3PXeI/8E8Laj74O3Ao17bxZ5KwvtM=;
 b=qf76+0mBcvgwqfVxMt6rA78J19bze4hGPJ8/M+rj5Ok7GsdEclmCmXY+Jf0ugForpYHxm+
 FAhlERG2wxy8SqBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82DC413D82;
 Thu, 14 Oct 2021 11:34:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wu9XH9AVaGGhIQAAMHmgww
 (envelope-from <dwagner@suse.de>); Thu, 14 Oct 2021 11:34:40 +0000
Date: Thu, 14 Oct 2021 13:34:40 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: Re: [PATCH] nvme: rename 'subtype' attribute to 'subsystype'
Message-ID: <20211014113440.dcmgoe3aolivuo7y@carbon.lan>
References: <20211014092734.138079-1-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014092734.138079-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_043443_923245_55A81675 
X-CRM114-Status: UNSURE (   8.93  )
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

On Thu, Oct 14, 2021 at 11:27:34AM +0200, Hannes Reinecke wrote:
> The sysfs attribute should be named 'subsystype' for consistency.
> 
> Fixes: b72529169a56 ("nvme: expose subsystem type in sysfs attribute 'subtype'")
> Suggested-by: Daniel Wagner <daniel.wagner@suse.de>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

LGTM,

Reviewed-by: Daniel Wagner <dwagner@suse.de>

