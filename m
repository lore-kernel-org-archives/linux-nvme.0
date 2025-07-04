Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BD7C83030
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Jul 2025 02:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FarKJlvmIvSzBW3L7HpMcZlXycBw+0IDuOFJCXeI2rw=; b=DWIQPBHd3PQidipVWIFHNwzKIu
	ax8R/ccGmtwUTzv3ZnTpaaoCg0pjeIer+8L0ViJc42Uii7XJoz4zfd0Qea9z4Bqx28e9efcv/QJrN
	vumbi+0gZKgkpXeGMql1HyeFNsTuEGqVgKB877J6Hqf7Tg9MkzwnWTPxol61eLv+woHUNfk+CE4IG
	k1lggK/jyvGe3fVf/2FoVQFOWHezLuTI5P52m0CElNrvAVHCSFERpeWU++m8z9TYpew8D4YmaG7qT
	7tVx1D/TQ8bVw5hikEo6O3ewp/4bmlvSEBjCn22JkMGbX6ciEzs2gKyVbTvP7xwsZnw8cIFugvFmU
	+0u9/T1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXW00-0000000D3Vh-49AV;
	Fri, 04 Jul 2025 02:18:00 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXVzy-0000000D3VD-1Yxj
	for linux-nvme@lists.infradead.org;
	Fri, 04 Jul 2025 02:17:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751595475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FarKJlvmIvSzBW3L7HpMcZlXycBw+0IDuOFJCXeI2rw=;
	b=YmL1lOycJsJAWbr1nQWKgmzoY/WJzjnHCJn2SAe8GIi7nqwT3g6bNfFmTj2Rj/3Mb0AVHE
	8D1avTSuzU/xF0vepi6vzgT7f9we6H7uGwvtOkjHT1Y3BEJ1dwNBLNIGuN4v5mcQj2IZNp
	cGXyYxY7yFdz61ZwcYkNGXhOsAG8KUM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-153-c3dXgwzkOUW8Je8pZzNKMA-1; Thu,
 03 Jul 2025 22:17:52 -0400
X-MC-Unique: c3dXgwzkOUW8Je8pZzNKMA-1
X-Mimecast-MFC-AGG-ID: c3dXgwzkOUW8Je8pZzNKMA_1751595471
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4851219560BE;
	Fri,  4 Jul 2025 02:17:50 +0000 (UTC)
Received: from fedora (unknown [10.72.116.40])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B37851956087;
	Fri,  4 Jul 2025 02:17:44 +0000 (UTC)
Date: Fri, 4 Jul 2025 10:17:38 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, alan.adamson@oracle.com,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Maurizio Lombardi <mlombard@redhat.com>
Subject: Re: [bug report] nvme4: inconsistent AWUPF, controller not added
 (0/7).
Message-ID: <aGc5wlj0Vgk6Mf6d@fedora>
References: <CAHj4cs_Ckhz4sL5k5ug_Dc5XfjSo9QDRSrHMfBj2XYGm_gb2+g@mail.gmail.com>
 <6e74e9a8-2dbb-4ad4-a48b-9af40d6af711@oracle.com>
 <20250703080359.GA365@lst.de>
 <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHj4cs_pJDR-VH7-RzGwt9KmNCdTnQ38bejeB72280e9ke8ebg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_191758_485619_217C98CC 
X-CRM114-Status: GOOD (  17.28  )
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

On Fri, Jul 04, 2025 at 01:47:50AM +0800, Yi Zhang wrote:
> On Thu, Jul 3, 2025 at 4:04 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Jul 02, 2025 at 09:33:32AM -0700, alan.adamson@oracle.com wrote:
> > > Looks like the device isn't reporting AWUPF after the format/reset.
> >
> > The other option would be that the format changed the value.
> >
> > The mess NVMe creasted with the totally un-thought out atomics is
> > beyond belive :(
> >
> > I wonder if we should just back out the whole thing and wait for the
> > working group to come up with something that can actually safely work.
> >
> 
> Yeah, the format operation will change the awupf value.
> Here is the reset operation pass[1] and fail[2] log
> [1]
> + nvme format -l0 -f /dev/nvme3n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme3
> + grep awupf
> awupf     : 7
> + grep nawupf
> + nvme id-ns /dev/nvme3n1
> nawupf  : 7
> + nvme format -l1 -f /dev/nvme3n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme3
> + grep awupf
> awupf     : 0
> + nvme id-ns /dev/nvme3n1
> + grep nawupf
> nawupf  : 0
> + nvme reset /dev/nvme3
> + nvme id-ctrl /dev/nvme3
> + grep awupf
> awupf     : 0
> 
> [2]
> + nvme format -l0 -f /dev/nvme5n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme5
> + grep awupf
> awupf     : 7
> + nvme id-ns /dev/nvme5n1
> + grep nawupf
> nawupf  : 7
> + nvme format -l1 -f /dev/nvme5n1
> Success formatting namespace:1
> + nvme id-ctrl /dev/nvme5
> + grep awupf
> awupf     : 0

Per NVMe spec, AWUPF unit is 'logical blocks', and logical block size is changed
by 'nvme format', so AWUPF value retuned from `Identify command` can be changed
because the controller implements fixed-length atomic write size(512*8, 4096 * 1)?


Thanks,
Ming


