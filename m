Return-Path: <SRS0=WXQx=56=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3290FC2BA19
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2020 17:34:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084C92054F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2020 17:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RqyzrRGi";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6OFaHl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084C92054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5zz0GFWNifiHtIUBNugKCr16ChCf4az0ay/K7XCGh+E=; b=RqyzrRGiYlGmlC
	4Uy+zxeBN8Agfr86rwmo640/tdM4vV6dBmWfd6+Hw9Y0/mBoJusSnKujnPfMVPtE8b7C7kpmMcSm0
	OsN/TCbW/7imNUnBm6qPWlgp/HepdPnotpD4UEX8i3HwUJSB6oyZzMJQf3fQ1pUSQOl+hzOOLVpOz
	GDMd1pdMniSIKB9/i0paHkx/xgxLuuL7jKl1ycgTxAiBRE+AXj6b8elcgbWbcEVwm3BeNpIYmh1xE
	qDT6HyG9m0tEu1E4UNMKHGISydmGEOCvARhP+GUuMqywOFUNLe/5EDo9Gd/Dvi0HTs8s532yBCDzY
	9x+Chf/z56K7TAQODF+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jOPS6-0005CQ-6W; Tue, 14 Apr 2020 17:34:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jOPS1-0005BN-P6
 for linux-nvme@lists.infradead.org; Tue, 14 Apr 2020 17:34:22 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9AAEF206A2;
 Tue, 14 Apr 2020 17:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1586885661;
 bh=kh08S5dbHA6FwFQ7E5TnW2HyGawRGiHy0gXzR/3V0OI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=c6OFaHl1J+M0/J5dsII+ZJCVP+IQ5+FaLVBGZnA57r6tgKQOoo9xfkHrjscTLIOiz
 wwjwZhcZ5k8EUyCEdzprSbgdI3x/vC5kTiZiGePgwbIv+4WCmIzsiA6X1DjM+X5Mic
 EfqVNHIKleUKKj1KyZeGO1qOqO2e9oKOMcTURJqg=
Date: Wed, 15 Apr 2020 02:34:14 +0900
From: Keith Busch <kbusch@kernel.org>
To: Murali N Iyer <mniyer@us.ibm.com>
Subject: Re: nvme-cli support for persistent event log
Message-ID: <20200414173414.GA29863@redsun51.ssa.fujisawa.hgst.com>
References: <OFBFEC6E14.C0E83521-ON00258549.006FFDBC-86258549.00708C3D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <OFBFEC6E14.C0E83521-ON00258549.006FFDBC-86258549.00708C3D@notes.na.collabserv.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200414_103421_833845_43A39DC3 
X-CRM114-Status: UNSURE (   9.60  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Apr 13, 2020 at 03:29:22PM -0500, Murali N Iyer wrote:
> 
> Hi
> I looked at the latest nvme-cli and didn't find the support for persistent
> event log. Is my understanding correct or I have not looked at hard enough?

Your understanding is correct, there is no support for retreiving
or decoding these logs in nvme-cli. I'll be happy to apply a patch
implementing this feature if someone can successfully test it on a
capable device. :)

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
