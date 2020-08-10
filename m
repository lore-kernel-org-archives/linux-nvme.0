Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB48CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:11:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4E3B206B5
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 21:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pjXX8khJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAqk3G/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4E3B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tLFb4iFv15GU0peFNkFibLJ4f10j4dW53OQqTawYQBI=; b=pjXX8khJG/IdOfylUWZBeRTo5
	Tzg5gp8p1Nd3SkdG2V/jyrZ2/3UPisMQETUR7xDCkWErrc/Pj/HmJr6mXvHXIf6INJQ0G73//YMNS
	TjuOsWcLNZzNxS3dNx4Sv/0oSRyajPYaC35fiXQ3rbsQK5Yy8mehmpi6dQ9NN0fzTDUm2OnWOb7XT
	qdMa/CFTSGiqGzBX2QWcF3ap/csCNlBnk+TGxie8BhR10zTikYeiHnose/kxr74eA34zKb0HX4lAd
	kMn494OMJ0LO3X8dF/GTcWQlVyo49yH9zkd16MvvorM6MYQGEePS/0N7+jzuXHEtTZixQQTW+Z1Vt
	RmQoZ++dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5F4n-0003Oe-6P; Mon, 10 Aug 2020 21:11:25 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5F4l-0003OJ-HJ
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 21:11:24 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C95B206B5;
 Mon, 10 Aug 2020 21:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597093881;
 bh=Eydrj9M8awrci3OJuWt7IUxmBCO8ZOUegIcwMBB6YTQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gAqk3G/S3Ded/zW1myFB8+geiE+VWmnWnkspfRpgnwkDVlfEMDJSNWY0ZjytyFBK4
 AuQPD7s2QpyRQLb1G53qsmARHxUWgZh2ImUzQ9gdAsOV1kuQDp8Sa8+wwnCremMby1
 0YfeoDY6VIxp4LUeFeS7Geneon4TJlG4H5wIkRw8=
Date: Mon, 10 Aug 2020 14:11:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Message-ID: <20200810211119.GB269401@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_171123_653135_D01A838B 
X-CRM114-Status: GOOD (  12.48  )
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
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Aug 10, 2020 at 11:54:50AM -0700, Chaitanya Kulkarni wrote:
> The function nvme_is_write() only checks the last bit of the opcode to
> determine if command is a write command or not based on that it sets
> the bio->bi_opf for passthru bio with REQ_SYNC | REQ_IDLE.

Are these flags even used? I'm not finding these getting copied to the
'struct request' in this command's setup, nor am I finding anything in
the blk_execute_rq() path that checks the bio's bi_opf.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
