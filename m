Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02416C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 18:05:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9736A64F2B
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 18:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9736A64F2B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NxdFzNUawx8LpBdAVnYH0TDh3fpHdMFcf4P98ZHl9LI=; b=rIBijLgHi0KwTemqmcPqlDosg
	m8MjOj7VpWFxOQpg062sdyHcBY70ahf6WaDSYnn0x83p08K6d+jfT1QMKmbrVtGo0ifnmdGzv6Mn6
	5hK+yeaESMACF5Ouklm21+oGXBc2poOY56lx9hr71zQyWeynyIyHaFq6yKT0gtmaEAJ5EusxLuSVg
	0kaFJd5moNG1a6CLvCUE+HB4Y9UfpAeqZI8SpgugLgZpsyi2dCNg/eLAPHbRYIJi1gR2GVrkWYkTX
	HtwUSZaFPgJrTaYgmpQ/876MsmzeaDjVYzLCwaTj+suBW6fFXMfyEnxKgnBLxjZHZ/ZPZoag6H6OE
	j557DwVEQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLraD-00GdFT-E2; Mon, 15 Mar 2021 18:04:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLra8-00GdE0-BO
 for linux-nvme@desiato.infradead.org; Mon, 15 Mar 2021 18:04:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=kiPk6oz4QokDIktCc2OqHG3wmTvcOhpSt5LH5YBv4Ts=; b=Cd6TZOwcr0Rrl+1/G2WsUIlu4v
 GFa+cGuNhhcVR7uGe8EMmh6xnX57QGqg2GYR5AnARkDcRdBujH1IMtruwjrdpZ5gQich8h38pndp0
 s+w0OM+YyilZFJem8joTw9J6MOH6m6EScxeq0acPlDXU8IkUZwPL05ZUR9Gb7SwFT7+gP/xTR0EF7
 ZrtXol3nxsKjOGL3oXIJl9mqNo1VCqqeMaze4tc2WRF9Qxn4Rt8eYunw+h0SyzUJKn04f+ljcu2Hb
 miaFkSbzmtmfu3lxxrzauVsxheUaC31XwyO+0SzZlbopLYR0hkfm92herrT/65iavUmPi9TcZ0P9A
 4O0TSAIQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lLrZw-000YnH-Qp; Mon, 15 Mar 2021 18:04:39 +0000
Date: Mon, 15 Mar 2021 18:04:32 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org
Subject: Re: BUG: using __this_cpu_read() in preemptible code observed with
 blktests nvme-tcp on rt kernel
Message-ID: <20210315180432.GA131743@infradead.org>
References: <2052426528.19238323.1615703548200.JavaMail.zimbra@redhat.com>
 <99ff5e9a-1ff5-81f2-0ef0-68461ddbf711@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <99ff5e9a-1ff5-81f2-0ef0-68461ddbf711@grimberg.me>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Mar 15, 2021 at 10:29:37AM -0700, Sagi Grimberg wrote:
> 
> > Hi
> > 
> > I reproduced this issue on latest rt kernel, could you help check it, thanks.
> > 
> > [   76.812567] run blktests nvme/003 at 2021-03-14 07:29:39
> > [   76.880530] loop: module loaded
> > [   76.893827] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> > [   76.895766] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
> > [   76.898923] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:f1d7a9f1-79ef-42a3-952b-59c7338f3b54.
> > [   76.899061] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 127.0.0.1:4420
> > [   76.899063] BUG: using __this_cpu_read() in preemptible [00000000] code: kworker/u64:25/231
> > [   76.899065] caller is nvme_tcp_submit_async_event+0x128/0x170 [nvme_tcp]
> > [   76.899069] CPU: 3 PID: 231 Comm: kworker/u64:25 Tainted: G S        I       5.12.0-rc2-rt1 #4
> > [   76.899071] Hardware name: Dell Inc. PowerEdge R640/06NR82, BIOS 2.10.0 11/12/2020
> > [   76.899072] Workqueue: nvme-wq nvme_async_event_work [nvme_core]
> > [   76.899081] Call Trace:
> > [   76.899083]  dump_stack+0x64/0x7c
> > [   76.899086]  check_preemption_disabled+0xb6/0xd0
> > [   76.899090]  nvme_tcp_submit_async_event+0x128/0x170 [nvme_tcp]
> > [   76.899093]  nvme_async_event_work+0x5d/0xc0 [nvme_core]
> > [   76.899098]  process_one_work+0x1c8/0x3f0
> > [   76.899101]  ? process_one_work+0x3f0/0x3f0
> > [   76.899102]  worker_thread+0x30/0x370
> > [   76.899104]  ? process_one_work+0x3f0/0x3f0
> > [   76.899105]  kthread+0x183/0x1a0
> > [   76.899108]  ? kthread_park+0x80/0x80
> > [   76.899110]  ret_from_fork+0x1f/0x30
> > [   86.912113] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
> 
> Annoying... why can't we just get an advisory hint of the running cpu
> without disabling preemption ?!

You'll have to use raw_smp_processor_id() for that.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
