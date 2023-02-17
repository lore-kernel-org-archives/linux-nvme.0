Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCFDC05027
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Feb 2023 05:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:MIME-Version:Date:Message-ID:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yi3+oO6NkvyJq/M7+ZlXO/xUbEHsjHJt4EmGl8WNlVY=; b=K3J4s0jUUqkrPP
	tTQyLjb79LYeOEFBDxKxB+CCtWBymx6Vrn2Uz0ON/6cDGLPVZcC2D8WQ2INQnnNn8/mWiDxg/blzw
	ubGMVFZuDbWw1w9qZN40QpELOFMRr/tQNyWFLz43xmYuLRGKx4VHbTJpmSv7SEJSeqzX6bnRhUuXV
	rHOFedD4JL3gyOW1pnwtF7kB2sIBsCsWzOZkhcB1E/sDzKStdo0NfXLQk9XKblqvpVs/v0ch5hx+W
	jug+g9962VIlmnZk+stbliVv9X8wrLKPtpqP75qogTa0NXfeitJPJLCTE1DMkZ1klH6DIPIVMVYIw
	b9e9Wvgqh6Wg6cNrHzZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pStKc-00CpUQ-4h; Fri, 17 Feb 2023 05:30:50 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pStKZ-00CpTj-DS
	for linux-nvme@lists.infradead.org; Fri, 17 Feb 2023 05:30:49 +0000
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1pStKQ-0008US-F4; Fri, 17 Feb 2023 06:30:38 +0100
Message-ID: <2f7f3714-b77f-e3b3-636f-4ce19b6bb5bb@leemhuis.info>
Date: Fri, 17 Feb 2023 06:30:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] nvme-pci: refresh visible attrs for cmb attributes
Content-Language: en-US, de-DE
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: sagi@grimberg.me, Keith Busch <kbusch@kernel.org>
References: <20230216164403.501894-1-kbusch@meta.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <20230216164403.501894-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676611847;68984c66;
X-HE-SMSGID: 1pStKQ-0008US-F4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_213047_643184_0ECA3880 
X-CRM114-Status: UNSURE (   9.92  )
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
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 16.02.23 17:44, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>

Thx for looking into this and creating a fix so quickly.

> The sysfs group containing the cmb attributes is registered before the
> driver knows if they need to be visible or not. Update the group when
> cmb attributes are known to exist so the visibility setting is correct.

There are two small details that would be nice to have.

Having a

Reported-by: michallinuxstuff <michallinuxstuff@gmail.com>

here would be fair.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217037
> Fixes: 86adbf0cdb9ec65 ("nvme: simplify transport specific device attribute handling")

And a

Cc: stable@vger.kernel.org # 6.1.y

here would be wise to ensure this is fixed in 6.1 as well, as the change
apparently was backported [no, a fixes tag is not enough to ensure that].

> Signed-off-by: Keith Busch <kbusch@kernel.org>
> [...]
Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

