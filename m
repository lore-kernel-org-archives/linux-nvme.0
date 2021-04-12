Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E775CC433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:49:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2767C6135B
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 07:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2767C6135B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WEUUBtCv1eHCDcH26WsYrL4TpORPTaRJAA/GaWXy7po=; b=cepBFnUtnPmMrrewOtN40OCQK
	hsxFupNdHB/mOBXgf8GGFSqGszEs5yze0guhnUETe6KJfEKtEOvBsLB8qxEM0epeVM09bOZV3cvfz
	ukuNHlYk7OXy9WY0222ldU0ZZAVla3+7Bq5DKllMLoTlC7UTkHjF1alAnu3YDt2dzuGOfpOjZI5Vm
	0eiwjo8adH3VdSxVj1s9vutYbHymxHudhqpraR1oCh0xKNjbGNpwUA/hVqKzeQui3zIfkQiVgaoRj
	HP4gmmYuXHoWjGzQvK3di+HR6MDifxUd+zIMyLmKYcdNmNubTD/3Mk6wDHDFjGTLBX4KaBJMPX6Fm
	ERo5V+Oyw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVrJQ-00619m-8N; Mon, 12 Apr 2021 07:48:48 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVrJC-00618p-Sf
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 07:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=rFtat2jViATy5vdCIpEfo793dXLULAcOer/vj9JyrW0=; b=HAx1Ck0pkGclygrZ1sgSiL4sQM
 jQgOkBBBUs3oVZzc65D4sEYNWpCS3hmgN0XDPd5bAdmAUui/drhLlwD5gjhiMxgG+iA294rx8xFc5
 eI8sddG1Cy1nDxboYelq8sclwsLTtKj19RdNdZ11+9lGbVj7NXp6dzO+aEJYWdRBeYuZi5Df8e0kM
 4yLY5Xsul26pvZvHUVP6UEHlW2UByTZ3fe3rZdcL5Zkp8T+em0IlvSRXq8Izk9FtaglNXKzdF4KQR
 Gc2a+bDMKV2HFHnO4e9UmYzpIUKbknZc6+qt5Y5Z7D7q8U6/y8VCQRXBxCQ/76ed3V3Hc43kawrxN
 gHl6DE1Q==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat
 Linux)) id 1lVrIx-003x7y-IN; Mon, 12 Apr 2021 07:48:24 +0000
Date: Mon, 12 Apr 2021 08:48:19 +0100
From: Christoph Hellwig <hch@infradead.org>
To: amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, james.smart@broadcom.com,
 Chaitanya.Kulkarni@wdc.com, James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Message-ID: <20210412074819.GA942225@infradead.org>
References: <20210322195717.13094-1-amit.engel@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210322195717.13094-1-amit.engel@dell.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks, applied to nvme-5.13.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
