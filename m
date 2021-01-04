Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBECC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 18:44:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D65821D93
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 18:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D65821D93
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h8H7WCiuC+oopi2984204CTazXg9c8CZgMg7LYFDvq4=; b=jUDsw8nBzoBvrQ8skrrvFsP6U
	dz3mqGCcUQA87rVyrBhd7HanYbxs9+GB1kO0RHwCyY2p4K5NKmnxC8DbB5DhcHSt2Bk2lKXATf2oW
	Jk8yXdwf1ie9LwfJaQCXSO2U1mQq1VeiWDM6HlHjRQ9UxpcYb70BBbGUFyL0jDU9lIjrIE7JEHkSp
	di3+dNyPcdfHZbgGEoR1mhAgpWnNpE4ADWXwp1WWkz0J5z0cpSIs0erVDg212maTYObnk1obmlgr8
	YMmwdPmFvkBBAGKRM0edHff9adPRsLO7GqjHpKNtirz6a5zZZl0K8bVlXOdnc04HCZ1gac6ijRwBY
	H4vMRsNfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwUqP-0002au-IN; Mon, 04 Jan 2021 18:44:41 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwUqM-0002aO-TY
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 18:44:39 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED70E21D1B;
 Mon,  4 Jan 2021 18:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1609785878;
 bh=BZCbDCfAIPGMN8C51RV1GNs2Lj/tpg4E0GmzGukteb8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=L19PZFd8a54PiyrBCqoaRN6yON4E5SEa1gsGIjojdNCbCSaPVnNndbRkw/iIVm/sh
 Xe5A2+Ee3wtpOnPsN8syf5YW9SEsOEeHyZ9VWleBJUc+yobaMjC+PVuFjCyIgvSRc/
 J0QyYl2+l21zjvgT3YcyLA1BXB5QlJiPPCRs2cHVdRtN3uIQSl3fQF53uWgVxu622J
 L24ZLJqpUVE+a02KA/G0Ls56yJR4xhEC+hVF97h1DsF9v9az+4SBgiI9I49J9fdbQR
 sxlPxlinKeqV0a1EgoI/+SNMeDcKooJJ65EnZDBQg+vi71nmEFPp/FOCnxjjwtG3N4
 2kplfZUJADzpQ==
Date: Mon, 4 Jan 2021 10:44:35 -0800
From: Keith Busch <kbusch@kernel.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Are AER corrected errors worrying?
Message-ID: <20210104184435.GE1024941@dhcp-10-100-145-180.wdc.com>
References: <20210101224028.4akud7meibjavvtf@function>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210101224028.4akud7meibjavvtf@function>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_134439_028671_2744E995 
X-CRM114-Status: GOOD (  14.02  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 01, 2021 at 11:40:28PM +0100, Samuel Thibault wrote:
> Hello,
> 
> Our lab has bought a new Dell Latitude 5410 laptop, I installed debian
> bullseye on it with kernel 5.9.0-5-amd64, but it is spitting these
> errors now and then (sometimes a dozen per a minute):
> 
> Jan  1 23:30:53 begin kernel: [   46.675818] pcieport 0000:00:1d.0: AER: Corrected error received: 0000:02:00.0
> Jan  1 23:30:53 begin kernel: [   46.675933] nvme 0000:02:00.0: PCIe Bus Error: severity=Corrected, type=Physical Layer, (Receiver ID)
> Jan  1 23:30:53 begin kernel: [   46.676048] nvme 0000:02:00.0:   device [15b7:5006] error status/mask=00000001/0000e000
> Jan  1 23:30:53 begin kernel: [   46.676140] nvme 0000:02:00.0:    [ 0] RxErr
> 
> Since it's corrected it's not actually an issue, but how worrying is it
> to see such errors on new hardware? Documentation/PCI/pcieaer-howto.rst
> is not commenting whether we are really supposed to see some of them. I
> see forums telling to use pci=noaer to stop the error logging, but is
> that really something to do?

Additional work has to happen to correct a receiver error, so it's
possible you're getting degraded performance. You may not notice worse
performance if these are infrequent enough, though.

Sometimes these types of errors occur from low power settings, so you
can try disabling the automatic management of these (assuming the
hardware supports it). To disable nvme specific power state transitions,
the kernel parameter is "nvme_core.default_ps_max_latency_us=0". PCI
also has automatic link power savings that you can disable with
parameter "pcie_aspm=off". It might be worth seeing if either of those
changes your observation.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
