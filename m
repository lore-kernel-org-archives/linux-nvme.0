Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BEFC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 19:42:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05BA60BD3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 19:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F05BA60BD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ucw.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=hwEVYbKvQcSTRz/pdrY2lH9THe5rTptafHD1j84kAl4=; b=LFJoz0BhCWlfeC
	woLk+PACgTIvAHu4oZfSUvstDJpY9vXbOYJdmPi0enyLhk9pq4nukt7UROLzPo3ZwF6VSeXRyOgty
	0PwNGDnKLVYeTg0sQge3c1oc7sD38QLkH3BmSX6srIrXloNDYUmYSOA8rcUyQqVj6eY00d5bLp9kS
	/Nu9pFcD4TTsdSkyxrGPykA5EvEh698lHLG398Un4HvpjYczKNSf3H4Vc+lql+QmV5M2fJAVEPVm7
	jifMzsl5TzlLEmCcZ/N6VjBf1o1Il3cnyvOf0bPsL4kz24ESgR1wYYFpFtKoFBOFDI/pJyqCNA1L+
	L1CsuZCK6DaZQhVxikQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m86UG-00CNZS-9K; Mon, 26 Jul 2021 19:42:04 +0000
Received: from jabberwock.ucw.cz ([46.255.230.98])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m86UC-00CNYI-TS
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 19:42:02 +0000
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
 id 49F911C0B76; Mon, 26 Jul 2021 21:41:52 +0200 (CEST)
Date: Mon, 26 Jul 2021 21:41:46 +0200
From: Pavel Machek <pavel@ucw.cz>
To: shiva.linuxworks@gmail.com
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org,
 kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Shivamurthy Shastri <sshivamurthy@micron.com>,
 Keith Busch <kbush@kernel.org>
Subject: Re: [PATCH v2 1/2] PM: enable support for imminent power loss
Message-ID: <20210726194146.GA3986@localhost>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
 <20210726132223.1661-2-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210726132223.1661-2-sshivamurthy@micron.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_124201_139882_B104C3DA 
X-CRM114-Status: GOOD (  11.02  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi!

> If the shutdown is pwerformed when the platform is running on the
> limited backup power supply, some of the devices might not have enough
> power to perform a clean shutdown.
> 
> It is necessary to inform the driver about the limited backup power
> supply, to allow the driver to decide to perform the minimal required
> operation for a fast and clean shutdown.

If you can do shutdown that is fast & clean, why not do it always?

How fast is normal shutdown vs. fast shutdown?

> +#define PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT	BIT(3)

I believe we should be more concrete here. Like explaining use (did
UPS say battery is low? Or does it mean 10 seconds remaining? Or...?)

Plus, who sets this flag? Userland?

Best regards,
								Pavel


-- 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
