Return-Path: <SRS0=aESL=MZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757F3C432BE
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 15:56:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C3F61103
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Aug 2021 15:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 40C3F61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bFwTR15EEP9wcysyelb3PlyFEZLwsNe0aN4ljuuOvFg=; b=ZNFOaSh/TKkj7O
	rxEdKtaSkqNdvz0XFq9iVnZvK8iNB18KOE2bcMyG7HjBxIqQhaCgyQeqfAR0sDjKfluDEgbGcshVN
	vItbpZzJMhC3qURZxM+O8uOrcWs72ss8Pqnl82hfvRk+2kWhjWVzhEG+jPuNB3pd7IzQhX0I2Bzbq
	nxhc6janiQKJfaWW5X4lmnzbJq5Kz0G5lSMvK15PL7/hDFXIOQ2JTkBHpT2m5Cke1E7VGRSA123bL
	atM0muCMLHuzLH2Dyi28CihrNEV7Aih4UqiKUolgqZZFaPyQylm91B4G254OGO+6htZLwF/AIQoAE
	WMKiQlKVeuUrIZyPVTEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mAaJ3-00H4iW-83; Mon, 02 Aug 2021 15:56:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mAaJ0-00H4hV-PF
 for linux-nvme@lists.infradead.org; Mon, 02 Aug 2021 15:56:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id D169261103;
 Mon,  2 Aug 2021 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627919802;
 bh=rm3KUMEX7Ey/9EDUwMaGOFKN+Lwxj/SdFWzs3POcZzA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OiHQ0Ef21+vPBPNTyrSvMC39yqECQivJZ4tB/5iXvbzDbOrpt5fJhmvCzj4logLWe
 JLoATGPXPam7qFmWSceFs5Sp1463nnbG2Np0ht96rQtwalCM0LcLevRdXvVTs098HC
 vJFdlho2Jm5Ey5NKyyv7cYgfsMvOXD2Ymeydn51jLbLAJnYEIoeWg12m9d18RIpICm
 k3NVqrE83+aVVep3BKsjVuX9RKmo5wDlthoBIZxf3QoYlrZ1Zfhi+r+/+KXL0mxFN/
 q+V8wVWPVxdm6qaFGrxP+RWCETuEBCRjpssHamZlNphtodF2tpIJwWNaH/jf3vxxpi
 9DpflMhWPmrwQ==
Date: Mon, 2 Aug 2021 08:56:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: koos vriezen <koos.vriezen@gmail.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: bisected: 5befc7c26e nvme impl non-mdts gives smartd error log
 entries
Message-ID: <20210802155639.GA2293188@dhcp-10-100-145-180.wdc.com>
References: <CAGCbPWTKos2c7aLt35ZvsvK56Tqy05BTOTeaEbL8jJty25J+zg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGCbPWTKos2c7aLt35ZvsvK56Tqy05BTOTeaEbL8jJty25J+zg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210802_085642_884691_58CF4933 
X-CRM114-Status: GOOD (  11.31  )
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

On Sat, Jul 31, 2021 at 10:32:20AM +0200, koos vriezen wrote:
> Hi,
> 
> On my XPS 13 9380 I get local mails with content
> 
> "
> The following warning/error was logged by the smartd daemon:
> 
> Device: /dev/nvme0, number of Error Log entries increased from 28 to 29
> 
> Device info:
> PM981 NVMe Samsung 512GB, S/N:S3ZHNF0KB11472, FW:EXA74D1Q, 512 GB
> "
> 
> after boot and increasing numbers after resume. Git bisect report:

The controller shouldn't log an error when we request an optional
identification. We don't have another way to determine if the controller
supports this other than to request it. I think this should be reported
to the device vendor for a firmware fix.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
