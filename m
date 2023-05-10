Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8369FC77B75
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 00:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jsnzExyrJlL+W6ZQtPzZuL3D5xvHObXs4CR8CUs7eMg=; b=dzFZrArVAmVNTF01rl2n6/Srj+
	8dGNvkZkBsvPs8ASNM4Gyzgb/EKzD6McqrNugtoj6YVOwtfL3cMTbEaQYsSMo28DY9v8v0aPrqdwf
	v+4qp75CvQkmq4zWgpKOoPqRQ1fxuUDw+29WbHvZMmq6oVrtE2/F4WoGJRGSYcbY3mASmuIhrqfCu
	xSx1kNNPvz5/S0+ez1U61d6OfoFDXYWKlcMhKjZeIzGuiVNYv92v0B+2dmM2tXgVSV3negh6eYGTV
	1IupIDkt0J56mSYY8SXb2p3fS10RkEsYqieI+/0vgdpFOPv5oId1Ej77MC6diLyIHhP/cLuCugwjL
	9YWSteoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwXzO-004d14-2R;
	Wed, 10 May 2023 00:47:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwXzM-004d0g-06
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 00:47:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9F26560919;
	Wed, 10 May 2023 00:47:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 709D8C433D2;
	Wed, 10 May 2023 00:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683679645;
	bh=Sm4bqVFvF/nkgPPA/vc9xjZVyLcIYSr+EKYT7klqGb0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfjKj5P0VuM8wOJ2Sr1i9e5cpetfpvQO4umyJ68hKw0EZO7JCV3pTbL5pKoAl7u4i
	 JE+1wgQiOGkFnY/ZpHxvLYG2l6mS2UB5kIWGy8uBjrUyOEcx7aDa8Y8vFt0ag2kws/
	 KetAqRh9XmlKazdyX8fMjvvNNeptotGVDVuNUaA4K6DIubMsY5VAd/I1DtmxaAUbDt
	 OmQQUaL8Yq+ImqUbxtjWOkeSjeX6dmGTjP2Mx7GHKtXNnpChIaEL8D5ZiglaN4cKZ3
	 ximqTKorAdM5tbolCAhFX4pQlXFfJg36iJhEczzOFAURnu/zgBswxslLOE522v6Gx2
	 /HJuGRFSyJ/1Q==
Date: Tue, 9 May 2023 17:47:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, Chuck Lever
 <chuck.lever@oracle.com>, kernel-tls-handshake@lists.linux.dev, Boris
 Pismenny <boris.pismenny@gmail.com>
Subject: Re: [PATCH 06/17] net/tls: implement ->read_sock()
Message-ID: <20230509174724.4a198306@kernel.org>
In-Reply-To: <da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me>
References: <20230419065714.52076-1-hare@suse.de>
	<20230419065714.52076-7-hare@suse.de>
	<da7135cf-c96e-f79f-9d49-87ee269871cf@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_174728_134299_7C5EAADD 
X-CRM114-Status: GOOD (  14.78  )
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

On Tue, 9 May 2023 16:30:03 -0700 Sagi Grimberg wrote:
> Can we get an ack (or review) from you on this?
> 
> The only consumer of this is nvme, and seems to at least
> work on the limited testing this series has seen.
> 
> We can take this piece from the nvme tree or not, whatever
> you prefer.

Let's get all the TLS patches posted to netdev, reviewed there,
then we can put them on a branch on top of -rc1 and they can
be pulled into both netdev and nvme tree.

