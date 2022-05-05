Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A7AC433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 May 2022 05:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=20d4hKjJVzRypf5QIswJ7bqEfsq2yOfYFvX+da9JUfw=; b=h+qdo7b2VHqDsOvxy8Tm95/lmY
	vMMS1+Stg5mgTXIX+VSQb5jG6ho2P/5+NCHBiOcmz8Q2jya7sZj5IUJs7KMPFTzs9kzoxm7sAe7D/
	xirop+8g+74sEPgtPBhNToJ8bUlB2zVJG8V98no0phFPNwNZks5z/NpONsoXVQTemUkYZMZXBdrGr
	qMF74baUUVqqe52hWdJp+eVuTSza2T0RcA4WdF9gBCBWh7K6vfU3uazJFKgrAJHDXYwHQr9B0tZA3
	W2nOulH5dGczD451avwiFUtT0Ag6KNNrYYa04RsQLxOEJgD30Mm1/dHaf7Ei01TJzDqH8a6Jkuymu
	UVILXoBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nmTtW-00E0gB-OK; Thu, 05 May 2022 05:19:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nmTtT-00E0fY-S8
 for linux-nvme@lists.infradead.org; Thu, 05 May 2022 05:19:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC9B618C5;
 Thu,  5 May 2022 05:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC29C385A4;
 Thu,  5 May 2022 05:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1651727953;
 bh=CjoysTt4smiT9cYHZROxtXKWyaDUyxzXOQTicMbEYJU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=n7DaK2CI4XjVWFu0mBhCxA8nTRXbsnYsLE53Sp0Nj5ggzrg30/mJGosd00h2nYW6D
 J2TVSCGAuewrgjBy2zlMVTpLCF4P+K2Kh+IenApMvT9Vv1eiJYZBt3BFEdt7x2/Ih3
 4gtJrtifNcw3rP9p/FsHVL0iaakh2aHmnrgjmZTds5cP2kqgbD73XiS9qdCFERz7ws
 IV5PugUFqaYY1m6E+AZAVr5kNEyiMgFOAq3z5QBwcHRTAO3D7LGd4fUCw9h+mlhFMy
 yF4JfnNicUltgXoA8kF8pN/793dvYBSAusMngCWCe7ENNTUUGNE/6kLMGkcsA6LaxQ
 L9cUoKOV5jxcw==
Date: Wed, 4 May 2022 22:19:10 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: linux@leemhuis.info,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, luto@kernel.org
Subject: Re: [BUG][5.18rc5] nvme nvme0: controller is down; will reset:
 CSTS=0xffffffff, PCI_STATUS=0x10
Message-ID: <YnNeTsSzFJqEK/s+@kbusch-mbp.dhcp.thefacebook.com>
References: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsMiKe31UaoMV02gW4iJSKnBiO5jGQKej=Zem24mD0ObQw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220504_221915_985424_4B06391B 
X-CRM114-Status: GOOD (  11.88  )
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

On Thu, May 05, 2022 at 06:58:11AM +0500, Mikhail Gavrilov wrote:
> ps    1 : mp:7.10W operational enlat:0 exlat:0 rrt:1 rrl:1
>           rwt:1 rwl:1 idle_power:- active_power:-
> ps    2 : mp:5.20W operational enlat:0 exlat:0 rrt:2 rrl:2
>           rwt:2 rwl:2 idle_power:- active_power:-
> ps    3 : mp:0.0620W non-operational enlat:2500 exlat:7500 rrt:3 rrl:3
>           rwt:3 rwl:3 idle_power:- active_power:-
> ps    4 : mp:0.0440W non-operational enlat:10500 exlat:65000 rrt:4 rrl:4
>           rwt:4 rwl:4 idle_power:- active_power:-
> 
> # cat /sys/module/nvme_core/parameters/default_ps_max_latency_us
> 100000
> 
> I concluded that my problem is not related to APST because 2500 + 7500
> + 10500 + 65000 = 85500 < 100000
> 100000 is greater than the total latency of any state (enlat + xlat).
> 
> Or am I misinterpreting the results?

I think you did misinterpret the results. The max latency just says which power
state is the deepest it will request APST, and your controller's reported
values will allow the deepest low power state your controller supports, which
is known to cause problems with some platform/controller combinations.

The troubleshooting steps for your observation is to:

  1. Turn off APST (nvme_core.default_ps_max_latency_us=0)
  2. Turn off APSM (pcie_aspm=off)
  3. Turn off both

Typically one of those resolves the issue.

