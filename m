Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A25C05052
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 01:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WfMGBtaGHGLIJ63kT4rLPlN6AQGC+kGBWir4Ap9VMDg=; b=ssrvpEjbjgvY3IBj4QhXPm/P9f
	SQBURMvJEmuCLMUSLk3tS1he3A+vvWFaVI1lVNmWBpkJzuOtBTP2Yj31zPZdR7I89JHw1sR+7hqDo
	dAvPLrUmiLNewYFcAFf5BIVA5XEb0yB55CG++NZFNwUWFGcXuJ9pMTKkruho/ntgMNR+qrpJsZPg+
	ml06kFB3fGNVpB7uZoXOQ0gIBwDXumYFf8x4U2kATy2vA4sroPOXy7KWPUcIioEBQTPj3/7BEJzQV
	bjfns/+5SrXg7XThy5iJFYEiex3NCX/3HJlKJb1JEy5zhje5qXIDyG/vLX80l8cVZQ57UTJcYNWqF
	JFe+9wGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWRqT-005Igs-1r;
	Thu, 17 Aug 2023 01:30:41 +0000
Received: from s1.sapience.com ([72.84.236.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWRqQ-005IgX-14
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 01:30:40 +0000
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by s1.sapience.com (Postfix) with ESMTPS id 167D2480AB8;
	Wed, 16 Aug 2023 21:30:36 -0400 (EDT)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1692235835;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=WfMGBtaGHGLIJ63kT4rLPlN6AQGC+kGBWir4Ap9VMDg=;
 b=gphYlJDVky3wE2hL3f1mn+IoOgTKuJo6oFJY+Gdgo9RVrzGDbzOMZkZkE0LzMtjOQ5Qa+
 6ORwySW7xiYuKx5BA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1692235835;
	cv=none; b=lrdEHT9PaPyfu7m5kWc+m4Zb0nM7K0NIUa74pb4/9yyzMpZzoga0HISmLBTspX6pY+kSbtosk/TmxwRYoQOsRQHizm5TSwT+qX1+Ycqn0bXcHQx2uyKYVZ8T9nvvO+X03dofcfJGLx73XBLuJt7VlIEWXlE6oJXBo5SEMxCmq3W3xf7DxLOlK0HnGaPNze24AiyUTlqfTcWaDhfsfLL6qQUJbLaUwxp7cFYtFfMh3/sbAmZqDxKJEWErfMGQNMWZ42ImNeR5WAaq0m7CSUCRkXtarC6myYG1dxB31oMYB3uiF1KD3Jz8Z05A0QTmzqOdEsKKfh0XRAYRhPHl4rGFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
	t=1692235835; c=relaxed/simple;
	bh=BOzc6PlAXaMR/fEo/2en+w7lwkZ2f41MeeT2eay7BRw=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=HE6BFlyQrcp8sRwL45ZrTHLxHyWUpuUD4ZENpwKhGzol6g1QHvtgG5ws/Zrsf/b3Sb6/6w0PVRylVxjKbaSDL62uZF3e2U0VM/Cta6jLLn7qSFr1nmA+JKT5Bme0oijZ/nhQRkBwZ2xeofv+siE4bDDVKEtNSEb946OZeLm6kU2O1TlmSpgIQMXyjAu+uKzmBtQaVoNlbQNRM/cSgjse8qQ9aMsnSiu5+Z3BguEP24OAYpkOby8PlXGbOTuDZEfN9M+UVPgbRo5vKCBFC+2fWHiLPb7bu03vmyuZO3sfdotzfLVVd7L+F0jmUQDQTVPlZOBc80CNksQzSUfhZElUMQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1692235835;
 h=message-id : date : mime-version : subject : to : cc : references :
 from : in-reply-to : content-type : content-transfer-encoding : from;
 bh=WfMGBtaGHGLIJ63kT4rLPlN6AQGC+kGBWir4Ap9VMDg=;
 b=evjYAZhmSgRn7TUk8Vj4Q84iOQsleiyHQPcJnt+XbqrvZF6DuaTTc8n1uLJxmbOgsWzZx
 li1iSCEu9iGICYjNOtlUs/hhkbutGm8K+C99GI2cnJt2eHSwVv+PK+DRA/3WvZVzexV9ll/
 XPAioP5TYSsKVgBiACDN3nAVJBP8MOUkwCYMxzvWX5tWyzydGKqDHyMpFdjuXeA7mjMV58y
 hOgjimyjAvmlm4iV8c7HdI7hM3iKsC5raJtpOFLXydIfs61T5NfiVqNKpv5C9U5ES9XgoK7
 JH9xtT57bCNANBRo0f7YFA6YPUaHRk2xywz/SPkujqbzW8BC8PdGZlxb991w==
Message-ID: <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
Date: Wed, 16 Aug 2023 21:30:34 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, axboe@kernel.dk, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, hch@lst.de
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
From: Genes Lists <lists@sapience.com>
In-Reply-To: <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230816_183038_776600_686DFA96 
X-CRM114-Status: GOOD (  18.05  )
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

On 8/16/23 17:04, Keith Busch wrote:
...
> It sounds like you can recreate this. Since .10 worked and .11 doesn't,
> could you bisect the git commits? It looks like it will take 7 steps
> between those two versions.
> 
> I don't think there are any nvme specific patches that could contribute
> to what you're seeing, it's more likely some lower level platform patch
> if a kernel change really did cause the regression. None of the recent
> commits really stood out to me, so bisect is what I'd recommend.

Thank you

Bisect done - This is result:

----------------------------------------------------------------
69304c8d285b77c9a56d68f5ddb2558f27abf406 is the first bad commit
commit 69304c8d285b77c9a56d68f5ddb2558f27abf406
Author: Ricky WU <ricky_wu@realtek.com>
Date:   Tue Jul 25 09:10:54 2023 +0000

     misc: rtsx: judge ASPM Mode to set PETXCFG Reg

     commit 101bd907b4244a726980ee67f95ed9cafab6ff7a upstream.

     ASPM Mode is ASPM_MODE_CFG need to judge the value of clkreq_0
     to set HIGH or LOW, if the ASPM Mode is ASPM_MODE_REG
     always set to HIGH during the initialization.

     Cc: stable@vger.kernel.org
     Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
     Link: 
https://lore.kernel.org/r/52906c6836374c8cb068225954c5543a@realtek.com
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

  drivers/misc/cardreader/rts5227.c  |  2 +-
  drivers/misc/cardreader/rts5228.c  | 18 ------------------
  drivers/misc/cardreader/rts5249.c  |  3 +--
  drivers/misc/cardreader/rts5260.c  | 18 ------------------
  drivers/misc/cardreader/rts5261.c  | 18 ------------------
  drivers/misc/cardreader/rtsx_pcr.c |  5 ++++-
  6 files changed, 6 insertions(+), 58 deletions(-)

------------------------------------------------------

And the machine does have this hardware:

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A 
PCI Express Card Reader (rev 01)
         Subsystem: Dell RTS525A PCI Express Card Reader
         Physical Slot: 1
         Flags: bus master, fast devsel, latency 0, IRQ 141
         Memory at ed100000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [80] Power Management version 3
         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit+
         Capabilities: [b0] Express Endpoint, MSI 00
         Kernel driver in use: rtsx_pci
         Kernel modules: rtsx_pci




