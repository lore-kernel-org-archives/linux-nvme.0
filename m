Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EDDC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 21:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tmUDmlkZy0V/KcsZbbQj8FDvEOuLW2+iLS/1UsUlMHA=; b=GA3pVTEDFJIv4iKx/CRUpz8Pa9
	4y8KdsJ57ymhJFVe5xPR4YPXPJFg6w4uFz6sApZddRvWgMB/KdxNc7biaiMQEabZCFDxoEqHbUMzx
	+A9Iz4iVwlCPONLtjE/Qrr7sQDCAnygVRHWY8qkuwbOnx+KpbgaWuew8BL8q3R+6+v184CVSmOAqY
	haABOZo7AKeSRWc91xhjBX40d9HSYduE1nffchLBBvO44oOLjwbFOuFYRSoTATBsEV966qnkbeoLv
	WcsdVnDxqfolC7GFFc45Rr+6XTof3+Gge5tY1j5PEdD86mB5HYXhZ6rdN+saVsosmF8UZHjVxi9HN
	TdZZNkuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkBNh-008Sck-Ba; Thu, 28 Apr 2022 21:08:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkBNe-008Sbe-DD
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 21:08:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D56B461F10;
 Thu, 28 Apr 2022 21:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E69C385AE;
 Thu, 28 Apr 2022 21:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651180133;
 bh=NfJ7RXxovLcu/9DkEB6SDpL9K8C/TD0hKVuCmc9Ri8Y=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YQH4o1hmxaL45wEfgIjIiJwwilyidxEfysZAhu8S5qc8b+72JUEOKhnSQneqZA+XN
 LYaFQK/v4xjK2sprRF9eP7zFpb1iUp3dqruDUn93HUUKWoovGICF2NDEWb9TOQx9N8
 eEQ7uUiyZJFiB6eqrYfqRAJzWeA1ioptPFy+3T2Lk39ioYJEfjJ/fuWgblc3RK0phg
 lz48VVLmaoRkeAbTuz+SsnwfW0P1bc8afGH6v0fFXBVUoKkJe1RL/5d/ffV54INfAJ
 h/wWhK3rpaY7ewg6iv7HWHuwPw57DmRxqZxRhq+eE2qPNOHltVdOxKn2+Wrx5miWUY
 CzohEV0delN0w==
Date: Thu, 28 Apr 2022 14:08:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: netdev <netdev@vger.kernel.org>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-cifs@vger.kernel.org"
 <linux-cifs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>, "ak@tempesta-tech.com"
 <ak@tempesta-tech.com>, "borisp@nvidia.com" <borisp@nvidia.com>,
 "simo@redhat.com" <simo@redhat.com>
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220428140851.6e9eebd5@kernel.org>
In-Reply-To: <F64C2771-663D-4BE7-9EB9-A8859818C7F8@oracle.com>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
 <20220425101459.15484d17@kernel.org>
 <E8809EC2-D49A-4171-8C88-D5E24FFA4079@oracle.com>
 <20220426075504.18be4ee2@kernel.org>
 <BA6BB8F6-3A2A-427B-A5D7-30B5F778B7E0@oracle.com>
 <20220426164712.068e365c@kernel.org>
 <7B871201-AC3C-46E2-98B0-52B44530E7BD@oracle.com>
 <20220427165354.2eed6c5b@kernel.org>
 <F64C2771-663D-4BE7-9EB9-A8859818C7F8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_140854_612766_C5ED7DEB 
X-CRM114-Status: GOOD (  23.43  )
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

On Thu, 28 Apr 2022 01:29:10 +0000 Chuck Lever III wrote:
> > Is it possible to instead create a fd-passing-like structured message
> > which could carry the fd and all the relevant context (what goes 
> > via the getsockopt() now)?
> > 
> > The user space agent can open such upcall socket, then bind to
> > whatever entity it wants to talk to on the kernel side and read
> > the notifications via recv()?  
> 
> We considered this kind of design. A reasonable place to start there
> would be to fabricate new NETLINK messages to do this. I don't see
> much benefit over what is done now, it's just a different isomer of
> syntactic sugar, but it could be considered.
> 
> The issue is how the connected socket is materialized in user space.
> accept(2) is the historical way to instantiate an already connected
> socket in a process's file table, and seems like a natural fit. When
> the handshake agent is done with the handshake, it closes the socket.
> This invokes the tlsh_release() function which can check 

Actually - is that strictly necessary? It seems reasonable for NFS to
check that it got TLS, since that's what it explicitly asks for per
standard. But it may not always be the goal. In large data center
networks there can be a policy the user space agent consults to choose
what security to install. It may end up doing the auth but not enable
crypto if confidentiality is deemed unnecessary.

Obviously you may not have those requirements but if we can cover them
without extra complexity it'd be great.

> whether the IV implantation was successful.

I'm used to IV meaning Initialization Vector in context of crypto,
what does "IV implementation" stand for?

> So instead of an AF_TLSH listener we could use a named pipe or a
> netlink socket and a blocking recv(), as long as there is a reasonable
> solution to how a connected socket fd is attached to the handshake
> agent process.
> 
> I'm flexible about the mechanism for passing handshake parameters.
> Attaching them to the connected socket seems convenient, but perhaps
> not aesthetic.

recv()-based version would certainly make me happy.

