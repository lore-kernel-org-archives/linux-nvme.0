Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EE4C77B6F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Apr 2023 15:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obptCKCQzxtBRtmeQkubwSx5aUwtUWvLtRvvPs19XGQ=; b=iBJ4GcUoqrPj4S04oGJnVRmCr7
	Pj2PjSrYf3j8FGoo8B6knuroNv4FzotzlZg0v2W5DXKXNtYDwHmpa1PXjOSRcFHRn7uw4MWP+cr7Z
	siujW8V0ZvGq/9nlQ6wswZHCW7SZ0AnrrVtkKzxI3OYph9bTbEzq/Cua/CgNNbZZyi3x0vgQ/svqO
	xCeeaVDsU4njvSOEzr/mFTDfl2jyRgGr4RTTiB4GBafCcCn9O8hdEKEHwohLYJpUAQal6iPwG4Zrg
	wv5oEYwQcF+xE5wq1PZlq9DaIMvq6P46wyJ0Euw1jwqntNIYa0rGFOlY+FuGwFKlZGwc3he+PhrT0
	k4tSlQ8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pmFUE-000KQ8-05;
	Tue, 11 Apr 2023 15:00:46 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pmFUB-000KP4-0L
	for linux-nvme@lists.infradead.org;
	Tue, 11 Apr 2023 15:00:44 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 82049219EF;
	Tue, 11 Apr 2023 15:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681225238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obptCKCQzxtBRtmeQkubwSx5aUwtUWvLtRvvPs19XGQ=;
	b=xiYgXQh6gxorTUcefpy17ytbQFVYoPYIIOyBDppJuO9Yf602EaDVgh0z759AuDTGGNqkxX
	GqLaW/g2Q3cBmHeV0arsnzOFExcF8ERnQNJz8eMp94W5ilJbuk7tcgD2PeQiGkOYEw8/jr
	0zGRhaUvbmpX8CGzIx1PfFgphTq8nFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681225238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obptCKCQzxtBRtmeQkubwSx5aUwtUWvLtRvvPs19XGQ=;
	b=u07dUPE9HzhxeWCrY8FmNs4IG1IMB95tbUdQVdqGEAqzigjbF68axqKAjGwJNPEEIRHtLU
	brVgJLTsWJFysYAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7473D13638;
	Tue, 11 Apr 2023 15:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IedkHBZ2NWRobQAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 11 Apr 2023 15:00:38 +0000
Date: Tue, 11 Apr 2023 17:00:37 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>, 
	James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Subject: Re: [PATCH v2 0/4] nvmet-fcloop: unblock module removal
Message-ID: <sgoyzwj6ckrdrpq22u6fhtcemul5rqj6de4l5gw73vz77o3ils@vmv3jue4rom7>
References: <20230411120718.14477-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411120718.14477-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230411_080043_295827_7CCDCAA9 
X-CRM114-Status: GOOD (  12.45  )
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

On Tue, Apr 11, 2023 at 02:07:14PM +0200, Daniel Wagner wrote:
>  loop: module loaded
>  run blktests nvme/003 at 2023-04-11 13:55:57
>  nvmet: adding nsid 1 to subsystem blktests-subsystem-1
>  nvme nvme0: NVME-FC{0}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "nqn.2014-08.org.nvmexpress.discovery"
>  (NULL device *): {0:0} Association created
>  [71] nvmet: ctrl 1 start keep-alive timer for 120 secs
>  nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
>  nvme nvme0: NVME-FC{0}: controller connect complete
>  nvme nvme0: NVME-FC{0}: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>  nvme nvme1: NVME-FC{1}: create association : host wwpn 0x20001100aa000002  rport wwpn 0x20001100aa000001: NQN "blktests-subsystem-1"
>  (NULL device *): {0:1} Association created
>  [453] nvmet: ctrl 2 start keep-alive timer for 5 secs
>  nvmet: creating nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8.
>  [71] nvmet: adding queue 1 to ctrl 2.
>  [45] nvmet: adding queue 2 to ctrl 2.
>  [453] nvmet: adding queue 3 to ctrl 2.
>  [105] nvmet: adding queue 4 to ctrl 2.
>  nvme nvme1: NVME-FC{1}: controller connect complete
>  nvme nvme1: NVME-FC{1}: new ctrl: NQN "blktests-subsystem-1"
>  [453] nvmet: ctrl 2 reschedule traffic based keep-alive timer
>  [105] nvmet: ctrl 2 update keep-alive timer for 5 secs
>  [105] nvmet: ctrl 2 update keep-alive timer for 5 secs
>  nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
>  [45] nvmet: ctrl 1 stop keep-alive
>  (NULL device *): {0:0} Association deleted
>  (NULL device *): {0:0} Association freed
>  (NULL device *): Disconnect LS failed: No Association

It turns out this sequence is triggered the udev auto connect rules. As I read
the _setup_nvmet() code, the connect should happen via blktest and not udev.
Obviously, this messes with the test case. I'll try to figure out how we can
disable the udev rules during test run.

