Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D248ECAAA3
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 16:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K1vchQwdHNpdm9qLmZirW4JiJpiIN3V1BgUWIzsbXRw=; b=s0sqynJynBe0oiNP/PDXwOnnuz
	CjECySOtgOf4bkdHEllAFwDlRtrdnGEFzOd6nJF9Sm3Zy5XMhYS6XCpC5BfDtwyJzwJYirnFFV3wu
	5lPhZ31g9ooL2F63d2/JFY4xjZEVDyWUa2PUgEUF2zxmmu2Dlc8mrGzTzGc2dhiwN0lD8FEDetlSW
	4wH8FMqLV1HpeKyQ4pkJ5zB5fQwtS3MyHtWfvlMV0rE1PWJlQU8p/DFiVU4cgt1w/SWEIRJgSzOaD
	EeB6FHog3I1e1kS6vYvl4PIEdMmipJ2tLa0qgUejGqBlnI+3V4eAK7u8ay2mRWnV/SugS9nd+u/vy
	jskn3f0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRcaJ-008bpE-8e; Fri, 26 Aug 2022 16:53:31 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRcaG-008bZu-Bo
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 16:53:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 01A96B83212;
	Fri, 26 Aug 2022 16:53:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD75C433D6;
	Fri, 26 Aug 2022 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661532804;
	bh=hjceOySQM8aJMcdm3tYJxs6b92fh3qhBPCJFiSlrvWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBu+GmJ70IEU6QFjx3iJQDKKRs9KnyFz8X85C0eoTDfK+bRdvNArxAmF0hcnfcmVu
	 XqG9w5bIOPpW4ThGFkPArAJRgrIiu9DUf6LXnq03Fmv2pXk0G+v9Fegz3lcBdAdxrT
	 rwfl7nF5s3rq49TZy0/uOnByPLJRDAgetXhqmjfqt0uT5T8Roauai9y6bDlYdHeMJk
	 rlN81P6QVn68P79R3ZWAZKZORUXqHhgxd8W+kyDJdce09iGNbqvgayHzxm+v5M0TIM
	 v/nDY2+DSYvmHdNsWiw+XMUZ2l7Ogd1acILIVtwGOS8mCp9eijIq/+WF2yJbKv0Ys2
	 njRGuquHLOBjA==
Date: Fri, 26 Aug 2022 10:53:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shyamin Ayesh <me@shyamin.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH]: NVME device not found with Linux 5.19.* - globally
 duplicate IDs for nsid 1
Message-ID: <Ywj6gSsEI7BVpD7b@kbusch-mbp.dhcp.thefacebook.com>
References: <CAL1XK+MViKNnPJm=iiKNXBrNmNtourYsHR1n2oWpntjj6jxQnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL1XK+MViKNnPJm=iiKNXBrNmNtourYsHR1n2oWpntjj6jxQnw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_095328_564407_00CA67E3 
X-CRM114-Status: UNSURE (   7.48  )
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

This is not the correct way to format patches to the mailing list. Utilities
like 'git format-patch' and 'git send-email' are your friends. :)

I've sent a new version and is visible here:

  http://lists.infradead.org/pipermail/linux-nvme/2022-August/034308.html

