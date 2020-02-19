Return-Path: <SRS0=nRQ2=4H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E98C34056
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 20:51:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE81E24656
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Feb 2020 20:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GM3ACX37";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9zlWyXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE81E24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=MH7u307pBnohXYHISkGKLzg4J9if9qWS0gXIaif8RUQ=; b=GM3ACX37Cesg0F
	1gu/IrS0g3ZXBKFUU/GKv41YT2QXSyqLavglhePB05B8jQ88p5Jgi3HGeQgPaRPKF6yv9GyEUyGgc
	h7OGYA4zJujjlijwNByfEPn3KP/e/rYQc3rwaA7FiO48YPw9rguKlCv7CechLYp6qC/QmaELCq8IC
	FKmZB1LwEjc/mx9C3LN6PfUP6BOt7FS7v/+m+N8MoOEhHNYPjyiCaOTYa1MivHc/wvgwp3R2+C+u2
	CoXdrFtByf24cOxx1d8FG51VV1OI6L0kjywNkGc/v45W2ZGztjsczyT1CBvwE1W1PEgIY3cdIBf2I
	jAhsNEUVJ9li7szc8/OA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j4WJF-0002JA-GK; Wed, 19 Feb 2020 20:51:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j4WJD-0002I9-2F
 for linux-nvme@lists.infradead.org; Wed, 19 Feb 2020 20:51:04 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9CBC924656;
 Wed, 19 Feb 2020 20:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1582145459;
 bh=elJqOZvyfQWvQ8In1AjZnSkYrHkr0otpJwRaZHCgpxo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W9zlWyXKb/CugInFr/h8yZlZWNm/5x9tvD/KWAIHPuEvsrHpTChlurGgY9L8raBoy
 wCVWBwUJFkJs/eldR9pUoyDf7UuLF2zMc5co+/QiWjCncTpyha8w/AdC3seNQvEH0n
 iRIJiEGNGesF863JJJ5xwD3RTPGZ3uzH2UU3i2sE=
Date: Thu, 20 Feb 2020 05:50:52 +0900
From: Keith Busch <kbusch@kernel.org>
To: Tim Walker <tim.t.walker@seagate.com>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe HDD
Message-ID: <20200219205052.GB28509@redsun51.ssa.fujisawa.hgst.com>
References: <d043a58d-6584-1792-4433-ac2cc39526ca@suse.de>
 <20200214170514.GA10757@redsun51.ssa.fujisawa.hgst.com>
 <CANo=J17Rve2mMLb_yJNFK5m8wt5Wi4c+b=-a5BJ5kW3RaWuQVg@mail.gmail.com>
 <20200218174114.GA17609@redsun51.ssa.fujisawa.hgst.com>
 <20200219013137.GA31488@ming.t460p>
 <BYAPR04MB58165C6B400AE30986F988D5E7100@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20200219021540.GC31488@ming.t460p>
 <BYAPR04MB5816DF16BC3720ABF286671EE7100@BYAPR04MB5816.namprd04.prod.outlook.com>
 <CANo=J15Wvm2R+vuLj6QQ5Vete507cA==5Rw=4vn3Z8npZ=2vww@mail.gmail.com>
 <CANo=J14GM=Uu7qWirtvgzjEKVCzLV0nZLOOPqD9M+nwOKrv7yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANo=J14GM=Uu7qWirtvgzjEKVCzLV0nZLOOPqD9M+nwOKrv7yQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200219_125103_128445_B786AEE2 
X-CRM114-Status: GOOD (  11.29  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi <linux-scsi@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Ming Lei <ming.lei@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 19, 2020 at 11:28:46AM -0500, Tim Walker wrote:
> Hi Ming-
> 
> >Will NVMe HDD support multiple NS?
> 
> At this point it doesn't seem like an NVMe HDD could benefit from
> multiple namespaces. However, a multiple actuator HDD can present the
> actuators as independent channels that are capable of independent
> media access. It seems that we would want them on separate namespaces,
> or sets. I'd like to discuss the pros and cons of each, and which
> would be better for system integration.

If NVM Sets are not implemented, the host is not aware of resource
separatation for each namespace.

If you implement NVM Sets, two namespaces in different sets tells the host
that the device has a backend resource partition (logical or physical)
such that processing commands for one namespace will not affect the
processing capabilities of the other. Sets define "noisy neighbor"
domains.

Dual actuators sound like you have independent resources appropriate to
report as NVM Sets, but that may depend on other implementation details.

The NVMe specification does not go far enough, though, since IO queues
are always a shared resource. The host may implement a different IO
queue policy such that they're not shared (you'd need at least one IO
queue per set), but we don't currently do that.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
