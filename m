Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976B3E92FF9
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Oct 2023 08:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V4RERI3WDZp6MuS98DVvDkEhrqEd6V5FpHOSmADa1+Q=; b=2or3TN2kY+nU5TAoVvQYq2BVLL
	4AQYvw8/mpsRLs1tHIsCJ85tM735vutmUzzbJhV3FWP7rpZAS1du6RvgH065L4lTupNDZ8KOZffTY
	rDxaaQmqvNQYVaZWDf7HDbMj5P64cZshAagHGB8xJ9C2+06EAS/mmscdtQWdoYJ78kTrO/KuxUk8D
	6rgKC7Up+4EJCNOFyHIhWydBbyUCKkyfgefywLW1Mggod/17sU4exhMVtE/rRFirUImH9dOkJUeG+
	zLx/AGrr4Q3r1DfBGZbZaMG01G6HJe391lolU8nX5edZBTlWgFn4wcYUC4i20TPb4cv5zhW+89f28
	95k9xxFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qogRW-005JUN-36;
	Fri, 06 Oct 2023 08:44:18 +0000
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qogRQ-005JTY-1F
	for linux-nvme@lists.infradead.org;
	Fri, 06 Oct 2023 08:44:14 +0000
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c135cf2459so22044341fa.0
        for <linux-nvme@lists.infradead.org>; Fri, 06 Oct 2023 01:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.com; s=cloud; t=1696581849; x=1697186649; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=V4RERI3WDZp6MuS98DVvDkEhrqEd6V5FpHOSmADa1+Q=;
        b=ZWGt2hyf4EhiV5BZRuy4538yB3zBB/NsTPWEBzq5tHkCdOT8A7vOPIUh2x4PbLe4Cr
         BbCYUnrFq9QimXuh+5bTgQ17FOmkqbxTwlIGTvrxIhoBOXAfp6enXwB0QjB9CpidJFZc
         ARkblsxcKCOnBVm+3kamSFIkl211eIiDjKJWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696581849; x=1697186649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V4RERI3WDZp6MuS98DVvDkEhrqEd6V5FpHOSmADa1+Q=;
        b=cKDxo77y58RA5OLDdariJZuC5wH/bn9nk5qxlAF0HD5Id6iqY7y59p5BEzKTR5S7pO
         podGrOUVBxTd31hr3Ul92KqDRIRxcSnnPeXuJQrPLA4cnbwjK0f8K3gN6LCfol9+Jkoq
         jg937VGwtjXQ2J9vqzCpvxb64w4d0AKwlNYEQ+PqAJOSNYx3ouWreGeIpoay8kR4ss6h
         dpw6Ep1NmbQjjfhGcgaFHYmqNCSS0TeKF1WCDym26o/Mh0JSqQHMDI9F3cXoHdQ6/Q41
         5bcd1cAl0j2VuwyLnjdB6DNymIZryYv7v1u6AOyqs0xJtkDeJUJjyqwxR0AIIEMD2HWr
         59lg==
X-Gm-Message-State: AOJu0YwOARrNpF91lQfewfkBdOe4Ln64nohYv489mZwQSO+0uWS+O1ey
	9Z02taB1Bz8Pl8DNCkhrLyqtG+WevsdtRI/noQFBBQ==
X-Google-Smtp-Source: AGHT+IEUv+a5Xqx2NL7a3Jy/PmvBtnDfyBhnSaq3VajOg3m//CLYQtYSS89+hmU3cC6UqQZetS6dDc559xLkunb4bfU=
X-Received: by 2002:a2e:9e4f:0:b0:2bf:e61b:c980 with SMTP id
 g15-20020a2e9e4f000000b002bfe61bc980mr6030583ljk.8.1696581849576; Fri, 06 Oct
 2023 01:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAPYKksW8SyqG1+P1J7JRbrwnjkj=S5gWA93+yOugB=N+zhD3OQ@mail.gmail.com>
 <ZR5y+2P/NQ25/Rkv@infradead.org> <CAPYKksVJgr+XJUe5kFQq7T59Hn1ELvK9nLsz9re8UwvwPRY5Pw@mail.gmail.com>
 <ZR+7bCOan1wPM8jZ@infradead.org>
In-Reply-To: <ZR+7bCOan1wPM8jZ@infradead.org>
From: Mark Syms <mark.syms@cloud.com>
Date: Fri, 6 Oct 2023 09:43:58 +0100
Message-ID: <CAPYKksUVW4D7OVxjx4K0V13KdCXz6_3OFO+xPtSA5M4+C8GygA@mail.gmail.com>
Subject: Re: NVMe fabric multipathing
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-nvme@lists.infradead.org, Ross Lagerwall <ross.lagerwall@cloud.com>, 
	Andrew Cooper <andrew.cooper@cloud.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231006_014412_454506_FE716991 
X-CRM114-Status: GOOD (  23.75  )
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

On Fri, 6 Oct 2023 at 08:46, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Oct 05, 2023 at 11:16:41AM +0100, Mark Syms wrote:
> > > > We have a requirement to report information about the status of NVMe
> > > > multipath controllers on an NVMe over fabrics deployment. In
> > > > particular the total number of "known" paths and the number of
> > > > "currently active" paths. As far as we can see right now, when a path
> > > > to an NVMe target device, when using Fibre Channel, is blocked, all
> > > > local information about the affected controller is flushed leaving
> > > > just the currently active controller(s) present.
> > >
> > > What do you mean with "blocked"?
> > >
> > Made unavailable for any reason. So failed switch port, failed HBA,
> > failed SAN controller, etc. We've been "emulating" this for testing
> > purposes by unbinding the PCI device for the HBA on the NVMe target
> > device but I expect the same happens for any of those reasons.
>
> If you undbind the device there is no way NVMe can keep any knowledge
> about the connections it has.  If you have a real path failure on
> the underlying fabric as long as it hasn't given up on reconnects.  You
> can set the max_reconnects value to -1 to never stop reconnecting.

That was an unbind on the remote system not on the system that we were
pulling status from, that should, from the POV of the client host, be
essentially the same as dropping the switch port (or indeed a
controller in an HA Pair dropping offline) should it not? We can
certainly try dropping a switch port by SNMP and see if the behaviour
is different.

