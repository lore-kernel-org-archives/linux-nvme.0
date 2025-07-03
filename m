Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B6BC83F03
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0K14Nftf7MCxiLuTCgqd/9TubX2MuFP2HFIC0ZIZGVQ=; b=u+wDRfiT91J+0Vb0pwBPBUmtcW
	Tz23AuFM3Bz74/9XTiwFMphlZQT1iEvrM4mSfpVsSLmHLbKzi7YE6TP9hNot8tJIYh3byxfw4dmaR
	JlnD7WadovfoItyg2tpfYQ6s2L24PWiG7+vKWVUv5oheaK3Ycbwzj0QelYc66ICARYUETW2HW/VMn
	I5LvLTU7JlPCw11Q9D7oCk5Ek4PfYGkl6FF/iLrNNdUlHOCnvm7rRpS5bKFMqu7ncztjbGV9yYi45
	E5DoT/Lg27QFWQ9n449eXZa3ZnkSujavAQVm29xOatP8XtMUCe29YmKqsd98Eft7vBozWwiPLNido
	Hhk9q4/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXQzu-0000000CTk5-0Rx6;
	Thu, 03 Jul 2025 20:57:34 +0000
Received: from hr2.samba.org ([2a01:4f8:192:486::2:0])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXM41-0000000Brj3-1fuI
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 15:41:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Cc:To:From:Date;
	bh=0K14Nftf7MCxiLuTCgqd/9TubX2MuFP2HFIC0ZIZGVQ=; b=NZ0/NoFBt3VqRhzaZ/IhvzX0eX
	SQiTYR9TpEkaVnFuTiE8Z1P/gbc/4/A3oLYy6pFn8rq4YNVI7ldx6wdaixmbGnQT31SDDlNENY+Jt
	TW9y/S24YnEy+1JomhMbPY7YpZLSjs0XQxrXN6RAu3xP9EFKPuXBLwOMqTrD1ifv1W629Ki/FuJ+I
	6b//5jlYKiq4uI3gV0b62t7Nx55uhoOI5I4mm6a8jZ4nFd3n/I/ChhvNOaAOzaZOWYTq4cxLgnLsX
	T4os+ny8DZ8I7cvt1w/xXN7WI6zv0+axF4D82sh11PznVm5Jew66fvk/3Vr/5rNkT8NRY4AZPPSXP
	nOtj7uo6iN4w71LOCfA/weAmYh9ekJek/3/Zz1/o2n8H7kQ1d5Bmm3/q8bZrxcGO7EWBo5JM6bTAC
	Fjddj18gBGHGoWw7/i/5yvmdmSWmF19VsWRKnDRWtCWyyDuvbBFJoqrxLQYbvIksQO1SUvoLB0ggY
	AcN7p04GfYaD3UblQ39n4zwt;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uXM3n-00DoHg-0I;
	Thu, 03 Jul 2025 15:41:16 +0000
Date: Thu, 3 Jul 2025 08:41:08 -0700
From: Jeremy Allison <jra@samba.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>, sultan@kerneltoast.com,
	jra@samba.org
Subject: Re: [PATCH v10 0/5] shut down devices asynchronously
Message-ID: <aGaklKejxefXTQB4@jeremy-HP-Z840-Workstation>
References: <20250625201853.84062-1-stuart.w.hayes@gmail.com>
 <20250703114656.GE17686@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250703114656.GE17686@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_084129_452769_E07D6D9D 
X-CRM114-Status: GOOD (  11.70  )
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
Reply-To: Jeremy Allison <jra@samba.org>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 03, 2025 at 01:46:56PM +0200, Christoph Hellwig wrote:
>On Wed, Jun 25, 2025 at 03:18:48PM -0500, Stuart Hayes wrote:
>> Address resource and timing issues when spawning a unique async thread
>> for every device during shutdown:
>>   * Make the asynchronous threads able to shut down multiple devices,
>>     instead of spawning a unique thread for every device.
>>   * Modify core kernel async code with a custom wake function so it
>>     doesn't wake up threads waiting to synchronize every time the cookie
>>     changes
>
>Given all these thread spawning issues, why can't we just go back
>to the approach that kicks off shutdown asynchronously and then waits
>for it without spawning all these threads?

It isn't just an nvme issue. Red Hat found the same issue
with SCSI devices.

My colleague Sultan Alsawaf posted a simpler fix for the
earlier patch here:

https://lists.infradead.org/pipermail/linux-nvme/2025-January/053666.html

Maybe this could be explored.

