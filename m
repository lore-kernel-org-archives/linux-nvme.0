Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A9DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 21:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AnWdKTas9IpFKEhTT1qNvidezOZQ5jrs39s2ZQruhRY=; b=D3oO7H6ypCLTEoDdOulsArHx2a
	K4OwfsN/rwdSixvEgLKSmc0/sFjYmmRWncehSTZFwiVw5DCfXel2BhCEOPLHenR7z01/+7XMyAlFE
	3rwuTj+fEY9q9JTcVIvFVZ4IMOTcEAIQxNPDf5ColAzOYh3SY+DI+ECUUQQz4b6hJF+XvaH9HAvcA
	0/WNVdCuPe1wz/ew+vjXcBi9Cm2QDdkkaOnPu4Do4LKNpZ74B5CWEsLBGmscQy1kD3TNRbi5HySHj
	i84H1uHRJLmi1VI9+O6b5kLumuO+0rxnZ5PyqSmdeLgKMESUpSbs/XkrYBm8xV1EhBf8CllYMGyUr
	1lZiNdDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMcT6-00Bcsd-8Z; Tue, 22 Feb 2022 21:13:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMcT3-00BcrL-H4
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 21:13:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 316B4B81C67;
 Tue, 22 Feb 2022 21:13:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3E8C340E8;
 Tue, 22 Feb 2022 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645564382;
 bh=CLbIagV/MQB2m5ZSEv0peS7rGmq6ywXWnF5bfGM9/fs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gp7PHdqad+8kJwY3wRhTp+cjV9ERuetXszY1q80C8Va9yxWMsK2NOkXQjPQfFdfQC
 qqz5VOWI5Yns5t6QoYokVLWNQgUKUhe6y7Px2LXjzGfFiYsfM2hizdO3yRoBLL6bhu
 xe47u6y+Uy6nGqvgcfIb5MIlvpy4FQXLCPksBiqwURTCB7zVu1pfcBgy7/5D3WUsmR
 PLXgoGqvPDF95yCeWgpMDMT+o6HiV0Fyvb/vd0q6+UNEImxFQ2WNaOdDlCH22mChCQ
 FcyDldGo6uQPcnz1tO/riGgINC/7s3WSUoaemjLQ7qGfoISFguDGIHhsp0e2pc6pIp
 y4BM1wZoVx3Fg==
Date: Tue, 22 Feb 2022 13:12:59 -0800
From: Keith Busch <kbusch@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: David Laight <David.Laight@aculab.com>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
 "colyli@suse.de" <colyli@suse.de>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits macro
Message-ID: <20220222211259.GC1782741@dhcp-10-100-145-180.wdc.com>
References: <20220222163144.1782447-1-kbusch@kernel.org>
 <20220222163144.1782447-5-kbusch@kernel.org>
 <66a0c8210cf9e7dfcc3fa2d247de1eebd5a8acb7.camel@perches.com>
 <20220222165045.GA14168@lst.de>
 <20220222165613.GB1497257@dhcp-10-100-145-180.wdc.com>
 <603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
 <65fd7d9525b443fcbb15468176fca16a@AcuMS.aculab.com>
 <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eef8db106e310e20faff4563580fa0eeb064d17b.camel@perches.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_131305_740911_03D68F8E 
X-CRM114-Status: GOOD (  13.11  )
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

On Tue, Feb 22, 2022 at 12:31:30PM -0800, Joe Perches wrote:
> > I'd only use something GENMASK() for bit ranges.
> > Even then it is often easier to just write the value in hex.
> 
> Mostly it's the count of the repeated f that's difficult to
> quickly verify visually.

I admit I made this counting mistake in earlier versions of this series.

I think the earlier suggested "(1ull << 48) - 1" style in an inline
function seems good, and it doesn't appear to cause compiler concerns.

