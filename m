Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB38CAC5B8
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mteyqJ+aNjjLH/ss2WZIm9u7qv5L6hUgc0ouRxP9jF4=; b=efsP0PYuQIVOGRpUuIrikqgCaW
	tpyzqYvIQIXNetlzNHRTmQqnTHike45qFX5VWRucRi1JFhgAlZBD/NfJg+Q8YUDwqUZDe8LdzK5Pe
	qgpu4vDb5/PEfCNCoFaWuYN6WzBNn+Rf+8G9adtgO2lHs3XKYvcpbuemxStgTcxfaQWqsNCXKUQye
	7psfrBVM8xORXADSiMxVfAcMxAz7BPs8BMoVzulU9VnSuLFK2vQuuVGJALu+mwOg5Bko9rzSK54eN
	nl7ITsPffVHeYjS2GRh5EdROSexArc4Bb1Erj+vDop7ToAOTvG2AqJoc2QLOnvjBQH2YhkP95ehHk
	AK9X/JIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5m2g-000000009on-0tPk;
	Mon, 06 Oct 2025 14:18:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5m2d-000000009oT-2ATk
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 14:18:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B0DED4441A;
	Mon,  6 Oct 2025 14:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 571DCC4CEF9;
	Mon,  6 Oct 2025 14:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759760298;
	bh=Gx9y0VlbK0lYH2T9Fayq7xIksBTJUSX9op5yZaFvKFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pyBsamvS+IvC0GPchKDszBiIlAQshaabAgzAkojx2aifDRzLkp2zBz2DDRjBlGy1h
	 u613L8RO0+CFo6I5WifbKrEXMyK98CU7ZetKrtcirDII6ohRkmfCFAZfK4OaBYyXIz
	 BaV6ks5riNn94yoHQFEpc7OjshZXfFKyHcNIevL/1OEMzwPhr2svv5A7m4IGwYjigq
	 ZNnUWnFGj+3AkXIXNzXxxBvjN3lNG3QeTIs678U8s5pu4pPHxd6+PDA+z4aaw3R5Vq
	 zoAN6qxsWdAzbUdQBY2h+NteykD7jZ2se98k20y74cxEFde0a4xGuJotOrknXVmnMX
	 r8mDtQm+eLHdg==
Date: Mon, 6 Oct 2025 08:18:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/3] nvme-keyring: use correct format specifier
Message-ID: <aOPPqNffLH8mAoMQ@kbusch-mbp>
References: <20251001142200.61696-1-hare@kernel.org>
 <20251001142200.61696-2-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001142200.61696-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_071819_576117_1003DD32 
X-CRM114-Status: UNSURE (   8.17  )
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

On Wed, Oct 01, 2025 at 04:21:58PM +0200, Hannes Reinecke wrote:
> @@ -340,7 +340,7 @@ static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
>  		keylen = 70;
>  		break;
>  	default:
> -		pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
> +		pr_debug("%s: Invalid data length %u\n", __func__, datalen);

It's still the wrong specifier. size_t should use %zu. I folded that in,
pushed out to nvme-6.19.

