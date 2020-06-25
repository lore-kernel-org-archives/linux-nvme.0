Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0DBC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:49:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAB9620781
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="beYZK5XG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z3VVoS+6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9ON+615"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAB9620781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZVAY+oCZoYIzv4cUbhZiTMbRUd/TtQ0Yxsuf5FpI0wM=; b=beYZK5XGoVW7YHbkyLYWBNNNA
	mt3bvRcKhCcCdQR+UzE0Oa9D2NzjtBF4x/pRIAypumzSVsDLmmJRjZSGeMdvk0kLnnNV25i4Yy84m
	4DepYOGVaynBAfRFzcfV8RcCFwE/ZVu5tzzBSi+FbSoSpXMqu3orqYqnW1wIyxjqWHRswEE/ck8dZ
	h8lFXpymqiDs05BQ+vCTlqV7MMcfGTXg13V4Psp9z+qZTk9xHwHADh5wBbvsAwh/8ZcZwRHUJRNdX
	1XAqBFTRdCYCK9GekdOoZ4THxL/YPuurvPooIhnZsJ42xH70XhrMhXo50lPvalmpgArWge/Rnsbwq
	e7hcKPH/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomqe-0004gv-Fg; Fri, 26 Jun 2020 11:48:48 +0000
Received: from casper.infradead.org ([90.155.50.34])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jolNN-0001V2-GE
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 10:14:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=lzyFWo86iZe9eq6LGUCUxohB+V0jXUL8xvrcxQFDISE=; b=Z3VVoS+6G1DsPMZXHo5bGah6Vv
 fyfgXR3uQjeoD5bz07xXGIMbTd1wwpPW6cgpLvMtS9ilPZ6FtY2UPuskplPq67yqNXu0kR5hzgH0i
 W90bcEaih7d5WReb9vFRok6RWVwG5yJqqt34AtgRu2nirGdZRU7/f6vCDq8PNNWeWn622BQG4YOZp
 Ll8kOPvnqe2AxS+sQF28sdocSs28/WQ1p7YORfixX7F1gHVz22ygLy/rYofs9yHJZOquAp4YjOHM8
 jcAENAYmYEVDtE7a3yGBMoglxLQQSaiTJS1RKYz3Es9fweKRS7Ttqp1EXVp8OlGe7UuXKTyj5MWiY
 02aLiVvg==;
Received: from mail.kernel.org ([198.145.29.99])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joVKw-0000pb-JD
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 17:06:57 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B12B420707;
 Thu, 25 Jun 2020 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1593104811;
 bh=MctoXz+8DooV3AcZaIqf88+Iy+QCalq9Qo6fuQvwJRI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V9ON+615OXjxV7/btRnHVBGOgZUwzuH0LR//Q8fMWRfKUZKbJz+AMJeAJPm7zfp78
 y959OY0JqrcQQTDtlskvKBHkCgY0XpNtpmPZgCuJlJ+0FI6TaBsJ3XYGpH7ubAmROj
 J9+T+483nEU2oGkecAsL4lHCCd2qx1+wpXbPj6wk=
Date: Thu, 25 Jun 2020 10:06:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix identify error status silent ignore
Message-ID: <20200625170648.GA1533037@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200625000257.29981-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200625000257.29981-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200625_180654_980281_4597F027 
X-CRM114-Status: GOOD (  12.55  )
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
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 24, 2020 at 05:02:57PM -0700, Sagi Grimberg wrote:
> @@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
> -		if (status > 0 && !(status & NVME_SC_DNR))
> +		if (status > 0 && (status & NVME_SC_DNR))
>  			status = 0;

Just remove the gratuitous parens, and okay to go. I'll rebase the zns
tree with this patch.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
