Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC84C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 20:46:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1361D20656
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 20:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L0KBLwj4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu4daNnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1361D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6koUhjaEXn+KSgbdvXf5/Bs8699G3cIQXgPXv62UmB0=; b=L0KBLwj4i++hO54dA2hmilcf6
	qAhkbDQF+mjkXJZ4CCYtqgZorYdXAUBlShGqbFgdBOCQIutKhjS1LTvMw7JFOKeK7KWccvq8M0ikJ
	7eGV+OhbjM58AxCtvKWT7gK43uVXzzL8miFtmpX0v1DWVx/7obYKYEdmidwwHoQx+mmE8slVY1Exe
	iDrfcw1Mp6ANCoHr5RREDh1sGFWkuBt3NUefL/E3gOWr15dGQUKBdkGThla/puFv+Aeef9Px90Fnz
	OREHLehCSxLMSQkIS2M+/Pj7oIf90xiCnUS1qjrAPAmY9aYJlug73oCFbCRXPLZ7wkeqNZMyTqtuz
	NFzMFZQ5w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Egk-0000z5-I3; Mon, 10 Aug 2020 20:46:34 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Egh-0000yb-IC
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 20:46:32 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5DF0920656;
 Mon, 10 Aug 2020 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597092389;
 bh=TXB9J4UvY6I91uH/VfUn9lp4JapXDtDXkJuoxhcWEIw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cu4daNnBKfjGYbJIHGDTtk9nRzb+HdcbqYoVwLVraEN0/Gvvrb6TCsqqzE9VNMCdw
 Ftca5A96FvcdIE3XIwh2AJ2kAmf07i/G9aNyjXnEx4lELt7ANZZK/pLkG9qWjxjsV4
 t5V1OMFRFPRhVbfzbh++XYcAy+j+BtNKcMjik2rI=
Date: Mon, 10 Aug 2020 13:46:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 06/14] nvmet: use unlikely for uncommon commands
Message-ID: <20200810204627.GA269401@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-7-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200810185456.7713-7-chaitanya.kulkarni@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_164631_686514_ED5C0130 
X-CRM114-Status: GOOD (  13.53  )
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

On Mon, Aug 10, 2020 at 11:54:48AM -0700, Chaitanya Kulkarni wrote:
> I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
> when accessing passthru controller, most controllers should not
> have set the effects for r/w I/O commnds (atleast I don't know at this
> moment).

The method that gets effects actually always returns 0 for IO commands,
which is the case if you are sending this command to a namespace.

>  	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);

In which case you could skip retrieving effects if ns != NULL.

> -	if (req->p.use_workqueue || effects) {
> +	if (unlikely(req->p.use_workqueue || effects)) {
>  		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
>  		req->p.rq = rq;
>  		schedule_work(&req->p.work);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
