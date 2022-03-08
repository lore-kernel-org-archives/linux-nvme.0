Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13717C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 20:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=108dqffMngjZn1OR0xjgn4e+T9q6hsFruvc4kcZgz/I=; b=QdyMjKoNTf+MEvPQ+qSibg3e8o
	DWu3h5fqmosQ4iYl0EvTC4KrSYKVfOAztOJwahhSqxKTs+vYW9kFkIbnkbgZDu6ErtoqUvE8LU7vn
	SKpTXWplsEYI2WhM7RLbcG12LKzn+iiHVJvUt8Z15eIBhabWWVfN922Q77np2dG5IZEV8PrxCE75x
	XFixdAw6YIhjI661JxMpBDqZ3rpsNysq76Ts8/3gBi3/5zMDMtaxZiI0ylwciNhNfkHQZWOhtOdje
	bNasxJ/GgZnzfNbEcJymfAhi0L6z5JPPna6fNG94ne3SHMqDSi8rrEX2PO9fd1ACcFRB2mpYm7NAs
	eaixZ6Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRgQz-0069Ep-FC; Tue, 08 Mar 2022 20:27:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRgQw-0069EI-Pw
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 20:27:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 56827617D2;
 Tue,  8 Mar 2022 20:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31323C340EB;
 Tue,  8 Mar 2022 20:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646771269;
 bh=VzSyeoZJbdPe2AzD8QPLoUveZcdiFjPQE9WsdiQ7g64=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=UX3bsgkbhYNKFLhW6b9QZsick5aHN2KZXsQ5gWuXEb/Nc5Tl3IsVpdlLy7FRwiTvP
 lQwdd4xStb1vMDfo29yU412Ia/k0g68LSVBZ8lri9ghY23rkjYZcWJTeV6qt08CtTU
 PPhQc0BgNkrZSgPlKdrJYDS70+h7WqR7+o6vOEepQ2Gap/b4qbi8dQb1fc6SwjHb9U
 oPOEQ5yewJWq/f0lMmPM+rAqnefTyFxrKFwOoVfiMYnnkt8Lo+FZbj2qpKDHRpFZT8
 Z1pOyYya6BXFhmsfyKR/fCeTnR/bVQk1GLDqPeO8XLGTBhJ2hpzlseAKtbTKoJXOzA
 8UgUMNNuRwovw==
Date: Tue, 8 Mar 2022 12:27:47 -0800
From: Keith Busch <kbusch@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com
Subject: Re: [PATCHv4 6/8] crypto: add rocksoft 64b crc guard tag framework
Message-ID: <20220308202747.GA3502158@dhcp-10-100-145-180.wdc.com>
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220303201312.3255347-7-kbusch@kernel.org>
 <your-ad-here.call-01646770901-ext-3299@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01646770901-ext-3299@work.hours>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_122750_899789_7FFCA6B2 
X-CRM114-Status: GOOD (  12.34  )
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

On Tue, Mar 08, 2022 at 09:21:41PM +0100, Vasily Gorbik wrote:
> On Thu, Mar 03, 2022 at 12:13:10PM -0800, Keith Busch wrote:
> > Hardware specific features may be able to calculate a crc64, so provide
> > a framework for drivers to register their implementation. If nothing is
> > registered, fallback to the generic table lookup implementation. The
> > implementation is modeled after the crct10dif equivalent.
> 
> Hi Keith,
> 
> this is failing on big-endian systems. I get the following on s390:

Oh, I see the put_unaligned_le64() in chksum_final() was not the correct
action. I'll send an update, thank you for the report.

