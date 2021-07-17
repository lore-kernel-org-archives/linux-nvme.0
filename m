Return-Path: <SRS0=Rbl5=MJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98711C636C9
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 14:13:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 535F8613AF
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Jul 2021 14:13:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 535F8613AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4aRTDJFxWdzHqZXvk2FIKx+RMxUhkLMRJ/vIP0dfLLA=; b=rRbmNdI4V2bjIL
	hJ2KeIeUdNDss15l78YXUhVsPmWlK7xzdY99qMa/bScW8EJKgedMiRQOYsMoC29n8yRiM60vommkf
	LSp67kh+COJkkc8ADmdYZsqPb9gCQpUw9emgglPWCRyzIa5MYlKIsEBk3aDbo8WiuZvxoq5TwqRx0
	R7q7CeNot+rHDCA5cR+IxAHbgeE1DSIFYQFy8KHYSEbyTco4X8C2RoAMWo2TeRnxmI+fkcq9XpMg1
	rkbAC5KPxSOI7SFkiuYHkIzf2lbjqiEpPwLnVvA7Mrr5o4DdVTEgXszHCCGBYZAuVGqeT4zduaEUF
	gTyvzeEwj8SK+7PIPBDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4l3x-006hvo-M9; Sat, 17 Jul 2021 14:13:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4l3v-006hvU-9n
 for linux-nvme@lists.infradead.org; Sat, 17 Jul 2021 14:13:04 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46A2F613AF;
 Sat, 17 Jul 2021 14:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626531176;
 bh=CSqWbwnDQetPqNrqCiyqzlstecp4z8aojSFR6OWBeHE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YHLfkMcAhW3q0tcYt29I0fGtfM8rUS64uVWbUwB5VV+prO+xo4gSkNp9iKpSUor6i
 qnRdzGnj+0clXdYsYPm5HRi25jueLTd8oz8SBGzbUIFWjRwH4hGJHwTcoMpppgLyE7
 jWSXpogKnu84n0PF6KNtBKUkdg1eimerDyBLg35Kue4cKTjYGhzbYHWgsIOaOUct9Y
 CkrEMNpX0AfmcjezQI5rarlr3kXL0D5KeF45aLFdUMomXnn8eKj4CJ99scEmZWxRDg
 csikWLEha5YOSJmMmuH89qBzHdweUWLXw6PBo0yKu25SUJ2NL1/wa9aT7CxiqRXfEZ
 OqLm3kFhs1wTQ==
Date: Sat, 17 Jul 2021 09:12:54 -0500
From: Eric Biggers <ebiggers@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 04/11] lib/base64: RFC4648-compliant base64 encoding
Message-ID: <YPLlZvVTMvjs8UGu@quark.localdomain>
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-5-hare@suse.de>
 <a6708951-76f6-21bb-f7fe-e4bb32cd0448@grimberg.me>
 <7f320b51-1077-9b3f-bf29-49d0753adf6c@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f320b51-1077-9b3f-bf29-49d0753adf6c@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210717_071303_399224_3D7E9330 
X-CRM114-Status: GOOD (  10.42  )
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

On Sat, Jul 17, 2021 at 04:00:20PM +0200, Hannes Reinecke wrote:
> On 7/17/21 8:16 AM, Sagi Grimberg wrote:
> > 
> > > Add RFC4648-compliant base64 encoding and decoding routines.
> > 
> > Looks good to me (although didn't look in the logic itself).
> > Can you maybe mention where was this taken from?
> 
> Umm ... yeah, I guess I can; I _think_ I've copied it from base64 routines
> in fs/crypto/fname.c, but I'll check.
> 

Note that it wasn't simply a copy, as you changed the variant of base64 that is
implemented.  So please make sure that you are very clear about which variant of
base64 it is, and update all the comments accordingly.

- Eric

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
