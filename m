Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A989CF9C6C
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Sep 2024 15:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wP4zYyMKjvlQqzXGlg5uCLR5n6bTMrhjrcsn7/FxxMU=; b=WdjkeO2iRZXREDoJED9uSg24OD
	n2fnw/fs+fPRZ1un46trxp7r5OyKSTFVMnuo5b49Epzs62YF5qefajfHVDYYKaW0K5+PzDscfAiwJ
	ZDY5w9ipu92pGDodNQYY+QYKQkcvkP2O0FX7t/1IhmqRvWBmp3XlBdPITeBzJK/eXlz/1hLIEvEsr
	R2JD0ZmIkzpUUwiyEk0nf5RET0/cnyKsMHqdwUsqLEfDJd2H2Gy58oBnBHqtMEvL6CfPoPP5YBNkK
	8uqm8THhJfI5TeAJI+cFhAD+IJYZhUun/6xQuPS3485sM7yqIyQFjpBXk2ya2lX4i/n6XJE27Biu1
	f9iaSDcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ssOTe-0000000FLvE-2PaY;
	Sun, 22 Sep 2024 15:26:22 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ssOTb-0000000FLuZ-1pkI
	for linux-nvme@lists.infradead.org;
	Sun, 22 Sep 2024 15:26:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D30ACA40F03;
	Sun, 22 Sep 2024 15:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7365EC4CEC3;
	Sun, 22 Sep 2024 15:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727018777;
	bh=wP4zYyMKjvlQqzXGlg5uCLR5n6bTMrhjrcsn7/FxxMU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m29AhtuJU8gbL+qn+1MzcP5zEHmbdZNMTaKsqMXx0u3+qGJPDSG/mNPSiV9Ts/v+8
	 BY5ZzthkKwUn2rSHUGp8eF1T92eH6Eoi8vby097gAasOasFACW4nY1M9369Q6QpjyU
	 kaBAtiJPQ6aIeOJ0yYszHd7iFmdJDhQbMh+MnAS4Xxe8JEZjel2WsAbGO+oGI1+vWq
	 SRrCuGlRFGHC0K6JWq0vqZdFWEO3/LWkc9UBbGnH8zdEPJCV81Yzc/LuaQHA1EH1l6
	 y1hBA4iWF0ptIf6Ycx2NLyy1lSgNGf4xez7B7ImHlIfcNxYqYRvdckoHxMFlm2TETg
	 UBQUxu1YRF8jw==
Date: Sun, 22 Sep 2024 17:26:13 +0200
From: Keith Busch <kbusch@kernel.org>
To: Tokunori Ikegami <ikegami.t@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-sysfs: add 'lba_shift' ns attribute
Message-ID: <ZvA3FbEIWC-crwmB@kbusch-mbp>
References: <20240922105621.4642-1-ikegami.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922105621.4642-1-ikegami.t@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240922_082619_564570_6B5E6F06 
X-CRM114-Status: UNSURE (   7.29  )
X-CRM114-Notice: Please train this message.
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

On Sun, Sep 22, 2024 at 07:55:42PM +0900, Tokunori Ikegami wrote:
> This is to reduce the identify commands to get the information.

This proposed attribute is redundant with the request_queue's already
exported "logical_block_size" attribute.

