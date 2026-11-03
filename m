Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74AB606A32F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mCVParkL;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M2Hmcook
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mp3kk8+6LuA0IVceTCacKEe4tqnDRWucOGMN+FIMuVo=; b=mCVParkLfJj6HN
	VJ4Twr9lP+8mjlTGNSMcbfWLCax6jBsIpruqO8Nhdpx2EDco+4mnBxXvM4snrn5JhfWJzLHMdLUDb
	L9hJD1wZ3eqnU2o9SdIVVbj4lGFEN5qNllK3dKAzlaPONSvMkLU4I6dPtCNpJfLjvm3QGhzK6FZmh
	3ytA+2xg6ZxxBl4ZU2xlJU628Rf3VH/DHlqy7sxcfsXGTRfcraRj0hk5zh8d9NsH0Mz5UAbzz4ZaP
	d5k7Db1mCcHYD1Yfx6cQNwL9AmtA2dBdk896kpsvWTa4pH4uXmjf4ZAVdtdAzP33zQZgvVc6mZoLZ
	y9DO9ufkShzzdyTjVBUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7sr-00000001D0B-1uUs;
	Tue, 03 Nov 2026 06:20:37 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7sm-00000001CzD-0QeD
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:20:33 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-1a2761c69fbso6360527c88.0
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 22:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793686831; x=1794291631; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mp3kk8+6LuA0IVceTCacKEe4tqnDRWucOGMN+FIMuVo=;
        b=M2HmcookOUvJ7h44HO5zU1rCri92mLlgaSS+Gd+MdYmhLXXOMODIKkwaJJw2eZ0Xpb
         ETTBRfIbF0jSb2sDdWyzZ4BiGnGTqjHhLxXAf39l3cGnxJNOoMsf+DtxLGXEvxuisten
         YFonijMjokEsvz2I9rkViajBNB942WugWMRT4o8dfQPTAeD/pvGGZVCTiQ2L4wdaPFp1
         O5mZxHXhTiVhIWWxlxVAKIo4nAwKMhgaAk+hCOqy6Ee1v9+21loFrpXdLzOl+OC3mydi
         9RrYuACWYh8hEYDhpi55Q31H2UYSKLqclhH2gcNeg+sUN7wclh8OevorjEbIA1SqdLtR
         GLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793686831; x=1794291631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mp3kk8+6LuA0IVceTCacKEe4tqnDRWucOGMN+FIMuVo=;
        b=dXQ6e3Fal/sytZ21pBt3ydwfN6K0CcYDqggdUWuSPA1F3CZSozzutmjbXRZlLxki3P
         tBOcfS6ThMHvhyyNYG1ygAb04cHDylJ1pOYYXvZh5nIk8LdM8kZ8HVel67IuJnGYreo0
         3EUPobxk+GhuLfJpHdlEG5TtwznssnAxjPURSHOsCHc1Hi3WRkdpMMfaT3GiM9tKNVv2
         BVHtUTp/CMz33DU2vOMHyV8J4zkrFohitTOIv5lEJpLUtzER//lh3oNDcFA1MDRPLZor
         fdgs9rWnvTt4QktAAMxTjgJQv34oSlxei0t/hCK2TASCNkMmq6FtEhIOZ7HQbvpTFcdq
         ehbw==
X-Forwarded-Encrypted: i=1; AKwUvBx2JvYpPW9UkiULM7zRNRRP/ttSJ9d5vQcxeK6ZvB3vgG/2YbCmgyV0hyu/XoUIC6vU8O184gn91YW8@lists.infradead.org
X-Gm-Message-State: APuU4Z9Bk1oZ2yitff9/ANKeNhHAjzMI/yuEt0PyJGhW6m/tZttSqQis
	red9B6YVFsd2Kkep//XDlL1VWAYeQjggLvPOA9p0QaMeJl6vhxJyYLI/
X-Gm-Gg: AYBFou3PPCXzdc3Rv640uNsEtmxQfHT5C9omZHSxEigsHgUlvs5YObM2Q44rTu/M1ru
	zhLXle8WpTYsKRxWPpcfLVgff214RdWKDAnWLDjRst/NLebKMskPHiWYXITC0o0eWFYVJC6RWoX
	9LSLM/KXfqzbpfPF2uKWiYqkd15itN+4lR+kADvoGGI6qGDkDRpGpcpjPf70bF8Wep8gaxEqqHc
	Bn4AzNNfNieX9fTWGSz+/VcBE3JGMoNhs3ro/WNLuhS7KzDm3SKer7sXjQ/NyKNCWBZHRKOwUZS
	yLPFb0XP9JJ8nhdb70D8AL/8PojtWBQhj/vlC8P2g6wxirQ65RoY/X01ONKaERwhO6ekrrtoSez
	+NAjWD2r1sUPUyIaqJtjwH6aQ329dqVdDqA2+vn99Eg7162QSwZiVEie4xYGPEVrBJh1co1dPDb
	qnUS9B307OEDn9SqeRZbjQwDShWwae9v5tZS0StKXtBN0IxCZ/rFZsUOUpHTTuvXp+l3+auNC4P
	kB5GwBJdQwZq8j7gZHyuVe6FjN3cS9Uw/3ABiJjlu8257pPWebFt36rk22A4Es6P4ddKH2cKV/K
	gxAKSivaMUKR8vehUaqv
X-Received: by 2002:a05:701b:42c2:10b0:185:1640:5536 with SMTP id a92af1059eb24-1ac5ab52fa9mr19515376c88.19.1793686830658;
        Mon, 02 Nov 2026 22:20:30 -0800 (PST)
Received: from ubuntu.. ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1932sm39727023c88.2.2026.11.02.22.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:20:30 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ming Lei <tom.leiming@gmail.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH 2/2] block: set QUEUE_FLAG_NO_ELV_SWITCH under the read lock in del_gendisk()
Date: Tue,  3 Nov 2026 01:20:23 -0500
Message-ID: <20261103062023.2910587-1-odys.yuan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <44b0d0e5-b14f-4e6c-8e00-16b4af712b7d@linux.ibm.com>
References: <20261102-bug-nvme-remove-ns-async-v1-0-61780fee111c@gmail.com> <20261102-bug-nvme-remove-ns-async-v1-2-61780fee111c@gmail.com> <44b0d0e5-b14f-4e6c-8e00-16b4af712b7d@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_222032_162239_406BA001 
X-CRM114-Status: GOOD (  11.92  )
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 11:23:59 +0530, Nilay Shroff wrote:
> Currently, there's a patch[1] in-review to change update_nr_hwq_lock from
> write to read while switching elevator.
>
> So the proposal in this patch may not work out if the changes in patch[1]
> are accepted. I understand your proposed patchset but I'd recommend wait a
> bit till we settle with the patch[1].
>
> [1] https://lore.kernel.org/all/20261031044141.5569-1-laveeshb@laveeshbansal.com/

Right, with [1] a switch holds the lock for read and uses
QUEUE_FLAG_NO_ELV_SWITCH as its busy bit, so setting the flag under the
read lock here could be undone by a switch that is still running.

I'll drop this patch, send patch 1 on its own, and come back to this
once [1] has settled.

Thanks,
Qiliang

