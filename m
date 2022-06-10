Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4D3C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zEOQTQx6i38Z9K/fOJzfPspwSSrzimFhcNIqaBiE0Kk=; b=aS2BLctwK0xg4IL7Y6ZfRrKnah
	opxEWLZvwhuD4BSaK2GHqTsG7jCEqSXrAq+tp6EonAL1cYQViYxF+2zl9AqpfmetiGbc/L81Jxm0i
	CvJ0GUwa2XzaRMFZEXncVZStoihvbwJlDR66Vq67J16o5yi+dx3Gepr3qg/kQTEQVDab/2GTrpzEQ
	YM4/jBUdg7QFv/qE5x7VHQD3UwUwxEq/19Ni63naV4Og152oHzqpPWHm8WoKAcRpIjWXcGhTSX8mF
	JOMYAzOA6wzCtn0ICj6KnpjHXgpOhd3MOiS8eQ7Bk8hp5n50mOfV7TEYUkjoyiz1gaxbUhMlRdQXw
	EVcVqlpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzfvM-008dgp-Tg; Fri, 10 Jun 2022 14:47:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzfvJ-008dfP-Nw
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 14:47:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3B0D1B835D2;
	Fri, 10 Jun 2022 14:47:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0CDC34114;
	Fri, 10 Jun 2022 14:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654872459;
	bh=1G/kKmnPuQ1+bfxE++tWRK/QGRB9Ib5YyobZ1xQvME0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiinhiVfxa3+BNyJJbeXiwbniXz/YHopf92NhbJtOQtFSK+B/p4Hxv3EXkryys/j2
	 VLQvB2G1Oysi77kecifFhRPz7qKlcPslRapbJgUDEcCHXWqUuSzuSL4/w5lIIeI/RB
	 LdBI8tzU3HFJ7jHdntGsOqwJcv8kVFG4Mn0IBYySqGOrSlaPwMM9hE+Ri+OzWsAdag
	 sbmw7wcBwB+xmYDscdX1Aasox5fBEsSRuTdIiIekly8r3vkmGytMPZ7WU5p2lEjwsL
	 LXcw0nIzS35MNtI0PXsQCxIzD0kOtPLRF7SGskKBkIlC/Iw2WCpF3Qu++iV6xKp/Zw
	 Zbagt/xnpSadw==
Date: Fri, 10 Jun 2022 08:47:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <YqNZiMw+rH5gyZDI@kbusch-mbp.dhcp.thefacebook.com>
References: <20220609235329.4jbz4wr3eg2nmzqa@shindev>
 <717734c9-c633-fb48-499e-7e3e15113020@nvidia.com>
 <19d09611-42cc-5a81-d676-c5375865c14c@nvidia.com>
 <20220610122517.6pt5y63hcosk5mes@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610122517.6pt5y63hcosk5mes@shindev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_074741_961343_802D9B07 
X-CRM114-Status: GOOD (  17.39  )
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

On Fri, Jun 10, 2022 at 12:25:17PM +0000, Shinichiro Kawasaki wrote:
> On Jun 10, 2022 / 09:32, Chaitanya Kulkarni wrote:
> > >> #6: nvme/032: Failed at the first run after system reboot.
> > >>                 Used QEMU NVME device as TEST_DEV.
> > >>
> > 
> > ofcourse we need to fix this issue but can you also
> > try it with the real H/W ?
> 
> Hi Chaitanya, thank you for looking into the failures. I have just run the test
> case nvme/032 with real NVME device and observed the exactly same symptom as
> QEMU NVME device.

QEMU is perfectly fine for this test. There's no need to bring in "real"
hardware for this.

And I am not even sure this is real. I don't know yet why this is showing up
only now, but this should fix it:

---
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fc804e08e3cb..bebd816c11e6 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -476,7 +476,7 @@ static ssize_t dev_rescan_store(struct device *dev,
 	}
 	return count;
 }
-static struct device_attribute dev_attr_dev_rescan = __ATTR(rescan, 0200, NULL,
+static struct device_attribute dev_attr_dev_rescan = __ATTR_IGNORE_LOCKDEP(rescan, 0200, NULL,
 							    dev_rescan_store);
 
 static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
--

