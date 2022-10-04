Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18526C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Oct 2022 11:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=teWFD6yKhKsfoOLYcJKER6+SGdEgVp0+EoCAM6+27Uw=; b=0dUWkW3sSjCtTcj+Edfy6sLGU2
	S37GAFDy2ZqHaH3/QRkeJ6x/6dn2lWupYT5Xp7UHLDcsCi9I04iAVDGOkJiEXBuSN+dIDS+khitCH
	enQDAh0+4z7AMRZ19Dwgmw1HS7uafaHt16XY/zZXpA4/vRVllDBShu2Gjhf6lP/6+3aLYlQHAvkel
	ZK0p8puDF8tBZFfmf3VEvIyn0GEhjxZNS4IWRrlt1iqT4kOBGVsUc6axt09YkNVMejmpTqAbdR60n
	mUCAtEgU8dcasYgOQfsC8Ri6RJQBiyuzKOJgyPAvlAgyQTCcO8FLrvFNpwjuY5xsbKU6YJVAdYdvk
	OT2B6B1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1offpV-009Sun-Nw; Tue, 04 Oct 2022 11:11:17 +0000
Received: from www262.sakura.ne.jp ([202.181.97.72])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1offpS-009St1-NJ
	for linux-nvme@lists.infradead.org; Tue, 04 Oct 2022 11:11:16 +0000
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 294BAuLE002655;
	Tue, 4 Oct 2022 20:10:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Tue, 04 Oct 2022 20:10:56 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 294BAtVs002648
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 4 Oct 2022 20:10:56 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <63e14e00-e877-cb5a-a69a-ff44bed8b5a5@I-love.SAKURA.ne.jp>
Date: Tue, 4 Oct 2022 20:10:53 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Keith Busch <kbusch@kernel.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
 <20221004104456.ik42oxynyujsu5vb@shindev>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20221004104456.ik42oxynyujsu5vb@shindev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221004_041115_008251_87E89376 
X-CRM114-Status: UNSURE (   4.42  )
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

On 2022/10/04 19:44, Shinichiro Kawasaki wrote:
> Any comment on this patch will be appreciated. If this action approach is ok,
> I'll post as a formal patch for review.

I don't want you to make such change.

I saw a case where real deadlock was hidden by lockdep_set_novalidate_class().

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=62ebaf2f9261cd2367ae928a39343fcdbfe9f877
  https://groups.google.com/g/syzkaller-bugs/c/Uj9LqEUCwac/m/BhdTjWhNAQAJ

In general, this kind of deadlock possibility had better be addressed by bringing
problematic locks out of cancel{,_delayed}_work_sync() section.

  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=a91b750fd6629354460282bbf5146c01b05c4859


