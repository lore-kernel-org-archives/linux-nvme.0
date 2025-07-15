Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3455C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 01:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nOJuAUhtIocqRozml6l7p13P/wtZOJeAMArVf3PyWrc=; b=pZb53DN/HT7mXhajPrqyynccnh
	BPGNqvs5bwWk6IgbErA6iuBmBUdgdhvlfoprc/eIWMr4nmqpKW+W3QqenHqkzGg0f8J/BHFV7Lm+F
	zqk4UVD/3NAu11AtDAhNZH0tnKw33dLq7Dm6trITCy4RUR4V+0olCPBMRxJtxIgD/4xtlkMXzwfft
	TMagARygyyM0U+FLxOeKmGkRfkfBL+tjyyYZGJMPpO2Dwa3+c5m9z/XuZ9CquTewiPjDXPkLLdbFP
	g3QL9nMkU3xXKOw2cLkUp/9ks5gywAXVDqqHhWv7gsLQC6FRYIG9O2hx3ZYOcc5hHWvQ+J21ZF+YF
	M7eT1Heg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubUvs-00000003l0X-3kbN;
	Tue, 15 Jul 2025 01:58:12 +0000
Received: from infra.glanzmann.de ([2a01:4f8:b0:3ffe::5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubUvp-00000003l02-0krU
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 01:58:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glanzmann.de;
	s=infra26101010; t=1752544681;
	bh=nOJuAUhtIocqRozml6l7p13P/wtZOJeAMArVf3PyWrc=;
	h=Date:From:To:Subject:From;
	b=qT9V9y2/fsEHVxZY0uHxFGEYJ0zogUjC8PBaF2SaM3RGDv0H+Uo/PaJn+IspLmB5D
	 CrF+xuVaeNXnMEu+JTUaxmtna/kPQSC9Ay9mYRlA70JtbTSQSaKyLWTdOUMxOpq0u7
	 UelF3HtOe34WirowzUXr+QbV8I7CXIf0LWR0bHqmq5ca2890jPdBxZ3+bZP+eWbDFT
	 mAdIC45GKhcgncC5JJPyLeVw+7MfTjjTWQ0TujE/ycpCCVOdHtrGJiQEGTXRiutT7n
	 cbakMqIWrEQ6/g52lZCIZkuAssOhPaNQRG2NbvI1vhUjLZ53FGQzKzsdj+YaHEslSb
	 FOvDiNi0drRt2yt/YCJQ41RdN6sthHDlPjstRZZ0oJnwk4Towk8S//RgE6/P7tWtgX
	 N+ghkJZWInZWTAYCFvRPlwXqH/R69NAlaH86H1aVRR9uHNHZfinJQHCA6tYtt1tgk/
	 9H5yx1OZYFaEXOSJ42RdDnCyvwzFWSUXRv1lxrocm9lG5oTpDY6Oowb4EHAaMfog4i
	 5yALlvZ6pz5tyu0tdgDDbQRvZpbAZ9/k0DoOCqcfnJ4zZoDIKkL3baIkCKsCPQU2XF
	 6Dy9wNnPNDzcoeM2Yfza7j1cdjNEyoXmMZD3tXAlZjPhhd52ETnIiXFARFeBAVfHxm
	 0NB2OjX7JfYjRLkSfVs0LF24=
Received: by infra.glanzmann.de (Postfix, from userid 1000)
	id C8EE97A800B9; Tue, 15 Jul 2025 03:58:01 +0200 (CEST)
Date: Tue, 15 Jul 2025 03:58:01 +0200
From: Thomas Glanzmann <thomas@glanzmann.de>
To: linux-nvme@lists.infradead.org
Subject: Number of data and admin queues in use
Message-ID: <aHW1qUJksE5Okflb@glanzmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_185809_940911_10192C0A 
X-CRM114-Status: GOOD (  12.32  )
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
I have Linux system hooked up over two dedicated links to a NetApp using
NVMe/TCP. I would like to find out how many data and admin queues there are and
their queue depth? How can I find out the same?

So far, I found out:

(live) [~] nvme netapp ontapdevices /dev/nvme0n1
/dev/nvme0n1, Vserver svm1, Subsystem svm1_subsystem_553, Namespace Path rx3082_1, NSID 1, UUID 7f6be93b-60cb-11f0-866f-d039ead647e8, 1.10TB
(live) [~] nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=nqn.1992-08.com.netapp:sn.e0a0273a60b711f09deed039ead647e8:subsystem.svm1_subsystem_553
               hostnqn=nqn.2014-08.org.nvmexpress:uuid:20f011e6-9ab8-584f-abb0-a260d2d685c4
\
 +- nvme0 tcp traddr=192.168.0.2,trsvcid=4420,src_addr=192.168.0.100 live optimized
 +- nvme1 tcp traddr=192.168.1.2,trsvcid=4420,src_addr=192.168.1.100 live optimized
(live) [~] nvme list
Node                  Generic               SN                   Model                                    Namespace  Usage                      Format           FW Rev
--------------------- --------------------- -------------------- ---------------------------------------- ---------- -------------------------- ---------------- --------
/dev/nvme0n1          /dev/ng0n1            824nlJYbYm5ZAAAAAAAB NetApp ONTAP Controller                  0x1          8.62  GB /   1.10  TB      4 KiB +  0 B   9.16.1
(live) [~] sudo nvme get-feature /dev/nvme0n1 --feature-id=7 -H
get-feature:0x07 (Number of Queues), Current value:0x00010001
        Number of IO Completion Queues Allocated (NCQA): 2
        Number of IO Submission Queues Allocated (NSQA): 2

I also have some local NVMe where I would like to find out the same:

(infra) [~] sudo nvme get-feature /dev/nvme0n1 --feature-id=7 -H
get-feature:0x07 (Number of Queues), Current value:0x007f007f
        Number of IO Completion Queues Allocated (NCQA): 128
        Number of IO Submission Queues Allocated (NSQA): 128
(infra) [~] nvme list
Node                  Generic               SN                   Model                                    Namespace Usage                      Format           FW Rev
--------------------- --------------------- -------------------- ---------------------------------------- --------- -------------------------- ---------------- --------
/dev/nvme1n1          /dev/ng1n1            50026B7685E14353     KINGSTON SKC3000D2048G                   1           2.05  TB /   2.05  TB    512   B +  0 B   EIFK31.6
/dev/nvme0n1          /dev/ng0n1            50026B7685E1439E     KINGSTON SKC3000D2048G                   1           2.05  TB /   2.05  TB    512   B +  0 B   EIFK31.6
(infra) [~] nvme list-subsys /dev/nvme0n1
nvme-subsys0 - NQN=nqn.2020-04.com.kingston:nvme:nvm-subsystem-sn-50026B7685E1439E
\
 +- nvme0 pcie 0000:01:00.0 live

I one heard that the Linux kernel allocates one queue per processor (core or
hyperthread). I can see that using /proc/interrupts but only on physical
devices, but not on NVME/TCP systems.

Cheers,
        Thomas

