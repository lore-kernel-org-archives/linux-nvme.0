Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50CDC83F34
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpyMZD0Z4BYwGlCazgeEz14/cWNuI6/mEPgFvAQ/3LA=; b=WFNUkcOFsOt6liOAZAlanjPTBz
	Lf23CYuRoUX8SRRZhvaIief+ewboDrHsGUHzSw+Zq86BjgsZ8s6k2rdTNAzlZvcXGl1n8sIWbl559
	IzHhTr/eHpo7wKF77iBRqLPhyFW/oI9qo+SsLUI3H5hvcvjVADGW6EnwIh/q/CfPaZX+A+zzrh0pp
	WVg//DrA/zk05zMtnLzwIXS4fsj2jUn5T3pJE/wMdrnG+6f+shL8GdRNbbmN05McU+49CT8ct3dTr
	KeLZNz7fuyq8TsYT+KDUsWIXEtrlkij5B2cuqOnGUzBay2OqjrDC3vc8QaoBp6KVD6CpCs3VMluxp
	F7DJ8kHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublBX-000000061WH-3tyE;
	Tue, 15 Jul 2025 19:19:27 +0000
Received: from infra.glanzmann.de ([88.198.237.220])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubig7-00000005lRJ-0C27
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 16:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
	s=infra26101010; t=1752597527;
	bh=RpyMZD0Z4BYwGlCazgeEz14/cWNuI6/mEPgFvAQ/3LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P61prM5s8op/zODC8ZAI0ZIiSCRLd1gw8JTlK5uYjfGFauL/wb/7ITzNEkl33QXLI
	 AxBHgaRlAD6fiL6CON7ZZiMA0tYrynWOPOcJ0soUS/p8gw5zfWkvcR2Vhvk383XOWe
	 xPspH/v7WywFIREwpNFNpEUm8v+bthl15/6fQFDsQxwNqhsvGAgWMaHA0Aa6IqfXnj
	 Hobi6/yQkb2uX511wAWWqFLLlIu2LEyL1OoHTPiqZzBr6RrNUq0dDa7Y2m93+GAuzB
	 KngWgqCG8pLPv3ijU2APVqhV2lSQtdJb7y6U1VbAdhroUBeomQktMfYG1KHiFkp3uv
	 e9XT0oMnOQUItVlg86GPTckwjs8FNjjXjCOBPjW4/FTJbjuYqgOcafeU8CQBfeSr41
	 IgE5U3GsjoNq4ZVmk7XamfxG9fH09spbMAkRf1h8HcG68EZyIuV681aYU0Skfm4un8
	 O9xJMP7qIWFZ0rXokcdIyFUcNqv38WAvAmv1N128mch/MLxwFWAWquLqe5RLKbsWQd
	 E3omPCbSZ62aRFipzlip8bVZEl9c7w7wiBVP0AE49wkRAZ8LpGQUs8R0wJnNKw0hxy
	 rujmw6VjCPpRwd4RWSovu6l36Waju7hWgUx1kI5KNmyPYu0B0R83dfK+gYgxdXnNcr
	 qKCO+cZAO23NFXHZv9RnXq6Q=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
	id 687667A800B9; Tue, 15 Jul 2025 18:38:47 +0200 (CEST)
Date: Tue, 15 Jul 2025 18:38:47 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: Re: Number of data and admin queues in use
Message-ID: <aHaEF3-GW8dXaOhe@glanzmann.de>
References: <aHW1qUJksE5Okflb@glanzmann.de>
 <aHZoBO9cPcRGIDwH@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHZoBO9cPcRGIDwH@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_093851_799846_E4878755 
X-CRM114-Status: GOOD (  11.04  )
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

Hello Keith,

* Keith Busch <kbusch@kernel.org> [2025-07-15 16:39]:
> For PCI, the driver automatically handles the queue and interrupt setup,
> and cpu assignment.

> For TCP (and all fabrics transports), you have to specificy how many
> connections you want to make ("nr_io_queues=X") when you're setting up
> your initial fabrics connection.

> If you want to see what you've ended up with, you can consult the
> namespaces' sysfs entries:

> How many IO queues are there:

>   # ls -1 /sys/block/nvme0n1/mq/ | wc -l
>   64

> How large is each IO queue:

>   # cat /sys/block/nvme0n1/queue/nr_requests
>   1023

thank you for taking the time to answer me. I was looking multiple years for an
answer to this. nr_requests I stumbled on before, but /sys/block/nvme0n1/mq/
was new to me. The maximum that the NetApp appears to support is:

na2501::*> vserver nvme show-host-priority
Node                  Protocol  Priority I/O Queue Count I/O Queue Depth
--------------------- --------- -------- --------------- ---------------
na2501-01             fc-nvme
                                regular                4              32
                                high                   6              32
                      nvme-tcp
                                regular                2             128
                                high                   4             128
na2501-02             fc-nvme
                                regular                4              32
                                high                   6              32
                      nvme-tcp
                                regular                2             128
                                high                   4             128

(live) [~] ls -1 /sys/block/nvme0c0n1/mq/ | wc -l
4
(live) [~] ls -1 /sys/block/nvme0c1n1/mq/ | wc -l
4
(live) [~] cat /sys/block/nvme0c0n1/queue/nr_requests
127

With ext4 and fio I get:

fio --ioengine=libaio --refill_buffers --filesize=4G --ramp_time=2s --numjobs=40 --direct=1 --verify=0 --randrepeat=0 --group_reporting  --directory /mnt --name=4khqd --blocksize=4k --iodepth=50 --readwrite=write
  write: IOPS=159k, BW=620MiB/s (651MB/s)(159GiB/261872msec); 0 zone resets
fio --ioengine=libaio --refill_buffers --filesize=4G --ramp_time=2s --numjobs=40 --direct=1 --verify=0 --randrepeat=0 --group_reporting  --directory /mnt --name=4khqd --blocksize=4k --iodepth=50 --readwrite=read
  read: IOPS=449k, BW=1752MiB/s (1838MB/s)(157GiB/91645msec)

fio --ioengine=libaio --refill_buffers --filesize=4G --ramp_time=2s --numjobs=40 --direct=1 --verify=0 --randrepeat=0 --group_reporting  --directory /mnt --name=1mhqd --blocksize=1m --iodepth=50 --readwrite=write
  write: IOPS=1965, BW=1970MiB/s (2066MB/s)(157GiB/81434msec); 0 zone resets
fio --ioengine=libaio --refill_buffers --filesize=4G --ramp_time=2s --numjobs=40 --direct=1 --verify=0 --randrepeat=0 --group_reporting  --directory /mnt --name=1mhqd --blocksize=1m --iodepth=50 --readwrite=read
  read: IOPS=4034, BW=4044MiB/s (4241MB/s)(153GiB/38682msec)

Using 'iostat -xm 2' I can see that is utilizes the queue depth by watching aqu-sz.

Cheers,
	Thomas

