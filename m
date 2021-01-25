Return-Path: <SRS0=SsZO=G4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3722FC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 17:58:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D741722583
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Jan 2021 17:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D741722583
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0f8G8EkvVX8Mcb2G3BKdV5HNMDblmrKqRjT0Aw5gQjo=; b=gsLgMvIeFz3A/qtDGUwyGl0N+
	X0I/5x+SG5Pq1MU1pSefcVGwlyKD3FRRrUyVNvBf1whn7tLKqSEJCoCmu2CYMlFIuROiMihg4g5+d
	zOAxkbOqXnGqjKyHCh6Y9Bch6thkwHV4Y5s2EyTBQwyxSiO93iNRvnnN+uk/Hv/qqXxQDexrv3zKJ
	sAqckyhI1ZzK/VB06fPSv+ghPs6R7oKAUlFA0004gnNbJ2S13OAinSxsB6biX05SmpFtFr9XfvL7P
	Uen8qzxgdntYNKJfdjA31dryDDZlIe8AR/EP6UYb9AlnyaqCFd1gyZTc2JJZIHg3jetZ5zjcRWy0q
	wb9ZXfEDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l468G-0002vi-KW; Mon, 25 Jan 2021 17:58:32 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l468E-0002vD-G3
 for linux-nvme@lists.infradead.org; Mon, 25 Jan 2021 17:58:31 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 152B222583;
 Mon, 25 Jan 2021 17:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611597509;
 bh=3hi8nRYiYvyuhhmY7026Nd6wmPArs+Twqy+DKNlt5qk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=F6Hs02xNXceXrRLSWanN6kqkMIFBNnogGXke23eTq/E4wKZdbY4ROiDpRSCZW8f4H
 W4oPNj8BYLXsHBaGscSCo70jDSiquSro0jQz6ZJWKeGTlGtPqJNXtb5HFGsnHX336c
 iacbadzhScWgkc90QH+Pw9EKJKRwi7gkDosVnKUr3gNMwAAjKoGaW3tEyu17eHYIQo
 iDt4jcDBK1o8cPY6Zy9stXUGfQyK0ngltneafTKCWsM2Y/Y4W4Qq4M/RkIKvaUQmVm
 JgWkAZNag6MCo30rJG+DwkwoUvg0NwPv79d+tMaWq8JGbY2yI4MWvqaxuJ4etgL6V6
 JmfuJs9cY+Lxw==
Date: Mon, 25 Jan 2021 09:58:27 -0800
From: Keith Busch <kbusch@kernel.org>
To: Claus Stovgaard <claus.stovgaard@gmail.com>
Subject: Re: Missing or invalid SUBNQN on Corsair MP600 1TB device
Message-ID: <20210125175827.GA1732047@dhcp-10-100-145-180.wdc.com>
References: <04fdb6a116bbc4d9eadc3f9434d8b6f2426e3c57.camel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <04fdb6a116bbc4d9eadc3f9434d8b6f2426e3c57.camel@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210125_125830_610809_88B5EBFC 
X-CRM114-Status: GOOD (  18.31  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jan 25, 2021 at 05:00:57PM +0100, Claus Stovgaard wrote:
> I have just build a new workstation, where I noticed the following
> warning for the Corsair MP600 1 TB drive.
> 
> nvme nvme0: missing or invalid SUBNQN field.
> 
> it arrived with firmware 11.3 and I have later upgraded to firmware
> 13.0 to see if they have fixed the firmware.
> 
> Have also reported in their forum
> https://forum.corsair.com/forums/showthread.php?p=1077109#post1077109
> 
> Looking in the host pci.c code it seems to be a known issue on some
> drives where the "NVME_QUIRK_IGNORE_DEV_SUBNQN" is used.
> 
> So I guess that Corsair MP600 is a candidate for the same quirk.
> 
> Considered to add the Corsair to the list of drives with
> NVME_QUIRK_IGNORE_DEV_SUBNQN, but would just ask here first, if it
> would be the correct use and understanding.

Yes, that is the correct quirk to use with devices reporting spec
revision 1.2.1 compatibility but are not compliant with the subsys nqn
field. The device should continue to work without the quirk, but you'll
get the warning.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
