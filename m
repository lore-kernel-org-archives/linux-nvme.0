Return-Path: <SRS0=uU0g=D3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25658C4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4931121D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SkX1YwlL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJbITkWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4931121D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uheppLvPmaaDU/KK/tSIpS8B+S0d7DXEKM5yifU/WvM=; b=SkX1YwlLa4PvFzViOMUIVt+8k
	BJk+LNOx4u65OOKWwr1xd0v1umvr6PCCkY1WHNoqPbPGj18AmWNVHpCCUvE5qY5WTC6ZpDNAxHUCv
	evhaaiVaafOSn7h6ClXgHMuoU5FXhdCiw9Vt4e1FE5whiUuSFouKfDfZO/GA7zJTWS+M+KKMo5SL8
	Vfni0cxXyyHb7RNLJ8XbaKvgCjcadFzoOrWGgVKkzB5ptesPt/ryGZ5inb7z5SeDpCk37muqQnQVo
	DD9+tpmT96zus3nkzKDgE6eSj3m/fL8eaFkFn0ZxkIlK814QnkIRn3ihjhL+c2I3rLLIrX0t4AxhL
	wQc1Q0tLQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUt5q-00026n-Dl; Tue, 20 Oct 2020 14:58:30 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUt5o-000267-Ns
 for linux-nvme@lists.infradead.org; Tue, 20 Oct 2020 14:58:29 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BC7421D7B;
 Tue, 20 Oct 2020 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1603205906;
 bh=yQ3+k1bvxbxJ0qWMh3j7gJE6Ah9FMjkshIQdp/J1geU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lJbITkWE4qBzrNIFOV00Hxe1UDH11OZUqSb04dI6uf69kDq2E/YkKgEyxl5aazDOo
 T23QZ2lKCWpVd7wfApOd0zMt288ociTtOpV7o82nFTbm7dZX66JAq16gr3njgPJ5nE
 qzjo8jWitOO1nb6H0abH1QlPXpUKWO65sqHJsnww=
Date: Tue, 20 Oct 2020 07:58:24 -0700
From: Keith Busch <kbusch@kernel.org>
To: Han Han <hhan@redhat.com>
Subject: Re: [PATCH libnvme 0/2] Two fixes for the rpmbuild spec
Message-ID: <20201020145824.GI1435260@dhcp-10-100-145-180.wdc.com>
References: <20201020134921.270042-1-hhan@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201020134921.270042-1-hhan@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201020_105828_946050_95837ADB 
X-CRM114-Status: UNSURE (   8.29  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thank you, patches applied.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
