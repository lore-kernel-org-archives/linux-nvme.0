Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C1C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 03:54:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2633961077
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 03:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2633961077
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oDWRC5gawNQeXqBj8g93oYZuSLyzChTl8VQm2rNoKz8=; b=Seh5HKSc4diMOR
	OTuJ52dGgt7UFF7vHJRmVqs2ZXVUd0TTuSJsDNKppVeGIprthCd+rsww18esQLhhgHfq8zo9whoZ5
	mBqFEH2HsWiQR3phEmI2+GKdy0ulbKK4zk3u8yptYYRiII73ptZ59anxNu5V25+YLekf3r9o+7owB
	Z4qIhX5uhCW5TPjeI6h0B58CWSIgNswt1j4IlpxcbY/T9G8jMmjxG+uJoR7oo+p4fIFG3ef6XsjNz
	fE2ZcFDfiqlS2q7Dh2VSUl2Q1/Gk0qjg6RjKQVZNQxK6PQX4RSXfDno7vKIp+fA4upnnUQQNeXcmw
	eiMvq5hoT3F9yMBdei+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mULEV-00HZBP-DL; Sun, 26 Sep 2021 03:53:43 +0000
Received: from mail-40130.protonmail.ch ([185.70.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mULES-00HZAV-CE
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 03:53:41 +0000
Date: Sun, 26 Sep 2021 03:53:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632628413;
 bh=lgQ+HcUsV9Ns5rQFl+hCQzoLxtfLbJpUS4i09cACHFo=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=fqEhLWsrcrRvikWgcSd9dSgVn5aBm4XXGdjx8jiotL+PrjYoYBAviZWZK7wetpcfZ
 ef/xyPI1z7jkwez3tHeRTFkiZ19EfIea5l4BxI6Z4PJTrDQmKkD6Q3LnzHLIArhtKU
 yjavt6zJRbz/kvwFbsPxa5PpKfEEDCXT2QiRIHnI=
To: Keith Busch <kbusch@kernel.org>
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "gargaditya08@live.com" <gargaditya08@live.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
 "dwagner@suse.de" <dwagner@suse.de>, "hch@lst.de" <hch@lst.de>
Subject: Re: [REGRESSION] nvme: code command_id with a genctr for
 use-after-free validation crashes apple T2 SSD
Message-ID: <1a6f5030-27d9-d1ae-aff4-0ed2a10dce6b@protonmail.com>
In-Reply-To: <20210926020839.GA96176@C02WT3WMHTD6>
References: <cjJiSFV77WM51ciS8EuBcdeBcv9T83PUB-Kw3yi8PuC_LwrrUUnQ3w5RC1PbKvSYE72KryXp3wOJhv4Ov_WWIe2gKWOOo5uwuUjbbFA8HDM=@protonmail.com>
 <20210925171618.GA116968@dhcp-10-100-145-180.wdc.com>
 <fa9de055-c3b8-20d3-41e0-12e43d0c336a@protonmail.com>
 <20210926020839.GA96176@C02WT3WMHTD6>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_205340_605939_4402A5BD 
X-CRM114-Status: UNSURE (   9.75  )
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
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 26/9/21 12:08, Keith Busch wrote:
> On Sat, Sep 25, 2021 at 11:40:19PM +0000, Orlando Chamberlain wrote:
>> I've managed to get it to boot by commenting out the counter increment, which might work
>> as a quirk:
> 
> Great, that's essentially what I proposed in a different thread (sorry, I see
> now you were not copied there):
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html
> 
> The final patch may look a bit different, but it should be okay to test with
> the one in the link.
> 
I've tried that patch, it doesn't crash, but /dev/nvme0, /dev/nvme0n1 etc don't show up so
it doesn't progress past the initramfs. There weren't any errors other than preexisting
acpi table ones.

(I sent this a few minutes ago but I forgot to reply all so here it is again)


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
