Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05EE2CA0EF1
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Sep 2023 16:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NHzhhdgkKVg1Z1E3fYBIdKIk4RTB0+vFhn+9IZszqnI=; b=a1w2hwXAFLzyg0wIdY/iWkFgBf
	um0SODBFXK5VTjaJdCau59WQHyP6zvl1Sl7N94X6YWcp1KEb5Ka6W/7kkGs7Nr7axdo4bgI2Y+rwQ
	c7NT8b+N4GqGFBxLbjqV52OqJLZlMDBxdp52wNlAsbs9FwSkImOTfjLs/vMBVILn/3I0vODgmL2nz
	zdelKBIuDhpz5HBbE+otnURv96Co01NVTooxEiUcJQ9JobsDRdJuep74tZQCA4rEOUEryRKx50PYn
	AphYZigakfsSTpET4lJrpApLFs+HCMmQzXx0UVEOBzQMW8ELx5+Kjr5OHHMQjKE/k0M6gikChwbF8
	yj8N2lIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qg64n-003o5S-1P;
	Tue, 12 Sep 2023 16:17:21 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qg64k-003o4d-1V
	for linux-nvme@lists.infradead.org;
	Tue, 12 Sep 2023 16:17:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 5F3C8B81E67;
	Tue, 12 Sep 2023 16:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14833C433C7;
	Tue, 12 Sep 2023 16:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694535435;
	bh=NHzhhdgkKVg1Z1E3fYBIdKIk4RTB0+vFhn+9IZszqnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dvg1vea6OcIDuaEpOraqnWAIxKe+l8/GYbdYF5qPwBxP46C/4b5XjwSg1nFsLmQeR
	 4UwczeO8uuI9JTEn2i3wsiaE+9Z0aUN0tEPLoKEen3K/VrvkouGb+DYDRlJYAcr18l
	 FJAYYi/A3KhMQwydB7oiqu9TNb7z/kpq+I8cTzZIxk8QWRY6BZrxe2o4JgBgMwY/1p
	 AR1GxvilI/paKfYxhKnpNaX/dvHhuZ0m4elLmckngBZ/Eiqvkjr39GERj5bkSbLUGs
	 VBnBr5VjMMY20uWPFU5Js6eMzeZ3K+QpApNYIoYLVlT+phe5rP2/Rp6uj7CFer6/bB
	 mt5TyWxhV041Q==
Message-ID: <4ae938a0-6331-f5d6-baa5-62eb8b07e63f@kernel.org>
Date: Tue, 12 Sep 2023 10:17:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v15 01/20] net: Introduce direct data placement tcp
 offload
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, imagedong@tencent.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-2-aaptel@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230912095949.5474-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230912_091718_648347_6B35A45A 
X-CRM114-Status: UNSURE (   8.42  )
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

On 9/12/23 3:59 AM, Aurelien Aptel wrote:
> As a result, data from page frags should not be copied out to
> the linear part. To avoid needless copies, such as when using
> skb_condense, we mark the skb->ulp_ddp bit.

Not consolidating frags into linear is a requirement for any Rx ZC
solution (e.g., the gpu devmem RFC set and accompanying io_uring set for
userspace memory). Meaning, the bit can be more generic and less tied to
ulp_ddp.

