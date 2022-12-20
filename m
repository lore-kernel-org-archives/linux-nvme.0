Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02240C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Dec 2022 16:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DKf30HS+whzL4luNGYd8zER/WJyxQzTdsyprxZFOaFY=; b=jDNZ1pEN1RNqu4xcsBhbKa/0Ac
	pE1Z8un3eLs1yF9Iq7QKdescjciQedcwim3Mq5ztFcfanhVg4lx5thVN2qbF7YVmZJ6KCr2L3dxO9
	h6Ie4HjkgjBgyqHipPNJA1zfVFUqI3+6APSFUAe4IwapF7FNX2gD/7zstCB6KZL1jKf1zAqaebNwh
	9c2IH0ovsbdkhC+4ornezUqV5QEKOdhfUtx4nH9Q67Js/nLgBoD04bQ2GW07ikViJEXslxnYuY2VN
	wmjHkHYT4Z11sw/A/Xig8rdoXPB3UZvoqsf1zfJ7wcLahh03oQClO83OLnk4jrLl0ZQPba3FwKtSA
	bq9vmbIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7fur-000wSn-NG; Tue, 20 Dec 2022 16:56:33 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p7fuo-000wOe-DI
	for linux-nvme@lists.infradead.org; Tue, 20 Dec 2022 16:56:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 07C8CB816A3;
	Tue, 20 Dec 2022 16:56:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38560C433EF;
	Tue, 20 Dec 2022 16:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671555386;
	bh=HaTmFmw2Vu1KZi6WZwSUUCAUc4qCqv28GLfRnSAZCjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inuvsQrMNSMhpH0MuMr9NDO6Uksng5SngJOPcPMkyTIJGSV2/ugD5Gx7D9X9nPHVK
	 KknMoHy5LY+1IG14wZ+/3rAjJbu1uWxmvsy9KZfKsiZByFCoY101YqPgAFM7zwZNau
	 gii9KkWrBu7wWAfUwRmFcMmptuj53bzTdmtuQsslAUCtXEMcq0K0Fon9kJr4CTkPbF
	 WgrGhnrSaVZAdhbByoP/qCbD6miO7O2lGUrkiYScicXR4aD6HL7mOJtI+jADjJSwJO
	 KcycGjn9v6wug2xFxXJjBpDr8JdK4VaHNGAiNz/5E7XEeJ5ZapeBop8WOaw/fEgslq
	 qyx12JI5ZxcOA==
Date: Tue, 20 Dec 2022 09:56:23 -0700
From: Keith Busch <kbusch@kernel.org>
To: "J. Hart" <jfhart085@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@fb.com, hch@lst.de,
	sagi@grimberg.me
Subject: Re: nvme nvme0: I/O 0 (I/O Cmd) QID 1 timeout, aborting, source
 drive corruption observed
Message-ID: <Y6HpN83+Pm9WwjU0@kbusch-mbp>
References: <fe013f52-ac3c-4be2-6f1e-e68fea46e4c2@gmail.com>
 <Y5z8Sj+7N7HF4ZyP@kbusch-mbp.dhcp.thefacebook.com>
 <eb882c34-7b69-e0c2-f100-35f3a90ce94c@gmail.com>
 <Y6B4JFj5jIDs0cBI@kbusch-mbp.dhcp.thefacebook.com>
 <b82b44db-1169-6b77-4f1b-ffdf4fb7feae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b82b44db-1169-6b77-4f1b-ffdf4fb7feae@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221220_085630_815904_4C579863 
X-CRM114-Status: GOOD (  27.11  )
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

On Tue, Dec 20, 2022 at 10:10:30AM +0900, J. Hart wrote:
> On 12/19/22 11:41 PM, Keith Busch wrote:
> > Given the potential flakiness of read corruption, I'd disable relaxed
> > ordering and see if that improves anything.
> 
> I am not familiar with this part.  How is this done ?
> 
> > 
> > >                          MaxPayload 128 bytes, MaxReadReq 512 bytes
> > >                  DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+ TransPend-
> > >                  LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Latency L0 <1us, L1 <8us
> > >                          ClockPM+ Surprise- LLActRep- BwNot-
> > >                  LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
> > >                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > >                  LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> 
> 
> > Something seems off if it's downtraining to Gen1 x1. I believe this
> > setup should be capable of Gen2 x4. It sounds like the links among these
> > components may not be reliable.
> > 
> > Your first post mentioned total transfer was 50GB. If you've deep enough
> > queues, the tail latency will exceed the default timeout values when
> > you're limited to that kind of bandwidth. You'd probably be better off
> > from a performance strand point with a cheaper SATA SSD on AHCI.
> 
> It would be unfortunate I think if the linux driver could not be made to
> implement the NVME standards on the somewhat older equipment from perhaps
> ten or fifteen years ago.  Earlier than that is perhaps not terribly
> practical of course.  Equipment like that which is still operating does tend
> to be reliable, and it's something of a shame to have to waste it. Some of
> us also do lack the wherewithal to update equipment every two years,
> especially older people or those in areas where the economy is not so good.
> As I think we all know, there's more of that these days then we'd
> like.....:-)
> 
> In any case, I'm very willing to run tests on this equipment if that will
> help.  I'm fairly familiar with building kernels, writing software and that
> sort of thing, but perhaps less so with fixing drivers.

For the record, the linux driver does implement the nvme standards and
works fine on older equipment capable of implementing it.

The problem you're describing sounds closer to the pcie phy layer, far
below the nvme protocol. There's really not a lot we can do at the
kernel layer to say for sure, though; you'd need something like an
expensive pcie protocol analyzer to really confirm. But even if we did
have that kind of data, it's unlikely to reveal a viable work-around.

Though I am skeptical, Christoph seemed to also think there was a
possibility you hit a real kernel issue with your setup, but I don't
know if he has any ideas other than enabling KASAN to see if that
catches anything.

