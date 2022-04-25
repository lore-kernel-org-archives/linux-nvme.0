Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB99C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Apr 2022 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=43g99kmkCcK4X2z8RqH4FXCDQ/DSl+rKEZPKS+WkgfI=; b=al3q8khS4Zm3mkhlQQRS4yMKsX
	YRX+KFLt29ku5H2g0+tiFQhqavbrY9xnD6gtchpbVHS2FbtxWQOQrQspDa1QKlXAC8eOGV6CgDheB
	pFHetvJNxr2+rsEzTbtUWD3t52ghqjlinlo2B41HCvZ9GR+ySPRn7/wyp1VIwQUBm7DCwZKsGbl9H
	ZpNC/u/hU2hPlfezfh/Dq+BjmEHCTHErRM7dsoOjHGBXsWHfxWQv58yOMq8XdbIbaIoWd9mvJBTh8
	fN1y/h/YWWVpA27nrXEJQAhoinnnO8mICIJFwXdQecmblaqI3jq7gT2sNw2JSd7cP0lQ1K6u/4lhv
	Y43eT+cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nj2Ll-00AbJE-Qi; Mon, 25 Apr 2022 17:18:13 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nj2If-00AZUp-AF
 for linux-nvme@lists.infradead.org; Mon, 25 Apr 2022 17:15:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B904861501;
 Mon, 25 Apr 2022 17:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F221C385A7;
 Mon, 25 Apr 2022 17:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650906900;
 bh=azwiyx9Qzz2iHjECwV38Z63IZrqsIDeUQJJ8RRIUH04=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=QGwM8V39fNuvjWwbX1wgqckCCOHL+wPB9GXHM2L6qGiGea94zfToiFqejWBfIfelZ
 u11nUXYm6cKGU8vkHyJMRrW+O9aM2gqgceH2nWAzRxuLBB58XP4z5OvJkmDxn9qw2N
 k61rh2wpE/t+KIgHbBbeyhQbDBR8uoL+ybgweqCXHgjbZtQk8X4juvfwJCe9woW6e6
 xHa/TgqbKbKkggLwE6wE/gLm4QhrScCb/EyAz5Kqil29Dc8h8nd/t/62Jbh1gx9QIB
 twRNHqPh32H3/1nZs+elpZWYOy0J995A8oaQYoL/IrCMOSfuVo//U12SEB0Ip2R4Ht
 WPErAicpSEeKw==
Date: Mon, 25 Apr 2022 10:14:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, ak@tempesta-tech.com, borisp@nvidia.com,
 simo@redhat.com
Subject: Re: [PATCH RFC 4/5] net/tls: Add support for PF_TLSH (a TLS
 handshake listener)
Message-ID: <20220425101459.15484d17@kernel.org>
In-Reply-To: <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
 <165030059051.5073.16723746870370826608.stgit@oracle-102.nfsv4.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220425_101501_503008_6A125233 
X-CRM114-Status: GOOD (  16.75  )
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

On Mon, 18 Apr 2022 12:49:50 -0400 Chuck Lever wrote:
> In-kernel TLS consumers need a way to perform a TLS handshake. In
> the absence of a handshake implementation in the kernel itself, a
> mechanism to perform the handshake in user space, using an existing
> TLS handshake library, is necessary.
> 
> I've designed a way to pass a connected kernel socket endpoint to
> user space using the traditional listen/accept mechanism. accept(2)
> gives us a well-understood way to materialize a socket endpoint as a
> normal file descriptor in a specific user space process. Like any
> open socket descriptor, the accepted FD can then be passed to a
> library such as openSSL to perform a TLS handshake.
> 
> This prototype currently handles only initiating client-side TLS
> handshakes. Server-side handshakes and key renegotiation are left
> to do.
> 
> Security Considerations
> ~~~~~~~~ ~~~~~~~~~~~~~~
> 
> This prototype is net-namespace aware.
> 
> The kernel has no mechanism to attest that the listening user space
> agent is trustworthy.
> 
> Currently the prototype does not handle multiple listeners that
> overlap -- multiple listeners in the same net namespace that have
> overlapping bind addresses.

Create the socket in user space, do all the handshakes you need there
and then pass it to the kernel.  This is how NBD + TLS works.  Scales
better and requires much less kernel code.

