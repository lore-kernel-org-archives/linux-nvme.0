Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A7C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 02:09:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 258FE61090
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 02:09:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 258FE61090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=I8KDeqSgb4ZVS+/IqyzX2zpGt2I/ajvixcTSYBG/N6o=; b=Y1++41kUr15aaI
	HkHupN2BjmaqV/JdFIyq2I8SlczBJuYLwJMWZjPCpUQMw5USz+lQaxOUq48nx/panM0pUC2ushO/Y
	GuMRVspb0o75FzFiDlE6Jt6w3PX6t7b3bbV3OQ9K4Ke4PIZyBg0l+uiZRCrNn4fz88i+ja2DgpZtS
	AjiVPbN4CESXveuWsul4cGprYgKyvCbsbF31VEWBSbDs/QPf877CApepcrRC0vt05sZzCdMQE2Rl6
	zrjFH0skqAlPR0qB2XPt4Z20xfalMUrNeWV21Lcj1HEg35WdibaxumTSX2vPnOM3xRuosPNjIoV//
	toK9pcE1byi5Ykb0ipGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUJav-00HStX-1f; Sun, 26 Sep 2021 02:08:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUJas-00HStE-La
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 02:08:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB93761090;
 Sun, 26 Sep 2021 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632622122;
 bh=5jox8j1FhFcEcbka5HbxQzgLIhab0NqBEibSv3/IJJ4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d7Q3mt0ZFhAeuW2m3fNMTeWYbhle4gbt5/OKVNcOiDzIVuiSQ6cj6Sp0KMieQgAa1
 POZomGN9wpJmhiWeOoH/sn2KVI9Ylm44XimgC+gvIPs2hF0AaxbNlzfnQPlK8aONPy
 +KhnTm/YKJPpxdchJCAkqr8jPZeje44Jf27vY2KRXrPNUDh3mA2/nVqCjf97XRaCCU
 2R5JrHrqDSaSzun2ADYUdsGzW0lpf0IBLV0wGJdAsKftnRiygfiCUR5u8+t+aLp1Rc
 Tcz9iceuy56YQ803RyH1CKWzIJWQZ3UYVjAFxc3G5rZEBGaXWliqjjRz+37gGVVYTz
 RKHrHJXYrKFxQ==
Date: Sat, 25 Sep 2021 20:08:39 -0600
From: Keith Busch <kbusch@kernel.org>
To: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "gargaditya08@live.com" <gargaditya08@live.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "hare@suse.de" <hare@suse.de>, "dwagner@suse.de" <dwagner@suse.de>,
 "hch@lst.de" <hch@lst.de>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Message-ID: <20210926020839.GA96176@C02WT3WMHTD6>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_190842_749985_5842B414 
X-CRM114-Status: UNSURE (   7.16  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Sep 25, 2021 at 11:40:19PM +0000, Orlando Chamberlain wrote:
> I've managed to get it to boot by commenting out the counter increment, which might work
> as a quirk:

Great, that's essentially what I proposed in a different thread (sorry, I see
now you were not copied there):

  http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html

The final patch may look a bit different, but it should be okay to test with
the one in the link.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
