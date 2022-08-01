Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9250C00144
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Aug 2022 18:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHsERas7cd+IYYGEgYpydYgZdZKCngYjgts1H+pK4Vw=; b=buOugE/wE0ke48hRzzLDkGPQAS
	r/EsV8jtiWo5STqsJeZonJq1EiYREDKTgamY7gZ+apL+rqMadK2NjGB+pPgYWLcNmiMRrBPRtvsfi
	GrEiUEy7IQiJvvWVnthPyV0wZdCtn0yAUyJlxQFO608B/4yKbjc2H0LrRqHR7qc9/tOctFXMFh7vq
	7Hh+Gep0a/j+MGBTHjQ8tgCigCbuwlJrOzDZU+ZbE3OMH7VtT2jxQrXKQGKGKjVCbb2y82cTXYWTx
	A6RijtO7+yiN4jTHqG4wh9mzvduAyNOU7/WD/O+aPPP8nA8J7UJ3DZK/uIcGIyksy0yGEkPSUglMT
	PbKvcsYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaFO-00926B-7s; Mon, 01 Aug 2022 18:34:34 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oIaFL-00923l-PT; Mon, 01 Aug 2022 18:34:31 +0000
Date: Mon, 1 Aug 2022 11:34:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gilles Buloz <Gilles.Buloz@kontron.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: NVMe write protection support
Message-ID: <YugctzU0uDZvfAal@infradead.org>
References: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR10MB62528F66099C2311E2AF1EEE809A9@DU0PR10MB6252.EURPRD10.PROD.OUTLOOK.COM>
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

On Mon, Aug 01, 2022 at 08:36:12AM +0000, Gilles Buloz wrote:
> Dear developers,
> In case an NVMe module has a write protection feature,

Do you mean the "Namespace Write Protection Config", Feature Identifier
84h?  In that case you need to set bit 0 in the NSATTR field in the
Identify Namespace data structure(s) and the kernel will mark the
namespace read only.

If you mean something else, please clarify.

