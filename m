Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E6AC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 16:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9c9f/Z617NwlepBZ8kCvaLxh0DHSLLYncHvcWBGtmQo=; b=aBNDY3Y4ckpfNhUXEndTkPy5FZ
	nPzzv4Wbvx+Ozs1T0jlPXcMizU30/n28PQCYNcYO3D+cQgC2MWmLvFa8EDWpc3IFFID13Jb+ezI62
	IIqMg4lkThCRQf9WMGer3mZhJYV23IV/e8xTBYiYIW256dXumzW8abOiWgyO0XyDJSdvrvujn6XxH
	JDrqaBcj0/YDR48jbIyFlF71emuXz6BDWykYHZTQoW288f0uXn50/MP3CFf4+WAoy3CvGiElFprLS
	pj8lWHDmPtJkTDezLCo5yb0B7H2fIoRyQShqxNEsx/YLQAWGkw1hAU7OC+v48D/E/VrPfv2+xdtxz
	+4sxPeSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPFp-00Gprz-VZ; Thu, 22 Sep 2022 16:40:49 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPEl-00Gp6N-5N
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 16:39:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:content-disposition;
	bh=9c9f/Z617NwlepBZ8kCvaLxh0DHSLLYncHvcWBGtmQo=; b=mF1BGQAVgB/KUAw3GuN21F8Wtl
	cdrZMERc1Et3ePJXPYhHZF1FgmkSRYVA8CRESucV43/HCdVHXqMEZjHPXg+n1crhdTSnAD8QJc1VB
	kMV2O1zdyGIS1Dyiom+jhIwA5QB1wrUc5rUoj3eQqqiSY3VqBq8uZR/EOKhxgYZj3qD/4p+n5MunC
	oIHCot5mpdPQla7j8EDFmituvNXooNTr8vmqUXFjMkauVEjIAjamxL5zC9bk3SDTYkfo1ZXdAtcWD
	VYQqeeq1ZWMWO6yJSsnakcbZ75C1u0QeFqluSTviT0F7Z0Z47P8lrJxVyB/MBN7G9/mVmeKWOcH11
	REOZZAbQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEh-00862e-7S; Thu, 22 Sep 2022 10:39:40 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEb-0001s5-Rh; Thu, 22 Sep 2022 10:39:33 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 22 Sep 2022 10:39:26 -0600
Message-Id: <20220922163926.7077-9-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220922163926.7077-1-logang@deltatee.com>
References: <20220922163926.7077-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v10 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem allocate
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_093943_326016_08EF0742 
X-CRM114-Status: GOOD (  11.10  )
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

Add documentation for the p2pmem/allocate binary file which allows
for allocating p2pmem buffers in userspace for passing to drivers
that support them. (Currently only O_DIRECT to NVMe devices.)

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 6fc2c2efe8ab..f4602b8d6e11 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -407,6 +407,16 @@ Description:
 	        file contains a '1' if the memory has been published for
 		use outside the driver that owns the device.
 
+What:		/sys/bus/pci/devices/.../p2pmem/allocate
+Date:		August 2022
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		This file allows mapping p2pmem into userspace. For each
+		mmap() call on this file, the kernel will allocate a chunk
+		of Peer-to-Peer memory for use in Peer-to-Peer transactions.
+		This memory can be used in O_DIRECT calls to NVMe backed
+		files for Peer-to-Peer copies.
+
 What:		/sys/bus/pci/devices/.../link/clkpm
 		/sys/bus/pci/devices/.../link/l0s_aspm
 		/sys/bus/pci/devices/.../link/l1_aspm
-- 
2.30.2


