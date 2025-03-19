Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D4FC35FFA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F4OqWKmlxl0Z16U7v4S6Kvfx4lNXBOV/MAIt234mOqY=; b=qbzBIRWqOtBwphtz0khdglqmqX
	vSDt0WNOilXFr42jXecGVrD9rmotC0E+ELVXlMMkQ2yF6gZMeRbuqPimeFYd7Np1ttcwkKpYzdyG+
	vbhVtk1pHLbcKx9hVdvsQhSD4uNtNke85qAitv2mqi1AnFUNPLOmpazY9+2o0r03502K12UWH2Jhm
	Ij3V4KSf/py2PduoURaNpYybFyr39N6P2M8uHZdLmqF7UuwTUBTpEbiucUndQ8zK3Jme0kHwEt0Yg
	fMANaUElygWvPENrvSAyEqxmIC9ZykNNIW9cgx9XYrQlh9iobJKkNBBEatgqx8pVdvJXRjo88ln6F
	ak5VFRYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuvcM-00000009RX7-20Hz;
	Wed, 19 Mar 2025 15:46:06 +0000
Received: from m16.mail.163.com ([220.197.31.4])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuvWn-00000009PuF-1QJW
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 15:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=F4OqW
	Kmlxl0Z16U7v4S6Kvfx4lNXBOV/MAIt234mOqY=; b=fnGc/DpFfEdLF/Wkptue9
	THuRjI2/GMPnqZ6Ocs//QNP2pnk4vwks+Rp7k1naHnYvGwdO5x7KlmOyfzkganoB
	4igq9+z+ssHP4WAe4lzctpjTfpKWEdKjExtIO4ChE7dkacMqnxiaGdVq94wKK5qe
	cXbLgfeOgRH9yaRvw52DL0=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wC3JUog5dpnBJb3AQ--.38S4;
	Wed, 19 Mar 2025 23:39:48 +0800 (CST)
From: David Wang <00107082@163.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: nvme interrupt counters got reset after suspend/resume
Date: Wed, 19 Mar 2025 23:39:10 +0800
Message-Id: <20250319153910.18684-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wC3JUog5dpnBJb3AQ--.38S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1rCF1ruFy8JF47tF4xZwb_yoW8CryDp3
	Z8KF1qgr48Kr4xKa4UtF47Jr1aqa4IyF4Ut3W7Jr48ta9Y9w4jkryDtF1vq3WUuF4kZw1U
	Kws5t34vy34kGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-Originating-IP: [111.35.188.213]
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBkAcVqmfa4IeLzgAAs3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_084021_734720_2F81B03E 
X-CRM114-Status: UNSURE (   8.50  )
X-CRM114-Notice: Please train this message.
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

Hi,

I noticed that on my system, the counters from /proc/interrupts
for nvme got reset after I suspend and then resume the system.
For example, before `systemctl suspend`:
$ cat /proc/interrupts 
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
...
  38:          0          0          0         22          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    0-edge      nvme0q0
  39:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:22:00.0    0-edge      enp34s0
  40:         78          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    1-edge      nvme0q1
  41:          0        147          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    2-edge      nvme0q2
  42:          0          0         13          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    3-edge      nvme0q3
  43:          0          0          0          9          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    4-edge      nvme0q4
  44:          0          0          0          0         87          0          0          0 IR-PCI-MSIX-0000:25:00.0    5-edge      nvme0q5
  45:          0          0          0          0          0        112          0          0 IR-PCI-MSIX-0000:25:00.0    6-edge      nvme0q6
  46:          0          0          0          0          0          0         12          0 IR-PCI-MSIX-0000:25:00.0    7-edge      nvme0q7
  47:          0          0          0          0          0          0          0          8 IR-PCI-MSIX-0000:25:00.0    8-edge      nvme0q8

And right after resume the system, values are reset to 0s:
$ cat /proc/interrupts 
            CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7
...
  38:          0          0          0         21          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    0-edge      nvme0q0
  39:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:22:00.0    0-edge      enp34s0
  40:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    1-edge      nvme0q1
  41:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    2-edge      nvme0q2
  42:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    3-edge      nvme0q3
  43:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    4-edge      nvme0q4
  44:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    5-edge      nvme0q5
  45:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    6-edge      nvme0q6
  46:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    7-edge      nvme0q7
  47:          0          0          0          0          0          0          0          0 IR-PCI-MSIX-0000:25:00.0    8-edge      nvme0q8

This does not happend to counters for other interrupts on my system.
Not sure whether this is designed explicitly this way, or happended to be this way to make suspend/resume work,
or there is some bug behind this.
Just bring this up for discussion since I failed to find any discussion about it.

Thanks
David.


