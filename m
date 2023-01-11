Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006F4C5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:To:From:Subject:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8hILRbYj9I9EmnF82YqIMaso0+NGlS4mfXxNVoT4+t4=; b=IPnMxv7ks0N8ldxR9dzGkA/TfD
	p+l7GpjODoArGDvQqa2+ApN762r3uBA/ViA9RwtLskcNpo+gEV/uLT94hwq0bV7+t4oWoBRGViFfD
	BnfEL9YKRQo5LTiuE/f1KMTsPxYzBkohirpy2lDsuN2nKw01eLCIX8101r6VzLGWQk7e02xx53ask
	FBT2+WVJWsj1Y3Mh1XqzFLn7b4vPuujwBMZvJcNujy++hWVr/4+74q3wwNxwceRKsUjH4DF8pr7uV
	hk64rXNqmW+GBsuo3AEyDoil2ArFohihUFq5YYzjl2d9PuCLMR1LxLDH0ChO9ebKtEh1oxaJf1kHz
	95coxIFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFbim-00BitT-9e; Wed, 11 Jan 2023 14:04:52 +0000
Received: from bedivere.hansenpartnership.com ([2607:fcd0:100:8a00::2])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFbik-00Bise-1p
	for linux-nvme@lists.infradead.org; Wed, 11 Jan 2023 14:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1673445886;
	bh=FQHCe0QlB0ampWtNSW+uzhirXQBJvHqNFBSrLY1DN08=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=yCbzi6ix/z6K54TarWJCBjhdQkAPk6+QHeL9lpsZjTAeIuUJIP3FovdZidwFnk138
	 w8q5+TL9j0QNQTrZJG90R6Ih5sMj2NegKLXGEo2o4/Prlf0dpmRsyE5PwI8wDRcjPK
	 vZjzgqASRryEnE4LlUTnJB5z8jUy62LxvWcH/J1E=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1D7DB1285F60;
	Wed, 11 Jan 2023 09:04:46 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
	by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9oh48saRsWow; Wed, 11 Jan 2023 09:04:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1673445885;
	bh=FQHCe0QlB0ampWtNSW+uzhirXQBJvHqNFBSrLY1DN08=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=j4dc4qN64RKpGpWdsvjcuycZGrJIoTxYVqec/pOOCfPNAceOAy+cinraypitV3D/9
	 zBqgF9ARjjenP0hDRK/nBXmSS8lmBc/d/EvLKLjx7VqsUyYsbgfbCiyBqXtJ/E0hox
	 Du4EB/LpC8+rU+4pxLCO9cwc1NHgeWfjUbPhTfJE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 402581285F5F;
	Wed, 11 Jan 2023 09:04:45 -0500 (EST)
Message-ID: <8cb4f87aadcfe617a90291bc09afb833bd201eef.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Limits of development
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Hannes Reinecke <hare@suse.de>, lsf-pc@lists.linux-foundation.org, 
	"linux-nvme@lists.infradead.org"
	 <linux-nvme@lists.infradead.org>, linux-scsi@vger.kernel.org, 
	linux-block@vger.kernel.org
Date: Wed, 11 Jan 2023 09:04:43 -0500
In-Reply-To: <a7c37acd-eb59-54a7-d401-38ffd16a7062@suse.de>
References: <06e4d03c-3ecf-7e91-b80e-6600b3618b98@suse.de>
	 <5230135e68bdf7b3fcbff78e7ffd51beebe509c8.camel@HansenPartnership.com>
	 <a7c37acd-eb59-54a7-d401-38ffd16a7062@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_060450_123601_B6921759 
X-CRM114-Status: GOOD (  22.39  )
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

On Wed, 2023-01-11 at 14:17 +0100, Hannes Reinecke wrote:
> On 1/11/23 13:55, James Bottomley wrote:
> > On Wed, 2023-01-11 at 12:49 +0100, Hannes Reinecke wrote:
> > > Hi all,
> > > 
> > > given the recent discussion on the mailing list I would like to
> > > propose a topic for LSF/MM:
> > > 
> > > Limits of development
> > > 
> > > In recent times quite some development efforts were left
> > > floundering (Non-Po2 zones, NVMe dispersed namespaces), while
> > > others (like blk-snap) went ahead. And it's hard to figure out
> > > why some projects are deemed 'good', and others 'bad'.
> > 
> > It's not any form of secret: some ideas are just easier to
> > implement and lead to useful features and others don't.  It's
> > exactly why we insist on code based discussions.  It's also why
> > standards that aren't driven by implementations can be problematic:
> > what sounds good on paper doesn't necessarily work out well in
> > practice.
> > 
> But that's kinda the point.
> The above quoted examples do have implementations which were sent to
> the mailing list (well, not the dispersed namespace one, but let's
> not get hooked up on that one), _and_ enable existing hardware
> features.
> So they tick all the boxes you specified.
> Yet they have been rejected.

Because they don't provide much benefit once implemented and the
implementation is a bit many tentacled.  The point of implementation
driven specs isn't to declare it's great when you get to any old
implementation, however horrible, just because you can force one of
your employees to produce it, it's to fail fast and do something better
when the implementation proves problematic.  The kernel patch process
can provide the failure, but it's much less traumatic if the original
implementors recognize it before it gets spec'd.

Just because something exists in hardware is no reason to use it as the
fact that we use < 10% of the SCSI spec most hardware speaks will
attest.

James


