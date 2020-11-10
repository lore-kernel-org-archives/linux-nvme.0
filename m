Return-Path: <SRS0=JPfP=EQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF23AC4742C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 14:16:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75F48207D3
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2020 14:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MHTEk13h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZH7yYyRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F48207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3Q5bkCeLXCB3fiKEyCa4QTraZwnVjtlKfIGoHheRUnA=; b=MHTEk13hYAE6Snuz/2B9l3kng
	OPRI2FBKatU+dTye2625xvoUuV6yNJxGIn4IXJ1KcHiyNwOIn6gEzMhVcvjNhRbu1JhEcAet3WZfg
	HW+zA/hYbm2jWxmJmUKgT9pcTE6FDqcEAI1Zlu1766/NcYhZnFGX1329LCiA0NJymPASxkQ3liGsZ
	IX6dJ/H5wA+/G1rvK1zPpCOpbY1T6AEL/zgDTKt32YITTZYjRfbO76s9HLp5aKfnky6n2qRcnWyZp
	f0SUGVwTB6DZYwiYm7tZg8LHH1PWM9WE7QPPjDfUPfgBqWZMQQx0aGIfEloI9un5q+Hks0ntN4HnL
	HPPGFPX7Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcURv-0000aw-3b; Tue, 10 Nov 2020 14:16:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcURt-0000Zk-4g
 for linux-nvme@lists.infradead.org; Tue, 10 Nov 2020 14:16:42 +0000
Received: from dhcp-10-100-145-180.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D79892064B;
 Tue, 10 Nov 2020 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605017799;
 bh=yzAKnfzyFfX1zggSzmll1h/pqaUbZHH5azdI/mlAxEo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZH7yYyRcW/p7+J4kcta9hCpwCwdv+d/BPmIa6oJHHZ2MpG7oDtNgGV7+OmI55v7ER
 ckBEcu5eZFAqc+N55MF92SKbfuuKDBOGIqKIqw9uAFCOMp5n3o1zKijQdkIzRSJylc
 H6l+gZflxsrEodfgEBer9Py2OuP6Wuh3mgtnoQd8=
Date: Tue, 10 Nov 2020 06:16:36 -0800
From: Keith Busch <kbusch@kernel.org>
To: Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Subject: Re: [PATCH V2] nvme: enable ro namespace for ZNS without append
Message-ID: <20201110141636.GD2221592@dhcp-10-100-145-180.wdc.com>
References: <20201110093938.25386-1-javier.gonz@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201110093938.25386-1-javier.gonz@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201110_091641_273609_731BC212 
X-CRM114-Status: GOOD (  12.41  )
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
Cc: axboe@kernel.dk, Niklas.Cassel@wdc.com, sagi@grimberg.me,
 joshi.k@samsung.com, k.jensen@samsung.com, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org,
 Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Nov 10, 2020 at 10:39:38AM +0100, Javier Gonz=E1lez wrote:
>  	if (!(le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
>  			NVME_CMD_EFFECTS_CSUPP)) {
> +		set_bit(NVME_NS_FORCE_RO, &ns->flags);
>  		dev_warn(ns->ctrl->device,
> -			"append not supported for zoned namespace:%d\n",
> +			"append not supported for zoned namespace:%d. Forcing to read-only mo=
de\n",
>  			ns->head->ns_id);
> -		return -EINVAL;
>  	}

In the unlikely event that a f/w upgrade adds append support, do we want
to bother clearing this flag? If so, we would need to refresh the
command effects log page.

If not, you'd have to rebind the driver to make it writable. I don't see
that as being a big deal, so I think the patch is probably fine as-is.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
