Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7EAC636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qb9JP823hdGYl9ANoaVR+km395HqPK8w5FHA/GgGoHA=; b=SE6E0ldX2lt0rA+jBd30r0q1ax
	W3g8GuVrODiovwcxWQp2kfyp28m6HydHkL+9MhBTBxk6xHIznWZXBygUCkzH+Uq72cumF5ZKwcySp
	zEeqq0IuCTNLUYeSS7acEQp8CoaPnV6Bl4K6eLqbxd9Venz2T+bHxPa74uai0YDlTD4HraxlcqtPg
	wpsv1bbER2uf643OPR5uqM6rgMggw4jctp4VdZlRTXtj5onMw2M23LlVXPonQDwaJoN2yIQt25D3H
	HWE5MfF11Fm+j5iCtbPUKYlCGf26rsoe5l5kzCqYGsyjG3ahBwS2bru2Mw1jAFDBhhzWfl79Lwb3j
	SeVbS1pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRbky-00FUXo-NA; Mon, 13 Feb 2023 16:32:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRbkv-00FUVU-1C
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 16:32:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D4B04611B4;
	Mon, 13 Feb 2023 16:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A23DC433D2;
	Mon, 13 Feb 2023 16:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1676305959;
	bh=jjJDnTGjSXiaZuauJy0MSaY+8liiwCBH6sz7siUAAPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=El2YPMQdAetDuoea0FE4scf3ht15x3CSpePb62Ly/KCVmi7zLq/ReTZMMlOkOH1+z
	 xOSlnwyeFWl+4A1EYzVxjWcFdx4XN8TNAn+jaWFjKE8xBNRT45SIpGXQpetKAbyIkZ
	 quVDZnsHyH8HM/0jyF7STWQ519WKZdSBLzq7WgTbdhotucZLNIhzDiKK5bl5LmD+IB
	 Ex4h7m84DKxn5NYU6lCkTnZJU7aFVafgMQNx3UE31Wn4PKmM9iWu8fA2GT667GYZLn
	 qP/4wofPMFs3Dlztrh4G03uiG4dJKT2Y5WmNXgE3s2TWSfe4g+Jwnr0/0p95ybgS4i
	 Oz7MjD3K38HkA==
Date: Mon, 13 Feb 2023 09:32:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@infradead.org>, Ming Lei <ming.lei@redhat.com>,
	John Meneghini <jmeneghi@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme/pcie hot plug results in /dev name change
Message-ID: <Y+pmI52Ahfn/hF6m@kbusch-mbp>
References: <472fe309-f0f9-65bf-1ad1-8a92a349e973@redhat.com>
 <Y8sKv7q+UEbz5ddD@kbusch-mbp.dhcp.thefacebook.com>
 <Y8uN4V8uW2qS+xHR@infradead.org>
 <Y9ZKNb4UKwg5zF4j@T590>
 <Y9lEF7oY+aQw2POp@kbusch-mbp.dhcp.thefacebook.com>
 <Y9nPa2ZBc80g2LcA@T590>
 <Y9oGTKCFlOscbPc2@infradead.org>
 <Y9qT45LPnkeL8fkH@kbusch-mbp.dhcp.thefacebook.com>
 <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2205fb9d-f887-dedc-04c1-06190dc51413@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230213_083241_192838_A49C0530 
X-CRM114-Status: GOOD (  19.69  )
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

On Mon, Feb 13, 2023 at 04:01:03PM +0200, Sagi Grimberg wrote:
> > Also not sure if this is going to work out, but it looks like a good start to
> > me.
> > 
> > Instead of user pinning the virtual device so that it never goes away though, I
> > considered a user tunable "device missing delay" parameter to debounce link
> > events. New IOs would be deferred to the requeue_list while the timer is
> > active, and then EIO'ed if the timer expires without a successful LIVE
> > controller attachment. The use cases I'm considering are short bounces from
> > transient link resets, so I'd expect timers to be from a few seconds to maybe a
> > minute.
> 
> Isn't this equivalent to dm-mpath queue_if_no_path or no_path_timeout ?

Similiar, but generic to non-multipath devices.
 
> We can keep the mpath device around, but if not, what is the desired
> behavior from the upper layers?

I don't think we're looking for any behavioral changes in the upper layers.

