Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108B3C021A9
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Feb 2025 13:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:
	Subject:Cc:To:From:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PPqfVe6iVruXBlelKFlvxCjamAQklPE50Z3+WfCCBcE=; b=sp0WFHzlWlR5tthzyCAXJ7HOYv
	jHNZvs8e/lhgNXWpkGqXsfnwl+Zq1LzqyorKzX3izGXuaPDrgrROmdydZEHkqoesrZdV6Hp9ijSbg
	XtP7SOg/PCk78f/4nZgqoiF9c6LCoUXhGoMp4gLvdISNCdsETWz/rNAyqzFmLBnfmzw9L3PdQ9DJJ
	h5y9Efg9DqzzbIgKDdMNRN6G2vZaZhxq00d/jzVcGt4/Wvyvpti3FpFLuUelWxk1WN4hoWswQd7hy
	ZQPoT7QTocTibguTRlKEGLVYK3AYwuiHNyqgNoBJb8SLHNCwKgZArCXbPKL3ZwDZxe2wBEwNbf/WY
	6Gj3kddg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tk1I2-00000004h4V-2EZz;
	Mon, 17 Feb 2025 13:36:02 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tk1FW-00000004gMn-2QWo
	for linux-nvme@lists.infradead.org;
	Mon, 17 Feb 2025 13:33:27 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id c774ca0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 14:26:44 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 17 Feb 2025 14:26:44 +0100
Message-Id: <D7UR7CRSO1GQ.P6NWP5L85AAC@bsdbackstore.eu>
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Sagi Grimberg" <sagi@grimberg.me>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <linux-nvme@lists.infradead.org>,
 <hare@kernel.org>
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
X-Mailer: aerc
References: <20250214190012.311960-1-mlombard@redhat.com>
 <92435d5a-34d8-4450-a0ba-f1fef782b3a2@grimberg.me>
In-Reply-To: <92435d5a-34d8-4450-a0ba-f1fef782b3a2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250217_053326_950213_E41BFC42 
X-CRM114-Status: GOOD (  11.72  )
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

On Mon Feb 17, 2025 at 9:14 AM CET, Sagi Grimberg wrote:
>
>> +	fes =3D le16_to_cpu(pdu->fes);
>> +	if (fes && fes < ARRAY_SIZE(msg_table))
>> +		msg =3D msg_table[fes];
>> +	else
>> +		msg =3D "N/A";
>
> msg =3D "unknown" ? we shouldn't suggest N/A because it should be very=20
> much applicable.

Changed it to "Unknown".

>
>> +
>> +	dev_err(queue->ctrl->ctrl.device,
>> +		"Received C2HTermReq (FES =3D %s)\n", msg);
>> +}
>> +
>
> AFAIR, the goal with C2HTerm was to also log the offending PDU itself.=20
> However I don't think
> its really necessary looking back.

Yes, it also provides this information, I just didn't want
to make it too complicated to start with, I can improve it later.

>
> Can you test this also with header digest enabled?

Indeed there is a small change to do.
C2HTermReq is the only PDU coming from the controller that never includes
Header or Data digests, so the driver must skip the checks.

Will submit a V2 today.

Thanks,
Maurizio

