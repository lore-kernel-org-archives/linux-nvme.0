Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DA8CAC59A
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Sep 2025 21:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QKjojzLJxCVpyTNkNH0/brG9ExBBvoq8g8w836T50eU=; b=JgKf7KiMEuQEaMjKFZgnYJBtsl
	zOM/5UQxKGonoVZvrL2xgEQpvJEhnMVbeASBULbJ0JeXdEDOm+1UvIl/6fG07JCGLI+CmwpG7HPW7
	OGZWOVnatYnj9kp5MZQiqBylF8dAKspMjZn+fLdFT073JiCaE0a7bEjJ2ZyngNdqqrchRzfCiRRPH
	PB17KypFYdvPyrnujdeDG/qAR30dZVgMyT883xlWfVUUzJU0Hzv8txi4qT1CKx+vqFEtBdfk/WFMd
	CzQDpcIa+UFrDRi2v2l5IcGmCQRMa1OKO2VbtAL9XUrTYY1XLjsXDEkCnMiO2eX0EHBNicR5FN9KH
	Lwygww5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzv9-0000000EzCL-0NGn;
	Wed, 17 Sep 2025 21:42:35 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyzv6-0000000EzAT-41UQ
	for linux-nvme@lists.infradead.org;
	Wed, 17 Sep 2025 21:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758145352; x=1789681352;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x3uPm0xYDopT12eXOctOMhNA/7AZX0eI/ADHUbau0qM=;
  b=I5muQb3asEhyPo+ou1keKtohCLGQKKs92BPh28ac69NA7/JVemxynr8b
   WQGtZtMD5vW6yf89PzyVSpxYndkDuxGfAj2Rav4ZgOVj8vkuHqURgOYv0
   ZJ1tqs6aOaUgIFJ0y1ZCneGIRwrqa2/DMYNMfoGXKsyNLtIhem4g578uv
   OZ0xOhxSFsm3G77nVj+PXIQ1LoW1ft1CYgTk1MyLxkrJBpiJ4yMA5HnRy
   f6l5Ym30GCxOYVM2HuwcUBWqnBojOTq4MleOeYZS0o7lEfbL0Cgfq0fLc
   +3wcllCoid5GZPIn0OMkzuRVUFY119Az5X5jjr/a7sggdBfiPYrdQxuSq
   A==;
X-CSE-ConnectionGUID: 6uWtZwUiS1OHPHlGxBz3jw==
X-CSE-MsgGUID: JoOcLtjmRvu/ZutFIrBw7w==
X-IronPort-AV: E=Sophos;i="6.18,273,1751212800"; 
   d="scan'208";a="123023731"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 Sep 2025 05:42:30 +0800
IronPort-SDR: 68cb2b46_Q47LT/72ntL08g9QvLypjefRxXEL2FbBtDo2mXudaPcAVah
 YfGekGKJ2iARO0a86TDotPaNpkakATe6UeliyXA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:42:30 -0700
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Sep 2025 14:42:30 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4cRsgT5vMJz1SHvk
	for <linux-nvme@lists.infradead.org>; Wed, 17 Sep 2025 14:42:29 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavis); dkim=pass
 reason="pass (just generated, assumed good)" header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=in-reply-to:content-disposition
	:content-type:mime-version:references:message-id:subject:to:from
	:date; s=dkim; t=1758145349; x=1760737350; bh=x3uPm0xYDopT12eXOc
	tOMhNA/7AZX0eI/ADHUbau0qM=; b=Ywanj2ffby068BMfzTQBw0cfLVzudeZtQX
	hJRpKTxAjQcvgorsucp+M7wgqcZbQqP145E97i+J3EjQtNxsOPcfQVvdmmkZuKOl
	vUSBndAcgYhROaM22rE+t8vHJM2BOyHLCWXpe3Zu8Ief1790BRw1OHudZvn+J9g4
	0O8sKyE7fk142QNkyNDEWqolOHACe1X5AvAsDQ6HMjyA2nqkJoojkDgi0OL82Ye6
	BcTToxW6zvYCxlvZ0qPAhxklhuzDLL90LzavCTanQ53wTpiy6DJemfoRr/JZKdhM
	HjIVQ0sJkowwyd1pBfxRhKKekbUg2yzBGPEmPc8zxQ0vIBffyPYQ==
X-Virus-Scanned: amavis at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id HdkZSkhkfJ0c for <linux-nvme@lists.infradead.org>;
 Wed, 17 Sep 2025 14:42:29 -0700 (PDT)
Received: from opensource.wdc.com (ros-3.wdc.com [10.23.145.79])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4cRsgS3S2Rz1SHkR;
	Wed, 17 Sep 2025 14:42:28 -0700 (PDT)
Date: Wed, 17 Sep 2025 14:42:27 -0700
From: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
Subject: Re: [PATCH v2 1/2] nvme-core: add method to check for an I/O
 controller
Message-ID: <aMsrQzOukUXB0TZ7@opensource.wdc.com>
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-2-kamaljit.singh@opensource.wdc.com>
 <d1db6858-75e7-4853-a5e8-d0f1f02fb389@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1db6858-75e7-4853-a5e8-d0f1f02fb389@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250917_144233_093919_97863C86 
X-CRM114-Status: GOOD (  18.85  )
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

On Mon, Sep 08, 2025 at 02:56:35PM +0200, Hannes Reinecke wrote:
> On 9/6/25 01:25, Kamaljit Singh wrote:
> > Add nvme_is_io_ctrl() to check if the controller is of type I/O
> > controller. Uses negative logic by excluding an administrative
> > controller and a discovery controller.
> > 
> > Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> > ---
> >   drivers/nvme/host/core.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> 
Please review and provide any feedback on these 2 patches.

Thanks,
Kamaljit Singh

