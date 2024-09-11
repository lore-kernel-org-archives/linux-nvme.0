Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70CA1EE0206
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Sep 2024 16:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4JqNaJXldq8FIMnfaqDaw0f3mjGTip+MzSYQvZ1NAg4=; b=xSGYPe4Q3i2fYKUh0DBNkS/BmZ
	UHdN6GaffYY6ViHxJtRV9LFL7ND6BBnLzn4uipLcDc0m+oHQK8UA0YaFC6RPRGKc08VjHmh5M0pop
	pOVACPJwm2K+Fc/jBBfdR3UWXNDKKoq3fcwGtbey8uytz9Xf8LE/Li5GJDvavncYP7PndnkgY8Lgk
	/XwaVVn1g+GArUipwsMfkeWXyy7iq1houand95+Gm6Ba2Fj4l1A4XjV0RRNung7eEUJiBQur8c54O
	Pq+VOH4WTo53GI2vs2gdj2Km8mx02zl3bzKpwI0l7XVM1/rY87pjx/GwBYqgF07LA8E9IE14TeaFB
	bFe7r5Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQed-0000000AQ3p-45vo;
	Wed, 11 Sep 2024 16:57:19 +0000
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1soQea-0000000AQ38-2BQq
	for linux-nvme@lists.infradead.org;
	Wed, 11 Sep 2024 16:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1726073830; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZxEQr7sfE3hnAlGVxNnCSRD3qhUOe9vFrxHqJu/d7gDrUAA0C0kOzjh+QvtK3PGEiL1ughI4g8LwfJYtOXmCb1HIN7yGv6ydhJBC7dWaPqlJA4GTCKA2JIKcjC4afwk8EJabc7zVQ4qoAxAC4xyFNBbYuvt+6l1wGnxUbKzthw8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726073830; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4JqNaJXldq8FIMnfaqDaw0f3mjGTip+MzSYQvZ1NAg4=; 
	b=RDFHhx4oZBaxaDr6F3I999QUMX9G+5/oFCCUrevGbwZKY+vYSEAf3Pqo2PXSGx+pGzINxFJBssIetMQr7U8STcmnJTgxpJh1PUtfRg+T4iCoX0N2Z15xuXyDsl+w64lfpph8AbKSiSVZCXWLLjuPRachsCPRDYBdxW6BPheFivg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726073830;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=4JqNaJXldq8FIMnfaqDaw0f3mjGTip+MzSYQvZ1NAg4=;
	b=lQOhV7+Txpb/9vXYKQI/vuiM9YfKVsbvBS3gJJofQu1meWj9gsgAEMEeAzJdzfUg
	b69HtPTjXTzimyy2ikwfEJSxTya9YcpAPEsMKqE0fEId9XHrA/y9yWt2ps7wjOJVn24
	gJlm2Vdev7o64Xu7egQYNh7aqiZmsV/7yoE6am5A=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1726073797935336.22030053810806; Wed, 11 Sep 2024 09:56:37 -0700 (PDT)
Date: Wed, 11 Sep 2024 17:56:37 +0100
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "linux-nvme" <linux-nvme@lists.infradead.org>,
	"Jens Axboe" <axboe@fb.com>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"linux-mm" <linux-mm@kvack.org>
Message-ID: <191e203fd17.118394e2d1606957.7379866259983341167@collabora.com>
In-Reply-To: <ZuCHk6hDxF65v8T2@kbusch-mbp>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
 <Zt9amhUGs9FT5i-O@kbusch-mbp>
 <Zt9bLa4TJT6L75aG@kbusch-mbp>
 <191db450152.e0b28690987786.6989198174827147639@collabora.com>
 <191dcfa4846.bb18f3291189856.1624418308692137124@collabora.com> <ZuCHk6hDxF65v8T2@kbusch-mbp>
Subject: Re: possible regression fs corruption on 64GB nvme
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_095716_649135_8673EBF6 
X-CRM114-Status: GOOD (  33.14  )
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

 ---- On Tue, 10 Sep 2024 18:53:23 +0100  Keith Busch  wrote --- 
 > On Tue, Sep 10, 2024 at 06:27:55PM +0100, Robert Beckett wrote:
 > > nvme.io_queue_depth=2 appears to fix it. Could you explain the implications of this?
 > > I assume it is limiting to 2 outstanding requests concurrently.
 > 
 > You'd think so, but not quite. NVMe queues need to leave one entry
 > empty, so a submission queue with depth "2" means you can have at most 1
 > command outstanding.
 > 
 > > Does it suggest an issue with the specific device's FW?
 > 
 > I think that sounds probable. Especially considering the dmapool code
 > has had considerable run time in real life, and no other such issue has
 > been reported.
 > 
 > > I assume this would suggest that it is not actually anything wrong with the dmapool, it was just exposing the issue of the device/fw?
 > 
 > That's what I'm thinking, though, if you have a single queue with depth
 > 2, we're not stressing the dmapool implementation either. It's always
 > going to return the same dma block for each command.
 > 
 > > Any advice for handling this and/or investigating further?
 > 
 > If you have the resources for it, get protocol analyzer trace and show
 > it to your nvme vendor.

Unfortunately this is infeasible for us.

 >  
 > > My initial speculation was that maybe the disk fw is signalling completion of an access before it has actually finished making it's way to ram. I checked the code and saw that the dmapool appears to be used for storing the buffer page addresses, so I imagine that is not updated by the disk at all, which would rule out my assumption.
 > 
 > Right, it's used to make the prp/sgl list. Once we get a completion,
 > that dma block becomes immediately available for the very next command.
 > If you have a higher queue depth, it's possible that dma block is reused
 > immediately while the driver is still notifying the block layer of the
 > completion.
 > 
 > If we're thinking that the device is completing the command before it's
 > really done with the list (which could explain your observation), that
 > would be a problem. Going to single queue-depth might introduce a delay
 > or work around some firmware issue when dealing with concurrent
 > commands.
 > 
 > Prior to the "new" dmapool allocation, it was much less likely (though I
 > think still possible) for your next command to reuse the same dma block
 > of the command currently being completed.
 > 

given this ~9 year old temporary fix is still in the kernel for the Apple device, could we just add another device specific override? I could maybe convert it to a quirk that is set for them both (and any future devices)

