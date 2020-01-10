Return-Path: <SRS0=/IAj=27=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C987C282DD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 19:24:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF6920848
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2020 19:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OV9Ar6QZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lu2Die3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF6920848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=23CwqqAMD31m5vL+nvQztZlA+E+MGGOp9AUjjbKgofg=; b=OV9Ar6QZiuXdce
	x5fAqnoKYm+q9PrplQ9Nc4s4uCsIdbwLH+yZ8MF86BwBgNcxzdqvwlM2ogbbq2One3lL2xw7Xn0VN
	OtDtwCd69zFYBrSMtePQ/wlPRhvfxS5WM1o5SBduVZ4Pp6Dkb8w8hwDA31P4EGS3ANpfq0cFlxK0M
	XAogGA0JKtV4DBfXFp9uWPVoeNEgxUwGdL/AY2Ldn3Nm/TfTfR/HD3x/1QeV6Gvoq6uZ0vguKnGCh
	z2nivifg9vOvDLFqkJPJZS5zt8M/YO8N1ogEVVX8M0Z9sMNbmABW9zhlgYuvjAr0shuEcLqXMpSf1
	j6IpePTkzj92ZpBk+TXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipztJ-0006rO-DW; Fri, 10 Jan 2020 19:24:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipztH-0006qS-2E
 for linux-nvme@lists.infradead.org; Fri, 10 Jan 2020 19:24:16 +0000
Received: from chuupie.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2D97120848;
 Fri, 10 Jan 2020 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578684254;
 bh=SpfcY1Xbm59LDjFMZ3uuzyaEiroTvHs5+CZQ2oVlcNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lu2Die3qPhU7F9x8TsvGDELgqvkHFIsBFdxUQIpRNMEC0KFMb36R/LS7w1EKSXk+e
 yvGllZr0jN+5uoKg4+jqUNIpPQEh+5Gl5UP3+P2kMa6dL3gLLxEAEK96YNbxqD2AcC
 E04gNbzJ0U1hurhvJv1Yl/OonyfOLxVKA7/9RG2Y=
Date: Fri, 10 Jan 2020 11:24:12 -0800
From: Keith Busch <kbusch@kernel.org>
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>
Subject: Re: Page fault on branch nvme-5.6
Message-ID: <20200110192412.GA1041950@chuupie.wdl.wdc.com>
References: <BYAPR11MB271291B9322BFF44486E5673E5380@BYAPR11MB2712.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR11MB271291B9322BFF44486E5673E5380@BYAPR11MB2712.namprd11.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200110_112415_124700_E9D6165D 
X-CRM114-Status: UNSURE (   8.70  )
X-CRM114-Notice: Please train this message.
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jan 10, 2020 at 07:14:46PM +0000, Wunderlich, Mark wrote:
> Ping: Anyone tracking this already?  Do not see note on this list, maybe I missed it?  Will dig into it more unless already a known issue.
> Thanks --- Mark
> 
> Just updated to this branch.  Performing baseline testing before attempting to make any patch changes.
> Fio libaio seemed to work fine.  Fio io_uring hitting PF.  Attempting I/O to single nvmf tcp device.

Thanks for the notice. Looks like I've used a bad baseline to start the
5.6 nvme series. I'll find a more suitable starting point and push this
branch back out.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
