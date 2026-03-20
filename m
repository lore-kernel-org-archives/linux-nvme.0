Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3328310987A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 16:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VjiJyax6p2EAGaDfM7VCCTW59Gv9DAKxVxjRNq7D7HU=; b=yhSyPA8YyP3+gqz/KlkNl5fiZC
	BF9pgy5/yYl9VCsnsc0mDK3lgEWqnKjp4afn7q8vwm9R/DXkdWzaK+dVL31JXqonIpoehox+QDMg0
	fDPtyX15rLq7zuGTzYC3X0hbYEZsWBxemF3cUlxEBne5jCVXCSNfrAnHZXZjswUjW+jhmk3875Ddt
	l+F8p8UzzRHUNB5FL0aeE6HlvDxlJTeMXbrdTdgf+3n7hf4D19iJvizSmgh6ucLz1oWrp7/PybezT
	QwxfLsBpwsMacl3bmB0WQkXOkGgu78VYWim1mKTVeima1vOnupttTkZGrQPuqf65T5TzHOMLtDM1n
	X9w0HgVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3cIa-0000000D57I-34u7;
	Fri, 20 Mar 2026 16:02:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3cIX-0000000D56Z-3KNT
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 16:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774022524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VjiJyax6p2EAGaDfM7VCCTW59Gv9DAKxVxjRNq7D7HU=;
	b=bHXOlvjyan2kyITMC9DcRHK+rBJNQBQQzdO1cGbywtwMQBKxnNDjDES9PbcYH0X8Bw+sHP
	O/VRd7mRfRkXQ1f/ZZEoRrFuLYdsBTQoVOuiJM4O3TB/P5OIJ2b+bTIqGNa5pdNQv/WSxc
	g4m8UVrBkOilxEMl0mzzhp+dfyqY5wY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-j4vSDgxYPPiWXLRZ4gRE_A-1; Fri,
 20 Mar 2026 12:01:58 -0400
X-MC-Unique: j4vSDgxYPPiWXLRZ4gRE_A-1
X-Mimecast-MFC-AGG-ID: j4vSDgxYPPiWXLRZ4gRE_A_1774022517
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84419195607B;
	Fri, 20 Mar 2026 16:01:56 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.140])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id DD668180035F;
	Fri, 20 Mar 2026 16:01:53 +0000 (UTC)
Date: Fri, 20 Mar 2026 09:01:52 -0700
From: Chris Leech <cleech@redhat.com>
To: alistair23@gmail.com
Cc: hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	yjshin0438@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v4 1/2] nvme: Add the DHCHAP maximum HD IDs
Message-ID: <20260320-aftermath-espresso-2fddb7ef5c43@redhat.com>
References: <20260320002045.1927526-1-alistair.francis@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20260320002045.1927526-1-alistair.francis@wdc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: yUl6HKeQq4fyZDE4kG_KgHKssfEAno8cwvUBFRqeG3E_1774022517
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_090205_903243_E6539874 
X-CRM114-Status: UNSURE (   7.85  )
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

On Fri, Mar 20, 2026 at 10:20:44AM +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> In preperation for using DHCHAP length in upcoming host and target
> patches let's add the hash and diffie-hellman ID length macros.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Looks good to me.

Reviewed-by: Chris Leech <cleech@redhat.com>


