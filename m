Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136F1C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 20:06:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3EE613D5
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 20:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3EE613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=CC/uv45qzCStG9j7Fkin+tRYN/gPmEefWIGMoBE0WYw=; b=eqFVkiBP7TFgf5sUY/vcH6zZ/
	vu7WnRS1YlAZI9SOmSqTW9wZK5FuU11TAYrMMTc/1b71imx0eofLXXG/2HZRyW4ki4RJCLJ30x/9P
	s2XMKQQ77RGzJTMsiDV1ZfhaErbY2dUrDXHBTPsf6oUy90XhprjKunjJol/04KCpTzSsxHome+Stn
	itUOGZwtpS7KsrAFOIRKX5JoaU9gN+O762MC8Xt34+HoyQa1bSYCqqJz0/TfYVwylGG2tElvG0hGI
	UmwVtduCamnzmlzQtI4YqYtfIaPrnPI/7RtXwIqXvMGHLasITH7qagYTP3RVelhSAtloaC7u/UxzG
	lPf8rjrhw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYwcq-00CzGR-EE; Tue, 20 Apr 2021 20:05:36 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYwcm-00CzFt-54
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 20:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=KCz/9VhFslr2D/ubUE/EIY9hFTDoeOOjGpfNkCj3lTg=; b=BfvMd/hX36P30LemNxBTWeKmUk
 j6zYOxm1KrsfzD65hACwI98/9ppipIiqA1v564uT7BM3Obv7lQt3K/aqYnqWF0SPND/PAcZowD820
 DCTIEi/wRdBjmX5Sv0BdhWt8zvuuCY2fP2l/1EK96JEPatw6sZd+LRWCWkmYQ0m7aS4OgoGJT9ODz
 DwJ1BeXOwRKe0h33xxhQ0lHTx7vFpEgWJaIQlJ6i3fymAEBDKdn68neAZOHAZkHkhvvFVeVS3QvZc
 2sZAFD2NK2mnDXsfRPvt5Srb4QpyUIbJXSJocg2QwSI3Iat+KDaUKiWLe8Qce8S5YbV+wPnUgjNJ2
 VNRSJZRw==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYwch-00CORn-1a
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 20:05:30 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1618949122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCz/9VhFslr2D/ubUE/EIY9hFTDoeOOjGpfNkCj3lTg=;
 b=r+4LMErhSSqLb1nZ5RwoHg8+HRlvzi9di8ZoDEFRPuL+uHknlANRY5UQPlx8F6xgEeIFdX
 b/IgXcfFsAn5JgpauZFIpn/FYUiGqYjVddBAFTrAZzEKMrcjDu+sFo2+hBr+OACqgj6KhY
 gAM6XVBoO5eSDR+GAHsBK9JDQV30xkA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id E9940AEA6;
 Tue, 20 Apr 2021 20:05:21 +0000 (UTC)
Message-ID: <855d6f8ba89d03fc06466222ecd04f950b6eaa02.camel@suse.com>
Subject: Re: [PATCHv2] nvme-mpath: delete disk after last connection
From: Martin Wilck <mwilck@suse.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org, Daniel Wagner
 <daniel.wagner@suse.de>
Date: Tue, 20 Apr 2021 22:05:20 +0200
In-Reply-To: <20210420143906.GA19417@lst.de>
References: <20210416062411.47958-1-hare@suse.de>
 <20210420080527.GA21651@lst.de>
 <b5dc2cdf-fcb0-8ffc-8ea9-c77d32561043@suse.de>
 <20210420141436.GA14300@redsun51.ssa.fujisawa.hgst.com>
 <20210420143906.GA19417@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_130527_255334_A9A71326 
X-CRM114-Status: GOOD (  12.26  )
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

On Tue, 2021-04-20 at 16:39 +0200, Christoph Hellwig wrote:
> On Tue, Apr 20, 2021 at 11:14:36PM +0900, Keith Busch wrote:
> > =

> > The end result is also how non-multipath nvme behaves, so I think
> > that's
> > what users have come to expect.
> =

> I'm not sure that is what users expect.=A0 At least the SCSI multipath
> setups I've worked do not expect it and ensure the queue_if_no_path
> option is set.

For dm-multipath, this only holds for the case that all paths are
failed. But if the last path is actually *deleted*, multipathd flushes
the map (tries to, at least).
 =

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
