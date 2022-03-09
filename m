Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8CFC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 03:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEQhVEvE40vVYimYxwMAUGUosVfFFagOCSMfm5OfAWM=; b=YAx09xUzDP+1EvY1DMfGeWgEfE
	SMod0OOTiAw2pheTDtdCPgoFmdF1OAg4n8EsRbIlEsRUBpd2ZRSvAx7TJbVaGU9hlUU2pdAS8rr5Z
	4rM6dDbELyOZKO2aI4uL4VK1X05hPUIzbqrbrXLDZ4PFc/JwlEu/MMP9d3W2JLqq+9NYRH3c/zOMK
	luLHLMlj2h35gRs6QgkzVIRj/AKkRjITjuEzPZp2Aq0wQbzD9WCbDG65XbaRLdIX+dVKsJbpqID7v
	Md7s/0o43dJx43a/r3qEGCzSmb8yMpwmoHVrVIM88StejddDjpUAEvF9Ya+jUaam7E4TA3545MWvd
	bqYA2W4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRmi5-0073Nz-6G; Wed, 09 Mar 2022 03:09:57 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRmi1-0073Na-NQ
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 03:09:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7895C6178F;
 Wed,  9 Mar 2022 03:09:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7E9C340EB;
 Wed,  9 Mar 2022 03:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1646795390;
 bh=jWjiAqrUnpIhrBshclXWWixCzx//buFARMefUyobwqM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Oi2xzryvFZzBEi4JvZWKbqkaByE8vQttZgG8zIbfnUgoNheDANGSfJKw+UioNiZva
 PBhnAnyGTrQE+5pPlT6y2wAwpVFTI2Wnu5l4vRca2nP6GrfRn1gi1yDFaobyxKCPuB
 +loZQ/bexqdSU7TcmOrbKFxEYPr/ukyE7YI5ZSvMke3f5WglBq360s9m2RnPF9DeWP
 V6fxLY/1U7qHBTNOLkiDEtGAr6b92IBIJMNifgmutMP1ZilqMYWXPg3ARnbGEwYmm8
 Sc2acxK3Cm4Wkt5ichIXLW++MATAHZ7PjEB1BQBkTsr83d2V04HM02BunK9xeP9iUX
 /EQx5qiKfz9OQ==
Date: Tue, 8 Mar 2022 19:09:48 -0800
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>, linux-nvme@lists.infradead.org,
 axboe@fb.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Ming Lei <minlei@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: nvme-host: disk corruptions when issuing IDENTIFY commands via
 ioctl()
Message-ID: <20220309030948.GA3949054@dhcp-10-100-145-180.wdc.com>
References: <CAFL455n1WaRxZuqCeQGWt1MVDnK8uUytUsAUVEUV9-LLQYv9gQ@mail.gmail.com>
 <20220308195238.GC3501708@dhcp-10-100-145-180.wdc.com>
 <YifyZ9MoUws/7esK@T590>
 <20220309003904.GA3948780@dhcp-10-100-145-180.wdc.com>
 <Yif8svaBscrL9WZk@T590>
 <20220309011429.GA3948855@dhcp-10-100-145-180.wdc.com>
 <YigVg/URukuwwKWF@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YigVg/URukuwwKWF@T590>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_190953_827016_B28137DD 
X-CRM114-Status: GOOD (  22.76  )
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

On Wed, Mar 09, 2022 at 10:48:35AM +0800, Ming Lei wrote:
> > > On Tue, Mar 08, 2022 at 04:39:04PM -0800, Keith Busch wrote:
> 
> BTW, this issue is actually one real report from one Red Hat Customer.

And the correct fix has always been to fix the application.

> > > 
> > > But the spec states clearly the data length of IDENTIFY command is 4096
> > > and PRP list can't be used, so why do you think it isn't complete or
> > > future proof to validate data length of IDENTIFY in nvme driver?
> > 
> > The current spec says that opcode uses 4k today. What about some time in
> > the future?
> 
> spec change should only be applied on future hardware, which can not break
> current in-market hardware.

If a new Identify CNS were invented by committee that uses 8k, then the
older driver enforcing only 4k mappings will create more corruption, and
then it would be the driver's fault.

> nvme target has validated the Identify's transfer length already.

nvmet provides a fabrics targets, which uses SGL, not PRP. The SGL
encodes the length, so it's possible to validate it.
 
> > And why are you focusing on Identify anyway?
> 
> Nvme spec states explicitly that the following 4 commands can't use PRP list:
> 
> - Identify command
> - Namespace Attachment command
> - Namespace Management command
> - Set Features command
> 
> So it should be enough to just validate these commands.

Why are these 4 opcodes so special that the driver should provide
training wheels for broken apps, yet it must trust the same app with the
hundreds of other possible opcodes through the same interface?

