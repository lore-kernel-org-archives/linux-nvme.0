Return-Path: <SRS0=M30F=P7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35B3C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 21:38:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD28360E54
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Nov 2021 21:38:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD28360E54
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmfE/bx3mb9Zkdj9ibiKtSmckPFQCqlqa2uNol3SAQI=; b=Z5nVPRQNKUXzZ6AOtqWVVw35me
	Q9rEJ79kxToTbEpdnSIQ0Ir6GM73bHHchdXkHmmWTbmCdOM2h3WbM3JjCg2a4QPmh5fQbkqXJkviu
	5BHLVME0R53V/T4Sf6/S3r4Jfgvy64W8fGzTTxe2GUGgxxS4iNDVkElVco9HGFj6si3rlTqoY0pc5
	X44f97KbVKdKdUXc3kwBpXEa706/Qe86q7DV+O8L4vBV6TEp4jctm6+HN3yN5gTaKMY6QPgC9St3o
	lIxqVKeuGWM+wUfjp9ooOxDUx0WQ4fJahqJPp4xIxakA3rXwtvvdGkTNWP8ErfYCrRF02Qh6eCulr
	l1JjW+LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mleFC-00Bckd-CI; Fri, 12 Nov 2021 21:37:58 +0000
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mleF9-00Bci9-8s
 for linux-nvme@lists.infradead.org; Fri, 12 Nov 2021 21:37:56 +0000
Received: by mail-ua1-x931.google.com with SMTP id t13so21629157uad.9
 for <linux-nvme@lists.infradead.org>; Fri, 12 Nov 2021 13:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WmfE/bx3mb9Zkdj9ibiKtSmckPFQCqlqa2uNol3SAQI=;
 b=JbI4cYhpEpdgzxhS6Ubrqs4zWc2bJvoNSCGtwQDpIE/tztdWyLu9bzkdatTo8lcK8p
 WoA8faVWxFqlGwumC9VD7pvagwxCGHlguSLqPoVt5AEiOUR6iN3mzaLFJ0h+5elyC/qE
 VC7CrnWpljLx2vYgcjUr63kJb/4YJCVaezIz+eGwvtQyyBqChwAdd9e7C6DMKo/78QAK
 RbSI+zM2DrABkPD5vMIRLPQoUgn7Y8qvc1Yi/jpIWJgUlGr7UzYL7OZJhOKxQmt1Mab4
 ctx5eIGGHCtoDuE68BQCiedIpbuqdDAMQMbci3TYZMMNSVteF0gJ7pMSZhZtTeWBVCXi
 vtwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WmfE/bx3mb9Zkdj9ibiKtSmckPFQCqlqa2uNol3SAQI=;
 b=fvuJRoqUOVaNa11IAkI8wu3SZwWRGXT3EcIaJgLPhPdLuh1W07pizQTIBl7bh4huCi
 O7sDOdjC6UBWWjl2M7cgR9TGl3WECfn/Gknf0K4lMGMd5Fljidh+c5gMXODUyrZVO5op
 CJhEISxtE0WZ4JZJ13NGk3WhVgjnexNCWzmO0c300x+ZXxfp6A+jRaoHCynQMUtGLsYI
 OV7qoaoZZWLXLOGVM39qon8IKvg5GtZTWlsrCyk3qwjGR5AxqH1dtalubMGZOgJo9PBC
 kQ2DjGHcQVITJfUv5xnbpKMwu2T6PMKn8ggeYt05fA/5PzQCnr+bzuloRPObepZ55592
 w0ew==
X-Gm-Message-State: AOAM531Do03yR0O6lkIBRuciSNQo3wkAD7nd7TZ4hxBPs3a2zIteaCY/
 qoYMyew13efrT9dq6/n2md9GkGJ+KxyS7ssI6Wc=
X-Google-Smtp-Source: ABdhPJw2Gm2YtWpvusuhKbjqd2xWIZlzPHXUuBQUjy1MnxpOapuduQs1xgBneW9rSCUA2drPJwyG4wvRSmnKyhIvV1o=
X-Received: by 2002:ab0:3049:: with SMTP id x9mr26650208ual.55.1636753073523; 
 Fri, 12 Nov 2021 13:37:53 -0800 (PST)
MIME-Version: 1.0
References: <20211108144703.7971-1-mgurtovoy@nvidia.com>
 <20211108164511.GA2660170@dhcp-10-100-145-180.wdc.com>
 <20211109080903.GA28785@lst.de>
 <6292cd43-c746-0316-1820-aa52ec85d375@nvidia.com>
 <20211109131510.GA19713@lst.de>
 <9c740227-8c98-5877-9a9a-ae17756e851c@nvidia.com>
 <20211109143102.GA25263@lst.de>
 <20211109161547.GC2660170@dhcp-10-100-145-180.wdc.com>
 <a70fd129-d69d-2905-c43b-41eae0b3b8f8@nvidia.com>
 <20211109190432.GA2661484@dhcp-10-100-145-180.wdc.com>
 <e2d589ab-2457-a3c8-ba2a-9e4f813d9a72@grimberg.me>
 <fc27faf4-c876-ced5-c9cb-2d6730e07f2d@nvidia.com>
 <53205a07-1af6-38a5-c60c-ca7d12226202@grimberg.me>
In-Reply-To: <53205a07-1af6-38a5-c60c-ca7d12226202@grimberg.me>
From: Keith Busch <keith.busch@gmail.com>
Date: Fri, 12 Nov 2021 14:37:42 -0700
Message-ID: <CAOSXXT6A2Wk8bk3akQZDNRO_Wd8PfCL+T2PTY0HVdpENyq4c=Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Add command id quirk for fabrics
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, linux-nvme <linux-nvme@lists.infradead.org>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, oren@nvidia.com,
 benishay@nvidia.com, 
 borisp@nvidia.com, aviadye@nvidia.com, idanb@nvidia.com, jsmart2021@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211112_133755_330833_F749B105 
X-CRM114-Status: GOOD (  17.53  )
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

On Fri, Nov 12, 2021 at 9:08 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>
>
> >> Completely disagree here. The TCP original report was just an example of
> >> lack of protection we have against spurious completions. Nothing
> >> specific about nvme-tcp here, this was discussed and agreed on in
> >> the original report.
> >>
> > You are ignoring the facts:
> >
> > 1. The device that broke the spec in the first place was that device for
> > which caused you to add the gen bits to CID.
>
> Correct.

Can we also acknowledge that the broken device isn't really nvme? Apple uses
PCI class code 018020, which is an unspecified mass storage controller, clearly
*not* nvme. Apple does not care if their devices work with a generic
NVMe driver.
The only reason it works in Linux is because (1) a savvy user base exists to
reverse engineer their crap, and (2) their crap so far hasn't been invasive
enough to justify an entirely different driver. No one should consider Apple an
example to follow.

