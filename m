Return-Path: <SRS0=MUCY=OP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8B0C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:49:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DA0261029
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Sep 2021 20:49:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7DA0261029
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=svenpeter.dev
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:Cc:To:From:Date:References:
	In-Reply-To:Message-Id:Mime-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=P+bEQS7wStbrdEE1bzK2ZA89BtVC0TFl3qHsLFymTnA=; b=2Y6amPb3pDunBm
	lMR31QnhLGEjKenttpec/9gBNJTfxpSEz4jFdOkteL0r4bao9/07FuDxljfurYrCxS3D2nuW2CvyU
	v1Ts2LzRzKaYjDfoXQOsajVgcXyPaYMtDx+3HwY61v3n7uN4YIM17bNfmx4q6jDe1gzs9iesnSzOt
	d3mTA1yjb86O+aMhNcig2sjPhfqvCRCxLZesaf4RBLHUyWllaxWht4haCJCnREd96nx40qOWNPX1n
	ufo1Ule21HRSB8N99VvrgrFiY+0xhSsvSKyUqIlnUcIehAKfHKgMvFNgxrlfAxm2uI/V9HbyTHpjE
	Mzbund5+yxkI5sHUvU/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUEbX-00HEFR-9W; Sat, 25 Sep 2021 20:49:03 +0000
Received: from new2-smtp.messagingengine.com ([66.111.4.224])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mUEbV-00HEEZ-4m
 for linux-nvme@lists.infradead.org; Sat, 25 Sep 2021 20:49:02 +0000
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailnew.nyi.internal (Postfix) with ESMTP id 73A0D580D4B;
 Sat, 25 Sep 2021 16:49:00 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
 by compute1.internal (MEProxy); Sat, 25 Sep 2021 16:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
 h=mime-version:message-id:in-reply-to:references:date:from:to
 :cc:subject:content-type; s=fm2; bh=YgDo6sYrTikpb+AQKSVT01CWd92f
 psqGQwY+L/v1hmw=; b=Beb9qi2CBq+tq3fFfSs3C7lo0iIdSVu8DPDA0M3BYvZX
 Vl6lnn0BYLZ6Og/CHAhoEKq0FQjvC0R7x/eN3fksG84f74ng3uMp+K0rJuL/cTNk
 OY7UuuPbSqhJaCTYUBy8gXBrmNnJotuS/h0Os57W+jSLLJs3jeY7oLB0SyDdCTYQ
 dh9m/Frpm4YTzgFb1pDL/yf/rZPjh2fAQ4Xrj8fJfTFisWVyctxD91dOItMInDpm
 eMRsPL21C5jnihmp3cOd0tTgQ8vpMvmUD0LEX1Whg13ugxNNrVFa6eAlz4pUIEj2
 GQCfhJS6WxTxHv5gSCZh0ejjZrxw0IksxSYNk05IGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YgDo6s
 YrTikpb+AQKSVT01CWd92fpsqGQwY+L/v1hmw=; b=Y0tazXopVJ4wOuH/GdmVZ9
 kpXx/Z+n9YlFtlaV6gR9jsqjJN0BFeJbEROI8sInODGnC/ZpXGB1xVoG2jejhUV2
 8/YTSO/H5B9TOdTu2Pp6EgLfp/MUCfaOF/Rz4vuMM2LjJfEOkdWW8JtIcKMOkPc1
 7qViP1TpJ5+xDlPExiPXUAou7X5JjG2psu3KWPJc/55E4l0O5uSfzYMRN6lANvCm
 hdF2eVraanfgrGmFkN9ywRYOofjYO87C8dqD9Lc5Af56Y5soym6Y/uqT/eTuzVuC
 FFmELZL8a9RG4P3lLpplS5AkRjcC/S76qftriKXzZJ6wBuO4GPMPgn74JUF1jMHw
 ==
X-ME-Sender: <xms:PItPYfjERS1UX_pdipN3izCU5fFI1UHCXC4xvZvqeS3qemcZeiZXtQ>
 <xme:PItPYcDJQeIkJcmGKsqzwFotHKX-6fgc-w2rSjaXiBCcanGYMPafKLxXAuvy0TBHJ
 Hd9TTSvncMyfBoCDuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudejfedgudehudcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
 vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
 grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
 vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
 epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:PItPYfG-peXMduQ1Q37ca64Fkdym_zISF-4uNoaxabWrxttgB-g4jQ>
 <xmx:PItPYcQ-Lvrfol7dMyKvMNrbKSK7uAk_sQW0defAsvS4zrBmKX9iXQ>
 <xmx:PItPYcyVCCMPrD2g7ec8YfJq-hsDHHe7XECRpTcdHMCliISBkgDt8g>
 <xmx:PItPYYeYIPDvslIqOUY6SI0vN2OXRORl3tOiKJORThvS8SwNFuqDhw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 03A5351C0060; Sat, 25 Sep 2021 16:48:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1303-gb2406efd75-fm-20210922.002-gb2406efd
Mime-Version: 1.0
Message-Id: <08930bdf-6a3a-4d49-b366-8029b88b25b4@www.fastmail.com>
In-Reply-To: <20210925203857.GC116968@dhcp-10-100-145-180.wdc.com>
References: <PNZPR01MB4415600ACD3C8D9944F15058B8A59@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <CAHk-=wgML11x9afCvmg9yhVm9wi5mvnjBvmX+i7OfMA0Vd4FWA@mail.gmail.com>
 <20210925195425.GB116968@dhcp-10-100-145-180.wdc.com>
 <4849f3d3-4abd-49b7-b053-d7965daa7138@www.fastmail.com>
 <20210925203857.GC116968@dhcp-10-100-145-180.wdc.com>
Date: Sat, 25 Sep 2021 22:48:39 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Aditya Garg" <gargaditya08@live.com>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "trivial@kernel.org" <trivial@kernel.org>
Subject: Re: [PATCH] Urgent bug fix causing Apple SSDs to not work.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210925_134901_284764_A74EEA6A 
X-CRM114-Status: GOOD (  21.72  )
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



On Sat, Sep 25, 2021, at 22:38, Keith Busch wrote:
> On Sat, Sep 25, 2021 at 10:08:53PM +0200, Sven Peter wrote:
>> I actually ran into a similar issue while adding support for the NVMe
>> controller found on the M1 and assumed it was only present there.
>> 
>> Some background why this happens: ANS2 is a co-processor that emulates
>> an NVMe MMIO interface and uses the tag as an index to an internal data
>> structure. 
>
> Thanks for confirming the behavior. The patch should restore the
> command_id values to when everything was working. I'll just need to
> update the quirk description to better align with the actual limitation
> if the patch is successful. 
>
>> On the M1 we can directly talk to ANS2 and while we can submit
>> commands with a higher index it'll just ignore the upper bits and only
>> return the lowest eight IIRC in the completion queue.
>> I guess whatever software is running on the T2 actually has an assert to
>> ensure that the tag is within the limits before forwarding the command
>> to ANS2.
>
> Is the PCI Device ID for the M1 the same as reported for the T2? Either
> 0x2005 or 0x2003 should make this quirk apply.

Oh, it's worse. It's no longer a PCIe device there but a platform device
directly attached to the SoC's bus. It'll need almost all T2 quirks and then
some additional changes to the way command submission works and support to
program a tightly coupled IOMMU which Apple calls NVMMU (which probably is another
reason for this limit: they use the command id to find the corresponding entry in
the IOMMU that allows access to memory listed in the PRPs).
I'll just use the quirk in my platform driver and submit it once I get it into a
shape that can actually be reviewed.



Sven


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
