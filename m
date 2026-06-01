Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF33CD6E56
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 10:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fwEpVo49TgJKvVQDr0u+PJdeSHwhkkb2G/1D50QA9yM=; b=t0dMws3ARMheFULjtO6D2wzwIp
	ll1QNbs+ypeyTxeT+0YNuQhl9SCJcIvCAQqqnhUR2IeLvaynBlNyysPE9hw3M7Tbg2mK0X6Efh2UZ
	n0PSHnbHxUSmZ5fDdwaxVuPrjPe4F2SsBH337y/FJAshtsu2niNReD8zElFsBUP4MbV8eSrG1uQaU
	rdJ/H4YQDVkq6tYO6mQxopJKm6Z7nBd8D7KaU90eWTNO0srWvqePHyXCwuFT1nVUUJ6j6F4MpSu+B
	ximyB+YLbB6JzRFP2E2vnGfPelP2mdhM9OoUN1qwEN2tAmKqYICFbSSiUumz2ZfGjzAmawmwby3HI
	Q2svDlrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzz6-0000000AdGX-0z6k;
	Mon, 01 Jun 2026 10:35:04 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTzz3-0000000AdFf-0Xo8
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 10:35:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=M5IdJIAnkhPlqA
	dAqKSI0KurBV293IG5hCJcTD/uhdU=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=YnIUenZD52ydq/zX+3KIrIIHUgzHHcAkFNsmR
	plm31CuG5TVvv02G5lMworsuE0hRI900u3+eN2Rrz4pCUUDxscWf1ZwU2mFch9iOSOEaaR
	MmFsbYC2CoJRnZufuhlpYa9xhl4PTWBcBt9rGOjTQqfEFmoB/Ta4/jEAFwQMrT9XorBs4t
	L7gW5CqMZly3EtLek8JxqcDfxSocrHSF7ne/DqgQcTh0j04myonGiyhw9cboxQm61NNTpP
	I34ZQd5+7PwH9px1aaRSl9wN0066wgGl4UBKz4l0Hj/zMZDRhMhaF6Y6B8u/hNeWSDrsKP
	+whgWtVOJgzHqqEe6FYRRwqkA==
Received: from localhost (<unknown> [193.207.180.184])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 70d17cba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 12:28:17 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 12:28:14 +0200
Message-Id: <DIXN4746EVPY.1U3JU3JVQ1557@arkamax.eu>
Cc: <kbusch@kernel.org>, <mlombard@arkamax.eu>,
 <mkhalfella@purestorage.com>, <randyj@purestorage.com>, <hch@lst.de>,
 <linux-nvme@lists.infradead.org>, <emilne@redhat.com>
Subject: Re: [PATCH 1/1] nvme-fc: Do not cancel requests in io target before
 it is initialized
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260528092734.258899-1-mlombard@redhat.com>
 <20260528092734.258899-2-mlombard@redhat.com>
 <564f1396-dd4a-4246-931e-8541c8625211@flourine.local>
In-Reply-To: <564f1396-dd4a-4246-931e-8541c8625211@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_033501_795599_919981C5 
X-CRM114-Status: UNSURE (   8.45  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon Jun 1, 2026 at 11:47 AM CEST, Daniel Wagner wrote:
>> @@ -2900,6 +2900,11 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctr=
l)
>>  out_delete_hw_queues:
>>  	nvme_fc_delete_hw_io_queues(ctrl);
>>  out_cleanup_tagset:
>> +	/*
>> +	 * In CONNECTING state ctrl->ioerr_work will abort both admin
>> +	 * and io tagsets. Cancel it first before removing io tagset.
>> +	 */
>> +	cancel_work_sync(&ctrl->ioerr_work);
>>  	nvme_remove_io_tag_set(&ctrl->ctrl);
>>  	nvme_fc_free_io_queues(ctrl);
>
> Again, does makes sense but which tree is this based on? I don't see
> this hunk in master or in nvme-7.2.


I am not sure what do you mean, this applies and compiles cleanly
against master.

Maybe you are referring to the comment?

Maurizio

