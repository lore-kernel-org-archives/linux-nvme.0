Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B886C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 16:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oHjuD7i+UA3Qw3m7etGOaevmlRCqaIA5WQMiwQTIlE8=; b=vsWUXKnh1FJaLpKBF4xsXPATxR
	WBIr3O46arquv0JQYhlEXoZXnjdpsVjRJ1R815jsQcvyqogpjmr1YXvXSiftcvYwo3Z6xWoVNrBrl
	Iu4TZx8OrlMrilVkpB74TLDmar6fiuKg62icDbWrEDXbVeIzcEIOc5VhyPh0rFj53DElnwK5TFuk5
	Iqr5laLZCSE8V9d2GxkLpLDmAwC812PMqhPjrFANaspJpzANqjuO1WjvgJUepP5wVw5mmpBatHCX5
	2Xwn8CIjWHn9IFKeNH5sQ/fHjf+zykWQOMJgMY1TQSe59SEHjpXUekQpSf1fwwbSvxqN8T5mmebzr
	rLj17bxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLnCR-00HKe7-0q;
	Fri, 05 Jan 2024 16:37:35 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLmRA-00HD9a-2g;
	Fri, 05 Jan 2024 15:48:46 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28c0d8dd88bso1242579a91.2;
        Fri, 05 Jan 2024 07:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704469722; x=1705074522; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oHjuD7i+UA3Qw3m7etGOaevmlRCqaIA5WQMiwQTIlE8=;
        b=Vsog1nngPKo0zzVkImCeKRav9fr0ToWFfCih0bT9IIfiiIzx/MG0DuX6gdiFd0FSRW
         LBZzcoXcNig++CXxneulYuKh8GOWSe10tI7FxM5go9V0BDfBKzFpKsYX5GTYky2kHo0Q
         iE6Pp7W43iTvquJM84/DsjIJnLzLl4Pl8ivymw9e98a7B9SfmjLVwiNH4kL6srirr3Cn
         MIVKKaFOJzyObzuS5+5Sl26mkc03d1nXEwi4aJ0ZZcMtASxYLW5hcUUZW0qfsGzYG7c1
         t5GcZJhYGVLklSC0MOYE+YtIvGBxs0tEDlycLQIsk19XcPr9zg6253jfAhltEMTZ2s9L
         TKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704469722; x=1705074522;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oHjuD7i+UA3Qw3m7etGOaevmlRCqaIA5WQMiwQTIlE8=;
        b=W95K3mVQ4xHwicXRDuLXDb+FN4BYe/TRcdh8IoTMIUZou2FV2mDNVFYe6dDebfDELS
         C3wOtyqsDOZ2fz2epd6F7E4UTOK874RO/141wYyVaqgAVHH2zhee+W77cr/eXWywryMv
         ZWRINKXYghHpguKPhyqsYzs2iUQaqFOt1tvfJusuaBJmbYCfqV2pcsOcJwlnEPOlaUSi
         tsR1+OJhpj0+bqeHhHL/8WUrtRDUq6yqzXY2hnbMsRAYRgB88D1+CoaoN9G/B99ub0dD
         EaXwiOkle0ldlum7PBp0zWrkNbaHm+bCtS25iEWpNs6BFuj87Gg7T7dbe0kZuqPhIcg5
         zisg==
X-Gm-Message-State: AOJu0YwTsCFJZXE5pgQ5dotPBMA0A+gGAJZY1GI340kVYtbb3AFCEudX
	fASce6jr4/kP00sPfiTA/gp+yCPjunA=
X-Google-Smtp-Source: AGHT+IG4JLyKQE+gM4c27FKh73op2FHqLSCwte9ikVSJ5ZEE7F/zmt6FTbncQktxxFKJuFQG75IOqA==
X-Received: by 2002:a17:90a:5512:b0:28c:ef1a:db1a with SMTP id b18-20020a17090a551200b0028cef1adb1amr1858002pji.35.1704469721772;
        Fri, 05 Jan 2024 07:48:41 -0800 (PST)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id gj9-20020a17090b108900b0028be4f51d2dsm1420897pjb.5.2024.01.05.07.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 07:48:41 -0800 (PST)
Message-ID: <ec7f36ffdb2a76fe5cac7272da07242b3a6296f4.camel@gmail.com>
Subject: Re: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org,  pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Wang
 <jasowang@redhat.com>, Jeroen de Borst <jeroendb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Shailend Chand
 <shailend@google.com>, Eric Dumazet <edumazet@google.com>, Felix Fietkau
 <nbd@nbd.name>, John Crispin <john@phrozen.org>, Sean Wang
 <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Keith
 Busch <kbusch@kernel.org>,  Jens Axboe <axboe@kernel.dk>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,  Chaitanya Kulkarni
 <kch@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org, 
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org
Date: Fri, 05 Jan 2024 07:48:39 -0800
In-Reply-To: <20240103095650.25769-6-linyunsheng@huawei.com>
References: <20240103095650.25769-1-linyunsheng@huawei.com>
	 <20240103095650.25769-6-linyunsheng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_074844_868044_697BF959 
X-CRM114-Status: UNSURE (   7.65  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Fri, 05 Jan 2024 08:37:34 -0800
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

On Wed, 2024-01-03 at 17:56 +0800, Yunsheng Lin wrote:
> When draining a page_frag_cache, most user are doing
> the similar steps, so introduce an API to avoid code
> duplication.
>=20
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

Looks good to me.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>


