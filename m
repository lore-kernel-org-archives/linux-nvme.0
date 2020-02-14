Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F7C2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0942F206B6
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SJEO3ZZ4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="W21DxCIz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0942F206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6Zz7IBtBf4kXqkmjcgO/ZOYsdPapqVm49ZVSNmI49tw=; b=SJEO3ZZ4Pan2S7
	x3NW47MzkJSifEKaE7IiIiO5mX+TiW60Y8lzLZ9cCXN8Utu3aCc62t3kXpXjoBG7m3McxNwb7JMuN
	0OKObXNx0R3FN+g1YFuC7skiVditwzmKk3YjqiGYQCzl9T/FiMf5MOsb8aOMDZSCaphSS4r89Am9y
	Ql8SDaSh0NeUREPPTLjNdoMgE5TcRjAvtLS8glmfgrvsGieNKMl/uqZ/Dz5CFu6uF0UHPWXm9cuJo
	xs+K76W4zEGRKHccFyXkFxWfAla9fzjkssPV0oNglWQwbeP4agLqKgEopbHMhknnAtpHJrgng7eqR
	VkaBz1GI0P+b08LFFYBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2brn-0007MS-MU; Fri, 14 Feb 2020 14:22:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2brl-0007Lr-8o
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 14:22:50 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 78756206B6;
 Fri, 14 Feb 2020 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581690168;
 bh=3ZnU/ngbxru0mZrNhE/JQnKFg7M5dmh+U895A6Mj3ws=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W21DxCIzomhMYXbg6/tbtz6/CGrjQLT1tMUouGCrcHQ4m68hLZ58UQPeOj5lYdSzN
 iDnv0PdwPd5wh1kMxImjXEjkCc494RxzpeALqJ+kI0wk30K/g7LRtekUjkD+q+lRne
 h0oq3h36orSvQ1RQ85UchwukOIeuUhBfU/sYXuw8=
Date: Fri, 14 Feb 2020 23:22:42 +0900
From: Keith Busch <kbusch@kernel.org>
To: Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-cli: memblaze: change to 100644 mode for
 memblaze-nvme.c
Message-ID: <20200214142242.GA9819@redsun51.ssa.fujisawa.hgst.com>
References: <20200116075658.24938-1-yi.zhang@redhat.com>
 <0385dd9c-5b8f-c5e7-92e6-4ef70c25573a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0385dd9c-5b8f-c5e7-92e6-4ef70c25573a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_062249_326628_CCB1F705 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: jian.ding@memblaze.com, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Feb 14, 2020 at 07:07:21PM +0800, Yi Zhang wrote:
> ping
> 
> On 1/16/20 3:56 PM, Yi Zhang wrote:
> > Bellow WARNING observed with rpmbuild -bb rpmbuild/SPECS/nvme-cli.spec
> > *** WARNING: plugins/memblaze/memblaze-nvme.c is executable but has
> > empty or no shebang, removing executable bit
> > 
> > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> > ---
> >   plugins/memblaze/memblaze-nvme.c | 0
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >   mode change 100755 => 100644 plugins/memblaze/memblaze-nvme.c
> > 
> > diff --git a/plugins/memblaze/memblaze-nvme.c b/plugins/memblaze/memblaze-nvme.c
> > old mode 100755
> > new mode 100644

Thanks for the ping, patch applied.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
