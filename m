Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B94C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 14:53:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B566761428
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 14:53:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B566761428
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GupYa0nTIeE25bs3AE9haHD1Wr4ngFwrUTCkBooYrFM=; b=qfYREQ6vIio0P81NLgIPh0mEe
	zKZPKr7fXVic+sciUDjkQEaoqa1rncVVvNm+cII5RUTY4hs4rL84gVXvXPawFlPfIY+GNqIpu0qeY
	LbXVbVhH3QR929IpOoAcjvxe0svtu27Kjsg9Q/CQN2JA3TAMlSHlYlM8IGRQd12A6Y6+IHotD3apk
	YItYdopern7Y8rBp/MbIOOyqyufSdj1YsbFHIgSnW+kDW3JYKYYYharzwPkFLJv8sSm9kUtA7MNvV
	+ysbRZO+GHxVAivAKZIRvtnesNm/G9FQCRAXVCyC2EiJF7TP0ltYXnEdg+8w/P7ABu1+I0WnnK0uk
	zvBFnWF7w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgqF4-0035Hs-0L; Wed, 12 May 2021 14:53:42 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgqF0-0035HG-G7
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 14:53:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=uDSB6ZqUBOzWwWnKN0RiSydcUsr2CXxto2tXUsJDJww=; b=B2lDR1ZRHZc947v8QMW9frGVh9
 K4KLfknF8q0fwEMMBWQlXiSJe389324Tptvw2nV6eF+lZMSM7h0OTzMInpk5RMi/rUQjrCwlttPt2
 tn1/T1KpOF0+I6FqeYdAmmqwlLPZ4c0Qb4KW9Rq25WGVYVellwHQleNItBtQrXoT8Gc+zfLAtbF+Z
 teG4wxedKnB3S+djvPC1GVENnLrP0UPslrswMLPBgZT731ZV6MjZyHmKMSzzh/LDppPZABsullH+W
 WHNk8xh278BR87EUwkZLIY6P0+qtwKTOCVhpK6GriRRhBT21MHOqj61pFJ7+wBjkTFI2gU7jPXrVy
 gXWHRvYg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgqEy-00ASzQ-01
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 14:53:37 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1620831212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uDSB6ZqUBOzWwWnKN0RiSydcUsr2CXxto2tXUsJDJww=;
 b=cRE+aTtAE2BmxQmtUN05dK5TG/bWvhRXzUKO8O8WQxTbD0A3Zp17+trPlMzgS0e5sAYMfm
 F6PrrZwnfoYkBbo4pPXfPuB2Pc7JU+dn7mqLObLP+O6QS12BOOUkVjDHVhQpp4yK23m5pJ
 mSQ/StFmf9DMQPo3hgHhZ2V6CEzVnkw=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0B023AE81;
 Wed, 12 May 2021 14:53:32 +0000 (UTC)
Message-ID: <bc0a9cbf4567ee3ec96615fec56cd4899d5d496e.camel@suse.com>
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Date: Wed, 12 May 2021 16:53:31 +0200
In-Reply-To: <20210506134823.2566853-1-hch@lst.de>
References: <20210506134823.2566853-1-hch@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_075336_206183_AFB835C2 
X-CRM114-Status: UNSURE (   9.10  )
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
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, 2021-05-06 at 15:48 +0200, Christoph Hellwig wrote:
> nvme_init_identify and thus nvme_mpath_init can be called multiple
> times and thus must not overwrite potentially initialized or in-use
> fields.=A0 Split out a helper for the basic initialization when the
> controller is initialized and make sure the init_identify path does
> not blindly change in-use data structures.
> =

> Fixes: 0d0b660f214d ("nvme: add ANA support")
> Reported-by: Martin Wilck <mwilck@suse.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thank you. I'll prepare another test kernel for our partner.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
