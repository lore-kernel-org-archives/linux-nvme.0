Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29654F43830
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdpU36ytRDyTPClt0FPAhPcCtyommbNbu/0VUzq6kyw=; b=IfLsOUiNJgJx7RRNz99mQHRvpZ
	NmTZkMyp/gYcNfGABUHKmmzXlz1JkVpo/p94Qn70xEXVBA/UYSrISQCk/5n1Aydn2A4/W7oTydqTa
	B+2HzmvMquIgtnCwnKZaQY/ZTCkiTCWZ/dN9rkrt5jbRdivvfEUv6wo+ENVguhfq1Nu7qTWH7jIYq
	ImVVjoL81xO5S6uO+IpsFcvqIKd83jFAhKLcKPjD0ogmaf9v+Io+LknwvWjNIyjlm1lDgduWeMx6C
	XON8OO2KsWu2ZsDEc0taR7Q34LBqiMlzyJJqOZ5nYHSpWGEky5yaxz/YG6rmR8g9RwK/NdjX6jrAK
	FHLlcqbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD1T4-00000001FiT-2GKQ;
	Wed, 15 Apr 2026 14:43:50 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD1T2-00000001FiF-0jeV;
	Wed, 15 Apr 2026 14:43:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 19BA8600AE;
	Wed, 15 Apr 2026 14:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00294C19424;
	Wed, 15 Apr 2026 14:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776264226;
	bh=9i7ucr/FPUAUV3jCqOGxaNo9oFryZ+19C0hp4xTZ5Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gqaN5N0y3dhQK5sTEFWhpO1r9tU761vPUZi8owXkbkxUuCf43H9sZDCxMQZy+f9KN
	 mI6BWzwbN5fafhk4e0A0FZmPVZfU/83bpV2JDMENoxCy6OtFpBhXFnPLmTDBhzCMQ2
	 60H817fc34qGrVXhEon5JM36u3tcIdep+7IYsRDzPBgvnw55PNyNTQ9+mSpXcgUMHk
	 eCI+X0VCixYvRAkUd1nvJ4HPGJJ0H1PRRyz+GiN5I3yEPZPALet5kVgptTRgS+NaGM
	 paz8nA3yapGK7dgXQQ1axdzJN7aagQ7fdKoKwfCQIqT6liWjnzO5xslrZwPwAveuPT
	 WvU1oD/9PLUcw==
Date: Wed, 15 Apr 2026 08:43:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: =?utf-8?B?7KCE66+87Iud?= <hmi.jeon@samsung.com>
Cc: "hch@lst.de" <hch@lst.de>, Justin Tee <justintee8345@gmail.com>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"sven@kernel.org" <sven@kernel.org>, "j@jannau.net" <j@jannau.net>,
	"neal@gompa.dev" <neal@gompa.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"justin.tee@broadcom.com" <justin.tee@broadcom.com>,
	"nareshgottumukkala83@gmail.com" <nareshgottumukkala83@gmail.com>,
	"paul.ely@broadcom.com" <paul.ely@broadcom.com>,
	James Smart <james.smart@broadcom.com>,
	"kch@nvidia.com" <kch@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?7J207J2A7IiY?= <euns212.lee@samsung.com>,
	=?utf-8?B?7Lm47LCs?= <joshi.k@samsung.com>
Subject: Re: [PATCH v5] nvme: Skip trace complete_rq on host path error
Message-ID: <ad-kIPLsGO7iv8y0@kbusch-mbp>
References: <CGME20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71@epcms2p7>
 <20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71@epcms2p7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260415084107epcms2p71b9c0d252180653ab96a9f5f2121be71@epcms2p7>
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

On Wed, Apr 15, 2026 at 05:41:07PM +0900, 전민식 wrote:
> Hi Keith, hch
> 
> Gentle ping for review on [PATCH v5] nvme: Skip trace complete_rq on 
> host path error.
> 
> I agree with your propsed approach. Should I send a new version(v6) 
> based on that?

Yes, I hadn't seen an updated patch yet so was just waiting for that.
Or was this one on me to submit?

