Return-Path: <SRS0=/503=JU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE617C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 15:52:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FE23613DB
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Apr 2021 15:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE23613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UFGLwcn2Ne7lJBZ3MaD3ybeYM7q7c4ufBxLByp53l2I=; b=jPS1hkf99LPLU5pp12vqY0abZ
	ebHrvD360iWRCLr5ybru6Ua68aHSBpL/mwRRDdlhDk+fP9BUJ5RT6F+Zcdh7WAnSlFjKM7MbMU1vt
	wBtwHgjXzEDCdsNBhtYJwmTDCzA3/qAQkVicmYngi1b+EvqWmxB3hfcVygXA4CesFL9KQ4eJFo5mG
	wyrPEuPgc+TQJA8UuykxS9ytI73fkOCoRJJ9Rpwa9yLpXUsdKCgfDjv+ZaP4mKZR6NySnTAucTT50
	Ayx0yJ3zN2SULPcJGzvejUrOMXc+S0r/rE0R9JPhMbQCJKZrzKQ19mMMzbydm80CtP5ajaQmExNNJ
	lZjLjjTjQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZy66-001oNI-Am; Fri, 23 Apr 2021 15:52:02 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZy5q-001oN3-3i
 for linux-nvme@desiato.infradead.org; Fri, 23 Apr 2021 15:51:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=niydOJzXB0BVIVZTs2Wq/Cp/laORv0SPq3JvrEVBzfs=; b=CW9T3lVcp0UghHwdheZz7zHugl
 QHbpJ++wS41LmmMBAXNcZ6iT4vlmplBOffimwKLuHZiQoROyWbGGAEwcMz1UxIHt9mlZcRFyFggx7
 AhfQkxYDxDynCm3XmWn3Tf6RG+1yAMip6Z69LMXsK88Sii87Ah2ESaCoeMegLp6LVACOTwmZIPR/R
 J1H+AnjoiSz5Ugt8xIcPD7mzI8qhgxj0/Lk1FeKjbICe+I9LzFcJCu4xvHFlT4Cu4rS58A6O6WtU8
 2G3y1vsoisucQk48JYYwMKZF3R4VyoOfW3esrqlVFleg1i1OwQ6/HJHe3PFGN9Im7HkfVkLVdRx8b
 VAPrYsoA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZy5n-00EWa6-LP
 for linux-nvme@lists.infradead.org; Fri, 23 Apr 2021 15:51:44 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1225613F2;
 Fri, 23 Apr 2021 15:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619193102;
 bh=0jPcXM6DoynH6nIQ+ojZkZctCD4vtafuPjvydK7l6ug=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=loHfoirA5BoEfMKiYo6xXo3kB1CkRzTjqTFPTpVSX4AvegjASLzbHnynhuP07gfbv
 3Q3Bv5XYto+YuLlO/G7croyKi9RlqAdbXSZZIK7PQwIUMaKJAIKMnDljB00jdmE0R1
 U9s9fV6o3CzOMKAmgNEX+7ijRngi6bkaFap1z16ImHyegugUKVkjHL0f+j6ldDVlvz
 WyDZ5ugRwPpgYjatnQm89CnVxWnFAgd6Ggm249ptXrOr5jchTJSkkzu+VNF9mJt5CA
 t/tzchZMGIkcdcF7TW0FBwLcCaXZUoGsi48+KZk+6Wo5n1arAmppxvBfNzUV7QiTWl
 QpPJYXkn8n8Pw==
Date: Fri, 23 Apr 2021 08:51:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 chaitanya.kulkarni@wdc.com, oren@nvidia.com, ngottlieb@nvidia.com
Subject: Re: [PATCH 1/4] nvmet: change sn size and check validity
Message-ID: <20210423155139.GA3621038@dhcp-10-100-145-180.wdc.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420090903.595664-1-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210423_085143_767211_C8D3F8E2 
X-CRM114-Status: UNSURE (   5.93  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Apr 20, 2021 at 09:09:00AM +0000, Max Gurtovoy wrote:
> +/* See Section 1.5 of NVMe 1.4 */
> +static bool nvmet_is_ascii(const char c)
> +{
> +	return c >= 0x20 && c <= 0x7e;
> +}

There's a library function, "isprint()", that can provide this check.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
