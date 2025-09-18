Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6909CCAC59A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Sep 2025 16:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PjM9LBLkDnpBzobuoA/vNBhz/nfPo4oh28cYXojkEtw=; b=okKkMwQXQFZHgJQbj0VVkYCdV0
	tFvMbxjnPA/k5RpnmNUQ/eZgq7gweq/wugStlCLp24AnaEVdVpOZCRJie3HFSr9XXR4JXRAOEDQPW
	9gQDk81/NBkgsZ7jnIgh+fljb7/MDPE5BCeh4F5U79eqvio6iOVjxDPJUBRBFEl5JDJEk4Bxg0lK5
	yT64i1l4V/BLBa31uQK2puAJ31HSd0xCvZA7AHMWb0Zh/i5Yy/frUk6uCOAAZk4YNr0t8vWn6WI93
	iR1iUW4iV4bcED6DkIf8h9b08jaD7kRRYtvqc3qd9kQfPmth/q/jKdf9j0EhduFMf50BRiwCc7gVF
	AA6GMGsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzHCr-00000000ZMz-2SiT;
	Thu, 18 Sep 2025 16:10:01 +0000
Received: from infra.glanzmann.de ([2a01:4f8:b0:3ffe::5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uzHCo-00000000ZKg-3w8Z
	for linux-nvme@lists.infradead.org;
	Thu, 18 Sep 2025 16:10:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
	s=infra26101010; t=1758211792;
	bh=PjM9LBLkDnpBzobuoA/vNBhz/nfPo4oh28cYXojkEtw=;
	h=Date:From:To:Subject:From;
	b=jvEek+7Qk0RaurCKo7WF97rBZ1Em4Wg+vhTEATZv8eskvptS0Pklb2oQXXKLSR+xy
	 QDQvpIxum95M5ISGVMkbDFLeeCDLrnvsFehpw+jNXhM8BvnBIzrRrJ6dQH7INPXPKN
	 xS5HetDYYdh2hR3Ek9jTeqfssgzlHZZAhKJdToG0k2CzaUsj1G6+QhBKBg87oQL/Pt
	 Z3yY+bOjRpsL0F8rOCtp0on08rCbu5BKDBHGAGbahCj2Nxiio9buzmEchNW/DRMyJ6
	 z3nKrYIPVmVwNJIBwzUaOegevBE8Jn1vp815u9IZW980B6ptstr4dxwWMJyYgAXtH8
	 HIritFiDNDEtSgkGPge3fTNLrpWB7S7EDvNotCxSQVzeybmBy2A0EWknSZqMDqzuLh
	 O8WTT09q5GLADebNU+e22Ez7PllohtCDGT2D6LMm652JAP5EM3+WgSIu53nEQtAlUL
	 8W3BHlc+VtYQcHnMKR/NUnhXUYvVLaNFzm9KYMdzVJbYwnmHug97HQSmR/7vSvRs5E
	 eJOCe0QvULUdz8bQeq/yGVJiQkmECUFRu3BmGv+8q+MA5w2+uJXlQ22SGXlU3KZOu0
	 SPqsmJ63yN9H8SaX912wBMt3ZNx+GiUYGOxQ48K7hqBxhTwzCRBOSLaOJ+gMBOq7F5
	 rbm75bpokwSi6ttXxk9RncFU=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
	id DE8557A80203; Thu, 18 Sep 2025 18:09:52 +0200 (CEST)
Date: Thu, 18 Sep 2025 18:09:52 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: linux-nvme@lists.infradead.org
Subject: NetApp Snapmirror Active Sync NVMe target and Linux initiator: Paths
 disappearing after a power failure of one NetApp a150 system
Message-ID: <aMwu0DK_KRGF_UGD@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250918_090959_418985_1C06BFCD 
X-CRM114-Status: GOOD (  12.42  )
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

Hello,
today I tried to use two NetApp AFF A150 which consists of two
controllers and 8 disks each with NVMe/TCP. The idea is that you have 2
paths to each controller via two VLANs. If a controller or A150 fails the other
one should take over. That worked, however when the manually power fenced
system came back, I saw that the paths to it where 'chaining' and than
disappearing. However, I could manually reconnect the paths.
I assume that the NVME target of the powerfenced system came up without the
full configuration loaded.  As a result the Linux NVMe initiator droped the
paths.  Is that correct or is it a bug in the Linux NVMe stack. I used Debian
trixie (6.12.43+deb13-cloud-amd64).

- Before I had 8 paths:

(debian-05) [~] nvme list-subsys /dev/nvme4n1
nvme-subsys4 - NQN=nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:a44b1e42-29ec-1c09-c043-741282002d9c
\
 +- nvme10 tcp traddr=10.0.10.238,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme11 tcp traddr=10.0.20.238,trsvcid=4420,src_addr=10.0.20.25 live non-optimized
 +- nvme4 tcp traddr=10.0.10.235,trsvcid=4420,src_addr=10.0.10.25 live optimized
 +- nvme5 tcp traddr=10.0.20.235,trsvcid=4420,src_addr=10.0.20.25 live optimized
 +- nvme6 tcp traddr=10.0.10.236,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme7 tcp traddr=10.0.20.236,trsvcid=4420,src_addr=10.0.20.25 live non-optimized
 +- nvme8 tcp traddr=10.0.10.237,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme9 tcp traddr=10.0.20.237,trsvcid=4420,src_addr=10.0.20.25 live non-optimized

(debian-05) [~] mount /dev/nvme4n1 /mnt
(debian-05) [~] cd /mnt/
(debian-05) [/mnt] while true; do date | tee -a date.log; sync; sleep 1; done
...
Thu Sep 18 16:04:49 CEST 2025
Thu Sep 18 16:04:50 CEST 2025
# 10 seconds for the path failover
Thu Sep 18 16:05:00 CEST 2025
Thu Sep 18 16:05:01 CEST 2025
...

- While the first AFF A150 was offline:

(debian-05) [/mnt] nvme list-subsys /dev/nvme4n1
nvme-subsys4 - NQN=nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:a44b1e42-29ec-1c09-c043-741282002d9c
\
 +- nvme10 tcp traddr=10.0.10.238,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme11 tcp traddr=10.0.20.238,trsvcid=4420,src_addr=10.0.20.25 live non-optimized
 +- nvme4 tcp traddr=10.0.10.235,trsvcid=4420 connecting optimized
 +- nvme5 tcp traddr=10.0.20.235,trsvcid=4420 connecting optimized
 +- nvme6 tcp traddr=10.0.10.236,trsvcid=4420 connecting non-optimized
 +- nvme7 tcp traddr=10.0.20.236,trsvcid=4420 connecting non-optimized
 +- nvme8 tcp traddr=10.0.10.237,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme9 tcp traddr=10.0.20.237,trsvcid=4420,src_addr=10.0.20.25 live non-optimized

- Than I don't have the output because I ran it in watch, it said 'changing' for the failed paths.

- And than the paths disappeared completely and did not come back.

(debian-05) [/mnt] nvme list-subsys /dev/nvme4n1
nvme-subsys4 - NQN=nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:a44b1e42-29ec-1c09-c043-741282002d9c
\
 +- nvme10 tcp traddr=10.0.10.238,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme11 tcp traddr=10.0.20.238,trsvcid=4420,src_addr=10.0.20.25 live non-optimized
 +- nvme8 tcp traddr=10.0.10.237,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme9 tcp traddr=10.0.20.237,trsvcid=4420,src_addr=10.0.20.25 live non-optimized

- Than I manually reconnected:

(debian-05) [/mnt] nvme connect -t tcp -a 10.0.10.235 -s 4420 -n nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem -i 14
(debian-05) [/mnt] nvme connect -t tcp -a 10.0.20.235 -s 4420 -n nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem -i 14
(debian-05) [/mnt] nvme connect -t tcp -a 10.0.10.236 -s 4420 -n nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem -i 14
(debian-05) [/mnt] nvme connect -t tcp -a 10.0.20.236 -s 4420 -n nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem -i 14

(debian-05) [/mnt] nvme list-subsys /dev/nvme4n1
nvme-subsys4 - NQN=nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:a44b1e42-29ec-1c09-c043-741282002d9c
\
 +- nvme10 tcp traddr=10.0.10.238,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme11 tcp traddr=10.0.20.238,trsvcid=4420,src_addr=10.0.20.25 live non-optimized
 +- nvme12 tcp traddr=10.0.20.236,trsvcid=4420,src_addr=10.0.20.25 live non-optimized
 +- nvme5 tcp traddr=10.0.10.235,trsvcid=4420,src_addr=10.0.10.25 live optimized
 +- nvme6 tcp traddr=10.0.20.235,trsvcid=4420,src_addr=10.0.20.25 live optimized
 +- nvme7 tcp traddr=10.0.10.236,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme8 tcp traddr=10.0.10.237,trsvcid=4420,src_addr=10.0.10.25 live non-optimized
 +- nvme9 tcp traddr=10.0.20.237,trsvcid=4420,src_addr=10.0.20.25 live non-optimizedo

In dmesg I saw:

[90303.743154] nvme nvme6: Reconnecting in 10 seconds...
[90311.695617] nvme nvme4: Connect Invalid Data Parameter, subsysnqn "nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem"
[90311.695714] nvme nvme4: failed to connect queue: 0 ret=16770
[90311.695754] nvme nvme4: Failed reconnect attempt 1/-1
[90311.695775] nvme nvme5: Connect Invalid Data Parameter, subsysnqn "nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem"
[90311.695789] nvme nvme4: Removing controller (16770)...
[90311.695876] nvme nvme5: failed to connect queue: 0 ret=16770
[90311.695909] nvme nvme4: Removing ctrl: NQN "nqn.1992-08.com.netapp:sn.347a30cc947511f083a6d039ea2800fc:subsystem.subsystem"

full dmesg: https://tg.st/u/297bb062eca5c9d05b533691ce98c2fffc31deafe45fe399d7492381b47313bb.txt

Cheers,
	Thomas

