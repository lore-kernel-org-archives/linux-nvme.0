Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80FFC433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 22:21:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424F664E25
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 22:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424F664E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s1sT+gHwEA4C3nEN4pCoCCTdavAtIfo2XFtDRY/kB34=; b=XhrLo3OGvxPMdR7IP/kUfUB03
	aYiLcmKQIchX/gs7ZYpA5Uv9mzZ5hw6hw5/Z1t4twkC2Aoqh15lEbU9oXYQtOHWYY8seSri7dGPen
	4rtC0r1WureKKZy6OJjwTJF9BS9j2mFXuBVaQkhnS/BbVW7YouazBudPQSSUdWqnwRy5nYrRi6RKQ
	TaZXg1l3HSDxIhiKizBriWAgAls5yUvBX0IF65jKHyUcOUEWAn+KANQIt3z9H+96ppajeFebHoiTy
	Iht4Qn3qCudUGaMBliiU5UsShLW87VtvUkdA3HB+Mny/tLJ/j0U5In6O9mnNNVnQN0P4waOkGiQ06
	+Iazdb6bw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHZre-006ju7-Nl; Wed, 03 Mar 2021 22:21:07 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTAt-005KjX-4o
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 15:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=FeI/Z+loMOPxycFt0LSXEODA9iD0PAJXBSnRMip+AdQ=; b=fx7RkqfvlbpZhViIPy8KVFcgmX
 lP4CASMFTKk2a+YKb5eAsCcQG6Il010xWqHBEPSL+oc+781TkzA1jiDBCwtXfRzXOsr/HwpYExhtn
 0xbynyiuLjGogaWWirtRagDU6tqHdTCDe/hmD5AIDfcTICQ8PapCIMpAPyLbejhi7FZIQ1kvXJoqm
 CRcSqKcLZzym8LmxxBkyoZA7zkC8vAGr28Odc9iaDxUkE+KdGn0WqpM50fbfMpQFrMFkZLem4Oc2f
 wLKOLgveXu84AoYjQ5znLAZG8qVNY4yC9ATRyc/ZzgWdjN0/qMkKHa/NzePssS9KmvUuH1PLK0xuV
 fDJ22Pgg==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lH9hI-0002tI-GR
 for linux-nvme@lists.infradead.org; Tue, 02 Mar 2021 18:24:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF4B564F1E;
 Tue,  2 Mar 2021 18:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614709465;
 bh=UmOZ+Fai099Ec1SQwatDFYeRZ2hnvHanV+ozDIg6fiM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bZS2b6xyT4BQhxzdOJsKtEwEHrXh/jmjV6oZxkMO3A+nc92SiC9GrsM8tIHz63JgZ
 /MUEhXSAzC6b99SXN3BhcF+OXZl/kRVU2QPXyWHjG8hy3LoXN3pyuwFK+XMFl7jbod
 n9mguTGd3EkxlKBksUFxK69YjxKifnqE0dR9zWhzW5nNoQt7zD3e9+TDFKsHa8TiMK
 Bct1Rs5haQMk6hBBlJyBr/JqprfCiyR5OB3WtDM0YsBgOCogbE8lJQAzN2JNwB7FxS
 yjZF+nxxfgg8PxWl+lMGyL6lQ4NhVguZDpuX9Cix+BJ1qyw/wzCfzVKs6C2Z0dkHYb
 U0WI1LqfyHvaw==
Date: Wed, 3 Mar 2021 03:24:18 +0900
From: Keith Busch <kbusch@kernel.org>
To: Chao Leng <lengchao@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: fix crash for no IO queues
Message-ID: <20210302182418.GA22346@redsun51.ssa.fujisawa.hgst.com>
References: <20210223072602.3196-1-lengchao@huawei.com>
 <20210223232137.GA23682@redsun51.ssa.fujisawa.hgst.com>
 <7c30ddb7-ee41-9972-4cb6-0a5c089f687c@huawei.com>
 <2a9bb7c3-eb4e-2341-dcfa-583d41912977@suse.de>
 <0a8fbff4-3759-f300-1fa8-601df1eab683@huawei.com>
 <fe262778-4d30-176a-b6c5-a17f023ac22f@suse.de>
 <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8ceff1a9-8015-feab-6c02-fd22ec3346de@huawei.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210302_182450_316880_752757B1 
X-CRM114-Status: GOOD (  25.82  )
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 02, 2021 at 05:49:05PM +0800, Chao Leng wrote:
> =

> =

> On 2021/3/2 15:48, Hannes Reinecke wrote:
> > On 2/27/21 10:30 AM, Chao Leng wrote:
> > > =

> > > =

> > > On 2021/2/27 17:12, Hannes Reinecke wrote:
> > > > On 2/24/21 6:59 AM, Chao Leng wrote:
> > > > > =

> > > > > =

> > > > > On 2021/2/24 7:21, Keith Busch wrote:
> > > > > > On Tue, Feb 23, 2021 at 03:26:02PM +0800, Chao Leng wrote:
> > > > > > > A crash happens when set feature(NVME_FEAT_NUM_QUEUES) timeou=
t in nvme
> > > > > > > over rdma(roce) reconnection, the reason is use the queue whi=
ch is not
> > > > > > > alloced.
> > > > > > > =

> > > > > > > If it is not discovery and no io queues, the connection shoul=
d fail.
> > > > > > =

> > > > > > If you're getting a timeout, we need to quit initialization. Ha=
nnes
> > > > > > attempted making that status visible for fabrics here:
> > > > > > =

> > > > > > http://lists.infradead.org/pipermail/linux-nvme/2021-January/02=
2353.html
> > > > > > =

> > > > > I know the patch. It can not solve the scenario: target may be an
> > > > > attacker or the target behavior is incorrect.
> > > > > If target return 0 io queues or return other error code, the cras=
h will
> > > > > still happen. We should not allow this to happen.
> > > > I'm fully with you that we shouldn't crash, but at the same time a
> > > > value of '0' for the number of I/O queues is considered valid.
> > > > So we should fix the code to handle this scenario, and not disallow=
ing
> > > > zero I/O queues.
> > > '0' I/O queues doesn't make any sense to nvme over fabrics, it is
> > > different with nvme over pci. If there is some bug with target, we can
> > > debug it in target instead of use admin queue in host.
> > > target may be an attacker or the target behavior is incorrect. So we
> > > should avoid crash. Another option: prohibit=A0 request delivery if
> > > io queue do not created.
> > > I think failed connection with '0' I/O queues is a better choice.
> > =

> > Might be, but that's not for me to decide.
> > I tried that initially, but that patch got rejected as _technically_ the
> > controller is reachable via its admin queue.
> I know about your patch. That patch failed connection for all transports.
> It is not good for pcie transport, the controller can accept admin
> commands to get some diagnostics (perhaps an error log page), this is
> keith's thoughts.

We can continue to administrate a controller that didn't create IO
queues, but the controller must provide a response to all commands. If
it doesn't, the controller will either be reset or abandoned. This
should be the same behavior for any transport, though; there's nothing
special about PCIe for that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
