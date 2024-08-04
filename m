Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064BBC3DA4A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Aug 2024 03:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sM563CEGX+iYVBrLjeDfGXla4ALwff+kdJMmGjR+TG8=; b=tqPPnI54QwgPsVx6cQIEmxX/AX
	zGtWTa1KPQ3iSfU/5L+So79/dc0u5FKZ3cW2dRrRBEmREPSxNCAl/Xkk957NWokTfsxRJAOOShnyV
	USKwRl+HQulcSntBbMeuI3j8NfQWvQXEJVLUM5A3c6gz+VaAFKa5dPPLogvN+hOp+WYc8cNVn5ryK
	xcrgvz8Tl1GMr38GBBcpqBpm2oQ8tdkptcccS4oZzJYnw2VpB1FpuwCSiRhcrMFFY+k4azXK2Ishn
	QOaocmAkVf39fuA47whZ2Gfyh177g2JoDm4NP1b2yrgK+23bQXksqT3hReE98y0eED9qV8JeRZngG
	JRIXBjlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbAeh-00000000LIH-2nMR;
	Tue, 06 Aug 2024 03:14:35 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1saUyy-0000000Cm9I-0aKL;
	Sun, 04 Aug 2024 06:44:45 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-36841f56cf6so1199525f8f.3;
        Sat, 03 Aug 2024 23:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722753880; x=1723358680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sM563CEGX+iYVBrLjeDfGXla4ALwff+kdJMmGjR+TG8=;
        b=PPC7FKbEreY8J1kCPmQZYscgLuDXg6thbD8nCJtkkkTDrhpmX5UUNnLQeaqP3EOYdQ
         VaCMIc48PV2mfE8azNdy4eHEbChOoU8BFIxGeHsn4yYlO7LU90847sv4g41sK+ZdGged
         MUo8O2+HeWNwCm9gAkxBaVZaize9ja94yqp90qBTWE7jcD3FCQuemYeoGe3Y+eM2ucQE
         KdAS0V/z3Cg1vDqaFyEs7wzFFjKdROf0RKHBzmGADM7lyXRuDaHEmM80T0AIDowNJBbW
         ohKqwX/FWG5zkFvbFZ07aOCz0cEH7jUOQn7MCqW7WqWRDSQVnbf3fGaRSF/nHXLdToXS
         f1og==
X-Forwarded-Encrypted: i=1; AJvYcCUb0jEFA+lEvpUpYOQGLPIbQ/IN99aZdl/YV89CeYsok11Y6yzcVsprK/KfsAbn5bAqTtyEWQ74NJaBVi5cfuo=@lists.infradead.org, AJvYcCXJuWLuN8dWKutteYKLg0zOWbqWLPQhgaWTLu5vB/Vl/CRkJME+UIAuHueIYWLDb6/G9hE9Lq/bd2o=@lists.infradead.org, AJvYcCXUJ9Xp64k6/bDd0fw/6Oob68yice7n3BxbXi278/PR80GzYAbQO+COOn047hcxDRM8vS0RqbN0vOc6AQ==@lists.infradead.org, AJvYcCXkWi2U5rLM1p0Qd91f6MwR1Yvqt8Z5nkjWWxfhHU8FTKma5s3c9phGUAVYhUxbTFyarfspehVE6Y35Zyz6PJHZXw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzHjOs/4Lq9ecMDEelPFZOWINnU9vFxhDTdIlBT7xTYbPgV6ZfL
	jmjg2dVXXOpdhc1Tks2OveUwpSIT5bhOlZwcOd4Do9DVHFW9Gm4Z
X-Google-Smtp-Source: AGHT+IF+HIEN3u4KbARF8SJvOwd5zbIiuHalh5c4I/D6/TshZm+RxUSfK1q1kRjeS4JttPgnFZS+0w==
X-Received: by 2002:a5d:648d:0:b0:368:aa2:2b4e with SMTP id ffacd0b85a97d-36bbc0c8bbemr3329655f8f.4.1722753879500;
        Sat, 03 Aug 2024 23:44:39 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06e0f5sm5973058f8f.104.2024.08.03.23.44.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Aug 2024 23:44:39 -0700 (PDT)
Message-ID: <ddf1824f-c60a-4908-a67b-ebe7546be870@grimberg.me>
Date: Sun, 4 Aug 2024 09:44:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/14] mm: page_frag: add '_va' suffix to
 page_frag API
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Subbaraya Sundeep <sbhatta@marvell.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Shailend Chand <shailend@google.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Sunil Goutham <sgoutham@marvell.com>, Geetha sowjanya <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, Felix Fietkau <nbd@nbd.name>,
 Sean Wang <sean.wang@mediatek.com>, Mark Lee <Mark-MC.Lee@mediatek.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>,
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, linux-mm@kvack.org,
 bpf@vger.kernel.org, linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org
References: <20240731124505.2903877-1-linyunsheng@huawei.com>
 <20240731124505.2903877-5-linyunsheng@huawei.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240731124505.2903877-5-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240803_234444_212102_B13AE41B 
X-CRM114-Status: UNSURE (   5.96  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Mon, 05 Aug 2024 20:14:30 -0700
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

Regardless of the API discussion,

The nvme-tcp bits look straight-forward:
Acked-by: Sagi Grimberg <sagi@grimberg.me>

