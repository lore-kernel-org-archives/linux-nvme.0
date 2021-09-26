Return-Path: <SRS0=vClw=OQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C705C433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 08:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB6660F3A
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Sep 2021 08:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3BB6660F3A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:From:To:Date:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RqYYX9VuSGvzHG3NlX/06h9JLoFD7a+5LSO4f0k57Tg=; b=vZ+qGsGdLUK7+a
	ostOfwWE3uySlxsbLSDo5uDBLTKKeYT9Gjfxs5+7pKWLPZw0ZgeYV3OxPl262gJgvPKqjein2DUb8
	OKB+lRVEdyVcvYnFYjp4g1nUWCChasivAIECml1Fdf4PXDMtHuMGZ/uPQF8K4DihDG4xV3aT9ziOP
	PUv1DZh7jiXzsHosl+K/Ty32HN2WmeVTX3ScMszfSjp8vq3tQrgFngwnXoQj232GaidNYdqM7y5gk
	w5W1BvyygrVRlg8w9fwEMVH3b3KY+RT3nPQj5UsFqbKlNznGHqwZhd11Ki5SiLnL1CL+SArT/Hnv1
	aBCs9xHZaP1nz1Xiveqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUPmX-000G5f-Ot; Sun, 26 Sep 2021 08:45:09 +0000
Received: from mail-4324.protonmail.ch ([185.70.43.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUPmV-000G51-1e
 for linux-nvme@lists.infradead.org; Sun, 26 Sep 2021 08:45:08 +0000
Date: Sun, 26 Sep 2021 08:44:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail; t=1632645904;
 bh=qMCepfy0EOxS5z5FPguGeC8cRl3hAlRCyYPW4sTI8do=;
 h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
 b=DEH97cS7Z2pv9MgVRZy1o7uAVIQQiXIhe+fbaLjjfbfqDJui9Rawvg24C4LJ5/tJi
 xgHXwlfe0DMkCyS4a1j4yssRFKX/aleENjYmUxhDEbIq4+GU1E5/QT4qZKj2PYqj+8
 yTInJbFXfvIwgb8imkGZODrQ/BzkXdqc1wBNJ5fk=
To: Aditya Garg <gargaditya08@live.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>
From: Orlando Chamberlain <redecorating@protonmail.com>
Cc: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
Message-ID: <4dae80c3-034c-617b-c766-1858d6ee1220@protonmail.com>
In-Reply-To: <PNZPR01MB4415986CC44AACC100AD1189B8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <7e75e292-3073-f1f9-287a-badf92c8e4e8@grimberg.me>
 <PNZPR01MB4415F5304CAA1A83442549DBB8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB4415986CC44AACC100AD1189B8A69@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210926_014507_278628_9715DBE0 
X-CRM114-Status: UNSURE (   7.84  )
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

On 26/9/21 18:07, Aditya Garg wrote:
> I checked out the proposal sent by Orlando Chamberlain to replace 
> NVME_QUIRK_SHARED_TAGS , by NVME_QUIRK_SHARED_TAGS | given in the patch on 
> http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html 
> <http://lists.infradead.org/pipermail/linux-nvme/2021-September/027665.html>. 
> The , still causes panics to the T2 as described before. In the case of |, the 
> kernel boots correctly without panicking the T2, but in case we are having Linux 
> on an External Drive, which is my case, then the internal SSD doesn't seem to be 
> recognised at all. I've tested the patch on 5.14.7. A screenshot of the GNOME 
> Disks utility has been attached along with this mail.

I had some issues with the patch not applying automatically as I mixed up tabs and spaces,
(due to me copying stuff directly out of vim), so I had issues with getting patches to apply
automatically. I've checked that this file https://github.com/Redecorating/mbp-16.1-linux-wifi/blob/anbox-bt/1001-apple-t2-disable-nvme-gen-counter-quirk.patch
applies correctly for me (and github ci), so can you see if it still doesn't work with that?


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
