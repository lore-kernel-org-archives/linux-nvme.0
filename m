Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A18260A2602
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 00:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rdavH4I9;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=Ju3lBlDZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VdvlGvHc17Ho1RVg/HbNQxMrDh7Us0FmqUHW62zV8B8=; b=rdavH4I9UFPonW70gkJ+UPYdqM
	xCAJbTIrV3QgJ3MMk6u9fSbudVyjJJHGGuQmuxtfhYvoKMvSXJ2vMpwI0Oq73wuCbgm26D4qoAQTP
	mcBSSS1oQ8OKyQtuuywqE2lpUXfICGarrZgZ+pY3+37mfmD1jcU1ax88Ax1tuo7YIoum3hGmkuCG4
	Hob/utuhxJR3OJaawpUGEHnsdCGx06r8Kyr941AJVSFytExE1SjKLUJxNNbj+VWFaa7WCOyosV4Uk
	owXdDWNMLfwBMLYJZaQeMrMETIEaJ8ICxcNo18/1Cyg4FwJHQUE5iljs9Dp2Etaa9hViUjPtx9eO2
	GRl78fIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQZn8-000000021s9-1ytZ;
	Tue, 10 Nov 2026 00:32:50 +0000
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQZn5-000000021rG-1cRf
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 00:32:48 +0000
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-91ea16d8072so11083686d6.2
        for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2026 16:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794270765; x=1794875565; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VdvlGvHc17Ho1RVg/HbNQxMrDh7Us0FmqUHW62zV8B8=;
        b=Ju3lBlDZ/3F3eiWEG5myjC6A82mX1wux8oJJ4u6OxgS4/4I+TAzLxfpuNhv306uKhH
         LS8G+xAfbiz5jeIfR07eBRoV66nW51rOLsSTeEg+jVOcHXF5RMUAkd/8h12pb071gsx2
         EfNT6ShD0qY6VHAsy5mseVfQfzImdeG15OvcXcSGNZRpn+hw5eZUcYBaRlFkMQf+Fmc3
         PA/Y+VjGoml0Mip8QdHwRyBiqXwRsXz2ngxyRKHpQcTnFpW5pjnybNM53db3IxMpDkTv
         ErQgaFH+9cdNFJUnJ0LdKkPvEx/oU40xKW4Sjqy+rpNYYnqB1EA14GBPVnCbHY8N0bD+
         CZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270765; x=1794875565;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdvlGvHc17Ho1RVg/HbNQxMrDh7Us0FmqUHW62zV8B8=;
        b=W9yPcxAefhT9Qk9Z08Y9N4czGHH4PdMqxB1rlBhs0YAcNm8f6mOCHP1kTMj9Gsi5Kv
         SBr4gLGK8DTeixbBh9XlvEzsdNgeKAii6MqCT8dNzvV+2dDokQpUrWio4nfrXS9ZZo3k
         NLBaYzQH3q79cJEhBDtp1q+ZA2PSYeYbCV8S0a3dVETqRAQ8XGBJc3V2zEFDdnXT07YH
         LtIXbDszGLFAZ26F8LibdWr+s/KLq59lUh5cR/a+M2tejgN3vA/A4GjM9IW2qh1j9/T8
         lKHB6kF24gxnbS0vvXb3Gj+6aHvz+mFZDC6ZdemYOnzRwkLciRvEo/yM3fFXLVVJa/pv
         q77g==
X-Forwarded-Encrypted: i=1; AL+hErE188DXjLnheLexqc7sFUH7A4VNYf3/V0j3nw5wPoOOQNMhb7HF3fM28tQiA6c1Nkx3UvG5mS09B2F6@lists.infradead.org
X-Gm-Message-State: APuU4Z9636tjfsLZJ8rrd6gsol/x2kxzwBb3nh8IQgqvKNXsopC0zHcZ
	aSout88Qu8KY0yb6m4igw5W/sXSneAHA71nJg3d/21EHSpqlbjgP4UZhfpIfgS+4sOQ=
X-Gm-Gg: AYBFou3S1JCSOKpR/nJlqaxKh7wA3eV3lH1aXmumMq+PAWXypZMiRcQgHeN3JuqXsii
	ea4SoEajzFyKJVK+VOzxYa8I9rqcBXKOXg0kOv7Q6XUOTHltfX5RhV5z3k+9snPuunfVuJffYam
	B/k5udcfeUQYtV+uvrqXfdxNAt7GzMcvdYQeTnUufP2eNq8UmXpA8WSUvb4+8C4L+vwduf6RdWJ
	RN762EwsCfWZadS2JzXQNjO2ktfIfDvwfTAT4bnvYCf46v2KRVx+Up6hnx27AGIkB15nPyFLWNz
	xZCiCo1PcDnQQmdYByzYvrpHAqZp/fT5k/zf8ajat+YLi83a/qN63PqM6FwIXmaz/rDruKdfTOh
	U0I37D6MdslPqrPXvDdGqwXyBklvUzAqfGE9hzOOZnCozjVbTxm4ucQCWcBjQziXlwpEIbIpoqP
	WG0ZfJNeWdoZ/haiLa/jXNJqHhf0TvadqUtyJISLHuBeZypps9hrLfPwsTUzxyacSBTctrf1JMd
	jbXjBU9DOI5vgoCLW25w2HHFJVwZ4b0CMq+IEIxfxs96iO8AW6QT8x6HmIdGwdfbaAPk/sD583p
	NLDL/Yij/NAq0Y/tpIpD9NV4QI9nnNBeyXjrFJcUtBm9gva3Hc+8mjorUQDjyYA68Y16Rw7UZdH
	swn//FRiScQ==
X-Received: by 2002:a05:6214:4288:b0:91e:9811:7a2e with SMTP id 6a1803df08f44-91eef8cf6fcmr20963496d6.13.1794270764615;
        Mon, 09 Nov 2026 16:32:44 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef050ef22sm8450236d6.31.2026.11.09.16.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:32:44 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQZn1-00000003JiH-1vxr;
	Mon, 09 Nov 2026 20:32:43 -0400
Date: Mon, 9 Nov 2026 20:32:43 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: Re: [PATCH RFC 2/2] nvmet-rdma: use a separate lockdep class for the
 listening cm_id
Message-ID: <20261110003243.GS663069@ziepe.ca>
References: <20261108120154.148824-1-shinichiro.kawasaki@wdc.com>
 <20261108120154.148824-3-shinichiro.kawasaki@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108120154.148824-3-shinichiro.kawasaki@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_163247_430843_44F29D5A 
X-CRM114-Status: GOOD (  11.48  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 08, 2026 at 09:01:54PM +0900, Shin'ichiro Kawasaki wrote:
> @@ -1914,6 +1914,8 @@ static int nvmet_rdma_enable_port(struct nvmet_rdma_port *port)
>  		return PTR_ERR(cm_id);
>  	}
>  
> +	rdma_reclassify_id_for_listen(cm_id);
> +

It seems like a flag or new function for the create would make more
sense, and if this is the right fix then all the callers with the
pattern of rdma_create_id() .. rdma_listen() should be fixed too?

I suppose we cannot change the lock class in rdma_listen ?

Jason

