Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8364DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TzUH/+KtUePJm3VvSUD9DMk4PFiOFvsYjPIzi3V1hXw=; b=LSz/YpiVYJ63TATy6wAzgLAnge
	Fxz70QwvxafZs2/i6BN7X9MTVOM8NobCUsoj3LeENXmDYBBJQbrmyaGXelmsM5moaAXeOw2lQPLvX
	1tX5UxDcJDjmfbw3OtuLmy+gBDWanAfs4WaExuZHr+leIyXarO0ChBe67qs7JTldG8OvwikXWc+8J
	PT16l3M+OuZth3S8Y8PCgkui3mo1+TFKkDmE80lxha/ipt8lWmocPzRBApyO49jrixTu/1x7WvlHx
	fe+a2xM7LOsskYZnYbvsD/jTSEiK9cymNW+fSs93R+VsGZdkUrGNmYfTKoSfeLyWsbrOq8ENkAwjl
	RDE5BDWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh52n-007s0k-Kd; Wed, 20 Apr 2022 07:46:33 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1nh52l-007rzx-Uq; Wed, 20 Apr 2022 07:46:31 +0000
Date: Wed, 20 Apr 2022 00:46:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nitin Rawat <quic_nitirawa@quicinc.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Message-ID: <Yl+6V3pWuyRYuVV8@infradead.org>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
 <8b2735c1-4207-dc1b-45bc-33a4138b57cc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b2735c1-4207-dc1b-45bc-33a4138b57cc@quicinc.com>
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

On Fri, Apr 15, 2022 at 02:29:27PM +0530, Nitin Rawat wrote:
>  1. Adding a flag notifying nvme driver about the d3 support or not - Adding
> flag to PCI bus will make it applicable to all the child devices of the
> RC/bridge and that would cause problem as this behaviour is only applicable
> for nvme device for now. Any suggestion
> 
> to avoid this?

This seems like the only actual sensible option.  Why would you want
to avoid it?

