Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07164C6FD18
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Mar 2023 05:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=12NXJVOqHYOJfzuGRv+LXR+erdGzBR++9miDAp8/I6M=; b=mqL0R+Vda8ieQc/El2Gy9A4uq4
	Tv3kPdZDU65A2H5a2rsPTGmt57977ZIW64VIqu/QoSgs4nB8b/owwWSaktvLhSCx1+HqmCDFW7O0K
	ib/SWtNoGyZNxzg2mISvos8nasm5NqtiwYKMHSxZfcxrF03I59C/HWtjqTY2e6AD0wgNleYEWmJLf
	JedwJjEjeOWLDMnO1/bOfE3oWC80t7DGeRV1b9TQpfrIaxwe7lNVFcT8zKT4igv5+ag26ZGCxNGYQ
	+T1GVSKxHRAUPfHpeQauNe/XqrJ18pDRcjR7AZI3GZYMa/Z2Ddnxi1zGnl6WfpwfLXDW28AowThI1
	uSXUg+yw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pi7df-005vEg-2v;
	Fri, 31 Mar 2023 05:49:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pi7dd-005vE6-1o
	for linux-nvme@lists.infradead.org;
	Fri, 31 Mar 2023 05:49:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 92AF562354;
	Fri, 31 Mar 2023 05:49:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45DCBC433EF;
	Fri, 31 Mar 2023 05:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680241763;
	bh=Yw7/GHvt9TVDQ0FbQUD794UyOwYG/rHTIXocgA5C7LE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=du2lux+4z9fuJkw+E6h2GjDEFOwWUxi1LNlEdskQymXIu7TWkeLonGYMpFMsKWJm5
	 cwN7rWKopbMNIdCQCCyjXGocaiSbwrz36xddItWnKUfudh7zmB1CnCOdstX9JsyawG
	 YV//Q6Cq4eytj2Dj2Vq5Z5L5eOKot3eLbyyuu5jSk8UQ33oTmVtWX7uYRLFicgLXh5
	 +zrv+iPjC6Mz4SiShQZqlKPhe6iU3+AeFCkCdFnBf5/5g3Zqt5a/6mgzbG+PvyNQH+
	 v27F+nbcr0xyxB691M6io1e9dyyumVaqItwMc8wPhieWjnLFF808FO9vAQCEKzL61O
	 NjOYjKeTPH4Yg==
Date: Thu, 30 Mar 2023 22:49:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Boris
 Pismenny <borisp@nvidia.com>, john.fastabend@gmail.com, Paolo Abeni
 <pabeni@redhat.com>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH 10/18] nvme-tcp: fixup send workflow for kTLS
Message-ID: <20230330224920.3a47fec9@kernel.org>
In-Reply-To: <634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
References: <20230329135938.46905-1-hare@suse.de>
	<20230329135938.46905-11-hare@suse.de>
	<634385cc-35af-eca0-edcb-1196a95d1dfa@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_224925_642189_2DDC5184 
X-CRM114-Status: GOOD (  19.04  )
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

On Thu, 30 Mar 2023 18:24:04 +0300 Sagi Grimberg wrote:
> > kTLS does not support MSG_EOR flag for sendmsg(), and in general
> > is really picky about invalid MSG_XXX flags.  
> 
> CC'ing TLS folks.
>
> Can't tls simply ignore MSG_EOR instead of consumers having to be 
> careful over it?

I think we can support EOR, I don't see any fundamental problem there.

> > So ensure that the MSG_EOR flags is blanked out for TLS, and that
> > the MSG_SENDPAGE_LAST is only set if we actually do sendpage().  
> 
> You mean MSG_SENDPAGE_NOTLAST.
> 
> It is also a bit annoying that a tls socket dictates different behavior
> than a normal socket.
> 
> The current logic is rather simple:
> if more data comming:
> 	flags = MSG_MORE | MSG_SENDPAGE_NOTLAST
> else:
> 	flags = MSG_EOR
> 
> Would like to keep it that way for tls as well. Can someone
> explain why this is a problem with tls?

Some of the flags are call specific, others may be internal to the
networking stack (e.g. the DECRYPTED flag). Old protocols didn't do 
any validation because people coded more haphazardly in the 90s.
This lack of validation is a major source of technical debt :(

