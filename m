Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AEDFC5910
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 09:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lfy7MVqdArIB0L7GMUkL+VkqYAl5vjNiXBn8MQ1USz4=; b=ire1RFGbXGABnDT8LEe7iKT+pM
	HxLRZgexfHP94vVPSA1C/KW/+kc6yuDd4qdp2dKHOOipUyXpNalzkEbJIN99OkQjI/R3olnU7XMMZ
	00N9Zr1RFL+OZmzitFvr6WdKDHZYSgYkZwhh+6+kX/gFKaVRYoLy7D9FwR14Gb6xsN12Ijv8n6Ar4
	cp4DAgyJkdkSh25r1vlBXF8TLcHU66Zbop6s/AEAIJQ4SzYzm3Vp9HwV2cPl2eppd043xBklp5w7X
	khPfU/qUj2Iu8tXrfeBUb6OxovYPBvSuiokcrArg9G1YPhfB0Zowt1kFdFFrkVlDdxaAZo4vZmFXH
	fgGLIy7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvXuz-00000005ppb-0gOY;
	Thu, 26 Feb 2026 09:44:25 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvXuw-00000005pp9-0TPB
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 09:44:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D0D944408B;
	Thu, 26 Feb 2026 09:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE024C19422;
	Thu, 26 Feb 2026 09:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772099060;
	bh=arEp4p3Lz0gsbfUSGfe1BI/JlbjVGOC5vG4aqJm7jeE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=m8QaLT8EvXJEXqSvD/oC+3ZjA769sea/RsDrQVZZxH7RtqH66belgFnGC0c4YJ18Y
	 elD128DjhswOq5ncD8unOfFY22StoLnpL+m5hCUE8y3HMrWZkxbeGBmfR7meZiWHaY
	 nywwq65lrlw8hKlm0gZkBzptca9u/tcP5to1R+96N1noPYMiaVbMrbILmsTKw5VxeJ
	 6ywvWoWddoI/Cg/jLp7EStV//Yg+0XDGLeULZ93mjoCwbQUxcXIVrWMFjeB/WH9Zyb
	 vDnWh2cmeYj7iQsGbC6DtXA+Uoj+m+4waQCaSTUrGxC65IZ53YHWNR1sp2oDbUU0El
	 1haS+QFj/P5Cw==
Message-ID: <4919267aa2f6471005e24282f85348b2af7689ec.camel@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] NVMe over MPTCP: Multi-Fold Acceleration for
 NVMe over TCP in Multi-NIC Environments
From: Geliang Tang <geliang@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-nvme@lists.infradead.org, 
	mptcp@lists.linux.dev, Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
	 <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hannes Reinecke
	 <hare@suse.de>
Date: Thu, 26 Feb 2026 17:44:14 +0800
In-Reply-To: <aZ6PYgJ0ZWeSc_GS@fedora>
References: <a9f115aa5719e1088702a3fdeee766a3166611b1.camel@kernel.org>
	 <aZ6PYgJ0ZWeSc_GS@fedora>
X-Priority: 1
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_014422_201797_365C6FEF 
X-CRM114-Status: GOOD (  24.97  )
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

Hi Ming,

On Wed, 2026-02-25 at 13:57 +0800, Ming Lei wrote:
> Hi Geliang,
> 
> Looks one interesting topic!

Thanks for your reply.

> 
> On Thu, Jan 29, 2026 at 12:13:25PM +0800, Geliang Tang wrote:
> > As one of the MPTCP upstream developers, I'm recently working on
> > adding
> > MPTCP support to 'NVMe over TCP'. This approach achieves a multi-
> > fold
> > performance improvement over using standard TCP. The implementation
> > and
> > testing phases are largely complete. The code is currently in the
> > RFC
> > stage and has undergone several rounds of discussion and iteration
> > on
> > the MPTCP mailing list [1]. It will be sent to the NVMe mailing
> > list
> > shortly.
> > 
> > 1. Introduction to MPTCP
> > 
> > Multipath TCP (MPTCP), standardized in RFC 8684, represents a major
> > evolution of the TCP protocol. It enables a single transport
> > connection
> > to utilize multiple network paths simultaneously, providing
> > benefits in
> > redundancy, resilience, and bandwidth aggregation. Since its
> > introduction in Linux kernel v5.6, it has become a key technology
> > for
> > modern networking, particularly in multi-NIC environments.
> > 
> > On a supported system such as Linux, an MPTCP socket is created by
> > specifying the IPPROTO_MPTCP protocol in the socket() system call:
> > 
> > 	int fd = socket(AF_INET, SOCK_STREAM, IPPROTO_MPTCP);
> > 
> > This creates a socket that appears as a standard TCP socket to the
> > application but uses the MPTCP protocol stack underneath.
> > 
> > For more details, please visit the project website:
> > https://mptcp.dev.
> > 
> > 2. Implementation
> > 
> > 'NVMe over TCP' establishes multiple TCP connections between the
> > target
> > and host for data transfer. This includes one admin queue
> > connection
> > for management traffic and multiple I/O queue connections for data
> > traffic, with the number typically scaling with available CPU
> > cores.
> > While these multiple TCP connections (using the same IP address but
> > different ports) help distribute computational load across CPUs,
> > all
> > data traffic still flows through a single network interface card
> > (NIC),
> > even in multi-NIC environments.
> > 
> > The 'NVMe over MPTCP' solution enhances 'NVMe over TCP' by
> > replacing
> > the multiple TCP connections with multiple MPTCP connections,
> > leaving
> > other mechanisms unchanged. Internally, each MPTCP connection can
> > establish multiple subflows based on the number of configured NICs.
> > This distributes data traffic across all available NICs, thereby
> > increasing aggregate transmission speed.
> 
> NVMe supports multipath, which can apply load balance or sort of
> algorithm
> to maximize network link/bandwidth too.
> 
> Maybe you can compare mptcp with multipath in this viewpoint.

Indeed worth comparing. Although they work at different layers, their
goals share similarities. I'll compare them in a follow-up and get back
to you.

Thanks,
-Geliang

> 
> 
> 
> Thanks,
> Ming
> 

