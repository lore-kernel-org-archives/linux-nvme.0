Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF7FC54E65
	for <linux-nvme@archiver.kernel.org>; Wed, 21 May 2025 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lW3ReXr28mziMMAVZKQaxhHiyMhdGU1e8eWRwn5YoEo=; b=RH1YraJV5B49r77nep5OvDxGeW
	hmvQRw28Qe8nYAbZmehcP0XszoQd6zdX0/PRX/FalhGs9KqEHSDGKR3cQem+cud/96uSoDdku+z5E
	b1NCrzABwHL3YJiD1VFROr2JHIhs/FF0MqCge545U3clVvAkdV7BpGbj/DFgWWcXc/Gn3DW1ps47h
	gqeUuvVUOxpM30FDVAYjWwMC3h7JOqbet9VGFccwrS+GiK6gqsHHJ4SKBwS8dxUogQdH4kM0of+yR
	wGeQcq7extgZeYk4DYUKryVbjlh9RVMlHb/a2GpwjpoRhDiqaUDG3w56l3E/nRGMLQYWUr5GgYrNf
	bxovHr3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgsl-0000000FWKE-24Eu;
	Wed, 21 May 2025 10:41:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHgqH-0000000FW8q-22NR
	for linux-nvme@lists.infradead.org;
	Wed, 21 May 2025 10:38:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 992F5A4EA1C;
	Wed, 21 May 2025 10:38:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD53C4CEE4;
	Wed, 21 May 2025 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747823912;
	bh=aP22tRhItrix52YIZPiTVvPDKBs7jZe4Es3e+EjKrVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R+hXcp8pAKKzCs00FWgYrnC8O7yQAa8uVeh8w3VdkVwNpenLYkEnJri4VfxQGgUmX
	 tPbGB9gAE3C8CQrTF2evARCW2FebIqh0P+lgHT/0Fab1flj+/psCo42ZMn8YD0yz0l
	 wb0ZX64Io59BhUdN/RX3a3K1CRwCEgbG2oDjdQR2G5BeMFTQu9ikyRT231aTCKl3ZY
	 VxHFef/Sf2BpBItLSxucJR4RTvN1MfErTfsiY2WVFQpbmfYyQr+CasunfF++egf9ex
	 N/MC8zR+ATZXZPfbD5ynphUE6BnlsFTbwKudgIqlkY2+GhiMglr9mFXuP69RYKtfYp
	 RVDtb53gCEOzg==
Date: Wed, 21 May 2025 13:38:27 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Bernard Metzler <BMT@zurich.ibm.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of
 __skb_checksum()
Message-ID: <20250521103827.GK7435@unreal>
References: <20250511004110.145171-1-ebiggers@kernel.org>
 <20250511004110.145171-5-ebiggers@kernel.org>
 <BN8PR15MB2513872CE462784A1A4E50B7999CA@BN8PR15MB2513.namprd15.prod.outlook.com>
 <20250520131841.GH7435@unreal>
 <20250520151817.GA1249@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520151817.GA1249@sol>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250521_033833_586249_6991B84F 
X-CRM114-Status: GOOD (  14.73  )
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

On Tue, May 20, 2025 at 08:18:17AM -0700, Eric Biggers wrote:
> On Tue, May 20, 2025 at 04:18:41PM +0300, Leon Romanovsky wrote:
> > On Mon, May 19, 2025 at 09:04:04AM +0000, Bernard Metzler wrote:
> > > 
> > 
> > <...>
> > 
> > > > 
> > > 
> > > Thanks Eric!
> > > Works fine. Correct checksum tested against siw and cxgb4 peers.
> > > 
> > > Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
> > 
> > This patch should go through RDMA repository, Please resend it.
> > 
> > Thanks
> 
> It depends on patches 1-2, and patches 6-7 depend on this one.  So your proposal
> would require that we drag this out over 3 cycles (patches 1-3,5,8-10 in net in
> 6.16, patch 4 in RDMA in 6.17, patches 6-7 in net in 6.18).  Can we please just
> take the whole series through net in 6.16?  There aren't any conflicts.

No problem, if it helps.

Acked-by: Leon Romanovsky <leon@kernel.org>

