Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFEDC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 03:59:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B40B6113B
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 03:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B40B6113B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=BtGwgvwJWALIa/5T38TQnXmC5IPkjTbqzdh25JkLwrI=; b=P1gB0wbWxiB36SlHMvV2zI6cw
	KbaRuNkAaZ9zMSkGsxyXyEhvI2nenDdMYSCk99h2PRjfyQ2E/iCnNx0ZcsMHcOG8F05/Ng8oVPjEY
	TBqj7qWpkxHBBxzql13niuGMzpEJG08DfzooNaYzeJathAXTM28Mx/zkb8Hz7e600bAWn0OPwGyme
	YgNO8eqO9dKBmtxVIe8sTrLi8V0IEuy1/xoa8A6jeRPmfW+mHzVeocFvG6ZDXXFEfcxKkzMMpMFBT
	5I5061vyHOpqIjfgfdKYalfyXXkDf3Jm64fwyi0iGoZp2Y71d0TnCfODqJFWv4JPlre7zwu3Z0fu7
	v2AP+ZKjQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWtA3-00Eiv6-Jx; Thu, 15 Apr 2021 03:59:23 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWtA1-00Eiuv-1i
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 03:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=FuXTMtb4ppWPYyRnyN5l3+tQkH1OJQvsmA4dDE7luyE=; b=MW/mNT0Aw95+6pEPlAUfSuscuh
 WXS62LIId0DYEuv4jKkZ4xvWqJH/kxCOlrU1oepg9rMDdrQCLn02uVJR0besUEiF64LMuQsvsXeAn
 W102kq1dkxToZi2o6PxzSgQATjeI7OF6FxuOiugQlRBgynXlEhAFCTzHcDjA/eQahTzrFTxyDPLaQ
 PPCuvoPjj6kQjMVS49jKoCdrwA1hXgU+4k8STy1JwYkBkmj+L9XZ1JT/W/XOsDQr2R4pje6nywRV1
 kk3YbsIE//ijlWKrJhc6QvWGsXmXMxJbQjQhgzcz9WYltc6SyHu4G1F10XvPExHMoqh0oTA/4qF1m
 cPtwVywQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWt9y-008F5v-N8
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 03:59:19 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26D8C6113B;
 Thu, 15 Apr 2021 03:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618459157;
 bh=Y9UrYPh7hOfgYdmdiFIrPbfr9C7EOIbuXP02917Z+6I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=MfYCY3t3cBYeTIta2d/4u2ALoyrcTZVUzgGfIscm8tMY2g3VnowGgUPfmdZX41uLV
 C5lcVQfDt1vt8jYLIjBe830yKBy4wSWqIaCU/i25kgchU3jcVPqLtFIKbB1VWyBl48
 ajzc+3B/sF8FiWrOYqoTu/5iEI+EbOtLtfPR2EIoC7wmxkPmgU61BOmWeS619P9fP5
 vgi8ANgBhRmiJOd/SO7PQfk21k44UVvq7xymDqkY1D7Auz8UgqKqIGeRdc4I8jT4X8
 WHEL3UxLdkkI1n1Hrrn27P+CvWFB+fa0cPXlGxAJNAI6dLhnQDj95MjfFqlrtrvlhB
 tkpVW+n/V2zsw==
Date: Wed, 14 Apr 2021 20:59:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "hch@infradead.org" <hch@infradead.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: [PATCH 2/2] nvme-pci: add AMD PCIe quirk for suspend/resume
Message-ID: <20210415035915.GA2450149@dhcp-10-100-145-180.wdc.com>
References: <1618388281-15629-1-git-send-email-Prike.Liang@amd.com>
 <1618388281-15629-2-git-send-email-Prike.Liang@amd.com>
 <20210414162408.GC2448507@dhcp-10-100-145-180.wdc.com>
 <BYAPR12MB3238609A9A142C8A03AA587DFB4D9@BYAPR12MB3238.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238609A9A142C8A03AA587DFB4D9@BYAPR12MB3238.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210414_205918_793809_D25B7AC2 
X-CRM114-Status: UNSURE (   9.36  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 15, 2021 at 03:22:52AM +0000, Liang, Prike wrote:
> > >
> > > +rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
> >
> > Instead of assuming '0', shouldn't you use the domain of the NVMe PCI
> > device?
> Now we just add the NVMe shutdown quirk by checking the root complex ID instead of adding more and more variables endpoint NVMe device.

I understand what you are doing. I am just suggesting this quirk use the
RC of the device in question rather than assume the RC is in domain 0. I
realize a platform will probably align to your assumption. This is just
for correctness and should look like:

	rdev = pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus), 0, PCI_DEVFN(0, 0));

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
