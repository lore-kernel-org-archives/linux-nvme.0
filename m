Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35850C43334
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2RfejCiqJqDr9zKgrscLiItKu4ykAWEYMNSZ8/fl3go=; b=BKEh5ZJjIuTeltsJGj9bMAIX6i
	Gb5Yn7zWq+4iEBMYmsO/PP0nfF9awrUUiSU4Pf4KotHdZsouH4y6lSZqM1oJ+qLzbc+gE6iyiWw/9
	SXQ+fzuq45nSwK3iz449OnaDwkAMa5wyiW9HVHTkeuMEcPEui1yD2xQSM/MvITkMU+hGseMVo199l
	/eFQfLwDsoZWM9wGxuhYhf3Uo6nSA08Vr8ShobMnpMe2caj5U6NNBB+LtXUh9Wh847Ie1cBRX1acv
	l3/9ltKcgg52mUXlb4snlHX3EcZtQZWpTb/l383Mc6yKxjZ4BiP06RXrHN7GYFs38ssvE3eJKGind
	p/6PYzrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8K9t-007fCH-HF; Mon, 04 Jul 2022 11:22:29 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8JXr-00793t-2y
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 10:43:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 462F31F984;
	Mon,  4 Jul 2022 10:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656931389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RfejCiqJqDr9zKgrscLiItKu4ykAWEYMNSZ8/fl3go=;
	b=al3t0Ab722Uipa6AlFyTdE087TueyTBY+XF4pL+dfP3liYGDacoyghj24lzdLMLfZRiasa
	eyKe86Ufsi4I/jJ/aHtaCopeO0H/okxal3bIU4s+JHvNS92NfGRj/dMRx8AqHLRhcQPinJ
	XmdTqd1x1a+V81dRCtcFwuPyIxgPGz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656931389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RfejCiqJqDr9zKgrscLiItKu4ykAWEYMNSZ8/fl3go=;
	b=j3noAsSmfYkkrXi5JqMnNegKFpXfjhTuA+PGoG/Z8RJMNPazCz3KZXQhANSA6h3zHt9eh0
	4JkymRIaFS2Ge6Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 368561342C;
	Mon,  4 Jul 2022 10:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id mg8yDT3EwmIqewAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 04 Jul 2022 10:43:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	Chaitanya.Kulkarni@wdc.com
Subject: Re: [PATCH nvme-cli] udev: re-read the discovery log page when a discovery controller reconnected
Date: Mon,  4 Jul 2022 12:43:06 +0200
Message-Id: <165693137223.19246.2552194181165999373.b4-ty@suse.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627080650.108936-1-sagi@grimberg.me>
References: <20220627080650.108936-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_034311_335367_943FED68 
X-CRM114-Status: GOOD (  10.01  )
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

On Mon, 27 Jun 2022 11:06:50 +0300, Sagi Grimberg wrote:
> When using persistent discovery controllers, if the discovery
> controller loses connectivity and manage to reconnect after a while,
> we need to retrieve again the discovery log page in order to learn
> about possible changes that may have occurred during this time as
> discovery log change events were lost.
> 
> 
> [...]

Applied, thanks!

[1/1] udev: re-read the discovery log page when a discovery controller reconnected
      commit: f86faaaa2a1ff319bde188dc8988be1ec054d238

Best regards,
-- 
Daniel Wagner <dwagner@suse.de>

